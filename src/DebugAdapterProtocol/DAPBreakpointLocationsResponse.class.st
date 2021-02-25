"
Response to 'breakpointLocations' request.
Contains possible locations for source breakpoints.
"
Class {
	#name : #DAPBreakpointLocationsResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPBreakpointLocationsResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #visiting }
DAPBreakpointLocationsResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitBreakpointLocationsResponse: self
]

{ #category : #accessing }
DAPBreakpointLocationsResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPBreakpointLocationsResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPBreakpointLocationsResponse >> breakpoints [
	"Sorted set of possible breakpoint locations.
	array
	Auto-generated method"
	| result |

	result := self body at: #breakpoints ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPBreakpointLocationsResponse >> breakpoints: anObject [
	"Sorted set of possible breakpoint locations.
	array
	Auto-generated method"

	self body at: #breakpoints put: anObject
]

{ #category : #accessing }
DAPBreakpointLocationsResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body breakpoints )
]
