"
Response to 'setBreakpoints' request.
Returned is information about each breakpoint created by this request.
This includes the actual code location and whether the breakpoint could be verified.
The breakpoints returned are in the same order as the elements of the 'breakpoints'
(or the deprecated 'lines') array in the arguments.
"
Class {
	#name : #DAPSetBreakpointsResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPSetBreakpointsResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #visiting }
DAPSetBreakpointsResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitSetBreakpointsResponse: self
]

{ #category : #accessing }
DAPSetBreakpointsResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPSetBreakpointsResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPSetBreakpointsResponse >> breakpoints [
	"Information about the breakpoints.
The array elements are in the same order as the elements of the 'breakpoints' (or the deprecated 'lines') array in the arguments.
	array
	Auto-generated method"
	| result |

	result := self body at: #breakpoints ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPSetBreakpointsResponse >> breakpoints: anObject [
	"Information about the breakpoints.
The array elements are in the same order as the elements of the 'breakpoints' (or the deprecated 'lines') array in the arguments.
	array
	Auto-generated method"

	self body at: #breakpoints put: anObject
]

{ #category : #accessing }
DAPSetBreakpointsResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body breakpoints )
]
