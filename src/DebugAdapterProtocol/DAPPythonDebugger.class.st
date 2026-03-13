Class {
	#name : #DAPPythonDebugger,
	#superclass : #DAPDebugger,
	#instVars : [
		'host',
		'port'
	],
	#category : #'DebugAdapterProtocol-Client'
}

{ #category : #initialization }
DAPPythonDebugger >> attachToDebuggee [
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
		debugOptions: { 'RedirectOutput'. 'UnixClient'. 'ShowReturnValue' };
		justMyCode: false;
		showReturnValue: true;
		workspaceFolder: localRoot fullName;
		__sessionId: UUID new asString.
	request := DAPAttachRequest new 
		arguments: arguments;
		command: 'attach'.
	client sendMessage: request.

]

{ #category : #initialization }
DAPPythonDebugger >> connectTo: aHostNameOrNumber port: aPortNumber [

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

{ #category : #accessing }
DAPPythonDebugger >> hostName [
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
DAPPythonDebugger >> initializeRemote [
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
		supportsRunInTerminalRequest: false;
		locale: 'en-us';
		supportsProgressReporting: true;
		supportsInvalidatedEvent: true.
	request := DAPInitializeRequest new 
		arguments: arguments;
		command: 'initialize'.
	client sendMessage: request.
]
