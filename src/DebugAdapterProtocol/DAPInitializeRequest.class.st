"
The 'initialize' request is sent as the first request from the client to the debug adapter
in order to configure it with client capabilities and to retrieve capabilities from the debug adapter.
Until the debug adapter has responded to with an 'initialize' response, the client must not send any additional requests or events to the debug adapter.
In addition the debug adapter is not allowed to send any requests or events to the client until it has responded with an 'initialize' response.
The 'initialize' request may only be sent once.
"
Class {
	#name : #DAPInitializeRequest,
	#superclass : #DAPRequest,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPInitializeRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(initialize )
]

{ #category : #'json - configuration' }
DAPInitializeRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPInitializeRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitInitializeRequest: self
]

{ #category : #accessing }
DAPInitializeRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPInitializeRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPInitializeRequestArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPInitializeRequest >> command [
	"initialize: 
	Auto-generated method"

	^ command ifNil: [ 'initialize' ]
]

{ #category : #accessing }
DAPInitializeRequest >> command: anObject [
	"initialize: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPInitializeRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
