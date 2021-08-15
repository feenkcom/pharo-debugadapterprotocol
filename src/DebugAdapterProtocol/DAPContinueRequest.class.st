"
The request starts the debuggee to run again.

"
Class {
	#name : 'DAPContinueRequest',
	#superclass : 'DAPRequest',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'accessing' }
DAPContinueRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(continue )
]

{ #category : 'json - configuration' }
DAPContinueRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : 'visiting' }
DAPContinueRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitContinueRequest: self
]

{ #category : 'accessing' }
DAPContinueRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : 'accessing' }
DAPContinueRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPContinueArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : 'accessing' }
DAPContinueRequest >> command [
	"continue: 
	Auto-generated method"

	^ command ifNil: [ 'continue' ]
]

{ #category : 'accessing' }
DAPContinueRequest >> command: anObject [
	"continue: 
	Auto-generated method"

	command := anObject

]

{ #category : 'accessing' }
DAPContinueRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
