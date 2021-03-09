"
The request retrieves the source code for a given source reference.
"
Class {
	#name : #DAPSourceRequest,
	#superclass : #DAPRequest,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPSourceRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(source )
]

{ #category : #'json - configuration' }
DAPSourceRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPSourceRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitSourceRequest: self
]

{ #category : #accessing }
DAPSourceRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPSourceRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPSourceArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPSourceRequest >> command [
	"source: 
	Auto-generated method"

	^ command ifNil: [ 'source' ]
]

{ #category : #accessing }
DAPSourceRequest >> command: anObject [
	"source: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPSourceRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
