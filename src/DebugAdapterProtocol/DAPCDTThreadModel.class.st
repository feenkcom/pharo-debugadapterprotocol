"
DAPCDTThreadModel maps information from the CDTDebuggerClient on to the DAPThreadModel

"
Class {
	#name : #DAPCDTThreadModel,
	#superclass : #DAPThreadModel,
	#category : #'DebugAdapterProtocol-Model'
}

{ #category : #initialization }
DAPCDTThreadModel >> initialize [

	super initialize.
	threadId := 1.
]

{ #category : #accessing }
DAPCDTThreadModel >> stackFrames [ 

	^ stackFrames ifNil: [ stackFrames := client getStackFrames ]
]

{ #category : #accessing }
DAPCDTThreadModel >> state [ 
	"Since there is only one thread, the thread state is the same as the debugger state"

	^ client serverState
]
