"
Information about a Breakpoint created in setBreakpoints, setFunctionBreakpoints, setInstructionBreakpoints, or setDataBreakpoints.
"
Class {
	#name : #DAPBreakpoint,
	#superclass : #DAPObject,
	#instVars : [
		'column',
		'endColumn',
		'endLine',
		'id',
		'instructionReference',
		'line',
		'message',
		'offset',
		'source',
		'verified'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPBreakpoint class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #column to: #column.
		mapping mapAccessor: #line to: #line.
		mapping mapAccessor: #id to: #id.
		mapping mapAccessor: #endLine to: #endLine.
		mapping mapAccessor: #instructionReference to: #instructionReference.
		mapping mapAccessor: #offset to: #offset.
		mapping mapAccessor: #message to: #message.
		mapping mapAccessor: #verified to: #verified.
		mapping mapAccessor: #source to: #source.
		mapping mapAccessor: #endColumn to: #endColumn.
		].

]

{ #category : #visiting }
DAPBreakpoint >> acceptVisitor: aVisitor [

	^ aVisitor visitBreakpoint: self
]

{ #category : #accessing }
DAPBreakpoint >> column [
	"An optional start column of the actual range covered by the breakpoint.
	integer
	Auto-generated method"

	^ column
]

{ #category : #accessing }
DAPBreakpoint >> column: anObject [
	"An optional start column of the actual range covered by the breakpoint.
	integer
	Auto-generated method"

	column := anObject

]

{ #category : #accessing }
DAPBreakpoint >> displayLabel [

	^ self source 
		ifNil: [ '<unknown>:', line asString ]
		ifNotNil: [ self source path, ':', line asString ]
]

{ #category : #accessing }
DAPBreakpoint >> endColumn [
	"An optional end column of the actual range covered by the breakpoint.
If no end line is given, then the end column is assumed to be in the start line.
	integer
	Auto-generated method"

	^ endColumn
]

{ #category : #accessing }
DAPBreakpoint >> endColumn: anObject [
	"An optional end column of the actual range covered by the breakpoint.
If no end line is given, then the end column is assumed to be in the start line.
	integer
	Auto-generated method"

	endColumn := anObject

]

{ #category : #accessing }
DAPBreakpoint >> endLine [
	"An optional end line of the actual range covered by the breakpoint.
	integer
	Auto-generated method"

	^ endLine
]

{ #category : #accessing }
DAPBreakpoint >> endLine: anObject [
	"An optional end line of the actual range covered by the breakpoint.
	integer
	Auto-generated method"

	endLine := anObject

]

{ #category : #ui }
DAPBreakpoint >> gtSourceFor: aView [
	<gtView>

	^ aView explicit
		title: 'Source';
		priority: 10;
		actionUpdateButtonTooltip: 'Update Source';
		stencil: [ | editor |
			editor := BrEditor new
				text: self sourceText;
				look: BrGlamorousCodeEditorLook new;
				styler: PythonParser2 gtStyler.
			self line > 5 ifTrue:
				[ editor 	scrollToPosition: self line - 5 ].
			editor ]


]

{ #category : #accessing }
DAPBreakpoint >> id [
	"An optional identifier for the breakpoint. It is needed if breakpoint events are used to update or remove breakpoints.
	integer
	Auto-generated method"

	^ id
]

{ #category : #accessing }
DAPBreakpoint >> id: anObject [
	"An optional identifier for the breakpoint. It is needed if breakpoint events are used to update or remove breakpoints.
	integer
	Auto-generated method"

	id := anObject

]

{ #category : #accessing }
DAPBreakpoint >> instructionReference [
	"An optional memory reference to where the breakpoint is set.
	string
	Auto-generated method"

	^ instructionReference
]

{ #category : #accessing }
DAPBreakpoint >> instructionReference: anObject [
	"An optional memory reference to where the breakpoint is set.
	string
	Auto-generated method"

	instructionReference := anObject

]

{ #category : #accessing }
DAPBreakpoint >> line [
	"The start line of the actual range covered by the breakpoint.
	integer
	Auto-generated method"

	^ line
]

{ #category : #accessing }
DAPBreakpoint >> line: anObject [
	"The start line of the actual range covered by the breakpoint.
	integer
	Auto-generated method"

	line := anObject

]

{ #category : #accessing }
DAPBreakpoint >> message [
	"An optional message about the state of the breakpoint.
This is shown to the user and can be used to explain why a breakpoint could not be verified.
	string
	Auto-generated method"

	^ message
]

{ #category : #accessing }
DAPBreakpoint >> message: anObject [
	"An optional message about the state of the breakpoint.
This is shown to the user and can be used to explain why a breakpoint could not be verified.
	string
	Auto-generated method"

	message := anObject

]

{ #category : #accessing }
DAPBreakpoint >> offset [
	"An optional offset from the instruction reference.
This can be negative.
	integer
	Auto-generated method"

	^ offset
]

{ #category : #accessing }
DAPBreakpoint >> offset: anObject [
	"An optional offset from the instruction reference.
This can be negative.
	integer
	Auto-generated method"

	offset := anObject

]

{ #category : #accessing }
DAPBreakpoint >> printOn: aStream [

	aStream
		<< 'Breakpoint: ';
		<< self displayLabel
]

{ #category : #accessing }
DAPBreakpoint >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(column endColumn endLine id instructionReference line message offset source verified )
]

{ #category : #accessing }
DAPBreakpoint >> source [
	"The source where the breakpoint is located.
	#/definitions/Source
	Auto-generated method"

	^ source
]

{ #category : #accessing }
DAPBreakpoint >> source: anObject [
	"The source where the breakpoint is located.
	#/definitions/Source
	Auto-generated method"

	source := anObject isDictionary ifTrue:
		[ DAPSource fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #ui }
DAPBreakpoint >> sourceCode [

	source ifNil: [ ^ '' ].
	^ self source sourceCode
]

{ #category : #ui }
DAPBreakpoint >> sourceText [ 
	"Answer the receiver's source code, with the breakpoint line highlighted"
	| text indexes lineNumber sourceCode |

	lineNumber := self line.
	sourceCode := self sourceCode withSqueakLineEndings.
	text := sourceCode asRopedText.
	lineNumber = 0 ifTrue: [ ^ text ].
	indexes := sourceCode gtIndexOfLineNumber: lineNumber.
	indexes ifNotNil: 
		[ (text 
			from: indexes key + (self column ifNil: [ 1 ]) - 1 
			to: indexes value) 
			attribute: (BlTextHighlightAttribute paint: BrGlamorousColors errorBackgroundColor)
				beNotOverwritableByStyler  ].
	^ text
]

{ #category : #accessing }
DAPBreakpoint >> verified [
	"If true breakpoint could be set (but not necessarily at the desired location).
	boolean
	Auto-generated method"

	^ verified
]

{ #category : #accessing }
DAPBreakpoint >> verified: anObject [
	"If true breakpoint could be set (but not necessarily at the desired location).
	boolean
	Auto-generated method"

	verified := anObject

]
