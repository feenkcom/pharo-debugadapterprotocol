"
Response to 'evaluate' request.
"
Class {
	#name : #DAPEvaluateResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPEvaluateResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #visiting }
DAPEvaluateResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitEvaluateResponse: self
]

{ #category : #accessing }
DAPEvaluateResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPEvaluateResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPEvaluateResponse >> indexedVariables [
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
DAPEvaluateResponse >> indexedVariables: anObject [
	"The number of indexed child variables.
The client can use this optional information to present the variables in a paged UI and fetch them in chunks.
The value should be less than or equal to 2147483647 (2^31-1).
	integer
	Auto-generated method"

	self body at: #indexedVariables put: anObject
]

{ #category : #accessing }
DAPEvaluateResponse >> memoryReference [
	"Optional memory reference to a location appropriate for this result.
For pointer type eval results, this is generally a reference to the memory address contained in the pointer.
This attribute should be returned by a debug adapter if the client has passed the value true for the 'supportsMemoryReferences' capability of the 'initialize' request.
	string
	Auto-generated method"
	| result |

	result := self body at: #memoryReference ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPEvaluateResponse >> memoryReference: anObject [
	"Optional memory reference to a location appropriate for this result.
For pointer type eval results, this is generally a reference to the memory address contained in the pointer.
This attribute should be returned by a debug adapter if the client has passed the value true for the 'supportsMemoryReferences' capability of the 'initialize' request.
	string
	Auto-generated method"

	self body at: #memoryReference put: anObject
]

{ #category : #accessing }
DAPEvaluateResponse >> namedVariables [
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
DAPEvaluateResponse >> namedVariables: anObject [
	"The number of named child variables.
The client can use this optional information to present the variables in a paged UI and fetch them in chunks.
The value should be less than or equal to 2147483647 (2^31-1).
	integer
	Auto-generated method"

	self body at: #namedVariables put: anObject
]

{ #category : #accessing }
DAPEvaluateResponse >> presentationHint [
	"Properties of a evaluate result that can be used to determine how to render the result in the UI.
	#/definitions/VariablePresentationHint
	Auto-generated method"
	| result |

	result := self body at: #presentationHint ifAbsent: [ nil ].
	result isDictionary ifTrue:
		[ result := DAPVariablePresentationHint fromDictionary: result client: client ].
	^ result
]

{ #category : #accessing }
DAPEvaluateResponse >> presentationHint: anObject [
	"Properties of a evaluate result that can be used to determine how to render the result in the UI.
	#/definitions/VariablePresentationHint
	Auto-generated method"

	self body at: #presentationHint put: anObject
]

{ #category : #accessing }
DAPEvaluateResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body indexedVariables presentationHint result memoryReference variablesReference namedVariables type )
]

{ #category : #accessing }
DAPEvaluateResponse >> result [
	"The result of the evaluate request.
	string
	Auto-generated method"
	| result |

	result := self body at: #result ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPEvaluateResponse >> result: anObject [
	"The result of the evaluate request.
	string
	Auto-generated method"

	self body at: #result put: anObject
]

{ #category : #accessing }
DAPEvaluateResponse >> type [
	"The optional type of the evaluate result.
This attribute should only be returned by a debug adapter if the client has passed the value true for the 'supportsVariableType' capability of the 'initialize' request.
	string
	Auto-generated method"
	| result |

	result := self body at: #type ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPEvaluateResponse >> type: anObject [
	"The optional type of the evaluate result.
This attribute should only be returned by a debug adapter if the client has passed the value true for the 'supportsVariableType' capability of the 'initialize' request.
	string
	Auto-generated method"

	self body at: #type put: anObject
]

{ #category : #accessing }
DAPEvaluateResponse >> variablesReference [
	"If variablesReference is > 0, the evaluate result is structured and its children can be retrieved by passing variablesReference to the VariablesRequest.
The value should be less than or equal to 2147483647 (2^31-1).
	integer
	Auto-generated method"
	| result |

	result := self body at: #variablesReference ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPEvaluateResponse >> variablesReference: anObject [
	"If variablesReference is > 0, the evaluate result is structured and its children can be retrieved by passing variablesReference to the VariablesRequest.
The value should be less than or equal to 2147483647 (2^31-1).
	integer
	Auto-generated method"

	self body at: #variablesReference put: anObject
]
