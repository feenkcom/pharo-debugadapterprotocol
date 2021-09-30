"
The request starts the debuggee to run one step backwards.
The debug adapter first sends the response and then a 'stopped' event (with reason 'step') after the step has completed.
Clients should only call this request if the capability 'supportsStepBack' is true.

"
Class {
	#name : #DAPStepBackRequest,
	#superclass : #DAPRequest,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPStepBackRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(stepBack )
]

{ #category : #'json - configuration' }
DAPStepBackRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPStepBackRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitStepBackRequest: self
]

{ #category : #accessing }
DAPStepBackRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPStepBackRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPStepBackArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPStepBackRequest >> command [
	"stepBack: 
	Auto-generated method"

	^ command ifNil: [ 'stepBack' ]
]

{ #category : #accessing }
DAPStepBackRequest >> command: anObject [
	"stepBack: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPStepBackRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
