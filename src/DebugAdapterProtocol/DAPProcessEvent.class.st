"
The event indicates that the debugger has begun debugging a new process. Either one that it has launched, or one that it has attached to.

"
Class {
	#name : 'DAPProcessEvent',
	#superclass : 'DAPEvent',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPProcessEvent class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #event to: #event.
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : 'accessing' }
DAPProcessEvent class >> eventEnums [
	"Enumerated types for the associated attribute"

	^ #(process )
]

{ #category : 'visiting' }
DAPProcessEvent >> acceptVisitor: aVisitor [

	^ aVisitor visitProcessEvent: self
]

{ #category : 'accessing' }
DAPProcessEvent >> body [
	"Auto-generated method"

	^ body
]

{ #category : 'accessing' }
DAPProcessEvent >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : 'accessing' }
DAPProcessEvent >> event [
	"process: 
	Auto-generated method"

	^ event ifNil: [ 'process' ]
]

{ #category : 'accessing' }
DAPProcessEvent >> event: anObject [
	"process: 
	Auto-generated method"

	event := anObject

]

{ #category : 'accessing' }
DAPProcessEvent >> isLocalProcess [
	"If true, the process is running on the same computer as the debug adapter.
	boolean
	Auto-generated method"
	| result |

	result := self body at: #isLocalProcess ifAbsent: [ nil ].
	^ result
]

{ #category : 'accessing' }
DAPProcessEvent >> isLocalProcess: anObject [
	"If true, the process is running on the same computer as the debug adapter.
	boolean
	Auto-generated method"

	self body at: #isLocalProcess put: anObject
]

{ #category : 'accessing' }
DAPProcessEvent >> name [
	"The logical name of the process. This is usually the full path to process's executable file. Example: /home/example/myproj/program.js.
	string
	Auto-generated method"
	| result |

	result := self body at: #name ifAbsent: [ nil ].
	^ result
]

{ #category : 'accessing' }
DAPProcessEvent >> name: anObject [
	"The logical name of the process. This is usually the full path to process's executable file. Example: /home/example/myproj/program.js.
	string
	Auto-generated method"

	self body at: #name put: anObject
]

{ #category : 'accessing' }
DAPProcessEvent >> pointerSize [
	"The size of a pointer or address for this process, in bits. This value may be used by clients when formatting addresses for display.
	integer
	Auto-generated method"
	| result |

	result := self body at: #pointerSize ifAbsent: [ nil ].
	^ result
]

{ #category : 'accessing' }
DAPProcessEvent >> pointerSize: anObject [
	"The size of a pointer or address for this process, in bits. This value may be used by clients when formatting addresses for display.
	integer
	Auto-generated method"

	self body at: #pointerSize put: anObject
]

{ #category : 'accessing' }
DAPProcessEvent >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body event isLocalProcess name pointerSize startMethod systemProcessId )
]

{ #category : 'accessing' }
DAPProcessEvent >> startMethod [
	"Describes how the debug engine started debugging this process.
	string
	launch: Process was launched under the debugger.
	attach: Debugger attached to an existing process.
	attachForSuspendedLaunch: A project launcher component has launched a new process in a suspended state and then asked the debugger to attach.
	Auto-generated method"
	| result |

	result := self body at: #startMethod ifAbsent: [ nil ].
	result ifNil:
		[ result := 'launch' ].
	^ result
]

{ #category : 'accessing' }
DAPProcessEvent >> startMethod: anObject [
	"Describes how the debug engine started debugging this process.
	string
	launch: Process was launched under the debugger.
	attach: Debugger attached to an existing process.
	attachForSuspendedLaunch: A project launcher component has launched a new process in a suspended state and then asked the debugger to attach.
	Auto-generated method"

	self body at: #startMethod put: anObject
]

{ #category : 'accessing' }
DAPProcessEvent >> systemProcessId [
	"The system process id of the debugged process. This property will be missing for non-system processes.
	integer
	Auto-generated method"
	| result |

	result := self body at: #systemProcessId ifAbsent: [ nil ].
	^ result
]

{ #category : 'accessing' }
DAPProcessEvent >> systemProcessId: anObject [
	"The system process id of the debugged process. This property will be missing for non-system processes.
	integer
	Auto-generated method"

	self body at: #systemProcessId put: anObject
]
