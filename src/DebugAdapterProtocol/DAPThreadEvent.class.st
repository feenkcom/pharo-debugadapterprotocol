"
The event indicates that a thread has started or exited.
"
Class {
	#name : #DAPThreadEvent,
	#superclass : #DAPEvent,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPThreadEvent class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #event to: #event.
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #accessing }
DAPThreadEvent class >> eventEnums [
	"Enumerated types for the associated attribute"

	^ #(thread )
]

{ #category : #visiting }
DAPThreadEvent >> acceptVisitor: aVisitor [

	^ aVisitor visitThreadEvent: self
]

{ #category : #accessing }
DAPThreadEvent >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPThreadEvent >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPThreadEvent >> event [
	"thread: 
	Auto-generated method"

	^ event ifNil: [ 'thread' ]
]

{ #category : #accessing }
DAPThreadEvent >> event: anObject [
	"thread: 
	Auto-generated method"

	event := anObject

]

{ #category : #printing }
DAPThreadEvent >> printOn: aStream [

	aStream 
		<< 'Thread ';
		print: self threadId;
		<< ' ';
		print: self reason.

]

{ #category : #accessing }
DAPThreadEvent >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body event reason threadId )
]

{ #category : #accessing }
DAPThreadEvent >> reason [
	"The reason for the event.
	string
	Auto-generated method"
	| result |

	result := self body at: #reason ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPThreadEvent >> reason: anObject [
	"The reason for the event.
	string
	Auto-generated method"

	self body at: #reason put: anObject
]

{ #category : #accessing }
DAPThreadEvent >> threadId [
	"The identifier of the thread.
	integer
	Auto-generated method"
	| result |

	result := self body at: #threadId ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPThreadEvent >> threadId: anObject [
	"The identifier of the thread.
	integer
	Auto-generated method"

	self body at: #threadId put: anObject
]
