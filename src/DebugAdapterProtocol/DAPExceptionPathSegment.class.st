"
An ExceptionPathSegment represents a segment in a path that is used to match leafs or nodes in a tree of exceptions.
If a segment consists of more than one name, it matches the names provided if 'negate' is false or missing or
it matches anything except the names provided if 'negate' is true.
"
Class {
	#name : #DAPExceptionPathSegment,
	#superclass : #DAPObject,
	#instVars : [
		'negate',
		'names'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPExceptionPathSegment class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #negate to: #negate.
		mapping mapAccessor: #names to: #names.
		].

]

{ #category : #visiting }
DAPExceptionPathSegment >> acceptVisitor: aVisitor [

	^ aVisitor visitExceptionPathSegment: self
]

{ #category : #accessing }
DAPExceptionPathSegment >> names [
	"Depending on the value of 'negate' the names that should match or not match.
	array
	Auto-generated method"

	^ names
]

{ #category : #accessing }
DAPExceptionPathSegment >> names: anObject [
	"Depending on the value of 'negate' the names that should match or not match.
	array
	Auto-generated method"

	names := anObject

]

{ #category : #accessing }
DAPExceptionPathSegment >> negate [
	"If false or missing this segment matches the names provided, otherwise it matches anything except the names provided.
	boolean
	Auto-generated method"

	^ negate
]

{ #category : #accessing }
DAPExceptionPathSegment >> negate: anObject [
	"If false or missing this segment matches the names provided, otherwise it matches anything except the names provided.
	boolean
	Auto-generated method"

	negate := anObject

]

{ #category : #accessing }
DAPExceptionPathSegment >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(negate names )
]
