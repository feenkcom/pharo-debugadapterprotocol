"
Arguments for 'setVariable' request.
"
Class {
	#name : #DAPSetVariableArguments,
	#superclass : #DAPObject,
	#instVars : [
		'value',
		'format',
		'variablesReference',
		'name'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPSetVariableArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #name to: #name.
		mapping mapAccessor: #value to: #value.
		mapping mapAccessor: #variablesReference to: #variablesReference.
		mapping mapAccessor: #format to: #format.
		].

]

{ #category : #visiting }
DAPSetVariableArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitSetVariableArguments: self
]

{ #category : #accessing }
DAPSetVariableArguments >> format [
	"Specifies details on how to format the response value.
	#/definitions/ValueFormat
	Auto-generated method"

	^ format
]

{ #category : #accessing }
DAPSetVariableArguments >> format: anObject [
	"Specifies details on how to format the response value.
	#/definitions/ValueFormat
	Auto-generated method"

	format := anObject isDictionary ifTrue:
		[ DAPValueFormat fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPSetVariableArguments >> name [
	"The name of the variable in the container.
	string
	Auto-generated method"

	^ name
]

{ #category : #accessing }
DAPSetVariableArguments >> name: anObject [
	"The name of the variable in the container.
	string
	Auto-generated method"

	name := anObject

]

{ #category : #accessing }
DAPSetVariableArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(name value variablesReference format )
]

{ #category : #accessing }
DAPSetVariableArguments >> value [
	"The value of the variable.
	string
	Auto-generated method"

	^ value
]

{ #category : #accessing }
DAPSetVariableArguments >> value: anObject [
	"The value of the variable.
	string
	Auto-generated method"

	value := anObject

]

{ #category : #accessing }
DAPSetVariableArguments >> variablesReference [
	"The reference of the variable container.
	integer
	Auto-generated method"

	^ variablesReference
]

{ #category : #accessing }
DAPSetVariableArguments >> variablesReference: anObject [
	"The reference of the variable container.
	integer
	Auto-generated method"

	variablesReference := anObject

]
