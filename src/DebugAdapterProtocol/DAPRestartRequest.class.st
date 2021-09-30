"
Restarts a debug session. Clients should only call this request if the capability 'supportsRestartRequest' is true.
If the capability is missing or has the value false, a typical client will emulate 'restart' by terminating the debug adapter first and then launching it anew.

"
Class {
	#name : #DAPRestartRequest,
	#superclass : #DAPRequest,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPRestartRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(restart )
]

{ #category : #'json - configuration' }
DAPRestartRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPRestartRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitRestartRequest: self
]

{ #category : #accessing }
DAPRestartRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPRestartRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPRestartArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPRestartRequest >> command [
	"restart: 
	Auto-generated method"

	^ command ifNil: [ 'restart' ]
]

{ #category : #accessing }
DAPRestartRequest >> command: anObject [
	"restart: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPRestartRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
