"
The request starts the debuggee to run again for one step.
The debug adapter first sends the response and then a 'stopped' event (with reason 'step') after the step has completed.

"
Class {
	#name : #DAPStepOutRequest,
	#superclass : #DAPRequest,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPStepOutRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(stepOut )
]

{ #category : #'json - configuration' }
DAPStepOutRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPStepOutRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitStepOutRequest: self
]

{ #category : #accessing }
DAPStepOutRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPStepOutRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPStepOutArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPStepOutRequest >> command [
	"stepOut: 
	Auto-generated method"

	^ command ifNil: [ 'stepOut' ]
]

{ #category : #accessing }
DAPStepOutRequest >> command: anObject [
	"stepOut: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPStepOutRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
