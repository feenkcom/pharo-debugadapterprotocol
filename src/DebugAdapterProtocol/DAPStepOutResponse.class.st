"
Response to 'stepOut' request. This is just an acknowledgement, so no body field is required.

"
Class {
	#name : #DAPStepOutResponse,
	#superclass : #DAPResponse,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPStepOutResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : #visiting }
DAPStepOutResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitStepOutResponse: self
]

{ #category : #accessing }
DAPStepOutResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
