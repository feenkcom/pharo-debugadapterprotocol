"
This enumeration defines all possible access types for data breakpoints.

"
Class {
	#name : #DAPDataBreakpointAccessType,
	#superclass : #DAPObject,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPDataBreakpointAccessType class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : #visiting }
DAPDataBreakpointAccessType >> acceptVisitor: aVisitor [

	^ aVisitor visitDataBreakpointAccessType: self
]

{ #category : #accessing }
DAPDataBreakpointAccessType >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
