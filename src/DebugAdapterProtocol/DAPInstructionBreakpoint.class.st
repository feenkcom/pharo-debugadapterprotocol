"
Properties of a breakpoint passed to the setInstructionBreakpoints request

"
Class {
	#name : 'DAPInstructionBreakpoint',
	#superclass : 'DAPObject',
	#instVars : [
		'condition',
		'hitCondition',
		'instructionReference',
		'offset'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPInstructionBreakpoint class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #instructionReference to: #instructionReference.
		mapping mapAccessor: #condition to: #condition.
		mapping mapAccessor: #offset to: #offset.
		mapping mapAccessor: #hitCondition to: #hitCondition.
		].

]

{ #category : 'visiting' }
DAPInstructionBreakpoint >> acceptVisitor: aVisitor [

	^ aVisitor visitInstructionBreakpoint: self
]

{ #category : 'accessing' }
DAPInstructionBreakpoint >> condition [
	"An optional expression for conditional breakpoints.
It is only honored by a debug adapter if the capability 'supportsConditionalBreakpoints' is true.
	string
	Auto-generated method"

	^ condition
]

{ #category : 'accessing' }
DAPInstructionBreakpoint >> condition: anObject [
	"An optional expression for conditional breakpoints.
It is only honored by a debug adapter if the capability 'supportsConditionalBreakpoints' is true.
	string
	Auto-generated method"

	condition := anObject

]

{ #category : 'accessing' }
DAPInstructionBreakpoint >> hitCondition [
	"An optional expression that controls how many hits of the breakpoint are ignored.
The backend is expected to interpret the expression as needed.
The attribute is only honored by a debug adapter if the capability 'supportsHitConditionalBreakpoints' is true.
	string
	Auto-generated method"

	^ hitCondition
]

{ #category : 'accessing' }
DAPInstructionBreakpoint >> hitCondition: anObject [
	"An optional expression that controls how many hits of the breakpoint are ignored.
The backend is expected to interpret the expression as needed.
The attribute is only honored by a debug adapter if the capability 'supportsHitConditionalBreakpoints' is true.
	string
	Auto-generated method"

	hitCondition := anObject

]

{ #category : 'accessing' }
DAPInstructionBreakpoint >> instructionReference [
	"The instruction reference of the breakpoint.
This should be a memory or instruction pointer reference from an EvaluateResponse, Variable, StackFrame, GotoTarget, or Breakpoint.
	string
	Auto-generated method"

	^ instructionReference
]

{ #category : 'accessing' }
DAPInstructionBreakpoint >> instructionReference: anObject [
	"The instruction reference of the breakpoint.
This should be a memory or instruction pointer reference from an EvaluateResponse, Variable, StackFrame, GotoTarget, or Breakpoint.
	string
	Auto-generated method"

	instructionReference := anObject

]

{ #category : 'accessing' }
DAPInstructionBreakpoint >> offset [
	"An optional offset from the instruction reference.
This can be negative.
	integer
	Auto-generated method"

	^ offset
]

{ #category : 'accessing' }
DAPInstructionBreakpoint >> offset: anObject [
	"An optional offset from the instruction reference.
This can be negative.
	integer
	Auto-generated method"

	offset := anObject

]

{ #category : 'accessing' }
DAPInstructionBreakpoint >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(condition hitCondition instructionReference offset )
]
