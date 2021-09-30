"
Properties of a breakpoint or logpoint passed to the setBreakpoints request.

"
Class {
	#name : #DAPSourceBreakpoint,
	#superclass : #DAPObject,
	#instVars : [
		'column',
		'condition',
		'hitCondition',
		'line',
		'logMessage'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPSourceBreakpoint class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #logMessage to: #logMessage.
		mapping mapAccessor: #hitCondition to: #hitCondition.
		mapping mapAccessor: #line to: #line.
		mapping mapAccessor: #column to: #column.
		mapping mapAccessor: #condition to: #condition.
		].

]

{ #category : #visiting }
DAPSourceBreakpoint >> acceptVisitor: aVisitor [

	^ aVisitor visitSourceBreakpoint: self
]

{ #category : #accessing }
DAPSourceBreakpoint >> column [
	"An optional source column of the breakpoint.
	integer
	Auto-generated method"

	^ column
]

{ #category : #accessing }
DAPSourceBreakpoint >> column: anObject [
	"An optional source column of the breakpoint.
	integer
	Auto-generated method"

	column := anObject

]

{ #category : #accessing }
DAPSourceBreakpoint >> condition [
	"An optional expression for conditional breakpoints.
It is only honored by a debug adapter if the capability 'supportsConditionalBreakpoints' is true.
	string
	Auto-generated method"

	^ condition
]

{ #category : #accessing }
DAPSourceBreakpoint >> condition: anObject [
	"An optional expression for conditional breakpoints.
It is only honored by a debug adapter if the capability 'supportsConditionalBreakpoints' is true.
	string
	Auto-generated method"

	condition := anObject

]

{ #category : #accessing }
DAPSourceBreakpoint >> hitCondition [
	"An optional expression that controls how many hits of the breakpoint are ignored.
The backend is expected to interpret the expression as needed.
The attribute is only honored by a debug adapter if the capability 'supportsHitConditionalBreakpoints' is true.
	string
	Auto-generated method"

	^ hitCondition
]

{ #category : #accessing }
DAPSourceBreakpoint >> hitCondition: anObject [
	"An optional expression that controls how many hits of the breakpoint are ignored.
The backend is expected to interpret the expression as needed.
The attribute is only honored by a debug adapter if the capability 'supportsHitConditionalBreakpoints' is true.
	string
	Auto-generated method"

	hitCondition := anObject

]

{ #category : #accessing }
DAPSourceBreakpoint >> line [
	"The source line of the breakpoint or logpoint.
	integer
	Auto-generated method"

	^ line
]

{ #category : #accessing }
DAPSourceBreakpoint >> line: anObject [
	"The source line of the breakpoint or logpoint.
	integer
	Auto-generated method"

	line := anObject

]

{ #category : #accessing }
DAPSourceBreakpoint >> logMessage [
	"If this attribute exists and is non-empty, the backend must not 'break' (stop)
but log the message instead. Expressions within {} are interpolated.
The attribute is only honored by a debug adapter if the capability 'supportsLogPoints' is true.
	string
	Auto-generated method"

	^ logMessage
]

{ #category : #accessing }
DAPSourceBreakpoint >> logMessage: anObject [
	"If this attribute exists and is non-empty, the backend must not 'break' (stop)
but log the message instead. Expressions within {} are interpolated.
The attribute is only honored by a debug adapter if the capability 'supportsLogPoints' is true.
	string
	Auto-generated method"

	logMessage := anObject

]

{ #category : #accessing }
DAPSourceBreakpoint >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(column condition hitCondition line logMessage )
]
