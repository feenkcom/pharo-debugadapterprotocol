"
Response to 'stackTrace' request.
"
Class {
	#name : #DAPStackTraceResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPStackTraceResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #visiting }
DAPStackTraceResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitStackTraceResponse: self
]

{ #category : #accessing }
DAPStackTraceResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPStackTraceResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPStackTraceResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body stackFrames totalFrames )
]

{ #category : #accessing }
DAPStackTraceResponse >> stackFrames [
	"The frames of the stackframe. If the array has length zero, there are no stackframes available.
This means that there is no location information available.
	array
	Auto-generated method"
	| result |

	result := self body at: #stackFrames ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPStackTraceResponse >> stackFrames: anObject [
	"The frames of the stackframe. If the array has length zero, there are no stackframes available.
This means that there is no location information available.
	array
	Auto-generated method"

	self body at: #stackFrames put: anObject
]

{ #category : #accessing }
DAPStackTraceResponse >> totalFrames [
	"The total number of frames available in the stack. If omitted or if totalFrames is larger than the available frames, a client is expected to request frames until a request returns less frames than requested (which indicates the end of the stack). Returning monotonically increasing totalFrames values for subsequent requests can be used to enforce paging in the client.
	integer
	Auto-generated method"
	| result |

	result := self body at: #totalFrames ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPStackTraceResponse >> totalFrames: anObject [
	"The total number of frames available in the stack. If omitted or if totalFrames is larger than the available frames, a client is expected to request frames until a request returns less frames than requested (which indicates the end of the stack). Returning monotonically increasing totalFrames values for subsequent requests can be used to enforce paging in the client.
	integer
	Auto-generated method"

	self body at: #totalFrames put: anObject
]
