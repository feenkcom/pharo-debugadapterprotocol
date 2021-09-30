"
Evaluates the given expression in the context of the top most stack frame.
The expression has access to any variables and arguments that are in scope.

"
Class {
	#name : #DAPEvaluateRequest,
	#superclass : #DAPRequest,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPEvaluateRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(evaluate )
]

{ #category : #'json - configuration' }
DAPEvaluateRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPEvaluateRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitEvaluateRequest: self
]

{ #category : #accessing }
DAPEvaluateRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPEvaluateRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPEvaluateArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPEvaluateRequest >> command [
	"evaluate: 
	Auto-generated method"

	^ command ifNil: [ 'evaluate' ]
]

{ #category : #accessing }
DAPEvaluateRequest >> command: anObject [
	"evaluate: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPEvaluateRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
