"
Provides formatting information for a value.

"
Class {
	#name : #DAPValueFormat,
	#superclass : #DAPObject,
	#instVars : [
		'hex'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPValueFormat class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #hex to: #hex.
		].

]

{ #category : #visiting }
DAPValueFormat >> acceptVisitor: aVisitor [

	^ aVisitor visitValueFormat: self
]

{ #category : #accessing }
DAPValueFormat >> hex [
	"Display the value in hex.
	boolean
	Auto-generated method"

	^ hex
]

{ #category : #accessing }
DAPValueFormat >> hex: anObject [
	"Display the value in hex.
	boolean
	Auto-generated method"

	hex := anObject

]

{ #category : #accessing }
DAPValueFormat >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(hex )
]
