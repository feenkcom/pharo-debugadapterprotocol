"
Response to 'initialize' request.

"
Class {
	#name : #DAPInitializeResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPInitializeResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #visiting }
DAPInitializeResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitInitializeResponse: self
]

{ #category : #accessing }
DAPInitializeResponse >> body [
	"The capabilities of this debug adapter.
	#/definitions/Capabilities
	Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPInitializeResponse >> body: anObject [
	"The capabilities of this debug adapter.
	#/definitions/Capabilities
	Auto-generated method"

	body := anObject isDictionary ifTrue:
		[ DAPCapabilities fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPInitializeResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body )
]
