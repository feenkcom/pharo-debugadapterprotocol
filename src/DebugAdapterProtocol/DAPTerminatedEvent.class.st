"
The event indicates that debugging of the debuggee has terminated. This does **not** mean that the debuggee itself has exited.
"
Class {
	#name : #DAPTerminatedEvent,
	#superclass : #DAPEvent,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPTerminatedEvent class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #event to: #event.
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #accessing }
DAPTerminatedEvent class >> eventEnums [
	"Enumerated types for the associated attribute"

	^ #(terminated )
]

{ #category : #visiting }
DAPTerminatedEvent >> acceptVisitor: aVisitor [

	^ aVisitor visitTerminatedEvent: self
]

{ #category : #accessing }
DAPTerminatedEvent >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPTerminatedEvent >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPTerminatedEvent >> event [
	"terminated: 
	Auto-generated method"

	^ event ifNil: [ 'terminated' ]
]

{ #category : #accessing }
DAPTerminatedEvent >> event: anObject [
	"terminated: 
	Auto-generated method"

	event := anObject

]

{ #category : #accessing }
DAPTerminatedEvent >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(event body restart )
]

{ #category : #accessing }
DAPTerminatedEvent >> restart [
	"A debug adapter may set 'restart' to true (or to an arbitrary object) to request that the front end restarts the session.
The value is not interpreted by the client and passed unmodified as an attribute '__restart' to the 'launch' and 'attach' requests.
	arraybooleanintegernullnumberobjectstring
	Auto-generated method"
	| result |

	result := self body at: #restart ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPTerminatedEvent >> restart: anObject [
	"A debug adapter may set 'restart' to true (or to an arbitrary object) to request that the front end restarts the session.
The value is not interpreted by the client and passed unmodified as an attribute '__restart' to the 'launch' and 'attach' requests.
	arraybooleanintegernullnumberobjectstring
	Auto-generated method"

	self body at: #restart put: anObject
]
