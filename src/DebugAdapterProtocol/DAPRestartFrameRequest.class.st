"
The request restarts execution of the specified stackframe.
The debug adapter first sends the response and then a 'stopped' event (with reason 'restart') after the restart has completed.
Clients should only call this request if the capability 'supportsRestartFrame' is true.
"
Class {
	#name : #DAPRestartFrameRequest,
	#superclass : #DAPRequest,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPRestartFrameRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(restartFrame )
]

{ #category : #'json - configuration' }
DAPRestartFrameRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPRestartFrameRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitRestartFrameRequest: self
]

{ #category : #accessing }
DAPRestartFrameRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPRestartFrameRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPRestartFrameArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPRestartFrameRequest >> command [
	"restartFrame: 
	Auto-generated method"

	^ command ifNil: [ 'restartFrame' ]
]

{ #category : #accessing }
DAPRestartFrameRequest >> command: anObject [
	"restartFrame: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPRestartFrameRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(command arguments )
]
