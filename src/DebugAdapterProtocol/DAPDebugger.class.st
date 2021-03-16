Class {
	#name : #DAPDebugger,
	#superclass : #Object,
	#instVars : [
		'client',
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
DAPDebugger >> configurationDone [
	"Let the server know we've finished configuration"

	client sendMessageAndWait: DAPConfigurationDoneRequest new.
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
DAPDebugger >> gtStderrFor: aView [
	<gtView>

	^ aView forward 
		title: 'stderr';
		priority: 20;
		object: [ client ];
		view: #gtStderrFor:
]

{ #category : #ui }
DAPDebugger >> gtStdoutFor: aView [
	<gtView>

	^ aView forward 
		title: 'stdout';
		priority: 20;
		object: [ client ];
		view: #gtStdoutFor:
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

{ #category : #actions }
DAPDebugger >> setBreakpointInFile: aFileReference lines: anArray [ 

	client setBreakpointInFile: aFileReference lines: anArray 
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

	^ client 
		ifNil: [ '<no client>' ]
		ifNotNil: [ client statusString ]
]

{ #category : #actions }
DAPDebugger >> stepOver [ 

	self stoppedThread stepOver
]

{ #category : #accessing }
DAPDebugger >> stoppedThread [
	"Answer the thread in the stopped state, or nil"

	^ client stoppedThread
]
