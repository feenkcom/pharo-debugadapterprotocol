"
Response to 'runInTerminal' request.
"
Class {
	#name : #DAPRunInTerminalResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPRunInTerminalResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #visiting }
DAPRunInTerminalResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitRunInTerminalResponse: self
]

{ #category : #accessing }
DAPRunInTerminalResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPRunInTerminalResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPRunInTerminalResponse >> processId [
	"The process ID. The value should be less than or equal to 2147483647 (2^31-1).
	integer
	Auto-generated method"
	| result |

	result := self body at: #processId ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPRunInTerminalResponse >> processId: anObject [
	"The process ID. The value should be less than or equal to 2147483647 (2^31-1).
	integer
	Auto-generated method"

	self body at: #processId put: anObject
]

{ #category : #accessing }
DAPRunInTerminalResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body shellProcessId processId )
]

{ #category : #accessing }
DAPRunInTerminalResponse >> shellProcessId [
	"The process ID of the terminal shell. The value should be less than or equal to 2147483647 (2^31-1).
	integer
	Auto-generated method"
	| result |

	result := self body at: #shellProcessId ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPRunInTerminalResponse >> shellProcessId: anObject [
	"The process ID of the terminal shell. The value should be less than or equal to 2147483647 (2^31-1).
	integer
	Auto-generated method"

	self body at: #shellProcessId put: anObject
]
