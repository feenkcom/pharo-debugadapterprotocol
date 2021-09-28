"
The event indicates that one or more capabilities have changed.
Since the capabilities are dependent on the frontend and its UI, it might not be possible to change that at random times (or too late).
Consequently this event has a hint characteristic: a frontend can only be expected to make a 'best effort' in honouring individual capabilities but there are no guarantees.
Only changed capabilities need to be included, all other capabilities keep their values.

"
Class {
	#name : #DAPCapabilitiesEvent,
	#superclass : #DAPEvent,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPCapabilitiesEvent class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #event to: #event.
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #accessing }
DAPCapabilitiesEvent class >> eventEnums [
	"Enumerated types for the associated attribute"

	^ #(capabilities )
]

{ #category : #visiting }
DAPCapabilitiesEvent >> acceptVisitor: aVisitor [

	^ aVisitor visitCapabilitiesEvent: self
]

{ #category : #accessing }
DAPCapabilitiesEvent >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPCapabilitiesEvent >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPCapabilitiesEvent >> capabilities [
	"The set of updated capabilities.
	#/definitions/Capabilities
	Auto-generated method"
	| result |

	result := self body at: #capabilities ifAbsent: [ nil ].
	result isDictionary ifTrue:
		[ result := DAPCapabilities fromDictionary: result client: client ].
	^ result
]

{ #category : #accessing }
DAPCapabilitiesEvent >> capabilities: anObject [
	"The set of updated capabilities.
	#/definitions/Capabilities
	Auto-generated method"

	self body at: #capabilities put: anObject
]

{ #category : #accessing }
DAPCapabilitiesEvent >> event [
	"capabilities: 
	Auto-generated method"

	^ event ifNil: [ 'capabilities' ]
]

{ #category : #accessing }
DAPCapabilitiesEvent >> event: anObject [
	"capabilities: 
	Auto-generated method"

	event := anObject

]

{ #category : #accessing }
DAPCapabilitiesEvent >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body capabilities event )
]
