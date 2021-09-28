"
Arguments for 'setExpression' request.

"
Class {
	#name : #DAPSetExpressionArguments,
	#superclass : #DAPObject,
	#instVars : [
		'expression',
		'format',
		'frameId',
		'value'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPSetExpressionArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #frameId to: #frameId.
		mapping mapAccessor: #expression to: #expression.
		mapping mapAccessor: #value to: #value.
		mapping mapAccessor: #format to: #format.
		].

]

{ #category : #visiting }
DAPSetExpressionArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitSetExpressionArguments: self
]

{ #category : #accessing }
DAPSetExpressionArguments >> expression [
	"The l-value expression to assign to.
	string
	Auto-generated method"

	^ expression
]

{ #category : #accessing }
DAPSetExpressionArguments >> expression: anObject [
	"The l-value expression to assign to.
	string
	Auto-generated method"

	expression := anObject

]

{ #category : #accessing }
DAPSetExpressionArguments >> format [
	"Specifies how the resulting value should be formatted.
	#/definitions/ValueFormat
	Auto-generated method"

	^ format
]

{ #category : #accessing }
DAPSetExpressionArguments >> format: anObject [
	"Specifies how the resulting value should be formatted.
	#/definitions/ValueFormat
	Auto-generated method"

	format := anObject isDictionary ifTrue:
		[ DAPValueFormat fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPSetExpressionArguments >> frameId [
	"Evaluate the expressions in the scope of this stack frame. If not specified, the expressions are evaluated in the global scope.
	integer
	Auto-generated method"

	^ frameId
]

{ #category : #accessing }
DAPSetExpressionArguments >> frameId: anObject [
	"Evaluate the expressions in the scope of this stack frame. If not specified, the expressions are evaluated in the global scope.
	integer
	Auto-generated method"

	frameId := anObject

]

{ #category : #accessing }
DAPSetExpressionArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(expression format frameId value )
]

{ #category : #accessing }
DAPSetExpressionArguments >> value [
	"The value expression to assign to the l-value expression.
	string
	Auto-generated method"

	^ value
]

{ #category : #accessing }
DAPSetExpressionArguments >> value: anObject [
	"The value expression to assign to the l-value expression.
	string
	Auto-generated method"

	value := anObject

]
