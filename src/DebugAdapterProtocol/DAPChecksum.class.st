"
The checksum of an item calculated by the specified algorithm.
"
Class {
	#name : #DAPChecksum,
	#superclass : #DAPObject,
	#instVars : [
		'algorithm',
		'checksum'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPChecksum class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #checksum to: #checksum.
		mapping mapAccessor: #algorithm to: #algorithm.
		].

]

{ #category : #visiting }
DAPChecksum >> acceptVisitor: aVisitor [

	^ aVisitor visitChecksum: self
]

{ #category : #accessing }
DAPChecksum >> algorithm [
	"The algorithm used to calculate this checksum.
	#/definitions/ChecksumAlgorithm
	Auto-generated method"

	^ algorithm
]

{ #category : #accessing }
DAPChecksum >> algorithm: anObject [
	"The algorithm used to calculate this checksum.
	#/definitions/ChecksumAlgorithm
	Auto-generated method"

	algorithm := anObject isDictionary ifTrue:
		[ DAPChecksumAlgorithm fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPChecksum >> checksum [
	"Value of the checksum.
	string
	Auto-generated method"

	^ checksum
]

{ #category : #accessing }
DAPChecksum >> checksum: anObject [
	"Value of the checksum.
	string
	Auto-generated method"

	checksum := anObject

]

{ #category : #accessing }
DAPChecksum >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(algorithm checksum )
]
