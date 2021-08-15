"
Logical areas that can be invalidated by the 'invalidated' event.

"
Class {
	#name : 'DAPInvalidatedAreas',
	#superclass : 'DAPObject',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPInvalidatedAreas class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : 'visiting' }
DAPInvalidatedAreas >> acceptVisitor: aVisitor [

	^ aVisitor visitInvalidatedAreas: self
]

{ #category : 'accessing' }
DAPInvalidatedAreas >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
