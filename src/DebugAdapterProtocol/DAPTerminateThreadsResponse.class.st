"
Response to 'terminateThreads' request. This is just an acknowledgement, so no body field is required.

"
Class {
	#name : 'DAPTerminateThreadsResponse',
	#superclass : 'DAPResponse',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPTerminateThreadsResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : 'visiting' }
DAPTerminateThreadsResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitTerminateThreadsResponse: self
]

{ #category : 'accessing' }
DAPTerminateThreadsResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
