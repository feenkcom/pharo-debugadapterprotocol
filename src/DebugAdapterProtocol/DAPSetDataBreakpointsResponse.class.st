"
Response to 'setDataBreakpoints' request.
Returned is information about each breakpoint created by this request.

"
Class {
	#name : #DAPSetDataBreakpointsResponse,
	#superclass : #DAPResponse,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPSetDataBreakpointsResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #visiting }
DAPSetDataBreakpointsResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitSetDataBreakpointsResponse: self
]

{ #category : #accessing }
DAPSetDataBreakpointsResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPSetDataBreakpointsResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPSetDataBreakpointsResponse >> breakpoints [
	"Information about the data breakpoints. The array elements correspond to the elements of the input argument 'breakpoints' array.
	array
	Auto-generated method"
	| result |

	result := self body at: #breakpoints ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPSetDataBreakpointsResponse >> breakpoints: anObject [
	"Information about the data breakpoints. The array elements correspond to the elements of the input argument 'breakpoints' array.
	array
	Auto-generated method"

	self body at: #breakpoints put: anObject
]

{ #category : #accessing }
DAPSetDataBreakpointsResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body breakpoints )
]
