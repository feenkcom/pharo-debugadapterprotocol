"
The request starts the debuggee to step into a function/method if possible.
If it cannot step into a target, 'stepIn' behaves like 'next'.
The debug adapter first sends the response and then a 'stopped' event (with reason 'step') after the step has completed.
If there are multiple function/method calls (or other targets) on the source line,
the optional argument 'targetId' can be used to control into which target the 'stepIn' should occur.
The list of possible targets for a given source line can be retrieved via the 'stepInTargets' request.

"
Class {
	#name : #DAPStepInRequest,
	#superclass : #DAPRequest,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPStepInRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(stepIn )
]

{ #category : #'json - configuration' }
DAPStepInRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPStepInRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitStepInRequest: self
]

{ #category : #accessing }
DAPStepInRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPStepInRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPStepInArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPStepInRequest >> command [
	"stepIn: 
	Auto-generated method"

	^ command ifNil: [ 'stepIn' ]
]

{ #category : #accessing }
DAPStepInRequest >> command: anObject [
	"stepIn: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPStepInRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
