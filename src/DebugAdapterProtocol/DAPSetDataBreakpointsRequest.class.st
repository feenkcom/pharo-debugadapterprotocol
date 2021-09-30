"
Replaces all existing data breakpoints with new data breakpoints.
To clear all data breakpoints, specify an empty array.
When a data breakpoint is hit, a 'stopped' event (with reason 'data breakpoint') is generated.
Clients should only call this request if the capability 'supportsDataBreakpoints' is true.

"
Class {
	#name : #DAPSetDataBreakpointsRequest,
	#superclass : #DAPRequest,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPSetDataBreakpointsRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(setDataBreakpoints )
]

{ #category : #'json - configuration' }
DAPSetDataBreakpointsRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPSetDataBreakpointsRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitSetDataBreakpointsRequest: self
]

{ #category : #accessing }
DAPSetDataBreakpointsRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPSetDataBreakpointsRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPSetDataBreakpointsArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPSetDataBreakpointsRequest >> command [
	"setDataBreakpoints: 
	Auto-generated method"

	^ command ifNil: [ 'setDataBreakpoints' ]
]

{ #category : #accessing }
DAPSetDataBreakpointsRequest >> command: anObject [
	"setDataBreakpoints: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPSetDataBreakpointsRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
