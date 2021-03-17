"
A Scope is a named container for variables. Optionally a scope can map to a source or a range within a source.
"
Class {
	#name : #DAPScope,
	#superclass : #DAPObject,
	#instVars : [
		'column',
		'endColumn',
		'endLine',
		'expensive',
		'indexedVariables',
		'line',
		'name',
		'namedVariables',
		'presentationHint',
		'source',
		'variables',
		'variablesReference'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPScope class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #column to: #column.
		mapping mapAccessor: #expensive to: #expensive.
		mapping mapAccessor: #line to: #line.
		mapping mapAccessor: #variablesReference to: #variablesReference.
		mapping mapAccessor: #name to: #name.
		mapping mapAccessor: #indexedVariables to: #indexedVariables.
		mapping mapAccessor: #endLine to: #endLine.
		mapping mapAccessor: #presentationHint to: #presentationHint.
		mapping mapAccessor: #namedVariables to: #namedVariables.
		mapping mapAccessor: #source to: #source.
		mapping mapAccessor: #endColumn to: #endColumn.
		].

]

{ #category : #visiting }
DAPScope >> acceptVisitor: aVisitor [

	^ aVisitor visitScope: self
]

{ #category : #accessing }
DAPScope >> column [
	"Optional start column of the range covered by this scope.
	integer
	Auto-generated method"

	^ column
]

{ #category : #accessing }
DAPScope >> column: anObject [
	"Optional start column of the range covered by this scope.
	integer
	Auto-generated method"

	column := anObject

]

{ #category : #accessing }
DAPScope >> endColumn [
	"Optional end column of the range covered by this scope.
	integer
	Auto-generated method"

	^ endColumn
]

{ #category : #accessing }
DAPScope >> endColumn: anObject [
	"Optional end column of the range covered by this scope.
	integer
	Auto-generated method"

	endColumn := anObject

]

{ #category : #accessing }
DAPScope >> endLine [
	"Optional end line of the range covered by this scope.
	integer
	Auto-generated method"

	^ endLine
]

{ #category : #accessing }
DAPScope >> endLine: anObject [
	"Optional end line of the range covered by this scope.
	integer
	Auto-generated method"

	endLine := anObject

]

{ #category : #accessing }
DAPScope >> expensive [
	"If true, the number of variables in this scope is large or expensive to retrieve.
	boolean
	Auto-generated method"

	^ expensive
]

{ #category : #accessing }
DAPScope >> expensive: anObject [
	"If true, the number of variables in this scope is large or expensive to retrieve.
	boolean
	Auto-generated method"

	expensive := anObject

]

{ #category : #ui }
DAPScope >> gtVariablesFor: aView [
	<gtView>

	self variables ifEmpty: [ ^ aView empty ].
	^ aView columnedList
		title: 'Variables';
		priority: 10;
		items: [ self variables ];
		column: 'Name' text: [ :item | item name ];
		column: 'Value' text: [ :item | item value ]
]

{ #category : #accessing }
DAPScope >> indexedVariables [
	"The number of indexed variables in this scope.
The client can use this optional information to present the variables in a paged UI and fetch them in chunks.
	integer
	Auto-generated method"

	^ indexedVariables
]

{ #category : #accessing }
DAPScope >> indexedVariables: anObject [
	"The number of indexed variables in this scope.
The client can use this optional information to present the variables in a paged UI and fetch them in chunks.
	integer
	Auto-generated method"

	indexedVariables := anObject

]

{ #category : #accessing }
DAPScope >> line [
	"Optional start line of the range covered by this scope.
	integer
	Auto-generated method"

	^ line
]

{ #category : #accessing }
DAPScope >> line: anObject [
	"Optional start line of the range covered by this scope.
	integer
	Auto-generated method"

	line := anObject

]

{ #category : #accessing }
DAPScope >> name [
	"Name of the scope such as 'Arguments', 'Locals', or 'Registers'. This string is shown in the UI as is and can be translated.
	string
	Auto-generated method"

	^ name
]

{ #category : #accessing }
DAPScope >> name: anObject [
	"Name of the scope such as 'Arguments', 'Locals', or 'Registers'. This string is shown in the UI as is and can be translated.
	string
	Auto-generated method"

	name := anObject

]

{ #category : #accessing }
DAPScope >> namedVariables [
	"The number of named variables in this scope.
The client can use this optional information to present the variables in a paged UI and fetch them in chunks.
	integer
	Auto-generated method"

	^ namedVariables
]

{ #category : #accessing }
DAPScope >> namedVariables: anObject [
	"The number of named variables in this scope.
The client can use this optional information to present the variables in a paged UI and fetch them in chunks.
	integer
	Auto-generated method"

	namedVariables := anObject

]

{ #category : #accessing }
DAPScope >> presentationHint [
	"An optional hint for how to present this scope in the UI. If this attribute is missing, the scope is shown with a generic UI.
	string
	Auto-generated method"

	^ presentationHint
]

{ #category : #accessing }
DAPScope >> presentationHint: anObject [
	"An optional hint for how to present this scope in the UI. If this attribute is missing, the scope is shown with a generic UI.
	string
	Auto-generated method"

	presentationHint := anObject

]

{ #category : #printing }
DAPScope >> printOn: aStream [

	name ifNil: [ ^ super printOn: aStream ].
	aStream << name
]

{ #category : #accessing }
DAPScope >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(column endColumn endLine expensive indexedVariables line name namedVariables presentationHint source variablesReference )
]

{ #category : #accessing }
DAPScope >> setVariableNamed: aString to: anObject [

	variables detect: [ :each | each name = aString ]
		ifNone: [ self error: 'Invalid variable name' ].
	client setVariableNamed: aString reference: variablesReference to: anObject.
]

{ #category : #accessing }
DAPScope >> source [
	"Optional source for this scope.
	#/definitions/Source
	Auto-generated method"

	^ source
]

{ #category : #accessing }
DAPScope >> source: anObject [
	"Optional source for this scope.
	#/definitions/Source
	Auto-generated method"

	source := anObject isDictionary ifTrue:
		[ DAPSource fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPScope >> variables [ 
	"Answer the variables for the receiver.
	The debugger may not be in a state to retrieve the variables, in which case, answer nil"
	<return: #Array of: #DAPVariable>

	^ variables ifNil: [ 
		[ variables := (client variablesForReference: variablesReference) allVariables ]
			on: DAPBadResponse
			do: [ #() ].
		variables do: [ :variable | variable scope: self ].
		variables ]
]

{ #category : #accessing }
DAPScope >> variablesReference [
	"The variables of this scope can be retrieved by passing the value of variablesReference to the VariablesRequest.
	integer
	Auto-generated method"

	^ variablesReference
]

{ #category : #accessing }
DAPScope >> variablesReference: anObject [
	"The variables of this scope can be retrieved by passing the value of variablesReference to the VariablesRequest.
	integer
	Auto-generated method"

	variablesReference := anObject

]
