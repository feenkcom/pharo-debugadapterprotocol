"
Response to 'setVariable' request.

"
Class {
	#name : #DAPSetVariableResponse,
	#superclass : #DAPResponse,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPSetVariableResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #visiting }
DAPSetVariableResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitSetVariableResponse: self
]

{ #category : #accessing }
DAPSetVariableResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPSetVariableResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPSetVariableResponse >> indexedVariables [
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
DAPSetVariableResponse >> indexedVariables: anObject [
	"The number of indexed child variables.
The client can use this optional information to present the variables in a paged UI and fetch them in chunks.
The value should be less than or equal to 2147483647 (2^31-1).
	integer
	Auto-generated method"

	self body at: #indexedVariables put: anObject
]

{ #category : #accessing }
DAPSetVariableResponse >> namedVariables [
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
DAPSetVariableResponse >> namedVariables: anObject [
	"The number of named child variables.
The client can use this optional information to present the variables in a paged UI and fetch them in chunks.
The value should be less than or equal to 2147483647 (2^31-1).
	integer
	Auto-generated method"

	self body at: #namedVariables put: anObject
]

{ #category : #accessing }
DAPSetVariableResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body indexedVariables namedVariables type value variablesReference )
]

{ #category : #accessing }
DAPSetVariableResponse >> type [
	"The type of the new value. Typically shown in the UI when hovering over the value.
	string
	Auto-generated method"
	| result |

	result := self body at: #type ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPSetVariableResponse >> type: anObject [
	"The type of the new value. Typically shown in the UI when hovering over the value.
	string
	Auto-generated method"

	self body at: #type put: anObject
]

{ #category : #accessing }
DAPSetVariableResponse >> value [
	"The new value of the variable.
	string
	Auto-generated method"
	| result |

	result := self body at: #value ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPSetVariableResponse >> value: anObject [
	"The new value of the variable.
	string
	Auto-generated method"

	self body at: #value put: anObject
]

{ #category : #accessing }
DAPSetVariableResponse >> variablesReference [
	"If variablesReference is > 0, the new value is structured and its children can be retrieved by passing variablesReference to the VariablesRequest.
The value should be less than or equal to 2147483647 (2^31-1).
	integer
	Auto-generated method"
	| result |

	result := self body at: #variablesReference ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPSetVariableResponse >> variablesReference: anObject [
	"If variablesReference is > 0, the new value is structured and its children can be retrieved by passing variablesReference to the VariablesRequest.
The value should be less than or equal to 2147483647 (2^31-1).
	integer
	Auto-generated method"

	self body at: #variablesReference put: anObject
]
