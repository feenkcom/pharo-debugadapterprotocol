"
The request configures the debuggers response to thrown exceptions.
If an exception is configured to break, a 'stopped' event is fired (with reason 'exception').
Clients should only call this request if the capability 'exceptionBreakpointFilters' returns one or more filters.
If a filter or filter option is invalid (e.g. due to an invalid 'condition'), the request should fail with an 'ErrorResponse' explaining the problem(s).
"
Class {
	#name : #DAPSetExceptionBreakpointsRequest,
	#superclass : #DAPRequest,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPSetExceptionBreakpointsRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(setExceptionBreakpoints )
]

{ #category : #'json - configuration' }
DAPSetExceptionBreakpointsRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPSetExceptionBreakpointsRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitSetExceptionBreakpointsRequest: self
]

{ #category : #accessing }
DAPSetExceptionBreakpointsRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPSetExceptionBreakpointsRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPSetExceptionBreakpointsArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPSetExceptionBreakpointsRequest >> command [
	"setExceptionBreakpoints: 
	Auto-generated method"

	^ command ifNil: [ 'setExceptionBreakpoints' ]
]

{ #category : #accessing }
DAPSetExceptionBreakpointsRequest >> command: anObject [
	"setExceptionBreakpoints: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPSetExceptionBreakpointsRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
