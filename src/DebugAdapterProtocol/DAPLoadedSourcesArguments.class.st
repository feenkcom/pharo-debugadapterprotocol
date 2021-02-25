"
Arguments for 'loadedSources' request.
"
Class {
	#name : #DAPLoadedSourcesArguments,
	#superclass : #DAPObject,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPLoadedSourcesArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : #visiting }
DAPLoadedSourcesArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitLoadedSourcesArguments: self
]

{ #category : #accessing }
DAPLoadedSourcesArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
