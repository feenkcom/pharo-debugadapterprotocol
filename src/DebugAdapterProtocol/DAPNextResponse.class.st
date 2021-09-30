"
Response to 'next' request. This is just an acknowledgement, so no body field is required.

"
Class {
	#name : #DAPNextResponse,
	#superclass : #DAPResponse,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPNextResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : #visiting }
DAPNextResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitNextResponse: self
]

{ #category : #accessing }
DAPNextResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
