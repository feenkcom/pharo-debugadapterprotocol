"
Arguments for 'restart' request.
"
Class {
	#name : #DAPRestartArguments,
	#superclass : #DAPObject,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPRestartArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : #visiting }
DAPRestartArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitRestartArguments: self
]

{ #category : #accessing }
DAPRestartArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
