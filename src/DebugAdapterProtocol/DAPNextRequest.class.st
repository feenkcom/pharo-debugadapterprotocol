"
The request starts the debuggee to run again for one step.
The debug adapter first sends the response and then a 'stopped' event (with reason 'step') after the step has completed.

"
Class {
	#name : 'DAPNextRequest',
	#superclass : 'DAPRequest',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'accessing' }
DAPNextRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(next )
]

{ #category : 'json - configuration' }
DAPNextRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : 'visiting' }
DAPNextRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitNextRequest: self
]

{ #category : 'accessing' }
DAPNextRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : 'accessing' }
DAPNextRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPNextArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : 'accessing' }
DAPNextRequest >> command [
	"next: 
	Auto-generated method"

	^ command ifNil: [ 'next' ]
]

{ #category : 'accessing' }
DAPNextRequest >> command: anObject [
	"next: 
	Auto-generated method"

	command := anObject

]

{ #category : 'accessing' }
DAPNextRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
