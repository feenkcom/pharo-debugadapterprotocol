"
Reads bytes from memory at the provided location.
Clients should only call this request if the capability 'supportsReadMemoryRequest' is true.

"
Class {
	#name : #DAPReadMemoryRequest,
	#superclass : #DAPRequest,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPReadMemoryRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(readMemory )
]

{ #category : #'json - configuration' }
DAPReadMemoryRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPReadMemoryRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitReadMemoryRequest: self
]

{ #category : #accessing }
DAPReadMemoryRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPReadMemoryRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPReadMemoryArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPReadMemoryRequest >> command [
	"readMemory: 
	Auto-generated method"

	^ command ifNil: [ 'readMemory' ]
]

{ #category : #accessing }
DAPReadMemoryRequest >> command: anObject [
	"readMemory: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPReadMemoryRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
