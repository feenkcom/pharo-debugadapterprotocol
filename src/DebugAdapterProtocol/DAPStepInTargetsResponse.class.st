"
Response to 'stepInTargets' request.

"
Class {
	#name : 'DAPStepInTargetsResponse',
	#superclass : 'DAPResponse',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPStepInTargetsResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : 'visiting' }
DAPStepInTargetsResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitStepInTargetsResponse: self
]

{ #category : 'accessing' }
DAPStepInTargetsResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : 'accessing' }
DAPStepInTargetsResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : 'accessing' }
DAPStepInTargetsResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body targets )
]

{ #category : 'accessing' }
DAPStepInTargetsResponse >> targets [
	"The possible stepIn targets of the specified source location.
	array
	Auto-generated method"
	| result |

	result := self body at: #targets ifAbsent: [ nil ].
	^ result
]

{ #category : 'accessing' }
DAPStepInTargetsResponse >> targets: anObject [
	"The possible stepIn targets of the specified source location.
	array
	Auto-generated method"

	self body at: #targets put: anObject
]
