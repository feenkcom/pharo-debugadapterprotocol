"
This request retrieves the possible goto targets for the specified source location.
These targets can be used in the 'goto' request.
Clients should only call this request if the capability 'supportsGotoTargetsRequest' is true.
"
Class {
	#name : #DAPGotoTargetsRequest,
	#superclass : #DAPRequest,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPGotoTargetsRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(gotoTargets )
]

{ #category : #'json - configuration' }
DAPGotoTargetsRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPGotoTargetsRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitGotoTargetsRequest: self
]

{ #category : #accessing }
DAPGotoTargetsRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPGotoTargetsRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPGotoTargetsArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPGotoTargetsRequest >> command [
	"gotoTargets: 
	Auto-generated method"

	^ command ifNil: [ 'gotoTargets' ]
]

{ #category : #accessing }
DAPGotoTargetsRequest >> command: anObject [
	"gotoTargets: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPGotoTargetsRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
