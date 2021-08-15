"
This request retrieves the possible stepIn targets for the specified stack frame.
These targets can be used in the 'stepIn' request.
The StepInTargets may only be called if the 'supportsStepInTargetsRequest' capability exists and is true.
Clients should only call this request if the capability 'supportsStepInTargetsRequest' is true.

"
Class {
	#name : 'DAPStepInTargetsRequest',
	#superclass : 'DAPRequest',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'accessing' }
DAPStepInTargetsRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(stepInTargets )
]

{ #category : 'json - configuration' }
DAPStepInTargetsRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : 'visiting' }
DAPStepInTargetsRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitStepInTargetsRequest: self
]

{ #category : 'accessing' }
DAPStepInTargetsRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : 'accessing' }
DAPStepInTargetsRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPStepInTargetsArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : 'accessing' }
DAPStepInTargetsRequest >> command [
	"stepInTargets: 
	Auto-generated method"

	^ command ifNil: [ 'stepInTargets' ]
]

{ #category : 'accessing' }
DAPStepInTargetsRequest >> command: anObject [
	"stepInTargets: 
	Auto-generated method"

	command := anObject

]

{ #category : 'accessing' }
DAPStepInTargetsRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
