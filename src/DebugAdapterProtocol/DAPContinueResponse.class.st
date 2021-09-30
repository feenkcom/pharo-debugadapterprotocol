"
Response to 'continue' request.

"
Class {
	#name : #DAPContinueResponse,
	#superclass : #DAPResponse,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPContinueResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #visiting }
DAPContinueResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitContinueResponse: self
]

{ #category : #accessing }
DAPContinueResponse >> allThreadsContinued [
	"If true, the 'continue' request has ignored the specified thread and continued all threads instead.
If this attribute is missing a value of 'true' is assumed for backward compatibility.
	boolean
	Auto-generated method"
	| result |

	result := self body at: #allThreadsContinued ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPContinueResponse >> allThreadsContinued: anObject [
	"If true, the 'continue' request has ignored the specified thread and continued all threads instead.
If this attribute is missing a value of 'true' is assumed for backward compatibility.
	boolean
	Auto-generated method"

	self body at: #allThreadsContinued put: anObject
]

{ #category : #accessing }
DAPContinueResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPContinueResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPContinueResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(allThreadsContinued body )
]
