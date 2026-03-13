"
The request terminates the threads with the given ids.
Clients should only call this request if the capability 'supportsTerminateThreadsRequest' is true.

"
Class {
	#name : #DAPTerminateThreadsRequest,
	#superclass : #DAPRequest,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPTerminateThreadsRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(terminateThreads )
]

{ #category : #'json - configuration' }
DAPTerminateThreadsRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPTerminateThreadsRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitTerminateThreadsRequest: self
]

{ #category : #accessing }
DAPTerminateThreadsRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPTerminateThreadsRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPTerminateThreadsArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPTerminateThreadsRequest >> command [
	"terminateThreads: 
	Auto-generated method"

	^ command ifNil: [ 'terminateThreads' ]
]

{ #category : #accessing }
DAPTerminateThreadsRequest >> command: anObject [
	"terminateThreads: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPTerminateThreadsRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
