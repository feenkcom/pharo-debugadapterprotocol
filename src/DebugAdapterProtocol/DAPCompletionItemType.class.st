"
Some predefined types for the CompletionItem. Please note that not all clients have specific icons for all of them.

"
Class {
	#name : #DAPCompletionItemType,
	#superclass : #DAPObject,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPCompletionItemType class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		].

]

{ #category : #visiting }
DAPCompletionItemType >> acceptVisitor: aVisitor [

	^ aVisitor visitCompletionItemType: self
]

{ #category : #accessing }
DAPCompletionItemType >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]
