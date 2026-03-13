"
Response to 'restartFrame' request. This is just an acknowledgement, so no body field is required.

"
Class {
	#name : #DAPRestartFrameResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPRestartFrameResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : #visiting }
DAPRestartFrameResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitRestartFrameResponse: self
]

{ #category : #accessing }
DAPRestartFrameResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
