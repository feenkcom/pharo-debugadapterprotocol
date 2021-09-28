"
Response to 'terminate' request. This is just an acknowledgement, so no body field is required.

"
Class {
	#name : #DAPTerminateResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPTerminateResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : #visiting }
DAPTerminateResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitTerminateResponse: self
]

{ #category : #accessing }
DAPTerminateResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
