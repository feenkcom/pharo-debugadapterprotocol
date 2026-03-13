"
Modules can be retrieved from the debug adapter with this request which can either return all modules or a range of modules to support paging.
Clients should only call this request if the capability 'supportsModulesRequest' is true.

"
Class {
	#name : #DAPModulesRequest,
	#superclass : #DAPRequest,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPModulesRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(modules )
]

{ #category : #'json - configuration' }
DAPModulesRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPModulesRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitModulesRequest: self
]

{ #category : #accessing }
DAPModulesRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPModulesRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPModulesArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPModulesRequest >> command [
	"modules: 
	Auto-generated method"

	^ command ifNil: [ 'modules' ]
]

{ #category : #accessing }
DAPModulesRequest >> command: anObject [
	"modules: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPModulesRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
