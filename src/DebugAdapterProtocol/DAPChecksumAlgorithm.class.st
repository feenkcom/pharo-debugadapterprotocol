"
Names of checksum algorithms that may be supported by a debug adapter.
"
Class {
	#name : #DAPChecksumAlgorithm,
	#superclass : #DAPObject,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPChecksumAlgorithm class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : #visiting }
DAPChecksumAlgorithm >> acceptVisitor: aVisitor [

	^ aVisitor visitChecksumAlgorithm: self
]

{ #category : #accessing }
DAPChecksumAlgorithm >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
