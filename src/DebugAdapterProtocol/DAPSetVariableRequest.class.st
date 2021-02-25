"
Set the variable with the given name in the variable container to a new value. Clients should only call this request if the capability 'supportsSetVariable' is true.
"
Class {
	#name : #DAPSetVariableRequest,
	#superclass : #DAPRequest,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPSetVariableRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(setVariable )
]

{ #category : #'json - configuration' }
DAPSetVariableRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPSetVariableRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitSetVariableRequest: self
]

{ #category : #accessing }
DAPSetVariableRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPSetVariableRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPSetVariableArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPSetVariableRequest >> command [
	"setVariable: 
	Auto-generated method"

	^ command ifNil: [ 'setVariable' ]
]

{ #category : #accessing }
DAPSetVariableRequest >> command: anObject [
	"setVariable: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPSetVariableRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(command arguments )
]
