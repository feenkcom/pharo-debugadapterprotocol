"
A Stackframe contains the source location.
"
Class {
	#name : #DAPStackFrame,
	#superclass : #DAPObject,
	#instVars : [
		'canRestart',
		'column',
		'endColumn',
		'endLine',
		'id',
		'instructionPointerReference',
		'line',
		'moduleId',
		'name',
		'ordinal',
		'presentationHint',
		'scopes',
		'source'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPStackFrame class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #instructionPointerReference to: #instructionPointerReference.
		mapping mapAccessor: #moduleId to: #moduleId.
		mapping mapAccessor: #endColumn to: #endColumn.
		mapping mapAccessor: #line to: #line.
		mapping mapAccessor: #name to: #name.
		mapping mapAccessor: #canRestart to: #canRestart.
		mapping mapAccessor: #id to: #id.
		mapping mapAccessor: #endLine to: #endLine.
		mapping mapAccessor: #presentationHint to: #presentationHint.
		mapping mapAccessor: #source to: #source.
		mapping mapAccessor: #column to: #column.
		].

]

{ #category : #accessing }
DAPStackFrame class >> presentationHintEnums [
	"Enumerated types for the associated attribute"

	^ #(normal label subtle )
]

{ #category : #visiting }
DAPStackFrame >> acceptVisitor: aVisitor [

	^ aVisitor visitStackFrame: self
]

{ #category : #accessing }
DAPStackFrame >> canRestart [
	"Indicates whether this frame can be restarted with the 'restart' request. Clients should only use this if the debug adapter supports the 'restart' request (capability 'supportsRestartRequest' is true).
	boolean
	Auto-generated method"

	^ canRestart
]

{ #category : #accessing }
DAPStackFrame >> canRestart: anObject [
	"Indicates whether this frame can be restarted with the 'restart' request. Clients should only use this if the debug adapter supports the 'restart' request (capability 'supportsRestartRequest' is true).
	boolean
	Auto-generated method"

	canRestart := anObject

]

{ #category : #accessing }
DAPStackFrame >> column [
	"The column within the line. If source is null or doesn't exist, column is 0 and must be ignored.
	integer
	Auto-generated method"

	^ column
]

{ #category : #accessing }
DAPStackFrame >> column: anObject [
	"The column within the line. If source is null or doesn't exist, column is 0 and must be ignored.
	integer
	Auto-generated method"

	column := anObject

]

{ #category : #accessing }
DAPStackFrame >> endColumn [
	"An optional end column of the range covered by the stack frame.
	integer
	Auto-generated method"

	^ endColumn
]

{ #category : #accessing }
DAPStackFrame >> endColumn: anObject [
	"An optional end column of the range covered by the stack frame.
	integer
	Auto-generated method"

	endColumn := anObject

]

{ #category : #accessing }
DAPStackFrame >> endLine [
	"An optional end line of the range covered by the stack frame.
	integer
	Auto-generated method"

	^ endLine
]

{ #category : #accessing }
DAPStackFrame >> endLine: anObject [
	"An optional end line of the range covered by the stack frame.
	integer
	Auto-generated method"

	endLine := anObject

]

{ #category : #ui }
DAPStackFrame >> gtSourceFor: aView [
	<gtView>

	(self sourceCode isNil or: [ self sourceCode isEmpty]) ifTrue: [ ^ aView empty ].
	^ aView explicit
		title: 'Source';
		priority: 100;
		actionUpdateButtonTooltip: 'Update Source';
		stencil: [ | editor |
			editor := BrEditor new
				text: self sourceText;
				look: BrGlamorousCodeEditorLook new.
			self source gtStyler ifNotNil: [ :gtStyler |
				editor styler: gtStyler ].
			self line > 5 ifTrue:
				[ editor 	scrollToPosition: self line - 5 ].
			editor ]
]

{ #category : #ui }
DAPStackFrame >> gtVariablesFor: aView [
	<gtView>

	^ aView columnedTree
		title: 'Variables';
		priority: 1;
		items: [ self valuesDictionary associations ];
		children: [ :each | 
			each value isDictionary
				ifTrue: [ each value associations ]
				ifFalse: [ (each value isArray and: [ each value allSatisfy: #isDictionary ])
						ifTrue: [ each value collectWithIndex: [ :x :i | i -> x ] ]
						ifFalse: [ #() ] ] ];
		column: 'Key' text: [ :assoc | assoc key ];
		column: 'Value' text: [ :assoc | assoc value ];
		send: [ :assoc | assoc value ]
]

{ #category : #accessing }
DAPStackFrame >> id [
	"An identifier for the stack frame. It must be unique across all threads.
This id can be used to retrieve the scopes of the frame with the 'scopesRequest' or to restart the execution of a stackframe.
	integer
	Auto-generated method"

	^ id
]

{ #category : #accessing }
DAPStackFrame >> id: anObject [
	"An identifier for the stack frame. It must be unique across all threads.
This id can be used to retrieve the scopes of the frame with the 'scopesRequest' or to restart the execution of a stackframe.
	integer
	Auto-generated method"

	id := anObject

]

{ #category : #accessing }
DAPStackFrame >> instructionPointerReference [
	"Optional memory reference for the current instruction pointer in this frame.
	string
	Auto-generated method"

	^ instructionPointerReference
]

{ #category : #accessing }
DAPStackFrame >> instructionPointerReference: anObject [
	"Optional memory reference for the current instruction pointer in this frame.
	string
	Auto-generated method"

	instructionPointerReference := anObject

]

{ #category : #accessing }
DAPStackFrame >> line [
	"The line within the file of the frame. If source is null or doesn't exist, line is 0 and must be ignored.
	integer
	Auto-generated method"

	^ line
]

{ #category : #accessing }
DAPStackFrame >> line: anObject [
	"The line within the file of the frame. If source is null or doesn't exist, line is 0 and must be ignored.
	integer
	Auto-generated method"

	line := anObject

]

{ #category : #accessing }
DAPStackFrame >> moduleId [
	"The module associated with this frame, if any.
	integerstring
	Auto-generated method"

	^ moduleId
]

{ #category : #accessing }
DAPStackFrame >> moduleId: anObject [
	"The module associated with this frame, if any.
	integerstring
	Auto-generated method"

	moduleId := anObject

]

{ #category : #accessing }
DAPStackFrame >> name [
	"The name of the stack frame, typically a method name.
	string
	Auto-generated method"

	^ name
]

{ #category : #accessing }
DAPStackFrame >> name: anObject [
	"The name of the stack frame, typically a method name.
	string
	Auto-generated method"

	name := anObject

]

{ #category : #accessing }
DAPStackFrame >> ordinal [
	^ ordinal
]

{ #category : #accessing }
DAPStackFrame >> ordinal: anObject [
	ordinal := anObject
]

{ #category : #accessing }
DAPStackFrame >> presentationHint [
	"An optional hint for how to present this frame in the UI.
A value of 'label' can be used to indicate that the frame is an artificial frame that is used as a visual label or separator. A value of 'subtle' can be used to change the appearance of a frame in a 'subtle' way.
	string
	normal: 
	label: 
	subtle: 
	Auto-generated method"

	^ presentationHint ifNil: [ 'normal' ]
]

{ #category : #accessing }
DAPStackFrame >> presentationHint: anObject [
	"An optional hint for how to present this frame in the UI.
A value of 'label' can be used to indicate that the frame is an artificial frame that is used as a visual label or separator. A value of 'subtle' can be used to change the appearance of a frame in a 'subtle' way.
	string
	normal: 
	label: 
	subtle: 
	Auto-generated method"

	presentationHint := anObject

]

{ #category : #printing }
DAPStackFrame >> printOn: aStream [

	self source ifNil: [ ^ super printOn: aStream ].
	aStream
		<< self source path;
		<< ':';
		print: self line;
		<< ':';
		print: self column
]

{ #category : #accessing }
DAPStackFrame >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(canRestart column endColumn endLine id instructionPointerReference line moduleId name presentationHint source )
]

{ #category : #accessing }
DAPStackFrame >> scopes [ 

	^ scopes ifNil: [ scopes := (client scopesForFrameId: id) allScopes ]
]

{ #category : #actions }
DAPStackFrame >> setBreakpointInSourceLines: anArray [ 
	"Set breakpoints in the receiver's file at the designated  line numbers"

	^ client setBreakpointInSource: self source lines: anArray
]

{ #category : #accessing }
DAPStackFrame >> source [
	"The optional source of the frame.
	#/definitions/Source
	Auto-generated method"

	^ source
]

{ #category : #accessing }
DAPStackFrame >> source: anObject [
	"The optional source of the frame.
	#/definitions/Source
	Auto-generated method"

	source := anObject isDictionary ifTrue:
		[ DAPSource fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #ui }
DAPStackFrame >> sourceCode [

	source ifNil: [ ^ '' ].
	^ self source sourceCode
]

{ #category : #ui }
DAPStackFrame >> sourceText [ 
	"Answer the receiver's source code, with the current line highlighted"
	| text indexes lineNumber sourceCode |

	lineNumber := self line.
	sourceCode := self sourceCode withSqueakLineEndings.
	text := sourceCode asRopedText.
	lineNumber = 0 ifTrue: [ ^ text ].
	indexes := sourceCode gtIndexOfLineNumber: lineNumber.
	indexes ifNotNil: 
		[ (text from: indexes key + self column - 1 to: indexes value) 
			attribute: (BlTextHighlightAttribute paint: BrGlamorousColors errorBackgroundColor)
				beNotOverwritableByStyler  ].
	^ text
]

{ #category : #accessing }
DAPStackFrame >> valuesDictionary [
	"Answer a dictionary with key: Scope Name key: Variable Name value: DAPVariable"
	| dictionary scopeDictionary |

	"Some debuggers, e.g. Chrome, return the scopes in order"
	dictionary := OrderedDictionary new.
	self scopes do: [ :scope |
		scope variables do: [ :variable |
			scopeDictionary := dictionary at: scope name ifAbsentPut: [ OrderedDictionary new ].
			scopeDictionary at: variable name put: variable pharoValue ] ].
	^ dictionary
]

{ #category : #accessing }
DAPStackFrame >> variablesDictionary [
	"Answer a dictionary with key: Scope Name key: Variable Name value: DAPVariable"
	| dictionary scopeDictionary |

	"Some debuggers, e.g. Chrome, return the scopes in order"
	dictionary := OrderedDictionary new.
	self scopes do: [ :scope |
		scope variables do: [ :variable |
			scopeDictionary := dictionary at: scope name ifAbsentPut: [ OrderedDictionary new ].
			scopeDictionary at: variable name put: variable ] ].
	^ dictionary 

]
