"
Replaces all existing instruction breakpoints. Typically, instruction breakpoints would be set from a diassembly window. 
To clear all instruction breakpoints, specify an empty array.
When an instruction breakpoint is hit, a 'stopped' event (with reason 'instruction breakpoint') is generated.
Clients should only call this request if the capability 'supportsInstructionBreakpoints' is true.
"
Class {
	#name : #DAPSetInstructionBreakpointsRequest,
	#superclass : #DAPRequest,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPSetInstructionBreakpointsRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(setInstructionBreakpoints )
]

{ #category : #'json - configuration' }
DAPSetInstructionBreakpointsRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPSetInstructionBreakpointsRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitSetInstructionBreakpointsRequest: self
]

{ #category : #accessing }
DAPSetInstructionBreakpointsRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPSetInstructionBreakpointsRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPSetInstructionBreakpointsArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPSetInstructionBreakpointsRequest >> command [
	"setInstructionBreakpoints: 
	Auto-generated method"

	^ command ifNil: [ 'setInstructionBreakpoints' ]
]

{ #category : #accessing }
DAPSetInstructionBreakpointsRequest >> command: anObject [
	"setInstructionBreakpoints: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPSetInstructionBreakpointsRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
