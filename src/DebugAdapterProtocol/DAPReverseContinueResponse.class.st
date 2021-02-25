"
Response to 'reverseContinue' request. This is just an acknowledgement, so no body field is required.
"
Class {
	#name : #DAPReverseContinueResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPReverseContinueResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : #visiting }
DAPReverseContinueResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitReverseContinueResponse: self
]

{ #category : #accessing }
DAPReverseContinueResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
