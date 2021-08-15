"
Notification that the remote debugpy server is waiting.

"
Class {
	#name : 'DAPDebugpyWaitingForServerEvent',
	#superclass : 'DAPEvent',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPDebugpyWaitingForServerEvent class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #event to: #event.
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : 'accessing' }
DAPDebugpyWaitingForServerEvent class >> eventEnums [
	"Enumerated types for the associated attribute"

	^ #(debugpyWaitingForServer )
]

{ #category : 'visiting' }
DAPDebugpyWaitingForServerEvent >> acceptVisitor: aVisitor [

	^ aVisitor visitDebugpyWaitingForServerEvent: self
]

{ #category : 'accessing' }
DAPDebugpyWaitingForServerEvent >> body [
	"Auto-generated method"

	^ body
]

{ #category : 'accessing' }
DAPDebugpyWaitingForServerEvent >> body: anObject [
	"Auto-generated method"

	body := anObject isDictionary ifTrue:
		[ DAPIPAddress fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : 'accessing' }
DAPDebugpyWaitingForServerEvent >> event [
	"debugpyWaitingForServer: 
	Auto-generated method"

	^ event ifNil: [ 'debugpyWaitingForServer' ]
]

{ #category : 'accessing' }
DAPDebugpyWaitingForServerEvent >> event: anObject [
	"debugpyWaitingForServer: 
	Auto-generated method"

	event := anObject

]

{ #category : 'accessing' }
DAPDebugpyWaitingForServerEvent >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(event body )
]
