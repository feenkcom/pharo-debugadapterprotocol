"
Response to 'stepBack' request. This is just an acknowledgement, so no body field is required.

"
Class {
	#name : #DAPStepBackResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPStepBackResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : #visiting }
DAPStepBackResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitStepBackResponse: self
]

{ #category : #accessing }
DAPStepBackResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
