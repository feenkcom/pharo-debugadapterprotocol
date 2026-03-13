"
Retrieves all child variables for the given variable reference.
An optional filter can be used to limit the fetched children to either named or indexed children.

"
Class {
	#name : #DAPVariablesRequest,
	#superclass : #DAPRequest,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPVariablesRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(variables )
]

{ #category : #'json - configuration' }
DAPVariablesRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPVariablesRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitVariablesRequest: self
]

{ #category : #accessing }
DAPVariablesRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPVariablesRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPVariablesArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPVariablesRequest >> command [
	"variables: 
	Auto-generated method"

	^ command ifNil: [ 'variables' ]
]

{ #category : #accessing }
DAPVariablesRequest >> command: anObject [
	"variables: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPVariablesRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
