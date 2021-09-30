"
An ExceptionFilterOptions is used to specify an exception filter together with a condition for the setExceptionsFilter request.

"
Class {
	#name : #DAPExceptionFilterOptions,
	#superclass : #DAPObject,
	#instVars : [
		'condition',
		'filterId'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPExceptionFilterOptions class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #condition to: #condition.
		mapping mapAccessor: #filterId to: #filterId.
		].

]

{ #category : #visiting }
DAPExceptionFilterOptions >> acceptVisitor: aVisitor [

	^ aVisitor visitExceptionFilterOptions: self
]

{ #category : #accessing }
DAPExceptionFilterOptions >> condition [
	"An optional expression for conditional exceptions.
The exception will break into the debugger if the result of the condition is true.
	string
	Auto-generated method"

	^ condition
]

{ #category : #accessing }
DAPExceptionFilterOptions >> condition: anObject [
	"An optional expression for conditional exceptions.
The exception will break into the debugger if the result of the condition is true.
	string
	Auto-generated method"

	condition := anObject

]

{ #category : #accessing }
DAPExceptionFilterOptions >> filterId [
	"ID of an exception filter returned by the 'exceptionBreakpointFilters' capability.
	string
	Auto-generated method"

	^ filterId
]

{ #category : #accessing }
DAPExceptionFilterOptions >> filterId: anObject [
	"ID of an exception filter returned by the 'exceptionBreakpointFilters' capability.
	string
	Auto-generated method"

	filterId := anObject

]

{ #category : #accessing }
DAPExceptionFilterOptions >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(condition filterId )
]
