"
Arguments for 'completions' request.

"
Class {
	#name : #DAPCompletionsArguments,
	#superclass : #DAPObject,
	#instVars : [
		'column',
		'frameId',
		'line',
		'text'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPCompletionsArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #column to: #column.
		mapping mapAccessor: #text to: #text.
		mapping mapAccessor: #line to: #line.
		mapping mapAccessor: #frameId to: #frameId.
		].

]

{ #category : #visiting }
DAPCompletionsArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitCompletionsArguments: self
]

{ #category : #accessing }
DAPCompletionsArguments >> column [
	"The character position for which to determine the completion proposals.
	integer
	Auto-generated method"

	^ column
]

{ #category : #accessing }
DAPCompletionsArguments >> column: anObject [
	"The character position for which to determine the completion proposals.
	integer
	Auto-generated method"

	column := anObject

]

{ #category : #accessing }
DAPCompletionsArguments >> frameId [
	"Returns completions in the scope of this stack frame. If not specified, the completions are returned for the global scope.
	integer
	Auto-generated method"

	^ frameId
]

{ #category : #accessing }
DAPCompletionsArguments >> frameId: anObject [
	"Returns completions in the scope of this stack frame. If not specified, the completions are returned for the global scope.
	integer
	Auto-generated method"

	frameId := anObject

]

{ #category : #accessing }
DAPCompletionsArguments >> line [
	"An optional line for which to determine the completion proposals. If missing the first line of the text is assumed.
	integer
	Auto-generated method"

	^ line
]

{ #category : #accessing }
DAPCompletionsArguments >> line: anObject [
	"An optional line for which to determine the completion proposals. If missing the first line of the text is assumed.
	integer
	Auto-generated method"

	line := anObject

]

{ #category : #accessing }
DAPCompletionsArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(column frameId line text )
]

{ #category : #accessing }
DAPCompletionsArguments >> text [
	"One or more source lines. Typically this is the text a user has typed into the debug console before he asked for completion.
	string
	Auto-generated method"

	^ text
]

{ #category : #accessing }
DAPCompletionsArguments >> text: anObject [
	"One or more source lines. Typically this is the text a user has typed into the debug console before he asked for completion.
	string
	Auto-generated method"

	text := anObject

]
