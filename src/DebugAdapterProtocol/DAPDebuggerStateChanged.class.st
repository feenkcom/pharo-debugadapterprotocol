Class {
	#name : 'DAPDebuggerStateChanged',
	#superclass : 'DAPStateChanged',
	#instVars : [
		'debugger'
	],
	#category : 'DebugAdapterProtocol-Announcments'
}

{ #category : 'accessing' }
DAPDebuggerStateChanged >> debugger [
	^ debugger
]

{ #category : 'accessing' }
DAPDebuggerStateChanged >> debugger: anObject [
	debugger := anObject
]

{ #category : 'testing' }
DAPDebuggerStateChanged >> isAttached [ 

	^ debugger isAttached
]

{ #category : 'testing' }
DAPDebuggerStateChanged >> isInitialized [

	^ debugger isInitialized
]

{ #category : 'testing' }
DAPDebuggerStateChanged >> isTerminated [

	^ debugger isTerminated
]
