"
Notification that the remote debugpy server is waiting.
"
Class {
	#name : #DAPDebugpyWaitingForServer,
	#superclass : #DAPEvent,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPDebugpyWaitingForServer class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #event to: #event.
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #accessing }
DAPDebugpyWaitingForServer class >> eventEnums [
	"Enumerated types for the associated attribute"

	^ #(debugpyWaitingForServer )
]

{ #category : #visiting }
DAPDebugpyWaitingForServer >> acceptVisitor: aVisitor [

	^ aVisitor visitDebugpyWaitingForServer: self
]

{ #category : #accessing }
DAPDebugpyWaitingForServer >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPDebugpyWaitingForServer >> body: anObject [
	"Auto-generated method"

	body := anObject isDictionary ifTrue:
		[ DAPIPAddress fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPDebugpyWaitingForServer >> event [
	"debugpyWaitingForServer: 
	Auto-generated method"

	^ event ifNil: [ 'debugpyWaitingForServer' ]
]

{ #category : #accessing }
DAPDebugpyWaitingForServer >> event: anObject [
	"debugpyWaitingForServer: 
	Auto-generated method"

	event := anObject

]

{ #category : #accessing }
DAPDebugpyWaitingForServer >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(event body )
]
