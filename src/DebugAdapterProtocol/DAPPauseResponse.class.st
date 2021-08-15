"
Response to 'pause' request. This is just an acknowledgement, so no body field is required.

"
Class {
	#name : 'DAPPauseResponse',
	#superclass : 'DAPResponse',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPPauseResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : 'visiting' }
DAPPauseResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitPauseResponse: self
]

{ #category : 'accessing' }
DAPPauseResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
