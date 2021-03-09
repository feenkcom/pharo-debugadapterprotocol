"
This optional request is sent from the debug adapter to the client to run a command in a terminal.
This is typically used to launch the debuggee in a terminal provided by the client.
This request should only be called if the client has passed the value true for the 'supportsRunInTerminalRequest' capability of the 'initialize' request.
"
Class {
	#name : #DAPRunInTerminalRequest,
	#superclass : #DAPRequest,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPRunInTerminalRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(runInTerminal )
]

{ #category : #'json - configuration' }
DAPRunInTerminalRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPRunInTerminalRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitRunInTerminalRequest: self
]

{ #category : #accessing }
DAPRunInTerminalRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPRunInTerminalRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPRunInTerminalRequestArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPRunInTerminalRequest >> command [
	"runInTerminal: 
	Auto-generated method"

	^ command ifNil: [ 'runInTerminal' ]
]

{ #category : #accessing }
DAPRunInTerminalRequest >> command: anObject [
	"runInTerminal: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPRunInTerminalRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
