"
Response to 'attach' request. This is just an acknowledgement, so no body field is required.

"
Class {
	#name : #DAPAttachResponse,
	#superclass : #DAPResponse,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPAttachResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : #visiting }
DAPAttachResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitAttachResponse: self
]

{ #category : #accessing }
DAPAttachResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
