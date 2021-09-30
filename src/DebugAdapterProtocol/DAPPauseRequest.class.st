"
The request suspends the debuggee.
The debug adapter first sends the response and then a 'stopped' event (with reason 'pause') after the thread has been paused successfully.

"
Class {
	#name : #DAPPauseRequest,
	#superclass : #DAPRequest,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPPauseRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(pause )
]

{ #category : #'json - configuration' }
DAPPauseRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPPauseRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitPauseRequest: self
]

{ #category : #accessing }
DAPPauseRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPPauseRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPPauseArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPPauseRequest >> command [
	"pause: 
	Auto-generated method"

	^ command ifNil: [ 'pause' ]
]

{ #category : #accessing }
DAPPauseRequest >> command: anObject [
	"pause: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPPauseRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
