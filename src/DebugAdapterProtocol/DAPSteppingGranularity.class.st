"
The granularity of one 'step' in the stepping requests 'next', 'stepIn', 'stepOut', and 'stepBack'.

"
Class {
	#name : 'DAPSteppingGranularity',
	#superclass : 'DAPObject',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPSteppingGranularity class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : 'visiting' }
DAPSteppingGranularity >> acceptVisitor: aVisitor [

	^ aVisitor visitSteppingGranularity: self
]

{ #category : 'accessing' }
DAPSteppingGranularity >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
