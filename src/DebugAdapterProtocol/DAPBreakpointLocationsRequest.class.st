"
The 'breakpointLocations' request returns all possible locations for source breakpoints in a given range.
Clients should only call this request if the capability 'supportsBreakpointLocationsRequest' is true.
"
Class {
	#name : #DAPBreakpointLocationsRequest,
	#superclass : #DAPRequest,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPBreakpointLocationsRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(breakpointLocations )
]

{ #category : #'json - configuration' }
DAPBreakpointLocationsRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPBreakpointLocationsRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitBreakpointLocationsRequest: self
]

{ #category : #accessing }
DAPBreakpointLocationsRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPBreakpointLocationsRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPBreakpointLocationsArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPBreakpointLocationsRequest >> command [
	"breakpointLocations: 
	Auto-generated method"

	^ command ifNil: [ 'breakpointLocations' ]
]

{ #category : #accessing }
DAPBreakpointLocationsRequest >> command: anObject [
	"breakpointLocations: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPBreakpointLocationsRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
