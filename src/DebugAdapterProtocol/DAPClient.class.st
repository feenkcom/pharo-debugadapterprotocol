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
		'capabilities'
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

{ #category : #messages }
DAPClient >> variablesForReference: aNumber [ 
	| arguments request |

	arguments := DAPVariablesArguments new variablesReference: aNumber.
	request := DAPVariablesRequest new arguments: arguments.
	^ self sendMessageAndWait: request.
]
