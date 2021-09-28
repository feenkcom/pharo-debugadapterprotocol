"
Arguments for 'setFunctionBreakpoints' request.

"
Class {
	#name : #DAPSetFunctionBreakpointsArguments,
	#superclass : #DAPObject,
	#instVars : [
		'breakpoints'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPSetFunctionBreakpointsArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #breakpoints to: #breakpoints.
		].

]

{ #category : #visiting }
DAPSetFunctionBreakpointsArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitSetFunctionBreakpointsArguments: self
]

{ #category : #accessing }
DAPSetFunctionBreakpointsArguments >> breakpoints [
	"The function names of the breakpoints.
	array
	Auto-generated method"

	^ breakpoints
]

{ #category : #accessing }
DAPSetFunctionBreakpointsArguments >> breakpoints: anObject [
	"The function names of the breakpoints.
	array
	Auto-generated method"

	breakpoints := anObject

]

{ #category : #accessing }
DAPSetFunctionBreakpointsArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(breakpoints )
]
