"
Response to 'setExceptionBreakpoints' request. This is just an acknowledgement, so no body field is required.

"
Class {
	#name : 'DAPSetExceptionBreakpointsResponse',
	#superclass : 'DAPResponse',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPSetExceptionBreakpointsResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : 'visiting' }
DAPSetExceptionBreakpointsResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitSetExceptionBreakpointsResponse: self
]

{ #category : 'accessing' }
DAPSetExceptionBreakpointsResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
