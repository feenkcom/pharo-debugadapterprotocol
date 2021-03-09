"
The 'terminate' request is sent from the client to the debug adapter in order to give the debuggee a chance for terminating itself.
Clients should only call this request if the capability 'supportsTerminateRequest' is true.
"
Class {
	#name : #DAPTerminateRequest,
	#superclass : #DAPRequest,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPTerminateRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(terminate )
]

{ #category : #'json - configuration' }
DAPTerminateRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPTerminateRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitTerminateRequest: self
]

{ #category : #accessing }
DAPTerminateRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPTerminateRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPTerminateArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPTerminateRequest >> command [
	"terminate: 
	Auto-generated method"

	^ command ifNil: [ 'terminate' ]
]

{ #category : #accessing }
DAPTerminateRequest >> command: anObject [
	"terminate: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPTerminateRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
