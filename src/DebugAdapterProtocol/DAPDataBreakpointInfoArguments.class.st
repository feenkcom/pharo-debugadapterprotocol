"
Arguments for 'dataBreakpointInfo' request.

"
Class {
	#name : #DAPDataBreakpointInfoArguments,
	#superclass : #DAPObject,
	#instVars : [
		'name',
		'variablesReference'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPDataBreakpointInfoArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #name to: #name.
		mapping mapAccessor: #variablesReference to: #variablesReference.
		].

]

{ #category : #visiting }
DAPDataBreakpointInfoArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitDataBreakpointInfoArguments: self
]

{ #category : #accessing }
DAPDataBreakpointInfoArguments >> name [
	"The name of the Variable's child to obtain data breakpoint information for.
If variablesReference isn’t provided, this can be an expression.
	string
	Auto-generated method"

	^ name
]

{ #category : #accessing }
DAPDataBreakpointInfoArguments >> name: anObject [
	"The name of the Variable's child to obtain data breakpoint information for.
If variablesReference isn’t provided, this can be an expression.
	string
	Auto-generated method"

	name := anObject

]

{ #category : #accessing }
DAPDataBreakpointInfoArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(name variablesReference )
]

{ #category : #accessing }
DAPDataBreakpointInfoArguments >> variablesReference [
	"Reference to the Variable container if the data breakpoint is requested for a child of the container.
	integer
	Auto-generated method"

	^ variablesReference
]

{ #category : #accessing }
DAPDataBreakpointInfoArguments >> variablesReference: anObject [
	"Reference to the Variable container if the data breakpoint is requested for a child of the container.
	integer
	Auto-generated method"

	variablesReference := anObject

]
