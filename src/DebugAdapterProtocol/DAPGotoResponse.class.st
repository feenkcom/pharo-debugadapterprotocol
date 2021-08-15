"
Response to 'goto' request. This is just an acknowledgement, so no body field is required.

"
Class {
	#name : 'DAPGotoResponse',
	#superclass : 'DAPResponse',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPGotoResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : 'visiting' }
DAPGotoResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitGotoResponse: self
]

{ #category : 'accessing' }
DAPGotoResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
