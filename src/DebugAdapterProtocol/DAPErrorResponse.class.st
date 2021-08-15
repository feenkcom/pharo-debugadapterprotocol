"
On error (whenever 'success' is false), the body can provide more details.

"
Class {
	#name : 'DAPErrorResponse',
	#superclass : 'DAPResponse',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPErrorResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : 'visiting' }
DAPErrorResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitErrorResponse: self
]

{ #category : 'accessing' }
DAPErrorResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : 'accessing' }
DAPErrorResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : 'accessing' }
DAPErrorResponse >> error [
	"An optional, structured error message.
	#/definitions/Message
	Auto-generated method"
	| result |

	result := self body at: #error ifAbsent: [ nil ].
	result isDictionary ifTrue:
		[ result := DAPMessage fromDictionary: result client: client ].
	^ result
]

{ #category : 'accessing' }
DAPErrorResponse >> error: anObject [
	"An optional, structured error message.
	#/definitions/Message
	Auto-generated method"

	self body at: #error put: anObject
]

{ #category : 'accessing' }
DAPErrorResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body error )
]
