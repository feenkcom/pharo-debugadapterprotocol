"
Response to 'gotoTargets' request.
"
Class {
	#name : #DAPGotoTargetsResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPGotoTargetsResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #visiting }
DAPGotoTargetsResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitGotoTargetsResponse: self
]

{ #category : #accessing }
DAPGotoTargetsResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPGotoTargetsResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPGotoTargetsResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body targets )
]

{ #category : #accessing }
DAPGotoTargetsResponse >> targets [
	"The possible goto targets of the specified location.
	array
	Auto-generated method"
	| result |

	result := self body at: #targets ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPGotoTargetsResponse >> targets: anObject [
	"The possible goto targets of the specified location.
	array
	Auto-generated method"

	self body at: #targets put: anObject
]
