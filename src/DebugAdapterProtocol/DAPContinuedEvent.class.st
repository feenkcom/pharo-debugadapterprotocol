"
The event indicates that the execution of the debuggee has continued.
Please note: a debug adapter is not expected to send this event in response to a request that implies that execution continues, e.g. 'launch' or 'continue'.
It is only necessary to send a 'continued' event if there was no previous request that implied this.
"
Class {
	#name : #DAPContinuedEvent,
	#superclass : #DAPEvent,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPContinuedEvent class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #event to: #event.
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #accessing }
DAPContinuedEvent class >> eventEnums [
	"Enumerated types for the associated attribute"

	^ #(continued )
]

{ #category : #visiting }
DAPContinuedEvent >> acceptVisitor: aVisitor [

	^ aVisitor visitContinuedEvent: self
]

{ #category : #accessing }
DAPContinuedEvent >> allThreadsContinued [
	"If 'allThreadsContinued' is true, a debug adapter can announce that all threads have continued.
	boolean
	Auto-generated method"
	| result |

	result := self body at: #allThreadsContinued ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPContinuedEvent >> allThreadsContinued: anObject [
	"If 'allThreadsContinued' is true, a debug adapter can announce that all threads have continued.
	boolean
	Auto-generated method"

	self body at: #allThreadsContinued put: anObject
]

{ #category : #accessing }
DAPContinuedEvent >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPContinuedEvent >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPContinuedEvent >> event [
	"continued: 
	Auto-generated method"

	^ event ifNil: [ 'continued' ]
]

{ #category : #accessing }
DAPContinuedEvent >> event: anObject [
	"continued: 
	Auto-generated method"

	event := anObject

]

{ #category : #accessing }
DAPContinuedEvent >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(event body threadId allThreadsContinued )
]

{ #category : #accessing }
DAPContinuedEvent >> threadId [
	"The thread which was continued.
	integer
	Auto-generated method"
	| result |

	result := self body at: #threadId ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPContinuedEvent >> threadId: anObject [
	"The thread which was continued.
	integer
	Auto-generated method"

	self body at: #threadId put: anObject
]
