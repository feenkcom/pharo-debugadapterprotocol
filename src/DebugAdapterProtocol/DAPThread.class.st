"
A Thread
"
Class {
	#name : #DAPThread,
	#superclass : #DAPObject,
	#instVars : [
		'id',
		'name'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPThread class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #name to: #name.
		mapping mapAccessor: #id to: #id.
		].

]

{ #category : #visiting }
DAPThread >> acceptVisitor: aVisitor [

	^ aVisitor visitThread: self
]

{ #category : #accessing }
DAPThread >> id [
	"Unique identifier for the thread.
	integer
	Auto-generated method"

	^ id
]

{ #category : #accessing }
DAPThread >> id: anObject [
	"Unique identifier for the thread.
	integer
	Auto-generated method"

	id := anObject

]

{ #category : #accessing }
DAPThread >> name [
	"A name of the thread.
	string
	Auto-generated method"

	^ name
]

{ #category : #accessing }
DAPThread >> name: anObject [
	"A name of the thread.
	string
	Auto-generated method"

	name := anObject

]

{ #category : #accessing }
DAPThread >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(name id )
]
