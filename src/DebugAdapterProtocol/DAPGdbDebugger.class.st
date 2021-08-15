Class {
	#name : 'DAPGdbDebugger',
	#superclass : 'DAPDebugger',
	#instVars : [
		'serverExecutable',
		'program',
		'arguments'
	],
	#category : 'DebugAdapterProtocol-Client'
}

{ #category : 'accessing' }
DAPGdbDebugger >> arguments [
	^ arguments
]

{ #category : 'accessing' }
DAPGdbDebugger >> arguments: anArray [ 

	arguments := anArray
]

{ #category : 'initialization' }
DAPGdbDebugger >> connect [

	localRoot ifNil: 
		[ self error: 'The localRoot directory must be set before connecting' ].

	client := DAPClient new connectToServerExecutable: serverExecutable debugger: self.
	self initializeRemote.
	self launchProgram.
	self setFunctionBreakpoints.
	self configurationDone.
	self requestAllThreads.
	self requestAllStackTraces.
]

{ #category : 'initialization' }
DAPGdbDebugger >> initialize [ 

	serverExecutable := '/home/alistair/.vscode/extensions/ms-vscode.cpptools-1.2.2/debugAdapters/OpenDebugAD7' asFileReference.
	arguments := #().
]

{ #category : 'private' }
DAPGdbDebugger >> initializeRemote [
	| requestArguments request |

	requestArguments := DAPInitializeRequestArguments new 
		clientID: 'gtoolkit';
		clientName: 'Gtoolkit Remote Debugger';
		adapterID: 'cppdbg';
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
		arguments: requestArguments;
		command: 'initialize'.
	client sendMessage: request.
]

{ #category : 'private' }
DAPGdbDebugger >> launchProgram [
	| requestArguments |

	requestArguments := { 
		#name -> '(gdb) Launch'.
		#type -> 'cppdbg'.
		#request -> #launch.
		#program -> program fullName.
		#args -> arguments.
		#stopAtEntry -> true.
		#cwd -> localRoot fullName.
		#environment -> #().
		#externalConsole -> true.
		#MIMode -> #gdb.
		#setupCommands -> (Array with: {
			#description -> 'Enable pretty-printing for gdb'.
			#text -> '-enable-pretty-printing'.
			#ignoreFailures -> true } asDictionary).
		#'__configurationTarget' -> 5.
		#'__sessionId' -> UUID new asString } asDictionary.
	client launchWithArguments: requestArguments.
]

{ #category : 'accessing' }
DAPGdbDebugger >> program [
	^ program
]

{ #category : 'accessing' }
DAPGdbDebugger >> program: aFileReference [

	program := aFileReference asFileReference 
]

{ #category : 'accessing' }
DAPGdbDebugger >> serverExecutable [
	^ serverExecutable
]

{ #category : 'accessing' }
DAPGdbDebugger >> serverExecutable: aFileReference [

	serverExecutable := aFileReference asFileReference
]

{ #category : 'initialization' }
DAPGdbDebugger >> setFunctionBreakpoints [
	| requestArguments |

	requestArguments := DAPSetFunctionBreakpointsArguments new breakpoints: #().
	^ client setFunctionBreakpoints: requestArguments
]
