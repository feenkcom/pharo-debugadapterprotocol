"
The 'disconnect' request is sent from the client to the debug adapter in order to stop debugging.
It asks the debug adapter to disconnect from the debuggee and to terminate the debug adapter.
If the debuggee has been started with the 'launch' request, the 'disconnect' request terminates the debuggee.
If the 'attach' request was used to connect to the debuggee, 'disconnect' does not terminate the debuggee.
This behavior can be controlled with the 'terminateDebuggee' argument (if supported by the debug adapter).
"
Class {
	#name : #DAPDisconnectRequest,
	#superclass : #DAPRequest,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPDisconnectRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(disconnect )
]

{ #category : #'json - configuration' }
DAPDisconnectRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPDisconnectRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitDisconnectRequest: self
]

{ #category : #accessing }
DAPDisconnectRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPDisconnectRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPDisconnectArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPDisconnectRequest >> command [
	"disconnect: 
	Auto-generated method"

	^ command ifNil: [ 'disconnect' ]
]

{ #category : #accessing }
DAPDisconnectRequest >> command: anObject [
	"disconnect: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPDisconnectRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
