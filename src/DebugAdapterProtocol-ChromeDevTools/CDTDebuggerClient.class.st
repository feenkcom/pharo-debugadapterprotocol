Class {
	#name : #CDTDebuggerClient,
	#superclass : #RemoteDebuggerClient,
	#instVars : [
		'cdtDebugger'
	],
	#classVars : [
		'ServerStateMapping'
	],
	#category : #'DebugAdapterProtocol-ChromeDevTools'
}

{ #category : #'class initialization' }
CDTDebuggerClient class >> initialize [ 

	ServerStateMapping := { 
		#paused -> #stopped.
		#resumed -> #continued.
		 } asDictionary.
]

{ #category : #accessing }
CDTDebuggerClient >> capabilities [ 
	"Answer the capabilities of the remote server"
	<return: #DAPCapabilities>

	^ DAPCapabilities new 
]

{ #category : #accessing }
CDTDebuggerClient >> cdtDebugger [
	^ cdtDebugger
]

{ #category : #accessing }
CDTDebuggerClient >> cdtDebugger: aCDTDebugger [

	cdtDebugger := aCDTDebugger.
	threads at: 1 put: (DAPCDTThreadModel new client: self).
	cdtDebugger
		when: CDTDebuggerConsoleUpdated
		send: #onConsoleUpdated:
		to: self.
	cdtDebugger 
		when: CDTDebuggerClosed
		send: #onDebuggerClosed:
		to: self.
	cdtDebugger
		when: CDTDebuggerPaused
		send: #onDebuggerPaused:
		to: self.
	cdtDebugger 
		when: CDTDebuggerResumed
		send: #onDebuggerResumed:
		to: self
]

{ #category : #initialization }
CDTDebuggerClient >> cdtDebugger: aCDTDebugger debugger: aDebugger [

	self debugger: aDebugger.
	self cdtDebugger: aCDTDebugger.
]

{ #category : #actions }
CDTDebuggerClient >> configurationDone [
	"Let the server know we've finished configuration"

	"Nothing to do yet"
]

{ #category : #actions }
CDTDebuggerClient >> continueThreadId: aNumber [
	"Instruct the debugger to continue execution"

	"There's only one thread"
	self assert: aNumber equals: 1.
	cdtDebugger resume.
]

{ #category : #actions }
CDTDebuggerClient >> disconnect [ 

	cdtDebugger disconnect
]

{ #category : #private }
CDTDebuggerClient >> getStackFrames [
	"Convert the stack frames from the CDTDebugger to DAPStackFrames"
	
	^ cdtDebugger callFrames collect: [ :each |
		DAPCDTStackFrame new 
			client: self;
			cdtCallFrame: each ]
]

{ #category : #testing }
CDTDebuggerClient >> isAttached [ 
	"The CDT Debugger doesn't have an equivalent of attached"

	^ false
]

{ #category : #testing }
CDTDebuggerClient >> isConnected [

	^ cdtDebugger isOpen
]

{ #category : #testing }
CDTDebuggerClient >> isInitialized [ 
	"The CDT Debugger doesn't have an equivalent state"

	^ false
]

{ #category : #testing }
CDTDebuggerClient >> isStopped [ 

	^ cdtDebugger debuggerState = #paused
]

{ #category : #testing }
CDTDebuggerClient >> isTerminated [ 
	"Terminated is the equivalent of disconnected for the CDT debugger"

	^ self isConnected not
]

{ #category : #actions }
CDTDebuggerClient >> nextInThreadId: aNumber [
	"Instruct the debugger to step over the next instruction"

	self assert: aNumber equals: 1.
	cdtDebugger stepOver
]

{ #category : #'private - cdt announcements' }
CDTDebuggerClient >> onConsoleUpdated: aCDTDebuggerConsoleUpdated [

	self announce: (DAPStdoutUpdated new string: aCDTDebuggerConsoleUpdated string)
]

{ #category : #'private - cdt announcements' }
CDTDebuggerClient >> onDebuggerClosed: aCDTDebuggerClosed [

	self announce: (DAPDebuggerStateChanged new debugger: debugger)
]

{ #category : #'private - cdt announcements' }
CDTDebuggerClient >> onDebuggerPaused: aCDTDebuggerClosed [

	threads at: 1 put: (DAPCDTThreadModel new client: self).
	self announce: (DAPDebuggerStateChanged new debugger: debugger).
]

{ #category : #'private - cdt announcements' }
CDTDebuggerClient >> onDebuggerResumed: aCDTDebuggerClosed [

	self announce: (DAPDebuggerStateChanged new debugger: debugger)
]

{ #category : #actions }
CDTDebuggerClient >> requestAllStackTraces [ 
	"Stack traces are provided as part of the debugger state, so no explicit request is necessary"
]

{ #category : #actions }
CDTDebuggerClient >> requestAllThreads [ 
	"Node.JS is modelled as a single thread, no action required"
]

{ #category : #'accessing - cdt' }
CDTDebuggerClient >> scriptSourceFor: aScriptId [

	^ cdtDebugger scriptSourceFor: aScriptId
]

{ #category : #accessing }
CDTDebuggerClient >> serverState [ 

	^ ServerStateMapping at: cdtDebugger debuggerState ifAbsent: [ cdtDebugger debuggerState ]
]

{ #category : #actions }
CDTDebuggerClient >> setBreakpointInFile: aFileReference lines: anArray [ 

	self error: 'Not Yet Implemented'
]

{ #category : #actions }
CDTDebuggerClient >> setExceptionBreakpoints [

	cdtDebugger setPauseOnExceptions: #all
]

{ #category : #accessing }
CDTDebuggerClient >> statusString [
	"Answer a one-line string that represents the overall state of the debugger"
	<return: #String>

	cdtDebugger state ifNil: 
		[ ^ '<unknown>' ].

	self stoppedThread ifNotNil: [ :thread |
		^ String streamContents: [ :stream |
			stream
				<< thread displayName;
				<< ': ';
				<< thread state ] ].

	^ cdtDebugger debuggerState
]

{ #category : #accessing }
CDTDebuggerClient >> stdout [ 

	^ cdtDebugger console
]

{ #category : #actions }
CDTDebuggerClient >> stepIntoInThreadId: aNumber [
	"Step into the next statement"

	self assert: aNumber equals: 1.
	cdtDebugger stepInto
]

{ #category : #actions }
CDTDebuggerClient >> stepOutInThreadId: aNumber [
	"Step out (of somewhere)?"

	self assert: aNumber equals: 1.
	cdtDebugger stepOut
]

{ #category : #accessing }
CDTDebuggerClient >> stoppedThread [
	<return: #DAPThreadModel>

	self isStopped ifFalse: [ ^ nil ].

	^ self atThreadId: 1
]
