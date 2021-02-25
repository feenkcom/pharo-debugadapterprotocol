Class {
	#name : #DAPDebugger,
	#superclass : #Object,
	#instVars : [
		'client'
	],
	#category : #'DebugAdapterProtocol-Client'
}

{ #category : #'instance creation' }
DAPDebugger class >> connectTo: host port: portNumber [

	^ self new connectTo: host port: portNumber
]

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
 			host: 'localhost';
			port: 5678);
		pathMappings: {
			{
 				'localRoot' -> '/home/alistair/python/conda1'.
				'remoteRoot' -> '.'.
			} asDictionary };
		pythonPath: '/usr/bin/python';
		debugOptions: { 'RedirectOutput', 'UnixClient', 'ShowReturnValue' };
		justMyCode: true;
		showReturnValue: true;
		workspaceFolder: '/home/alistair/python/conda1';
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
DAPDebugger >> connectTo: host port: portNumber [

	client := DAPClient connectTo: host port: portNumber debugger: self.
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
DAPDebugger >> gtThreadsFor: aView [
	<gtView>

	(client isConnected not or: [ client isTerminated ]) ifTrue: [ ^ aView empty ].
	^ aView forward 
		title: 'Threads';
		priority: 10;
		object: [ client ];
		view: #gtThreadsFor:
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
	client sendMessageAndWait: request.
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
DAPDebugger >> isTerminated [

	^ client isTerminated
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
	client sendMessageAndWait: request.
]
