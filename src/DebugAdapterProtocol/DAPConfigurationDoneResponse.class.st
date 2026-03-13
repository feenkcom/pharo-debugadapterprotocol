"
Response to 'configurationDone' request. This is just an acknowledgement, so no body field is required.

"
Class {
	#name : #DAPConfigurationDoneResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPConfigurationDoneResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : #visiting }
DAPConfigurationDoneResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitConfigurationDoneResponse: self
]

{ #category : #accessing }
DAPConfigurationDoneResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
