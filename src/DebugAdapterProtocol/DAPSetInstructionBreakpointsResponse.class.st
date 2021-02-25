"
Response to 'setInstructionBreakpoints' request
"
Class {
	#name : #DAPSetInstructionBreakpointsResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPSetInstructionBreakpointsResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #visiting }
DAPSetInstructionBreakpointsResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitSetInstructionBreakpointsResponse: self
]

{ #category : #accessing }
DAPSetInstructionBreakpointsResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPSetInstructionBreakpointsResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPSetInstructionBreakpointsResponse >> breakpoints [
	"Information about the breakpoints. The array elements correspond to the elements of the 'breakpoints' array.
	array
	Auto-generated method"
	| result |

	result := self body at: #breakpoints ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPSetInstructionBreakpointsResponse >> breakpoints: anObject [
	"Information about the breakpoints. The array elements correspond to the elements of the 'breakpoints' array.
	array
	Auto-generated method"

	self body at: #breakpoints put: anObject
]

{ #category : #accessing }
DAPSetInstructionBreakpointsResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body breakpoints )
]
