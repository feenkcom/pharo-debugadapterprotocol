"
A debug adapter initiated event.
"
Class {
	#name : #DAPEvent,
	#superclass : #DAPProtocolMessage,
	#instVars : [
		'event',
		'body'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPEvent class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #type to: #type.
		mapping mapAccessor: #body to: #body.
		mapping mapAccessor: #event to: #event.
		].

]

{ #category : #accessing }
DAPEvent class >> typeEnums [
	"Enumerated types for the associated attribute"

	^ #(event )
]

{ #category : #visiting }
DAPEvent >> acceptVisitor: aVisitor [

	^ aVisitor visitEvent: self
]

{ #category : #accessing }
DAPEvent >> body [
	"Event-specific information.
	arraybooleanintegernullnumberobjectstring
	Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPEvent >> body: anObject [
	"Event-specific information.
	arraybooleanintegernullnumberobjectstring
	Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPEvent >> event [
	"Type of event.
	string
	Auto-generated method"

	^ event
]

{ #category : #accessing }
DAPEvent >> event: anObject [
	"Type of event.
	string
	Auto-generated method"

	event := anObject

]

{ #category : #accessing }
DAPEvent >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body event type )
]

{ #category : #accessing }
DAPEvent >> type [
	"event: 
	Auto-generated method"

	^ type ifNil: [ 'event' ]
]

{ #category : #accessing }
DAPEvent >> type: anObject [
	"event: 
	Auto-generated method"

	type := anObject

]
