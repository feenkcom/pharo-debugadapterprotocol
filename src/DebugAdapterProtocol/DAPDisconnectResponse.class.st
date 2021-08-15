"
Response to 'disconnect' request. This is just an acknowledgement, so no body field is required.

"
Class {
	#name : 'DAPDisconnectResponse',
	#superclass : 'DAPResponse',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPDisconnectResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : 'visiting' }
DAPDisconnectResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitDisconnectResponse: self
]

{ #category : 'accessing' }
DAPDisconnectResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
