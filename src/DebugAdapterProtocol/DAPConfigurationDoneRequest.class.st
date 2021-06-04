"
This optional request indicates that the client has finished initialization of the debug adapter.
So it is the last request in the sequence of configuration requests (which was started by the 'initialized' event).
Clients should only call this request if the capability 'supportsConfigurationDoneRequest' is true.

"
Class {
	#name : #DAPConfigurationDoneRequest,
	#superclass : #DAPRequest,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPConfigurationDoneRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(configurationDone )
]

{ #category : #'json - configuration' }
DAPConfigurationDoneRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPConfigurationDoneRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitConfigurationDoneRequest: self
]

{ #category : #accessing }
DAPConfigurationDoneRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPConfigurationDoneRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPConfigurationDoneArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPConfigurationDoneRequest >> command [
	"configurationDone: 
	Auto-generated method"

	^ command ifNil: [ 'configurationDone' ]
]

{ #category : #accessing }
DAPConfigurationDoneRequest >> command: anObject [
	"configurationDone: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPConfigurationDoneRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
