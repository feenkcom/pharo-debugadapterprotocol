"
The event signals that a long running operation is about to start and
provides additional information for the client to set up a corresponding progress and cancellation UI.
The client is free to delay the showing of the UI in order to reduce flicker.
This event should only be sent if the client has passed the value true for the 'supportsProgressReporting' capability of the 'initialize' request.

"
Class {
	#name : #DAPProgressStartEvent,
	#superclass : #DAPEvent,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPProgressStartEvent class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #event to: #event.
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #accessing }
DAPProgressStartEvent class >> eventEnums [
	"Enumerated types for the associated attribute"

	^ #(progressStart )
]

{ #category : #visiting }
DAPProgressStartEvent >> acceptVisitor: aVisitor [

	^ aVisitor visitProgressStartEvent: self
]

{ #category : #accessing }
DAPProgressStartEvent >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPProgressStartEvent >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPProgressStartEvent >> cancellable [
	"If true, the request that reports progress may be canceled with a 'cancel' request.
So this property basically controls whether the client should use UX that supports cancellation.
Clients that don't support cancellation are allowed to ignore the setting.
	boolean
	Auto-generated method"
	| result |

	result := self body at: #cancellable ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPProgressStartEvent >> cancellable: anObject [
	"If true, the request that reports progress may be canceled with a 'cancel' request.
So this property basically controls whether the client should use UX that supports cancellation.
Clients that don't support cancellation are allowed to ignore the setting.
	boolean
	Auto-generated method"

	self body at: #cancellable put: anObject
]

{ #category : #accessing }
DAPProgressStartEvent >> event [
	"progressStart: 
	Auto-generated method"

	^ event ifNil: [ 'progressStart' ]
]

{ #category : #accessing }
DAPProgressStartEvent >> event: anObject [
	"progressStart: 
	Auto-generated method"

	event := anObject

]

{ #category : #accessing }
DAPProgressStartEvent >> message [
	"Optional, more detailed progress message.
	string
	Auto-generated method"
	| result |

	result := self body at: #message ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPProgressStartEvent >> message: anObject [
	"Optional, more detailed progress message.
	string
	Auto-generated method"

	self body at: #message put: anObject
]

{ #category : #accessing }
DAPProgressStartEvent >> percentage [
	"Optional progress percentage to display (value range: 0 to 100). If omitted no percentage will be shown.
	number
	Auto-generated method"
	| result |

	result := self body at: #percentage ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPProgressStartEvent >> percentage: anObject [
	"Optional progress percentage to display (value range: 0 to 100). If omitted no percentage will be shown.
	number
	Auto-generated method"

	self body at: #percentage put: anObject
]

{ #category : #accessing }
DAPProgressStartEvent >> progressId [
	"An ID that must be used in subsequent 'progressUpdate' and 'progressEnd' events to make them refer to the same progress reporting.
IDs must be unique within a debug session.
	string
	Auto-generated method"
	| result |

	result := self body at: #progressId ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPProgressStartEvent >> progressId: anObject [
	"An ID that must be used in subsequent 'progressUpdate' and 'progressEnd' events to make them refer to the same progress reporting.
IDs must be unique within a debug session.
	string
	Auto-generated method"

	self body at: #progressId put: anObject
]

{ #category : #accessing }
DAPProgressStartEvent >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body cancellable event message percentage progressId requestId title )
]

{ #category : #accessing }
DAPProgressStartEvent >> requestId [
	"The request ID that this progress report is related to. If specified a debug adapter is expected to emit
progress events for the long running request until the request has been either completed or cancelled.
If the request ID is omitted, the progress report is assumed to be related to some general activity of the debug adapter.
	integer
	Auto-generated method"
	| result |

	result := self body at: #requestId ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPProgressStartEvent >> requestId: anObject [
	"The request ID that this progress report is related to. If specified a debug adapter is expected to emit
progress events for the long running request until the request has been either completed or cancelled.
If the request ID is omitted, the progress report is assumed to be related to some general activity of the debug adapter.
	integer
	Auto-generated method"

	self body at: #requestId put: anObject
]

{ #category : #accessing }
DAPProgressStartEvent >> title [
	"Mandatory (short) title of the progress reporting. Shown in the UI to describe the long running operation.
	string
	Auto-generated method"
	| result |

	result := self body at: #title ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPProgressStartEvent >> title: anObject [
	"Mandatory (short) title of the progress reporting. Shown in the UI to describe the long running operation.
	string
	Auto-generated method"

	self body at: #title put: anObject
]
