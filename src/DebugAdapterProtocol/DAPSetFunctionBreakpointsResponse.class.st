"
Response to 'setFunctionBreakpoints' request.
Returned is information about each breakpoint created by this request.

"
Class {
	#name : #DAPSetFunctionBreakpointsResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPSetFunctionBreakpointsResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #visiting }
DAPSetFunctionBreakpointsResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitSetFunctionBreakpointsResponse: self
]

{ #category : #accessing }
DAPSetFunctionBreakpointsResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPSetFunctionBreakpointsResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPSetFunctionBreakpointsResponse >> breakpoints [
	"Information about the breakpoints. The array elements correspond to the elements of the 'breakpoints' array.
	array
	Auto-generated method"
	| result |

	result := self body at: #breakpoints ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPSetFunctionBreakpointsResponse >> breakpoints: anObject [
	"Information about the breakpoints. The array elements correspond to the elements of the 'breakpoints' array.
	array
	Auto-generated method"

	self body at: #breakpoints put: anObject
]

{ #category : #accessing }
DAPSetFunctionBreakpointsResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body breakpoints )
]
