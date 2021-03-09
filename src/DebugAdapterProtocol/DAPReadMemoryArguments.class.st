"
Arguments for 'readMemory' request.
"
Class {
	#name : #DAPReadMemoryArguments,
	#superclass : #DAPObject,
	#instVars : [
		'count',
		'memoryReference',
		'offset'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPReadMemoryArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #memoryReference to: #memoryReference.
		mapping mapAccessor: #count to: #count.
		mapping mapAccessor: #offset to: #offset.
		].

]

{ #category : #visiting }
DAPReadMemoryArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitReadMemoryArguments: self
]

{ #category : #accessing }
DAPReadMemoryArguments >> count [
	"Number of bytes to read at the specified location and offset.
	integer
	Auto-generated method"

	^ count
]

{ #category : #accessing }
DAPReadMemoryArguments >> count: anObject [
	"Number of bytes to read at the specified location and offset.
	integer
	Auto-generated method"

	count := anObject

]

{ #category : #accessing }
DAPReadMemoryArguments >> memoryReference [
	"Memory reference to the base location from which data should be read.
	string
	Auto-generated method"

	^ memoryReference
]

{ #category : #accessing }
DAPReadMemoryArguments >> memoryReference: anObject [
	"Memory reference to the base location from which data should be read.
	string
	Auto-generated method"

	memoryReference := anObject

]

{ #category : #accessing }
DAPReadMemoryArguments >> offset [
	"Optional offset (in bytes) to be applied to the reference location before reading data. Can be negative.
	integer
	Auto-generated method"

	^ offset
]

{ #category : #accessing }
DAPReadMemoryArguments >> offset: anObject [
	"Optional offset (in bytes) to be applied to the reference location before reading data. Can be negative.
	integer
	Auto-generated method"

	offset := anObject

]

{ #category : #accessing }
DAPReadMemoryArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(count memoryReference offset )
]
