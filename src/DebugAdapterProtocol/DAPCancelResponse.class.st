"
Response to 'cancel' request. This is just an acknowledgement, so no body field is required.

"
Class {
	#name : #DAPCancelResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPCancelResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : #visiting }
DAPCancelResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitCancelResponse: self
]

{ #category : #accessing }
DAPCancelResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
