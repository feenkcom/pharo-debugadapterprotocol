"
The request returns the variable scopes for a given stackframe ID.

"
Class {
	#name : #DAPScopesRequest,
	#superclass : #DAPRequest,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPScopesRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(scopes )
]

{ #category : #'json - configuration' }
DAPScopesRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPScopesRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitScopesRequest: self
]

{ #category : #accessing }
DAPScopesRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPScopesRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPScopesArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPScopesRequest >> command [
	"scopes: 
	Auto-generated method"

	^ command ifNil: [ 'scopes' ]
]

{ #category : #accessing }
DAPScopesRequest >> command: anObject [
	"scopes: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPScopesRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
