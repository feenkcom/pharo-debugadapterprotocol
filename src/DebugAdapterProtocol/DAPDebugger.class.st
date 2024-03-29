Class {
	#name : #DAPDebugger,
	#superclass : #Object,
	#instVars : [
		'client',
		'localRoot'
	],
	#category : 'DebugAdapterProtocol-Client'
}

{ #category : #accessor }
DAPDebugger >> announcer [

	^ client announcer
]

{ #category : #accessing }
DAPDebugger >> atThreadId: aNumber [
	<return: #DAPThreadModel>

	^ client atThreadId: aNumber
]

{ #category : #accessing }
DAPDebugger >> breakpoints [
	"Answer the dictionary of known breakpoints"

	^ client breakpoints
]

{ #category : #accessing }
DAPDebugger >> capabilities [ 
	"Answer the capabilities of the remote server"

	^ client capabilities
]

{ #category : #initialization }
DAPDebugger >> configurationDone [
	"Let the server know we've finished configuration"

	client configurationDone
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

	^ client isStopped
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

{ #category : #accessing }
DAPDebugger >> modules [

	^ client modules
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

	client requestAllThreads
]

{ #category : #actions }
DAPDebugger >> setBreakpointInFile: aFileReference lines: anArray [ 

	client setBreakpointInFile: aFileReference lines: anArray 
]

{ #category : #initialization }
DAPDebugger >> setExceptionBreakpoints [

	client setExceptionBreakpoints
]

{ #category : #accessing }
DAPDebugger >> statusString [
	"Answer a one-line string that represents the overall state of the debugger"

	^ client 
		ifNil: [ '<no client>' ]
		ifNotNil: [ client statusString ]
]

{ #category : #accessing }
DAPDebugger >> stderr [

	^ client stderr
]

{ #category : #accessing }
DAPDebugger >> stdout [ 

	^ client stdout
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
