"
Arguments for 'variables' request.
"
Class {
	#name : #DAPVariablesArguments,
	#superclass : #DAPObject,
	#instVars : [
		'count',
		'filter',
		'format',
		'start',
		'variablesReference'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPVariablesArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #format to: #format.
		mapping mapAccessor: #count to: #count.
		mapping mapAccessor: #filter to: #filter.
		mapping mapAccessor: #variablesReference to: #variablesReference.
		mapping mapAccessor: #start to: #start.
		].

]

{ #category : #accessing }
DAPVariablesArguments class >> filterEnums [
	"Enumerated types for the associated attribute"

	^ #(indexed named )
]

{ #category : #visiting }
DAPVariablesArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitVariablesArguments: self
]

{ #category : #accessing }
DAPVariablesArguments >> count [
	"The number of variables to return. If count is missing or 0, all variables are returned.
	integer
	Auto-generated method"

	^ count
]

{ #category : #accessing }
DAPVariablesArguments >> count: anObject [
	"The number of variables to return. If count is missing or 0, all variables are returned.
	integer
	Auto-generated method"

	count := anObject

]

{ #category : #accessing }
DAPVariablesArguments >> filter [
	"Optional filter to limit the child variables to either named or indexed. If omitted, both types are fetched.
	string
	indexed: 
	named: 
	Auto-generated method"

	^ filter ifNil: [ 'indexed' ]
]

{ #category : #accessing }
DAPVariablesArguments >> filter: anObject [
	"Optional filter to limit the child variables to either named or indexed. If omitted, both types are fetched.
	string
	indexed: 
	named: 
	Auto-generated method"

	filter := anObject

]

{ #category : #accessing }
DAPVariablesArguments >> format [
	"Specifies details on how to format the Variable values.
The attribute is only honored by a debug adapter if the capability 'supportsValueFormattingOptions' is true.
	#/definitions/ValueFormat
	Auto-generated method"

	^ format
]

{ #category : #accessing }
DAPVariablesArguments >> format: anObject [
	"Specifies details on how to format the Variable values.
The attribute is only honored by a debug adapter if the capability 'supportsValueFormattingOptions' is true.
	#/definitions/ValueFormat
	Auto-generated method"

	format := anObject isDictionary ifTrue:
		[ DAPValueFormat fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPVariablesArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(count filter format start variablesReference )
]

{ #category : #accessing }
DAPVariablesArguments >> start [
	"The index of the first variable to return; if omitted children start at 0.
	integer
	Auto-generated method"

	^ start
]

{ #category : #accessing }
DAPVariablesArguments >> start: anObject [
	"The index of the first variable to return; if omitted children start at 0.
	integer
	Auto-generated method"

	start := anObject

]

{ #category : #accessing }
DAPVariablesArguments >> variablesReference [
	"The Variable reference.
	integer
	Auto-generated method"

	^ variablesReference
]

{ #category : #accessing }
DAPVariablesArguments >> variablesReference: anObject [
	"The Variable reference.
	integer
	Auto-generated method"

	variablesReference := anObject

]
