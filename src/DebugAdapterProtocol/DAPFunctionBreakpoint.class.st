"
Properties of a breakpoint passed to the setFunctionBreakpoints request.
"
Class {
	#name : #DAPFunctionBreakpoint,
	#superclass : #DAPObject,
	#instVars : [
		'hitCondition',
		'name',
		'condition'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPFunctionBreakpoint class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #name to: #name.
		mapping mapAccessor: #condition to: #condition.
		mapping mapAccessor: #hitCondition to: #hitCondition.
		].

]

{ #category : #visiting }
DAPFunctionBreakpoint >> acceptVisitor: aVisitor [

	^ aVisitor visitFunctionBreakpoint: self
]

{ #category : #accessing }
DAPFunctionBreakpoint >> condition [
	"An optional expression for conditional breakpoints.
It is only honored by a debug adapter if the capability 'supportsConditionalBreakpoints' is true.
	string
	Auto-generated method"

	^ condition
]

{ #category : #accessing }
DAPFunctionBreakpoint >> condition: anObject [
	"An optional expression for conditional breakpoints.
It is only honored by a debug adapter if the capability 'supportsConditionalBreakpoints' is true.
	string
	Auto-generated method"

	condition := anObject

]

{ #category : #accessing }
DAPFunctionBreakpoint >> hitCondition [
	"An optional expression that controls how many hits of the breakpoint are ignored.
The backend is expected to interpret the expression as needed.
The attribute is only honored by a debug adapter if the capability 'supportsHitConditionalBreakpoints' is true.
	string
	Auto-generated method"

	^ hitCondition
]

{ #category : #accessing }
DAPFunctionBreakpoint >> hitCondition: anObject [
	"An optional expression that controls how many hits of the breakpoint are ignored.
The backend is expected to interpret the expression as needed.
The attribute is only honored by a debug adapter if the capability 'supportsHitConditionalBreakpoints' is true.
	string
	Auto-generated method"

	hitCondition := anObject

]

{ #category : #accessing }
DAPFunctionBreakpoint >> name [
	"The name of the function.
	string
	Auto-generated method"

	^ name
]

{ #category : #accessing }
DAPFunctionBreakpoint >> name: anObject [
	"The name of the function.
	string
	Auto-generated method"

	name := anObject

]

{ #category : #accessing }
DAPFunctionBreakpoint >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(name condition hitCondition )
]
