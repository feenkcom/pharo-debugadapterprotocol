Class {
	#name : #DAPDebugger,
	#superclass : #Object,
	#instVars : [
		'client',
		'host',
		'port',
		'localRoot'
	],
	#category : #'DebugAdapterProtocol-Client'
}

{ #category : #accessor }
DAPDebugger >> announcer [

	^ client announcer
]

{ #category : #accessing }
DAPDebugger >> atThreadId: aNumber [

	^ client atThreadId: aNumber
]

{ #category : #initialization }
DAPDebugger >> attachToDebuggee [
	"Send a request to the adapter to attach to a debuggee"
	| arguments request |

	arguments := DAPPythonAttachRequestArguments new 
		name: 'Python: Remote Attach';
		type: 'python';
		request: 'attach';
		connect: (DAPIPAddress new
 			host: self hostName;
			port: port);
		pathMappings: {
			{
 				'localRoot' -> localRoot fullName.
				'remoteRoot' -> localRoot fullName.
			} asDictionary };
		pythonPath: '/usr/bin/python';
		debugOptions: { 'RedirectOutput', 'UnixClient', 'ShowReturnValue' };
		justMyCode: true;
		showReturnValue: true;
		workspaceFolder: localRoot fullName;
		__sessionId: UUID new asString.
	request := DAPAttachRequest new 
		arguments: arguments;
		command: 'attach'.
	client sendMessage: request.

]

{ #category : #initialization }
DAPDebugger >> configurationDone [
	"Let the server know we've finished configuration"

	client sendMessageAndWait: DAPConfigurationDoneRequest new.
]

{ #category : #initialization }
DAPDebugger >> connectTo: aHostNameOrNumber port: aPortNumber [

	localRoot ifNil: 
		[ self error: 'The localRoot directory must be set before connecting' ].

	host := aHostNameOrNumber.
	port := aPortNumber.
	client := DAPClient connectTo: host port: port debugger: self.
	self initializeRemote.
	self attachToDebuggee.
	self setExceptionBreakpoints.
	self configurationDone.
	self requestAllThreads.
	self requestAllStackTraces.
]

{ #category : #actions }
DAPDebugger >> continueThreadId: aNumber [
	"Instruct the debugger to continue execution"

	^ client continueThreadId: aNumber
]

{ #category : #actions }
DAPDebugger >> disconnect [ 

	client disconnect
]

{ #category : #ui }
DAPDebugger >> gtBreakpointsFor: aView [
	<gtView>

	(client isConnected not or: [ client isTerminated ]) ifTrue: [ ^ aView empty ].
	^ aView forward 
		title: 'Breakpoints';
		priority: 20;
		object: [ client ];
		view: #gtBreakpointsFor:
]

{ #category : #ui }
DAPDebugger >> gtModulesFor: aView [
	<gtView>

	(client isConnected not or: [ client isTerminated ]) ifTrue: [ ^ aView empty ].
	^ aView forward 
		title: 'Modules';
		priority: 10;
		object: [ client ];
		view: #gtModulesFor:
]

{ #category : #ui }
DAPDebugger >> gtThreadsFor: aView [
	<gtView>

	(client isConnected not or: [ client isTerminated ]) ifTrue: [ ^ aView empty ].
	^ aView forward 
		title: 'Threads';
		priority: 10;
		object: [ client ];
		view: #gtThreadsFor:
]

{ #category : #accessing }
DAPDebugger >> hostName [
	"Answer the hostName as a string.
	This can only be called after connection to the debugger has been initiated"

	^ host isString 
		ifTrue: [ host ]
		ifFalse: [ String streamContents: [ :stream |
				host 
					do: [ :number | stream print: number ] 
					separatedBy: [ stream nextPut: $. ] ] ]
]

{ #category : #initialization }
DAPDebugger >> initializeRemote [
	| arguments request |

	arguments := DAPInitializeRequestArguments new 
		clientID: 'gtoolkit';
		clientName: 'Gtoolkit Remote Debugger';
		adapterID: 'python';
		pathFormat: 'path';
		linesStartAt1: true;
		columnsStartAt1: true;
		supportsVariableType: true;
		supportsVariablePaging: true;
		supportsRunInTerminalRequest: true;
		locale: 'en-us';
		supportsProgressReporting: true;
		supportsInvalidatedEvent: true.
	request := DAPInitializeRequest new 
		arguments: arguments;
		command: 'initialize'.
	client sendMessage: request.
]

{ #category : #testing }
DAPDebugger >> isAttached [ 

	^ client isAttached
]

{ #category : #testing }
DAPDebugger >> isInitialized [

	^ client isInitialized
]

{ #category : #testing }
DAPDebugger >> isStopped [
	"Answer a boolean indicating if the receiver is stopped"

	^ self stoppedThread isNotNil
]

{ #category : #testing }
DAPDebugger >> isTerminated [

	^ client isTerminated
]

{ #category : #accessing }
DAPDebugger >> localRoot [
	^ localRoot
]

{ #category : #accessing }
DAPDebugger >> localRoot: aFileReference [

	localRoot := aFileReference asFileReference
]

{ #category : #printing }
DAPDebugger >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPut: $(;
		<< self statusString;
		nextPut: $)
]

{ #category : #initialization }
DAPDebugger >> requestAllStackTraces [
	"Request stack traces for the existing threads"

	client requestAllStackTraces 
]

{ #category : #initialization }
DAPDebugger >> requestAllThreads [
	"Request a list of all the current threads in the server.
	The response visitor will update the client state."

	client sendMessageAndWait: DAPThreadsRequest new.
]

{ #category : #initialization }
DAPDebugger >> setExceptionBreakpoints [
	| arguments request |

	arguments := DAPSetExceptionBreakpointsArguments new 
		filters: #(uncaught).
	request := DAPSetExceptionBreakpointsRequest new
		arguments: arguments.
	client sendMessage: request.
]

{ #category : #accessing }
DAPDebugger >> statusString [
	"Answer a one-line string that represents the overall state of the debugger"

	^ client statusString
]

{ #category : #accessing }
DAPDebugger >> stoppedThread [
	"Answer the thread in the stopped state, or nil"

	^ client stoppedThread
]
