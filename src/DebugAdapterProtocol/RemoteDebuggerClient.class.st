"
RemoteDebuggerClient is an abstract class that defines the API for {{gtClass:name=DAPDebugger}}s.

Subclasses are responsible for performing the communications with the remote server.  Subclasses of {{gtClass:name=DAPDebugger}} take care of the differences between the various servers.

"
Class {
	#name : #RemoteDebuggerClient,
	#superclass : #Object,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'debugger',
		'modules',
		'threads',
		'breakpoints',
		'stdoutStream',
		'stderrStream'
	],
	#category : 'DebugAdapterProtocol-Client'
}

{ #category : #announcer }
RemoteDebuggerClient >> announcer [
	<return: #Announcer>

	^ announcer
]

{ #category : #accessing }
RemoteDebuggerClient >> atThreadId: aNumber [ 
	<return: #DAPThreadModel>

	^ threads at: aNumber ifAbsentPut: 
		[ DAPThreadModel new 
			client: self;
			threadId: aNumber ]
]

{ #category : #accessing }
RemoteDebuggerClient >> breakpoints [
	"Answer the dictionary of known breakpoints"
	<return: #Dictionary of: #DAPBreakpoint>

	^ breakpoints
]

{ #category : #accessing }
RemoteDebuggerClient >> capabilities [ 
	"Answer the capabilities of the remote server"
	<return: #DAPCapabilities>

	^ self subclassResponsibility 
]

{ #category : #actions }
RemoteDebuggerClient >> configurationDone [
	"Let the server know we've finished configuration"

	self subclassResponsibility
]

{ #category : #actions }
RemoteDebuggerClient >> continueThreadId: aNumber [
	"Instruct the debugger to continue execution"

	self subclassResponsibility 
]

{ #category : #accessing }
RemoteDebuggerClient >> debugger [
	^ debugger
]

{ #category : #accessing }
RemoteDebuggerClient >> debugger: anObject [
	debugger := anObject
]

{ #category : #actions }
RemoteDebuggerClient >> disconnect [ 

	self subclassResponsibility 
]

{ #category : #ui }
RemoteDebuggerClient >> gtBreakpointsFor: aView [
	<gtView>

	(self isConnected not or: [ self isTerminated ]) ifTrue: [ ^ aView empty ].
	^ aView columnedList
		title: 'Breakpoints';
		priority: 20;
		items: [ breakpoints associations sorted: [ :a :b | a key < b key ] ];
		column: 'Id' text: [ :item | item key ];
		column: 'Description' text: [ :item | item value displayLabel ];
		actionUpdateButtonTooltip: 'Update Breakpoints'

]

{ #category : #ui }
RemoteDebuggerClient >> gtModulesFor: aView [
	<gtView>

	(self isConnected not or: [ self isTerminated ]) ifTrue: [ ^ aView empty ].
	modules ifEmpty: [ ^ aView empty ].
	^ aView columnedList 
		title: 'Modules';
		priority: 20;
		items: [ modules associations ];
		column: 'Name' text: [ :item | item value name ];
		column: 'Path' text: [ :item | item value path ];
		send: [ :item | item value ];
		actionUpdateButtonTooltip: 'Update Modules'

]

{ #category : #ui }
RemoteDebuggerClient >> gtStderrFor: aView [
	<gtView>

	^ aView textEditor 
		title: 'stderr';
		priority: 20;
		text: [ stderrStream contents ];
		actionUpdateButtonTooltip: 'Update stderr'

]

{ #category : #ui }
RemoteDebuggerClient >> gtStdoutFor: aView [
	<gtView>

	^ aView textEditor 
		title: 'stdout';
		priority: 20;
		text: [ stdoutStream contents ];
		actionUpdateButtonTooltip: 'Update stdout'

]

{ #category : #ui }
RemoteDebuggerClient >> gtThreadsFor: aView [
	<gtView>

	(self isConnected not or: [ self isTerminated ]) ifTrue: [ ^ aView empty ].
	threads ifEmpty: [ ^ aView empty ].
	^ aView columnedList 
		title: 'Threads';
		priority: 20;
		items: [ threads associations sorted: [ :a :b | a key < b key ] ];
		column: 'Id' text: [ :item | item key asString ];
		column: 'Name' text: [ :item | item value displayName ];
		column: 'State' text: [ :item | item value state asString ];
		send: [ :item | item value ];
		actionUpdateButtonTooltip: 'Update Threads'

]

{ #category : #initialization }
RemoteDebuggerClient >> initialize [ 

	super initialize.
	announcer := Announcer new.
	stdoutStream := (String new: 10240) writeStream.
	stderrStream := (String new: 10240) writeStream.
	"Maintain the latest status of any threads that have been started.  Key = threadId"
	threads := Dictionary new.
	"Maintain a list of loaded modules. Key = id"
	modules := Dictionary new.
	breakpoints := Dictionary new.

]

{ #category : #testing }
RemoteDebuggerClient >> isAttached [ 

	^ self subclassResponsibility
]

{ #category : #testing }
RemoteDebuggerClient >> isConnected [

	^ self subclassResponsibility
]

{ #category : #testing }
RemoteDebuggerClient >> isInitialized [ 

	^ self subclassResponsibility
]

{ #category : #testing }
RemoteDebuggerClient >> isStopped [ 

	^ self subclassResponsibility
]

{ #category : #testing }
RemoteDebuggerClient >> isTerminated [ 

	^ self subclassResponsibility
]

{ #category : #accessing }
RemoteDebuggerClient >> modules [
	<return: #Dictionary of: #DAPModule>

	^ modules
]

{ #category : #actions }
RemoteDebuggerClient >> nextInThreadId: aNumber [
	"Instruct the debugger to step over the next instruction"

	self subclassResponsibility 
]

{ #category : #actions }
RemoteDebuggerClient >> requestAllStackTraces [ 

	self subclassResponsibility 
]

{ #category : #actions }
RemoteDebuggerClient >> requestAllThreads [ 

	self subclassResponsibility 
]

{ #category : #accessing }
RemoteDebuggerClient >> serverState [
	"Answer the state of the server.
	Known states include: nil (no activity), attached, initialized, continued, stopped, exited, terminated.
	DAP servers may add their own state, e.g. debugpyWaitingForServer"
	<return: #String>

	^ self subclassResponsibility 
]

{ #category : #actions }
RemoteDebuggerClient >> setBreakpointInFile: aFileReference lines: anArray [ 

	self subclassResponsibility 
]

{ #category : #actions }
RemoteDebuggerClient >> setExceptionBreakpoints [

	self subclassResponsibility 
]

{ #category : #accessing }
RemoteDebuggerClient >> statusString [
	"Answer a one-line string that represents the overall state of the debugger"
	<return: #String>

	^ self subclassResponsibility 
]

{ #category : #accessing }
RemoteDebuggerClient >> stderr [

	^ stderrStream contents
]

{ #category : #accessing }
RemoteDebuggerClient >> stderrNextPutAll: aString [

	stderrStream nextPutAll: aString.
	self announce: (DAPStderrUpdated new string: aString).
]

{ #category : #accessing }
RemoteDebuggerClient >> stdout [ 

	^ stdoutStream contents
]

{ #category : #accessing }
RemoteDebuggerClient >> stdoutNextPutAll: aString [

	stdoutStream nextPutAll: aString.
	self announce: (DAPStdoutUpdated new string: aString).
]

{ #category : #actions }
RemoteDebuggerClient >> stepIntoInThreadId: aNumber [
	"Step into the next statement"

	^ self subclassResponsibility 
]

{ #category : #actions }
RemoteDebuggerClient >> stepOutInThreadId: aNumber [
	"Step out (of somewhere)?"

	^ self subclassResponsibility 
]

{ #category : #actions }
RemoteDebuggerClient >> stepOverInThreadId: aNumber [
	"Pharo synonym for 'next'"

	^ self nextInThreadId: aNumber
]

{ #category : #accessing }
RemoteDebuggerClient >> stoppedThread [
	<return: #DAPThreadModel>

	^ self subclassResponsibility 
]
