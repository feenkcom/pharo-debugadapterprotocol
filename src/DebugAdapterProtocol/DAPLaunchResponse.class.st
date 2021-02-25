"
Response to 'launch' request. This is just an acknowledgement, so no body field is required.
"
Class {
	#name : #DAPLaunchResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPLaunchResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : #visiting }
DAPLaunchResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitLaunchResponse: self
]

{ #category : #accessing }
DAPLaunchResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
