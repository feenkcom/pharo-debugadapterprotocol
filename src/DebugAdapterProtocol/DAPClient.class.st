Class {
	#name : #DAPClient,
	#superclass : #RemoteDebuggerClient,
	#instVars : [
		'messageQueue',
		'messageId',
		'queueProcessor',
		'messageProcessorMutex',
		'messageProcessors',
		'serverAttributes',
		'serverState',
		'serverProcessDetailsEvent',
		'comms',
		'capabilities',
		'breakpointSpecs'
	],
	#category : #'DebugAdapterProtocol-Client'
}

{ #category : #'instance creation' }
DAPClient class >> connectTo: host port: portNumber debugger: aDAPDebugger [

	^ self new connectTo: host port: portNumber debugger: aDAPDebugger
]

{ #category : #'private - message processor' }
DAPClient >> addMessageProcessor: aMessageProcessor [

	^ messageProcessorMutex critical: 
		[ messageProcessors add: aMessageProcessor ]
]

{ #category : #private }
DAPClient >> breakpointEntriesInSource: aPath [
	"What we asked for in one file, paired with the line it ended up on. A back
	end may move a breakpoint to the next line that has code, so where a reader
	pointed and where the breakpoint is are two questions, and toggling has to
	answer both. Breakpoints set some other way are known only by where they
	ended up."

	^ self breakpointSpecs
		at: aPath
		ifAbsent: [ (self breakpointsInSource: aPath)
			collect: [ :each | (self breakpointSpecFor: each) -> each line ] ]
]

{ #category : #actions }
DAPClient >> breakpointLocationInSource: aDAPSource line: aLine [
	"Where a breakpoint asked for on this line would land, as a line and a
	column, or nil when nothing on or after it can be stopped at. A line is
	what a reader points at; where the back end stops is its own business, and
	this is how it says so before anything is set. A back end that cannot
	answer is taken at the line, which is all it knows about anyway."
	| arguments request response places |

	(self capabilities notNil and: [
		self capabilities supportsBreakpointLocationsRequest = true ])
			ifFalse: [ ^ aLine -> nil ].
	arguments := DAPBreakpointLocationsArguments new
		source: aDAPSource;
		line: aLine.
	request := DAPBreakpointLocationsRequest new arguments: arguments.
	response := self sendMessageAndWait: request.
	places := response breakpoints ifNil: [ #() ].
	places isEmpty ifTrue: [ ^ nil ].
	^ (places first at: 'line') -> (places first at: 'column' ifAbsent: [ nil ])
]

{ #category : #actions }
DAPClient >> breakpointLocationsInSource: aDAPSource line: aLine [
	"Every place on this line a breakpoint could stand, as the back end
	reports them: outermost form first, each with the extent of its form when
	the back end knows it. A back end that cannot answer reports none, and a
	caller then has only the line to go on."
	| arguments request response |

	(self capabilities notNil and: [
		self capabilities supportsBreakpointLocationsRequest = true ])
			ifFalse: [ ^ #() ].
	arguments := DAPBreakpointLocationsArguments new
		source: aDAPSource;
		line: aLine.
	request := DAPBreakpointLocationsRequest new arguments: arguments.
	response := self sendMessageAndWait: request.
	^ response breakpoints ifNil: [ #() ]
]

{ #category : #actions }
DAPClient >> breakpointPlaceIn: aDAPSource line: aLine column: aColumn [
	"The place a reader pointing here means. The back end says where a
	breakpoint can stand; which of the nested forms is meant is a question
	about the cursor, and is answered here.

	Places arrive outermost first, so the last one that still covers the
	cursor is the innermost form the reader is inside. Pointing at a line
	rather than into a form means the first place on it.

	A back end that reports no places is one that cannot answer the question,
	not one with nowhere to stop: it gets the line as asked, without a column,
	which is the only thing it understands."
	| places containing |

	places := self breakpointLocationsInSource: aDAPSource line: aLine.
	places isEmpty ifTrue: [ ^ { 'line' -> aLine } asDictionary ].
	containing := places select: [ :each |
		self place: each surroundsLine: aLine column: aColumn ].
	^ containing isEmpty
		ifTrue: [ places first ]
		ifFalse: [ containing last ]
]

{ #category : #private }
DAPClient >> breakpointSpecFor: aDAPBreakpoint [
	"One breakpoint as the request wants it back."

	^ self specForLine: aDAPBreakpoint line column: aDAPBreakpoint column
]

{ #category : #private }
DAPClient >> breakpointSpecs [
	"The specs we last sent, per file. The registered breakpoints are what the
	back end confirmed, which is a different thing as soon as it moves one."

	^ breakpointSpecs ifNil: [ breakpointSpecs := Dictionary new ]
]

{ #category : #accessing }
DAPClient >> breakpointsInSource: aPath [
	"The breakpoints the server has confirmed in one file. This side keeps no
	list of its own: it is the registered breakpoints, asked where they are."

	^ (breakpoints values select: [ :each |
		each source notNil and: [ each source path = aPath ] ])
			asArray sort: [ :a :b | a id <= b id ]
]

{ #category : #accessing }
DAPClient >> capabilities [
	"Answer the server's capabilities.
	There is a DAPServerCapabilitiesEvent, however the capabilities are sometimes returned as attributes"

	^ capabilities ifNil: 
		[ serverAttributes at: #capabilities 
			ifAbsent: [ nil ] ]
]

{ #category : #accessing }
DAPClient >> capabilities: anObject [
	capabilities := anObject
]

{ #category : #'private - message processor' }
DAPClient >> checkResponse: response [

	response success ifFalse:
		[ DAPBadResponse new
			response: response;
			signal ].
	^true
]

{ #category : #actions }
DAPClient >> configurationDone [
	"Let the server know we've finished configuration"

	self sendMessageAndWait: DAPConfigurationDoneRequest new.
]

{ #category : #initialization }
DAPClient >> connectTo: host port: portNumber debugger: aDAPDebugger [

	debugger := aDAPDebugger.
	comms := DAPSocketComms new 
		host: host;
		port: portNumber;
		client: self;
		connect.
	self startQueueProcessor.
]

{ #category : #initialization }
DAPClient >> connectToServerExecutable: aFileReference debugger: aDAPDebugger [

	debugger := aDAPDebugger.
	comms := DAPSubprocessComms new 
		serverExecutable: aFileReference;
		client: self;
		connect.
	self startQueueProcessor.
]

{ #category : #actions }
DAPClient >> continueThreadId: aNumber [
	"Instruct the debugger to continue execution"
	| arguments request |

	arguments := DAPContinueArguments new threadId: aNumber.
	request := DAPContinueRequest new arguments: arguments.
	^ self sendMessageAndWait: request.
]

{ #category : #actions }
DAPClient >> disconnect [ 

	self disconnectWithRestart: false.
]

{ #category : #actions }
DAPClient >> disconnectWithRestart: restartBoolean [
	| arguments request |

	arguments := DAPDisconnectArguments new 
		restart: restartBoolean.
	request := DAPDisconnectRequest new
		arguments: arguments.
	self sendMessage: request.
]

{ #category : #private }
DAPClient >> entry: anAssociation isAt: aLine column: aColumn [
	"Whether this is the breakpoint a reader means by pointing at a place: the
	one we asked for there, or the one the back end moved there."

	| spec |
	spec := anAssociation key.
	^ ((spec at: 'line') = aLine
		and: [ (spec at: 'column' ifAbsent: [ nil ]) = aColumn ])
		or: [ anAssociation value = aLine ]
]

{ #category : #initialization }
DAPClient >> initialize [ 

	super initialize.
	messageQueue := AtomicSharedQueue new.
	messageId := 0.
	messageProcessors := OrderedCollection new.
	messageProcessorMutex := Mutex new.
	"Server attributes is a set of information that may be useful for human debugging"
	serverAttributes := Dictionary new.

	"Always have a general event and response message processors"
	self addMessageProcessor: (DAPReceivedMessageProcessor new client: self).
]

{ #category : #testing }
DAPClient >> isAttached [
	"Answer a boolean indicating whether the server is attached"

	^ serverState == #attached
]

{ #category : #testing }
DAPClient >> isConnected [
	"Answer a boolean indicating whether the connection to the remote debugger is open"

	^ comms isConnected
]

{ #category : #testing }
DAPClient >> isDisconnected [
	"Answer a boolean indicating whether the connection to the remote debugger is disconnected"

	^ comms isDisconnected
]

{ #category : #testing }
DAPClient >> isInitialized [
	"Answer a boolean indicating whether the server is initialized"

	^ serverState == #initialized
]

{ #category : #testing }
DAPClient >> isStopped [ 

	^ serverState = #stopped
]

{ #category : #testing }
DAPClient >> isTerminated [ 
	"Answer a boolean indicating whether the server has been terminated"

	^ serverState == #terminated
]

{ #category : #private }
DAPClient >> killProcesses [
	"Kill the DAP server processes"
	| serverPid proc |

	serverPid := serverProcessDetailsEvent systemProcessId.
	proc := GtSubprocessWithInMemoryOutput 
		command: 'kill'
		arguments: { serverPid asString }.
	proc runAndWait.
	proc isSuccess ifFalse:
		[ self error: 'Unable to kill server process' ]
]

{ #category : #actions }
DAPClient >> launchWithArguments: aDictionary [
	| request |

	request := DAPLaunchRequest new arguments: aDictionary.
	^ self sendMessageAndWait: request.
]

{ #category : #actions }
DAPClient >> nextInThreadId: aNumber [
	"Stop over the next statement"

	^ self sendMessageAndWait: (DAPNextRequest new arguments: 
		(DAPNextArguments new threadId: aNumber)).
]

{ #category : #private }
DAPClient >> nextMessageId [

	^ messageId := messageId + 1
]

{ #category : #messages }
DAPClient >> nextPutReceivedMessage: aByteArray [

	messageQueue nextPut: aByteArray
]

{ #category : #private }
DAPClient >> place: aDictionary surroundsLine: aLine column: aColumn [
	"Whether the form at a place covers a cursor. The end is one past the
	form's last character, the way the rest of the protocol reports one, so a
	cursor sitting exactly at the end is outside."
	| startLine startColumn endLine endColumn |

	"A caller with no column to offer is pointing at the line, not into a form,
	and no form on it surrounds the cursor. Columns count from one, so a zero
	is the same statement in the protocol's own terms."
	(aColumn isNil or: [ aColumn = 0 ]) ifTrue: [ ^ false ].
	startLine := aDictionary at: 'line'.
	startColumn := aDictionary at: 'column' ifAbsent: [ 1 ].
	endLine := aDictionary at: 'endLine' ifAbsent: [ startLine ].
	endColumn := aDictionary at: 'endColumn' ifAbsent: [ startColumn + 1 ].
	startLine > aLine ifTrue: [ ^ false ].
	(startLine = aLine and: [ startColumn > aColumn ]) ifTrue: [ ^ false ].
	endLine < aLine ifTrue: [ ^ false ].
	(endLine = aLine and: [ endColumn <= aColumn ]) ifTrue: [ ^ false ].
	^ true
]

{ #category : #printing }
DAPClient >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPut: $(;
		<< self statusString;
		nextPut: $)
]

{ #category : #messages }
DAPClient >> processMessage: aByteArray [
	| processors message handled |

	message := DAPObject fromJSONDictionary: (STONJSON fromString: aByteArray utf8Decoded) client: self.
	DAPMessageSignal new
		direction: #received;
		message: message;
		emit.
	"Take a copy of the current processors so we can release the mutex ASAP"
	messageProcessorMutex critical: 
		[ processors := messageProcessors asArray ].

	handled := false.
	processors do: [ :processor |
		handled := handled | (processor processMessage: message) ].
	"If the response hasn't been handled, check the status and fork any errors"
	(handled not and: [ message type = #response ]) ifTrue: 
		[ [ self checkResponse: message ]
			on: Error fork: [ :ex | ex pass ] ].
]

{ #category : #private }
DAPClient >> registerBreakpoint: aDAPBreakpoint [
	"Add the supplied breakpoint to the receiver's list"

	breakpoints at: aDAPBreakpoint id put: aDAPBreakpoint.
	self announce: (DAPBreakpointAdded new breakpoint: aDAPBreakpoint).
]

{ #category : #private }
DAPClient >> rememberSpecs: anArray resolvedFrom: confirmed inSource: aPath [
	"The response answers one breakpoint per spec, in the order they were sent,
	so what we asked for can be paired with where it ended up."

	self breakpointSpecs
		at: aPath
		put: (anArray withIndexCollect: [ :spec :index |
			spec -> (index <= confirmed size
				ifTrue: [ (confirmed at: index) at: 'line' ifAbsent: [ nil ] ]
				ifFalse: [ nil ]) ])
]

{ #category : #actions }
DAPClient >> removeBreakpointsInSource: aPath [
	"Forget what we knew about the breakpoints in one file. Setting
	breakpoints replaces every breakpoint in a file, so the answer to the next
	setBreakpoints is the whole truth about it and everything before is stale."

	(self breakpointsInSource: aPath) do: [ :each |
		breakpoints removeKey: each id ifAbsent: [ ] ].
	self breakpointSpecs removeKey: aPath ifAbsent: [ ]
]

{ #category : #'private - message processor' }
DAPClient >> removeMessageProcessor: aMessageProcessor [

	^ messageProcessorMutex critical: 
		[ messageProcessors remove: aMessageProcessor ]
]

{ #category : #accessing }
DAPClient >> removeThreadId: aNumber [ 

	threads removeKey: aNumber
]

{ #category : #actions }
DAPClient >> requestAllStackTraces [
	"Request stack traces for the existing threads"

	self threads keysAndValuesDo: [ :threadId :state |
		self requestStackTraceForThreadId: threadId startFrame: 0 levels: 20 ]
]

{ #category : #actions }
DAPClient >> requestAllThreads [
	"Request a list of all the current threads in the server.
	The response visitor will update the client state."

	self sendMessageAndWait: DAPThreadsRequest new.
]

{ #category : #messages }
DAPClient >> requestStackTraceForThreadId: threadId startFrame: startFrame levels: levels [
	| request arguments response |

	arguments := DAPStackTraceArguments new
		threadId: threadId;
		startFrame: startFrame;
		levels: levels.
	request := DAPStackTraceRequest new
		arguments: arguments.
	response := self sendMessageAndWait: request.
	(self atThreadId: threadId)
		stackFrames: (response stackFrames collect: [ :frame |
			DAPStackFrame fromDictionary: frame client: self ]);
		totalStackFrames: response totalFrames.
]

{ #category : #messages }
DAPClient >> scopesForFrameId: aNumber [ 
	| arguments request |

	arguments := DAPScopesArguments new frameId: aNumber.
	request := DAPScopesRequest new arguments: arguments.
	^ self sendMessageAndWait: request.
]

{ #category : #private }
DAPClient >> sendMessage: request [
	"Send the supplied message."

	DAPMessageSignal new
		direction: #sent;
		message: request;
		emit.
	request seq ifNil: 
		[ request seq: self nextMessageId ].
	^ self sendMessageString: (String streamContents: [ :stream |
		(DAPJson new writerOn: stream) nextPut: request ])
]

{ #category : #messages }
DAPClient >> sendMessageAndWait: request [
	"Send the supplied message to the remote and wait for the response.
	Raise an exception on failure."
	| result processor sequenceNumber |

	result := nil.
	"Ensure that a message sequence number is included"
	sequenceNumber := self nextMessageId.
	request seq: sequenceNumber.
	processor := DAPStatusMessageProcessor forMessageId: sequenceNumber.
	self addMessageProcessor: processor.
	"Send the message"
	self sendMessage: request.
	processor wait.
	self checkResponse: processor result.
	self removeMessageProcessor: processor.
	result := processor result.
	^ result
]

{ #category : #private }
DAPClient >> sendMessageString: aString [ 
	| wrappedMessage |

	wrappedMessage := String streamContents: [ :stream |
		stream
			<< 'Content-Length: ';
			print: aString size;
			crlf; crlf;
			<< aString ].
	comms 
		nextPutAll: wrappedMessage utf8Encoded;
		flush.
]

{ #category : #accessing }
DAPClient >> serverAttributes [
	^ serverAttributes
]

{ #category : #accessing }
DAPClient >> serverAttributes: anObject [
	serverAttributes := anObject
]

{ #category : #accessing }
DAPClient >> serverProcessDetailsEvent [
	^ serverProcessDetailsEvent
]

{ #category : #accessing }
DAPClient >> serverProcessDetailsEvent: anObject [
	serverProcessDetailsEvent := anObject
]

{ #category : #accessing }
DAPClient >> serverState [
	"Answer the state of the server.
	Known states include: nil (no activity), attached, initialized, continued, stopped, exited, terminated.
	DAP servers may add their own state, e.g. debugpyWaitingForServer"
	<return: #String>

	^ serverState
]

{ #category : #accessing }
DAPClient >> serverState: aString [

	serverState := aString.
	self announce: (DAPDebuggerStateChanged new debugger: debugger)
]

{ #category : #actions }
DAPClient >> serverTerminated [
	"Notification that the server has terminated.
	Mark everything terminated and close the socket.
	Obviously this should only be sent if the server has in fact notified the client that it has terminated."

	threads valuesDo: [ :thread | thread threadTerminated ].
	self serverState: #terminated.
	comms disconnect.
]

{ #category : #actions }
DAPClient >> setBreakpointInFile: aFileReference lines: anArray [ 
	| source fileReference |

	fileReference := aFileReference asFileReference.
	source := DAPSource new
		name: fileReference basename;
		path: fileReference fullName.
	^ self setBreakpointInSource: source lines: anArray.
]

{ #category : #actions }
DAPClient >> setBreakpointInSource: aDAPSource lines: anArray [
	"Set a breakpoint in the supplied filename at the given line numbers.
	anArray must be an Array of Integer"
	| request arguments response |

	arguments := DAPSetBreakpointsArguments new
		source: aDAPSource;
		lines: anArray;
		breakpoints: (anArray collect: [ :lineNumber | { 'line' -> lineNumber } asDictionary ]);
		sourceModified: false.
	request := DAPSetBreakpointsRequest new
		arguments: arguments.
	response := self sendMessageAndWait: request.
	response breakpoints do: [ :aDictionary | | breakpoint |
		breakpoint := DAPBreakpoint fromDictionary: aDictionary client: self.
		self registerBreakpoint: breakpoint ]

]

{ #category : #actions }
DAPClient >> setBreakpointsInSource: aDAPSource specs: anArray [
	"Ask the server to stop at exactly these places in one file, and answer
	what it made of them. A spec is a dictionary with a line and, when it
	matters which form on that line is meant, a column.

	setBreakpointInSource:lines: is the same request without columns, from
	before any back end could say which form on a line it stopped at."
	| arguments request response confirmed |

	arguments := DAPSetBreakpointsArguments new
		source: aDAPSource;
		lines: (anArray collect: [ :each | each at: 'line' ]);
		breakpoints: anArray;
		sourceModified: false.
	request := DAPSetBreakpointsRequest new arguments: arguments.
	response := self sendMessageAndWait: request.
	confirmed := response breakpoints ifNil: [ #() ].
	self removeBreakpointsInSource: aDAPSource path.
	confirmed do: [ :aDictionary |
		self registerBreakpoint: (DAPBreakpoint fromDictionary: aDictionary client: self) ].
	self rememberSpecs: anArray resolvedFrom: confirmed inSource: aDAPSource path.
	^ self breakpointsInSource: aDAPSource path
]

{ #category : #actions }
DAPClient >> setExceptionBreakpoints [
	| arguments request |

	arguments := DAPSetExceptionBreakpointsArguments new 
		filters: #(uncaught).
	request := DAPSetExceptionBreakpointsRequest new
		arguments: arguments.
	self sendMessage: request.
]

{ #category : #actions }
DAPClient >> setFunctionBreakpoints: requestArguments [
	| request response |

	request := DAPSetFunctionBreakpointsRequest new arguments: requestArguments.
	response := self sendMessageAndWait: request.
	response breakpoints do: [ :aDictionary | | breakpoint |
		breakpoint := DAPBreakpoint fromDictionary: aDictionary client: self.
		self registerBreakpoint: breakpoint ]

]

{ #category : #actions }
DAPClient >> setVariableNamed: aString reference: variablesReference to: anObject [
	"Set the specified variable and answer the DAPVariable"
	| request arguments |

	arguments := DAPSetVariableArguments new
		name: aString;
		variablesReference: variablesReference;
		value: anObject asString.
	request := DAPSetVariableRequest new
		arguments: arguments.
	^ self sendMessageAndWait: request.

]

{ #category : #messages }
DAPClient >> sourceCodeFor: aDAPSource [
	| request arguments |

	arguments := DAPSourceArguments new 
		sourceReference: aDAPSource sourceReference;
		source: { #path -> aDAPSource path. #sourceReference -> aDAPSource sourceReference } asDictionary.
	request := DAPSourceRequest new
		arguments: arguments.
	^ (self sendMessageAndWait: request) content.
]

{ #category : #private }
DAPClient >> specForLine: aLine column: aColumnOrNil [
	"One breakpoint as the request wants it: a line, and a column when it is
	known which form on the line is meant."

	^ aColumnOrNil
		ifNil: [ { 'line' -> aLine } asDictionary ]
		ifNotNil: [ { 'line' -> aLine. 'column' -> aColumnOrNil } asDictionary ]
]

{ #category : #private }
DAPClient >> startQueueProcessor [
	"Start the process for processing messages from the remote debugger."

	queueProcessor := [ [ self isConnected ] whileTrue: 
		[ self processMessage: messageQueue next ].
			] forkAt: Processor userSchedulingPriority - 1 named: 'DAP Queue Processor'.
]

{ #category : #printing }
DAPClient >> statusString [

	serverState ifNil: 
		[ ^ '<unknown>' ].

	self stoppedThread ifNotNil: [ :thread |
		^ String streamContents: [ :stream |
			stream
				<< thread displayName;
				<< ': ';
				<< thread state ] ].

	^ serverState
]

{ #category : #actions }
DAPClient >> stepBackInThreadId: aNumber [
	"Step back"

	^ self sendMessageAndWait: (DAPStepBackRequest new arguments: 
		(DAPStepBackArguments new threadId: aNumber)).
]

{ #category : #actions }
DAPClient >> stepIntoInThreadId: aNumber [
	"Step into the next statement"

	^ self sendMessageAndWait: (DAPStepInRequest new arguments: 
		(DAPStepInArguments new threadId: aNumber)).
]

{ #category : #actions }
DAPClient >> stepOutInThreadId: aNumber [
	"Step out (of somewhere)?"

	^ self sendMessageAndWait: (DAPStepOutRequest new arguments: 
		(DAPStepOutArguments new threadId: aNumber)).
]

{ #category : #accessing }
DAPClient >> stoppedThread [
	"Answer the thread in the stopped state, or nil"

	^ threads
		detect: #isStopped 
		ifNone: nil
]

{ #category : #actions }
DAPClient >> terminate [
	| arguments request |

	arguments := DAPTerminateArguments new 
		restart: false.
	request := DAPTerminateRequest new
		arguments: arguments.
	self sendMessage: request.

]

{ #category : #actions }
DAPClient >> terminateAndKillProcesses [
	"Send a terminate request to the client and then forcefully kill the processes"
	| retries |

	self terminate.
	retries := 0.
	[ self isTerminated not and: [ retries < 20 ] ] whileTrue:
		[ 0.2 seconds wait.
		retries := retries + 1 ].
	self killProcesses.
]

{ #category : #accessing }
DAPClient >> threads [
	^ threads
]

{ #category : #actions }
DAPClient >> toggleBreakpointInSource: aDAPSource line: aLine [
	"The whole line, for a caller with no column to offer: the outermost form
	on it."

	^ self toggleBreakpointInSource: aDAPSource line: aLine column: 0
]

{ #category : #actions }
DAPClient >> toggleBreakpointInSource: aDAPSource line: aLine column: aColumn [
	"Put a breakpoint on the form the cursor is in, or take away the one
	already there. The protocol has a request for neither: both are the
	file's whole list of breakpoints, sent again."
	| place entries line column kept |

	place := self breakpointPlaceIn: aDAPSource line: aLine column: aColumn.
	place ifNil: [ ^ nil ].
	line := place at: 'line'.
	column := place at: 'column' ifAbsent: [ nil ].
	entries := self breakpointEntriesInSource: aDAPSource path.
	kept := entries reject: [ :each | self entry: each isAt: line column: column ].
	kept size = entries size ifTrue: [
		kept := kept , { (self specForLine: line column: column) -> nil } ].
	^ self setBreakpointsInSource: aDAPSource specs: (kept collect: [ :each | each key ])
]

{ #category : #messages }
DAPClient >> variablesForReference: aNumber [ 
	| arguments request |

	arguments := DAPVariablesArguments new variablesReference: aNumber.
	request := DAPVariablesRequest new arguments: arguments.
	^ self sendMessageAndWait: request.
]
