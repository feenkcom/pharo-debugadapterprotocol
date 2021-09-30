"
The event indicates that the debuggee has exited and returns its exit code.

"
Class {
	#name : #DAPExitedEvent,
	#superclass : #DAPEvent,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPExitedEvent class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #event to: #event.
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #accessing }
DAPExitedEvent class >> eventEnums [
	"Enumerated types for the associated attribute"

	^ #(exited )
]

{ #category : #visiting }
DAPExitedEvent >> acceptVisitor: aVisitor [

	^ aVisitor visitExitedEvent: self
]

{ #category : #accessing }
DAPExitedEvent >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPExitedEvent >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPExitedEvent >> event [
	"exited: 
	Auto-generated method"

	^ event ifNil: [ 'exited' ]
]

{ #category : #accessing }
DAPExitedEvent >> event: anObject [
	"exited: 
	Auto-generated method"

	event := anObject

]

{ #category : #accessing }
DAPExitedEvent >> exitCode [
	"The exit code returned from the debuggee.
	integer
	Auto-generated method"
	| result |

	result := self body at: #exitCode ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPExitedEvent >> exitCode: anObject [
	"The exit code returned from the debuggee.
	integer
	Auto-generated method"

	self body at: #exitCode put: anObject
]

{ #category : #accessing }
DAPExitedEvent >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body event exitCode )
]
