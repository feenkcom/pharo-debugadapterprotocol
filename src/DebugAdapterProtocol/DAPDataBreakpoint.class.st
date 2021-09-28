"
Properties of a data breakpoint passed to the setDataBreakpoints request.

"
Class {
	#name : #DAPDataBreakpoint,
	#superclass : #DAPObject,
	#instVars : [
		'accessType',
		'condition',
		'dataId',
		'hitCondition'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPDataBreakpoint class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #condition to: #condition.
		mapping mapAccessor: #hitCondition to: #hitCondition.
		mapping mapAccessor: #accessType to: #accessType.
		mapping mapAccessor: #dataId to: #dataId.
		].

]

{ #category : #visiting }
DAPDataBreakpoint >> acceptVisitor: aVisitor [

	^ aVisitor visitDataBreakpoint: self
]

{ #category : #accessing }
DAPDataBreakpoint >> accessType [
	"The access type of the data.
	#/definitions/DataBreakpointAccessType
	Auto-generated method"

	^ accessType
]

{ #category : #accessing }
DAPDataBreakpoint >> accessType: anObject [
	"The access type of the data.
	#/definitions/DataBreakpointAccessType
	Auto-generated method"

	accessType := anObject isDictionary ifTrue:
		[ DAPDataBreakpointAccessType fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPDataBreakpoint >> condition [
	"An optional expression for conditional breakpoints.
	string
	Auto-generated method"

	^ condition
]

{ #category : #accessing }
DAPDataBreakpoint >> condition: anObject [
	"An optional expression for conditional breakpoints.
	string
	Auto-generated method"

	condition := anObject

]

{ #category : #accessing }
DAPDataBreakpoint >> dataId [
	"An id representing the data. This id is returned from the dataBreakpointInfo request.
	string
	Auto-generated method"

	^ dataId
]

{ #category : #accessing }
DAPDataBreakpoint >> dataId: anObject [
	"An id representing the data. This id is returned from the dataBreakpointInfo request.
	string
	Auto-generated method"

	dataId := anObject

]

{ #category : #accessing }
DAPDataBreakpoint >> hitCondition [
	"An optional expression that controls how many hits of the breakpoint are ignored.
The backend is expected to interpret the expression as needed.
	string
	Auto-generated method"

	^ hitCondition
]

{ #category : #accessing }
DAPDataBreakpoint >> hitCondition: anObject [
	"An optional expression that controls how many hits of the breakpoint are ignored.
The backend is expected to interpret the expression as needed.
	string
	Auto-generated method"

	hitCondition := anObject

]

{ #category : #accessing }
DAPDataBreakpoint >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(accessType condition dataId hitCondition )
]
