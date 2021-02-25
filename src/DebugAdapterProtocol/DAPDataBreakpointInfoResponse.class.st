"
Response to 'dataBreakpointInfo' request.
"
Class {
	#name : #DAPDataBreakpointInfoResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPDataBreakpointInfoResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #visiting }
DAPDataBreakpointInfoResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitDataBreakpointInfoResponse: self
]

{ #category : #accessing }
DAPDataBreakpointInfoResponse >> accessTypes [
	"Optional attribute listing the available access types for a potential data breakpoint. A UI frontend could surface this information.
	array
	Auto-generated method"
	| result |

	result := self body at: #accessTypes ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPDataBreakpointInfoResponse >> accessTypes: anObject [
	"Optional attribute listing the available access types for a potential data breakpoint. A UI frontend could surface this information.
	array
	Auto-generated method"

	self body at: #accessTypes put: anObject
]

{ #category : #accessing }
DAPDataBreakpointInfoResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPDataBreakpointInfoResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPDataBreakpointInfoResponse >> canPersist [
	"Optional attribute indicating that a potential data breakpoint could be persisted across sessions.
	boolean
	Auto-generated method"
	| result |

	result := self body at: #canPersist ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPDataBreakpointInfoResponse >> canPersist: anObject [
	"Optional attribute indicating that a potential data breakpoint could be persisted across sessions.
	boolean
	Auto-generated method"

	self body at: #canPersist put: anObject
]

{ #category : #accessing }
DAPDataBreakpointInfoResponse >> dataId [
	"An identifier for the data on which a data breakpoint can be registered with the setDataBreakpoints request or null if no data breakpoint is available.
	stringnull
	Auto-generated method"
	| result |

	result := self body at: #dataId ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPDataBreakpointInfoResponse >> dataId: anObject [
	"An identifier for the data on which a data breakpoint can be registered with the setDataBreakpoints request or null if no data breakpoint is available.
	stringnull
	Auto-generated method"

	self body at: #dataId put: anObject
]

{ #category : #accessing }
DAPDataBreakpointInfoResponse >> description [
	"UI string that describes on what data the breakpoint is set on or why a data breakpoint is not available.
	string
	Auto-generated method"
	| result |

	result := self body at: #description ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPDataBreakpointInfoResponse >> description: anObject [
	"UI string that describes on what data the breakpoint is set on or why a data breakpoint is not available.
	string
	Auto-generated method"

	self body at: #description put: anObject
]

{ #category : #accessing }
DAPDataBreakpointInfoResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body accessTypes description canPersist dataId )
]
