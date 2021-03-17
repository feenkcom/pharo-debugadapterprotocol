"
A Variable is a name/value pair.
Optionally a variable can have a 'type' that is shown if space permits or when hovering over the variable's name.
An optional 'kind' is used to render additional properties of the variable, e.g. different icons can be used to indicate that a variable is public or private.
If the value is structured (has children), a handle is provided to retrieve the children with the VariablesRequest.
If the number of named or indexed children is large, the numbers should be returned via the optional 'namedVariables' and 'indexedVariables' attributes.
The client can use this optional information to present the children in a paged UI and fetch them in chunks.
"
Class {
	#name : #DAPVariable,
	#superclass : #DAPObject,
	#instVars : [
		'evaluateName',
		'indexedVariables',
		'memoryReference',
		'name',
		'namedVariables',
		'presentationHint',
		'type',
		'value',
		'variablesReference',
		'scope'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPVariable class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #indexedVariables to: #indexedVariables.
		mapping mapAccessor: #memoryReference to: #memoryReference.
		mapping mapAccessor: #value to: #value.
		mapping mapAccessor: #presentationHint to: #presentationHint.
		mapping mapAccessor: #variablesReference to: #variablesReference.
		mapping mapAccessor: #namedVariables to: #namedVariables.
		mapping mapAccessor: #evaluateName to: #evaluateName.
		mapping mapAccessor: #name to: #name.
		mapping mapAccessor: #type to: #type.
		].

]

{ #category : #visiting }
DAPVariable >> acceptVisitor: aVisitor [

	^ aVisitor visitVariable: self
]

{ #category : #accessing }
DAPVariable >> evaluateName [
	"Optional evaluatable name of this variable which can be passed to the 'EvaluateRequest' to fetch the variable's value.
	string
	Auto-generated method"

	^ evaluateName
]

{ #category : #accessing }
DAPVariable >> evaluateName: anObject [
	"Optional evaluatable name of this variable which can be passed to the 'EvaluateRequest' to fetch the variable's value.
	string
	Auto-generated method"

	evaluateName := anObject

]

{ #category : #accessing }
DAPVariable >> indexedVariables [
	"The number of indexed child variables.
The client can use this optional information to present the children in a paged UI and fetch them in chunks.
	integer
	Auto-generated method"

	^ indexedVariables
]

{ #category : #accessing }
DAPVariable >> indexedVariables: anObject [
	"The number of indexed child variables.
The client can use this optional information to present the children in a paged UI and fetch them in chunks.
	integer
	Auto-generated method"

	indexedVariables := anObject

]

{ #category : #accessing }
DAPVariable >> memoryReference [
	"Optional memory reference for the variable if the variable represents executable code, such as a function pointer.
This attribute is only required if the client has passed the value true for the 'supportsMemoryReferences' capability of the 'initialize' request.
	string
	Auto-generated method"

	^ memoryReference
]

{ #category : #accessing }
DAPVariable >> memoryReference: anObject [
	"Optional memory reference for the variable if the variable represents executable code, such as a function pointer.
This attribute is only required if the client has passed the value true for the 'supportsMemoryReferences' capability of the 'initialize' request.
	string
	Auto-generated method"

	memoryReference := anObject

]

{ #category : #accessing }
DAPVariable >> name [
	"The variable's name.
	string
	Auto-generated method"

	^ name
]

{ #category : #accessing }
DAPVariable >> name: anObject [
	"The variable's name.
	string
	Auto-generated method"

	name := anObject

]

{ #category : #accessing }
DAPVariable >> namedVariables [
	"The number of named child variables.
The client can use this optional information to present the children in a paged UI and fetch them in chunks.
	integer
	Auto-generated method"

	^ namedVariables
]

{ #category : #accessing }
DAPVariable >> namedVariables: anObject [
	"The number of named child variables.
The client can use this optional information to present the children in a paged UI and fetch them in chunks.
	integer
	Auto-generated method"

	namedVariables := anObject

]

{ #category : #accessing }
DAPVariable >> pharoValue [
	"Answer the receiver's value converted to the equivalent Pharo object"

	self type = #int ifTrue: [ ^ self value asNumber ].
	^ self value
]

{ #category : #accessing }
DAPVariable >> presentationHint [
	"Properties of a variable that can be used to determine how to render the variable in the UI.
	#/definitions/VariablePresentationHint
	Auto-generated method"

	^ presentationHint
]

{ #category : #accessing }
DAPVariable >> presentationHint: anObject [
	"Properties of a variable that can be used to determine how to render the variable in the UI.
	#/definitions/VariablePresentationHint
	Auto-generated method"

	presentationHint := anObject isDictionary ifTrue:
		[ DAPVariablePresentationHint fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #printing }
DAPVariable >> printOn: aStream [

	aStream << self value asString
]

{ #category : #accessing }
DAPVariable >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(evaluateName indexedVariables memoryReference name namedVariables presentationHint type value variablesReference )
]

{ #category : #accessing }
DAPVariable >> scope [
	^ scope
]

{ #category : #accessing }
DAPVariable >> scope: anObject [
	scope := anObject
]

{ #category : #accessing }
DAPVariable >> setValue: anObject [
	"Update the receiver's value in the debugger"

	scope setVariableNamed: name to: anObject.
	self value: anObject
]

{ #category : #accessing }
DAPVariable >> type [
	"The type of the variable's value. Typically shown in the UI when hovering over the value.
This attribute should only be returned by a debug adapter if the client has passed the value true for the 'supportsVariableType' capability of the 'initialize' request.
	string
	Auto-generated method"

	^ type
]

{ #category : #accessing }
DAPVariable >> type: anObject [
	"The type of the variable's value. Typically shown in the UI when hovering over the value.
This attribute should only be returned by a debug adapter if the client has passed the value true for the 'supportsVariableType' capability of the 'initialize' request.
	string
	Auto-generated method"

	type := anObject

]

{ #category : #accessing }
DAPVariable >> value [
	"The variable's value. This can be a multi-line text, e.g. for a function the body of a function.
	string
	Auto-generated method"

	^ value
]

{ #category : #accessing }
DAPVariable >> value: anObject [
	"The variable's value. This can be a multi-line text, e.g. for a function the body of a function.
	string
	Auto-generated method"

	value := anObject

]

{ #category : #accessing }
DAPVariable >> variablesReference [
	"If variablesReference is > 0, the variable is structured and its children can be retrieved by passing variablesReference to the VariablesRequest.
	integer
	Auto-generated method"

	^ variablesReference
]

{ #category : #accessing }
DAPVariable >> variablesReference: anObject [
	"If variablesReference is > 0, the variable is structured and its children can be retrieved by passing variablesReference to the VariablesRequest.
	integer
	Auto-generated method"

	variablesReference := anObject

]
