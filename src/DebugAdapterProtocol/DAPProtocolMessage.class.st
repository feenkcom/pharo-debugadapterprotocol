"
Base class of requests, responses, and events.
"
Class {
	#name : #DAPProtocolMessage,
	#superclass : #DAPObject,
	#instVars : [
		'type',
		'seq'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPProtocolMessage class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #seq to: #seq.
		mapping mapAccessor: #type to: #type.
		].

]

{ #category : #visiting }
DAPProtocolMessage >> acceptVisitor: aVisitor [

	^ aVisitor visitProtocolMessage: self
]

{ #category : #accessing }
DAPProtocolMessage >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(seq type )
]

{ #category : #accessing }
DAPProtocolMessage >> seq [
	"Sequence number (also known as message ID). For protocol messages of type 'request' this ID can be used to cancel the request.
	integer
	Auto-generated method"

	^ seq
]

{ #category : #accessing }
DAPProtocolMessage >> seq: anObject [
	"Sequence number (also known as message ID). For protocol messages of type 'request' this ID can be used to cancel the request.
	integer
	Auto-generated method"

	seq := anObject

]

{ #category : #accessing }
DAPProtocolMessage >> type [
	"Message type.
	string
	Auto-generated method"

	^ type
]

{ #category : #accessing }
DAPProtocolMessage >> type: anObject [
	"Message type.
	string
	Auto-generated method"

	type := anObject

]
