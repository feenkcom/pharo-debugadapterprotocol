"
Arguments for 'configurationDone' request.

"
Class {
	#name : #DAPConfigurationDoneArguments,
	#superclass : #DAPObject,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPConfigurationDoneArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : #visiting }
DAPConfigurationDoneArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitConfigurationDoneArguments: self
]

{ #category : #accessing }
DAPConfigurationDoneArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
