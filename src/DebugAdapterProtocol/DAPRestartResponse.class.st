"
Response to 'restart' request. This is just an acknowledgement, so no body field is required.
"
Class {
	#name : #DAPRestartResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPRestartResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : #visiting }
DAPRestartResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitRestartResponse: self
]

{ #category : #accessing }
DAPRestartResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
