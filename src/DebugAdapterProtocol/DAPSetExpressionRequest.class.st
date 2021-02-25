"
Evaluates the given 'value' expression and assigns it to the 'expression' which must be a modifiable l-value.
The expressions have access to any variables and arguments that are in scope of the specified frame.
Clients should only call this request if the capability 'supportsSetExpression' is true.
"
Class {
	#name : #DAPSetExpressionRequest,
	#superclass : #DAPRequest,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPSetExpressionRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(setExpression )
]

{ #category : #'json - configuration' }
DAPSetExpressionRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPSetExpressionRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitSetExpressionRequest: self
]

{ #category : #accessing }
DAPSetExpressionRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPSetExpressionRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPSetExpressionArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPSetExpressionRequest >> command [
	"setExpression: 
	Auto-generated method"

	^ command ifNil: [ 'setExpression' ]
]

{ #category : #accessing }
DAPSetExpressionRequest >> command: anObject [
	"setExpression: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPSetExpressionRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(command arguments )
]
