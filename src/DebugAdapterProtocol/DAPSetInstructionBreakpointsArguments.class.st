"
Arguments for 'setInstructionBreakpoints' request

"
Class {
	#name : #DAPSetInstructionBreakpointsArguments,
	#superclass : #DAPObject,
	#instVars : [
		'breakpoints'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPSetInstructionBreakpointsArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #breakpoints to: #breakpoints.
		].

]

{ #category : #visiting }
DAPSetInstructionBreakpointsArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitSetInstructionBreakpointsArguments: self
]

{ #category : #accessing }
DAPSetInstructionBreakpointsArguments >> breakpoints [
	"The instruction references of the breakpoints
	array
	Auto-generated method"

	^ breakpoints
]

{ #category : #accessing }
DAPSetInstructionBreakpointsArguments >> breakpoints: anObject [
	"The instruction references of the breakpoints
	array
	Auto-generated method"

	breakpoints := anObject

]

{ #category : #accessing }
DAPSetInstructionBreakpointsArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(breakpoints )
]
