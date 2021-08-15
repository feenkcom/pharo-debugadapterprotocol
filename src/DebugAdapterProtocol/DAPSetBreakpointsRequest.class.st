"
Sets multiple breakpoints for a single source and clears all previous breakpoints in that source.
To clear all breakpoint for a source, specify an empty array.
When a breakpoint is hit, a 'stopped' event (with reason 'breakpoint') is generated.

"
Class {
	#name : 'DAPSetBreakpointsRequest',
	#superclass : 'DAPRequest',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'accessing' }
DAPSetBreakpointsRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(setBreakpoints )
]

{ #category : 'json - configuration' }
DAPSetBreakpointsRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : 'visiting' }
DAPSetBreakpointsRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitSetBreakpointsRequest: self
]

{ #category : 'accessing' }
DAPSetBreakpointsRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : 'accessing' }
DAPSetBreakpointsRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPSetBreakpointsArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : 'accessing' }
DAPSetBreakpointsRequest >> command [
	"setBreakpoints: 
	Auto-generated method"

	^ command ifNil: [ 'setBreakpoints' ]
]

{ #category : 'accessing' }
DAPSetBreakpointsRequest >> command: anObject [
	"setBreakpoints: 
	Auto-generated method"

	command := anObject

]

{ #category : 'accessing' }
DAPSetBreakpointsRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
