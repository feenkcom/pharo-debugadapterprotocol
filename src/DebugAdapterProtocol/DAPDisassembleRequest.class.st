"
Disassembles code stored at the provided location.
Clients should only call this request if the capability 'supportsDisassembleRequest' is true.

"
Class {
	#name : 'DAPDisassembleRequest',
	#superclass : 'DAPRequest',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'accessing' }
DAPDisassembleRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(disassemble )
]

{ #category : 'json - configuration' }
DAPDisassembleRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : 'visiting' }
DAPDisassembleRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitDisassembleRequest: self
]

{ #category : 'accessing' }
DAPDisassembleRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : 'accessing' }
DAPDisassembleRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPDisassembleArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : 'accessing' }
DAPDisassembleRequest >> command [
	"disassemble: 
	Auto-generated method"

	^ command ifNil: [ 'disassemble' ]
]

{ #category : 'accessing' }
DAPDisassembleRequest >> command: anObject [
	"disassemble: 
	Auto-generated method"

	command := anObject

]

{ #category : 'accessing' }
DAPDisassembleRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
