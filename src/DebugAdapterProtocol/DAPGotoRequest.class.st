"
The request sets the location where the debuggee will continue to run.
This makes it possible to skip the execution of code or to executed code again.
The code between the current location and the goto target is not executed but skipped.
The debug adapter first sends the response and then a 'stopped' event with reason 'goto'.
Clients should only call this request if the capability 'supportsGotoTargetsRequest' is true (because only then goto targets exist that can be passed as arguments).

"
Class {
	#name : #DAPGotoRequest,
	#superclass : #DAPRequest,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPGotoRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(goto )
]

{ #category : #'json - configuration' }
DAPGotoRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPGotoRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitGotoRequest: self
]

{ #category : #accessing }
DAPGotoRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPGotoRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPGotoArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPGotoRequest >> command [
	"goto: 
	Auto-generated method"

	^ command ifNil: [ 'goto' ]
]

{ #category : #accessing }
DAPGotoRequest >> command: anObject [
	"goto: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPGotoRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
