"
The event signals that the progress reporting needs to updated with a new message and/or percentage.
The client does not have to update the UI immediately, but the clients needs to keep track of the message and/or percentage values.
This event should only be sent if the client has passed the value true for the 'supportsProgressReporting' capability of the 'initialize' request.
"
Class {
	#name : #DAPProgressUpdateEvent,
	#superclass : #DAPEvent,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPProgressUpdateEvent class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #event to: #event.
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #accessing }
DAPProgressUpdateEvent class >> eventEnums [
	"Enumerated types for the associated attribute"

	^ #(progressUpdate )
]

{ #category : #visiting }
DAPProgressUpdateEvent >> acceptVisitor: aVisitor [

	^ aVisitor visitProgressUpdateEvent: self
]

{ #category : #accessing }
DAPProgressUpdateEvent >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPProgressUpdateEvent >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPProgressUpdateEvent >> event [
	"progressUpdate: 
	Auto-generated method"

	^ event ifNil: [ 'progressUpdate' ]
]

{ #category : #accessing }
DAPProgressUpdateEvent >> event: anObject [
	"progressUpdate: 
	Auto-generated method"

	event := anObject

]

{ #category : #accessing }
DAPProgressUpdateEvent >> message [
	"Optional, more detailed progress message. If omitted, the previous message (if any) is used.
	string
	Auto-generated method"
	| result |

	result := self body at: #message ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPProgressUpdateEvent >> message: anObject [
	"Optional, more detailed progress message. If omitted, the previous message (if any) is used.
	string
	Auto-generated method"

	self body at: #message put: anObject
]

{ #category : #accessing }
DAPProgressUpdateEvent >> percentage [
	"Optional progress percentage to display (value range: 0 to 100). If omitted no percentage will be shown.
	number
	Auto-generated method"
	| result |

	result := self body at: #percentage ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPProgressUpdateEvent >> percentage: anObject [
	"Optional progress percentage to display (value range: 0 to 100). If omitted no percentage will be shown.
	number
	Auto-generated method"

	self body at: #percentage put: anObject
]

{ #category : #accessing }
DAPProgressUpdateEvent >> progressId [
	"The ID that was introduced in the initial 'progressStart' event.
	string
	Auto-generated method"
	| result |

	result := self body at: #progressId ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPProgressUpdateEvent >> progressId: anObject [
	"The ID that was introduced in the initial 'progressStart' event.
	string
	Auto-generated method"

	self body at: #progressId put: anObject
]

{ #category : #accessing }
DAPProgressUpdateEvent >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(event body percentage message progressId )
]
