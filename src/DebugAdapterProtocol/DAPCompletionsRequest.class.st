"
Returns a list of possible completions for a given caret position and text.
Clients should only call this request if the capability 'supportsCompletionsRequest' is true.

"
Class {
	#name : #DAPCompletionsRequest,
	#superclass : #DAPRequest,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPCompletionsRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(completions )
]

{ #category : #'json - configuration' }
DAPCompletionsRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPCompletionsRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitCompletionsRequest: self
]

{ #category : #accessing }
DAPCompletionsRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPCompletionsRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPCompletionsArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPCompletionsRequest >> command [
	"completions: 
	Auto-generated method"

	^ command ifNil: [ 'completions' ]
]

{ #category : #accessing }
DAPCompletionsRequest >> command: anObject [
	"completions: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPCompletionsRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
