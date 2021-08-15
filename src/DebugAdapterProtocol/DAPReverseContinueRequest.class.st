"
The request starts the debuggee to run backward.
Clients should only call this request if the capability 'supportsStepBack' is true.

"
Class {
	#name : 'DAPReverseContinueRequest',
	#superclass : 'DAPRequest',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'accessing' }
DAPReverseContinueRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(reverseContinue )
]

{ #category : 'json - configuration' }
DAPReverseContinueRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : 'visiting' }
DAPReverseContinueRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitReverseContinueRequest: self
]

{ #category : 'accessing' }
DAPReverseContinueRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : 'accessing' }
DAPReverseContinueRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPReverseContinueArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : 'accessing' }
DAPReverseContinueRequest >> command [
	"reverseContinue: 
	Auto-generated method"

	^ command ifNil: [ 'reverseContinue' ]
]

{ #category : 'accessing' }
DAPReverseContinueRequest >> command: anObject [
	"reverseContinue: 
	Auto-generated method"

	command := anObject

]

{ #category : 'accessing' }
DAPReverseContinueRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
