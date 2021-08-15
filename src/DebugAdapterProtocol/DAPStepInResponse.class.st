"
Response to 'stepIn' request. This is just an acknowledgement, so no body field is required.

"
Class {
	#name : 'DAPStepInResponse',
	#superclass : 'DAPResponse',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPStepInResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : 'visiting' }
DAPStepInResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitStepInResponse: self
]

{ #category : 'accessing' }
DAPStepInResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
