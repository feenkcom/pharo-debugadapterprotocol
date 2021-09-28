"
This enumeration defines all possible conditions when a thrown exception should result in a break.
never: never breaks,
always: always breaks,
unhandled: breaks when exception unhandled,
userUnhandled: breaks if the exception is not handled by user code.

"
Class {
	#name : #DAPExceptionBreakMode,
	#superclass : #DAPObject,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPExceptionBreakMode class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : #visiting }
DAPExceptionBreakMode >> acceptVisitor: aVisitor [

	^ aVisitor visitExceptionBreakMode: self
]

{ #category : #accessing }
DAPExceptionBreakMode >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
