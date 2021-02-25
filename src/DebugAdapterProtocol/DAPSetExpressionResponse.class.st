"
Response to 'setExpression' request.
"
Class {
	#name : #DAPSetExpressionResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPSetExpressionResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #visiting }
DAPSetExpressionResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitSetExpressionResponse: self
]

{ #category : #accessing }
DAPSetExpressionResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPSetExpressionResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPSetExpressionResponse >> indexedVariables [
	"The number of indexed child variables.
The client can use this optional information to present the variables in a paged UI and fetch them in chunks.
The value should be less than or equal to 2147483647 (2^31-1).
	integer
	Auto-generated method"
	| result |

	result := self body at: #indexedVariables ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPSetExpressionResponse >> indexedVariables: anObject [
	"The number of indexed child variables.
The client can use this optional information to present the variables in a paged UI and fetch them in chunks.
The value should be less than or equal to 2147483647 (2^31-1).
	integer
	Auto-generated method"

	self body at: #indexedVariables put: anObject
]

{ #category : #accessing }
DAPSetExpressionResponse >> namedVariables [
	"The number of named child variables.
The client can use this optional information to present the variables in a paged UI and fetch them in chunks.
The value should be less than or equal to 2147483647 (2^31-1).
	integer
	Auto-generated method"
	| result |

	result := self body at: #namedVariables ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPSetExpressionResponse >> namedVariables: anObject [
	"The number of named child variables.
The client can use this optional information to present the variables in a paged UI and fetch them in chunks.
The value should be less than or equal to 2147483647 (2^31-1).
	integer
	Auto-generated method"

	self body at: #namedVariables put: anObject
]

{ #category : #accessing }
DAPSetExpressionResponse >> presentationHint [
	"Properties of a value that can be used to determine how to render the result in the UI.
	#/definitions/VariablePresentationHint
	Auto-generated method"
	| result |

	result := self body at: #presentationHint ifAbsent: [ nil ].
	result isDictionary ifTrue:
		[ result := DAPVariablePresentationHint fromDictionary: result client: client ].
	^ result
]

{ #category : #accessing }
DAPSetExpressionResponse >> presentationHint: anObject [
	"Properties of a value that can be used to determine how to render the result in the UI.
	#/definitions/VariablePresentationHint
	Auto-generated method"

	self body at: #presentationHint put: anObject
]

{ #category : #accessing }
DAPSetExpressionResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body value presentationHint indexedVariables variablesReference namedVariables type )
]

{ #category : #accessing }
DAPSetExpressionResponse >> type [
	"The optional type of the value.
This attribute should only be returned by a debug adapter if the client has passed the value true for the 'supportsVariableType' capability of the 'initialize' request.
	string
	Auto-generated method"
	| result |

	result := self body at: #type ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPSetExpressionResponse >> type: anObject [
	"The optional type of the value.
This attribute should only be returned by a debug adapter if the client has passed the value true for the 'supportsVariableType' capability of the 'initialize' request.
	string
	Auto-generated method"

	self body at: #type put: anObject
]

{ #category : #accessing }
DAPSetExpressionResponse >> value [
	"The new value of the expression.
	string
	Auto-generated method"
	| result |

	result := self body at: #value ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPSetExpressionResponse >> value: anObject [
	"The new value of the expression.
	string
	Auto-generated method"

	self body at: #value put: anObject
]

{ #category : #accessing }
DAPSetExpressionResponse >> variablesReference [
	"If variablesReference is > 0, the value is structured and its children can be retrieved by passing variablesReference to the VariablesRequest.
The value should be less than or equal to 2147483647 (2^31-1).
	integer
	Auto-generated method"
	| result |

	result := self body at: #variablesReference ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPSetExpressionResponse >> variablesReference: anObject [
	"If variablesReference is > 0, the value is structured and its children can be retrieved by passing variablesReference to the VariablesRequest.
The value should be less than or equal to 2147483647 (2^31-1).
	integer
	Auto-generated method"

	self body at: #variablesReference put: anObject
]
