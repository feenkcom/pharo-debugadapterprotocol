"
This event signals that some state in the debug adapter has changed and requires that the client needs to re-render the data snapshot previously requested.
Debug adapters do not have to emit this event for runtime changes like stopped or thread events because in that case the client refetches the new state anyway. But the event can be used for example to refresh the UI after rendering formatting has changed in the debug adapter.
This event should only be sent if the debug adapter has received a value true for the 'supportsInvalidatedEvent' capability of the 'initialize' request.

"
Class {
	#name : #DAPInvalidatedEvent,
	#superclass : #DAPEvent,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPInvalidatedEvent class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #event to: #event.
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #accessing }
DAPInvalidatedEvent class >> eventEnums [
	"Enumerated types for the associated attribute"

	^ #(invalidated )
]

{ #category : #visiting }
DAPInvalidatedEvent >> acceptVisitor: aVisitor [

	^ aVisitor visitInvalidatedEvent: self
]

{ #category : #accessing }
DAPInvalidatedEvent >> areas [
	"Optional set of logical areas that got invalidated. This property has a hint characteristic: a client can only be expected to make a 'best effort' in honouring the areas but there are no guarantees. If this property is missing, empty, or if values are not understand the client should assume a single value 'all'.
	array
	Auto-generated method"
	| result |

	result := self body at: #areas ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPInvalidatedEvent >> areas: anObject [
	"Optional set of logical areas that got invalidated. This property has a hint characteristic: a client can only be expected to make a 'best effort' in honouring the areas but there are no guarantees. If this property is missing, empty, or if values are not understand the client should assume a single value 'all'.
	array
	Auto-generated method"

	self body at: #areas put: anObject
]

{ #category : #accessing }
DAPInvalidatedEvent >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPInvalidatedEvent >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPInvalidatedEvent >> event [
	"invalidated: 
	Auto-generated method"

	^ event ifNil: [ 'invalidated' ]
]

{ #category : #accessing }
DAPInvalidatedEvent >> event: anObject [
	"invalidated: 
	Auto-generated method"

	event := anObject

]

{ #category : #accessing }
DAPInvalidatedEvent >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(areas body event stackFrameId threadId )
]

{ #category : #accessing }
DAPInvalidatedEvent >> stackFrameId [
	"If specified, the client only needs to refetch data related to this stack frame (and the 'threadId' is ignored).
	integer
	Auto-generated method"
	| result |

	result := self body at: #stackFrameId ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPInvalidatedEvent >> stackFrameId: anObject [
	"If specified, the client only needs to refetch data related to this stack frame (and the 'threadId' is ignored).
	integer
	Auto-generated method"

	self body at: #stackFrameId put: anObject
]

{ #category : #accessing }
DAPInvalidatedEvent >> threadId [
	"If specified, the client only needs to refetch data related to this thread.
	integer
	Auto-generated method"
	| result |

	result := self body at: #threadId ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPInvalidatedEvent >> threadId: anObject [
	"If specified, the client only needs to refetch data related to this thread.
	integer
	Auto-generated method"

	self body at: #threadId put: anObject
]
