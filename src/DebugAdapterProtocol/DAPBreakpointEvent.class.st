"
The event indicates that some information about a breakpoint has changed.

"
Class {
	#name : 'DAPBreakpointEvent',
	#superclass : 'DAPEvent',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPBreakpointEvent class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #event to: #event.
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : 'accessing' }
DAPBreakpointEvent class >> eventEnums [
	"Enumerated types for the associated attribute"

	^ #(breakpoint )
]

{ #category : 'visiting' }
DAPBreakpointEvent >> acceptVisitor: aVisitor [

	^ aVisitor visitBreakpointEvent: self
]

{ #category : 'accessing' }
DAPBreakpointEvent >> body [
	"Auto-generated method"

	^ body
]

{ #category : 'accessing' }
DAPBreakpointEvent >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : 'accessing' }
DAPBreakpointEvent >> breakpoint [
	"The 'id' attribute is used to find the target breakpoint and the other attributes are used as the new values.
	#/definitions/Breakpoint
	Auto-generated method"
	| result |

	result := self body at: #breakpoint ifAbsent: [ nil ].
	result isDictionary ifTrue:
		[ result := DAPBreakpoint fromDictionary: result client: client ].
	^ result
]

{ #category : 'accessing' }
DAPBreakpointEvent >> breakpoint: anObject [
	"The 'id' attribute is used to find the target breakpoint and the other attributes are used as the new values.
	#/definitions/Breakpoint
	Auto-generated method"

	self body at: #breakpoint put: anObject
]

{ #category : 'accessing' }
DAPBreakpointEvent >> event [
	"breakpoint: 
	Auto-generated method"

	^ event ifNil: [ 'breakpoint' ]
]

{ #category : 'accessing' }
DAPBreakpointEvent >> event: anObject [
	"breakpoint: 
	Auto-generated method"

	event := anObject

]

{ #category : 'accessing' }
DAPBreakpointEvent >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body breakpoint event reason )
]

{ #category : 'accessing' }
DAPBreakpointEvent >> reason [
	"The reason for the event.
	string
	Auto-generated method"
	| result |

	result := self body at: #reason ifAbsent: [ nil ].
	^ result
]

{ #category : 'accessing' }
DAPBreakpointEvent >> reason: anObject [
	"The reason for the event.
	string
	Auto-generated method"

	self body at: #reason put: anObject
]
