"
The attach request is sent from the client to the debug adapter to attach to a debuggee that is already running.
Since attaching is debugger/runtime specific, the arguments for this request are not part of this specification.

"
Class {
	#name : #DAPAttachRequest,
	#superclass : #DAPRequest,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPAttachRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(attach )
]

{ #category : #'json - configuration' }
DAPAttachRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPAttachRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitAttachRequest: self
]

{ #category : #accessing }
DAPAttachRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPAttachRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPAttachRequestArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPAttachRequest >> command [
	"attach: 
	Auto-generated method"

	^ command ifNil: [ 'attach' ]
]

{ #category : #accessing }
DAPAttachRequest >> command: anObject [
	"attach: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPAttachRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
