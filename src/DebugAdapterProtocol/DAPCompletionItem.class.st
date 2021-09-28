"
CompletionItems are the suggestions returned from the CompletionsRequest.

"
Class {
	#name : #DAPCompletionItem,
	#superclass : #DAPObject,
	#instVars : [
		'label',
		'length',
		'selectionLength',
		'selectionStart',
		'sortText',
		'start',
		'text',
		'type'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPCompletionItem class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #start to: #start.
		mapping mapAccessor: #selectionStart to: #selectionStart.
		mapping mapAccessor: #length to: #length.
		mapping mapAccessor: #sortText to: #sortText.
		mapping mapAccessor: #text to: #text.
		mapping mapAccessor: #type to: #type.
		mapping mapAccessor: #selectionLength to: #selectionLength.
		mapping mapAccessor: #label to: #label.
		].

]

{ #category : #visiting }
DAPCompletionItem >> acceptVisitor: aVisitor [

	^ aVisitor visitCompletionItem: self
]

{ #category : #accessing }
DAPCompletionItem >> label [
	"The label of this completion item. By default this is also the text that is inserted when selecting this completion.
	string
	Auto-generated method"

	^ label
]

{ #category : #accessing }
DAPCompletionItem >> label: anObject [
	"The label of this completion item. By default this is also the text that is inserted when selecting this completion.
	string
	Auto-generated method"

	label := anObject

]

{ #category : #accessing }
DAPCompletionItem >> length [
	"This value determines how many characters are overwritten by the completion text.
If missing the value 0 is assumed which results in the completion text being inserted.
	integer
	Auto-generated method"

	^ length
]

{ #category : #accessing }
DAPCompletionItem >> length: anObject [
	"This value determines how many characters are overwritten by the completion text.
If missing the value 0 is assumed which results in the completion text being inserted.
	integer
	Auto-generated method"

	length := anObject

]

{ #category : #accessing }
DAPCompletionItem >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(label length selectionLength selectionStart sortText start text type )
]

{ #category : #accessing }
DAPCompletionItem >> selectionLength [
	"Determines the length of the new selection after the text has been inserted (or replaced).
The selection can not extend beyond the bounds of the completion text.
If omitted the length is assumed to be 0.
	integer
	Auto-generated method"

	^ selectionLength
]

{ #category : #accessing }
DAPCompletionItem >> selectionLength: anObject [
	"Determines the length of the new selection after the text has been inserted (or replaced).
The selection can not extend beyond the bounds of the completion text.
If omitted the length is assumed to be 0.
	integer
	Auto-generated method"

	selectionLength := anObject

]

{ #category : #accessing }
DAPCompletionItem >> selectionStart [
	"Determines the start of the new selection after the text has been inserted (or replaced).
The start position must in the range 0 and length of the completion text.
If omitted the selection starts at the end of the completion text.
	integer
	Auto-generated method"

	^ selectionStart
]

{ #category : #accessing }
DAPCompletionItem >> selectionStart: anObject [
	"Determines the start of the new selection after the text has been inserted (or replaced).
The start position must in the range 0 and length of the completion text.
If omitted the selection starts at the end of the completion text.
	integer
	Auto-generated method"

	selectionStart := anObject

]

{ #category : #accessing }
DAPCompletionItem >> sortText [
	"A string that should be used when comparing this item with other items. When `falsy` the label is used.
	string
	Auto-generated method"

	^ sortText
]

{ #category : #accessing }
DAPCompletionItem >> sortText: anObject [
	"A string that should be used when comparing this item with other items. When `falsy` the label is used.
	string
	Auto-generated method"

	sortText := anObject

]

{ #category : #accessing }
DAPCompletionItem >> start [
	"This value determines the location (in the CompletionsRequest's 'text' attribute) where the completion text is added.
If missing the text is added at the location specified by the CompletionsRequest's 'column' attribute.
	integer
	Auto-generated method"

	^ start
]

{ #category : #accessing }
DAPCompletionItem >> start: anObject [
	"This value determines the location (in the CompletionsRequest's 'text' attribute) where the completion text is added.
If missing the text is added at the location specified by the CompletionsRequest's 'column' attribute.
	integer
	Auto-generated method"

	start := anObject

]

{ #category : #accessing }
DAPCompletionItem >> text [
	"If text is not falsy then it is inserted instead of the label.
	string
	Auto-generated method"

	^ text
]

{ #category : #accessing }
DAPCompletionItem >> text: anObject [
	"If text is not falsy then it is inserted instead of the label.
	string
	Auto-generated method"

	text := anObject

]

{ #category : #accessing }
DAPCompletionItem >> type [
	"The item's type. Typically the client uses this information to render the item in the UI with an icon.
	#/definitions/CompletionItemType
	Auto-generated method"

	^ type
]

{ #category : #accessing }
DAPCompletionItem >> type: anObject [
	"The item's type. Typically the client uses this information to render the item in the UI with an icon.
	#/definitions/CompletionItemType
	Auto-generated method"

	type := anObject isDictionary ifTrue:
		[ DAPCompletionItemType fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]
