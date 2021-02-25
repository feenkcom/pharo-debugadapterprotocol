"
The event signals the end of the progress reporting with an optional final message.
This event should only be sent if the client has passed the value true for the 'supportsProgressReporting' capability of the 'initialize' request.
"
Class {
	#name : #DAPProgressEndEvent,
	#superclass : #DAPEvent,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPProgressEndEvent class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #event to: #event.
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #accessing }
DAPProgressEndEvent class >> eventEnums [
	"Enumerated types for the associated attribute"

	^ #(progressEnd )
]

{ #category : #visiting }
DAPProgressEndEvent >> acceptVisitor: aVisitor [

	^ aVisitor visitProgressEndEvent: self
]

{ #category : #accessing }
DAPProgressEndEvent >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPProgressEndEvent >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPProgressEndEvent >> event [
	"progressEnd: 
	Auto-generated method"

	^ event ifNil: [ 'progressEnd' ]
]

{ #category : #accessing }
DAPProgressEndEvent >> event: anObject [
	"progressEnd: 
	Auto-generated method"

	event := anObject

]

{ #category : #accessing }
DAPProgressEndEvent >> message [
	"Optional, more detailed progress message. If omitted, the previous message (if any) is used.
	string
	Auto-generated method"
	| result |

	result := self body at: #message ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPProgressEndEvent >> message: anObject [
	"Optional, more detailed progress message. If omitted, the previous message (if any) is used.
	string
	Auto-generated method"

	self body at: #message put: anObject
]

{ #category : #accessing }
DAPProgressEndEvent >> progressId [
	"The ID that was introduced in the initial 'ProgressStartEvent'.
	string
	Auto-generated method"
	| result |

	result := self body at: #progressId ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPProgressEndEvent >> progressId: anObject [
	"The ID that was introduced in the initial 'ProgressStartEvent'.
	string
	Auto-generated method"

	self body at: #progressId put: anObject
]

{ #category : #accessing }
DAPProgressEndEvent >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(event body message progressId )
]
