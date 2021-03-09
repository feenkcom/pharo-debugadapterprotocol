"
Arguments for 'evaluate' request.
"
Class {
	#name : #DAPEvaluateArguments,
	#superclass : #DAPObject,
	#instVars : [
		'context',
		'expression',
		'format',
		'frameId'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPEvaluateArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #context to: #context.
		mapping mapAccessor: #frameId to: #frameId.
		mapping mapAccessor: #expression to: #expression.
		mapping mapAccessor: #format to: #format.
		].

]

{ #category : #visiting }
DAPEvaluateArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitEvaluateArguments: self
]

{ #category : #accessing }
DAPEvaluateArguments >> context [
	"The context in which the evaluate request is run.
	string
	Auto-generated method"

	^ context
]

{ #category : #accessing }
DAPEvaluateArguments >> context: anObject [
	"The context in which the evaluate request is run.
	string
	Auto-generated method"

	context := anObject

]

{ #category : #accessing }
DAPEvaluateArguments >> expression [
	"The expression to evaluate.
	string
	Auto-generated method"

	^ expression
]

{ #category : #accessing }
DAPEvaluateArguments >> expression: anObject [
	"The expression to evaluate.
	string
	Auto-generated method"

	expression := anObject

]

{ #category : #accessing }
DAPEvaluateArguments >> format [
	"Specifies details on how to format the Evaluate result.
The attribute is only honored by a debug adapter if the capability 'supportsValueFormattingOptions' is true.
	#/definitions/ValueFormat
	Auto-generated method"

	^ format
]

{ #category : #accessing }
DAPEvaluateArguments >> format: anObject [
	"Specifies details on how to format the Evaluate result.
The attribute is only honored by a debug adapter if the capability 'supportsValueFormattingOptions' is true.
	#/definitions/ValueFormat
	Auto-generated method"

	format := anObject isDictionary ifTrue:
		[ DAPValueFormat fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPEvaluateArguments >> frameId [
	"Evaluate the expression in the scope of this stack frame. If not specified, the expression is evaluated in the global scope.
	integer
	Auto-generated method"

	^ frameId
]

{ #category : #accessing }
DAPEvaluateArguments >> frameId: anObject [
	"Evaluate the expression in the scope of this stack frame. If not specified, the expression is evaluated in the global scope.
	integer
	Auto-generated method"

	frameId := anObject

]

{ #category : #accessing }
DAPEvaluateArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(context expression format frameId )
]
