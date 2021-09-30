"
Retrieves the set of all sources currently loaded by the debugged process.
Clients should only call this request if the capability 'supportsLoadedSourcesRequest' is true.

"
Class {
	#name : #DAPLoadedSourcesRequest,
	#superclass : #DAPRequest,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPLoadedSourcesRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(loadedSources )
]

{ #category : #'json - configuration' }
DAPLoadedSourcesRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPLoadedSourcesRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitLoadedSourcesRequest: self
]

{ #category : #accessing }
DAPLoadedSourcesRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPLoadedSourcesRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPLoadedSourcesArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPLoadedSourcesRequest >> command [
	"loadedSources: 
	Auto-generated method"

	^ command ifNil: [ 'loadedSources' ]
]

{ #category : #accessing }
DAPLoadedSourcesRequest >> command: anObject [
	"loadedSources: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPLoadedSourcesRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
