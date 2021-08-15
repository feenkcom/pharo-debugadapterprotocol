"
Replaces all existing function breakpoints with new function breakpoints.
To clear all function breakpoints, specify an empty array.
When a function breakpoint is hit, a 'stopped' event (with reason 'function breakpoint') is generated.
Clients should only call this request if the capability 'supportsFunctionBreakpoints' is true.

"
Class {
	#name : 'DAPSetFunctionBreakpointsRequest',
	#superclass : 'DAPRequest',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'accessing' }
DAPSetFunctionBreakpointsRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(setFunctionBreakpoints )
]

{ #category : 'json - configuration' }
DAPSetFunctionBreakpointsRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : 'visiting' }
DAPSetFunctionBreakpointsRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitSetFunctionBreakpointsRequest: self
]

{ #category : 'accessing' }
DAPSetFunctionBreakpointsRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : 'accessing' }
DAPSetFunctionBreakpointsRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPSetFunctionBreakpointsArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : 'accessing' }
DAPSetFunctionBreakpointsRequest >> command [
	"setFunctionBreakpoints: 
	Auto-generated method"

	^ command ifNil: [ 'setFunctionBreakpoints' ]
]

{ #category : 'accessing' }
DAPSetFunctionBreakpointsRequest >> command: anObject [
	"setFunctionBreakpoints: 
	Auto-generated method"

	command := anObject

]

{ #category : 'accessing' }
DAPSetFunctionBreakpointsRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
