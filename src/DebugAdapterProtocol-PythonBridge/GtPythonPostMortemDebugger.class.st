Class {
	#name : #GtPythonPostMortemDebugger,
	#superclass : #Object,
	#instVars : [
		'exception',
		'session',
		'stackFrames',
		'frameRegex'
	],
	#category : 'DebugAdapterProtocol-PythonBridge'
}

{ #category : #accessing }
GtPythonPostMortemDebugger >> application [

	^ exception application
]

{ #category : #accessing }
GtPythonPostMortemDebugger >> exception [

	^ exception
]

{ #category : #accessing }
GtPythonPostMortemDebugger >> exception: anObject [

	exception := anObject
]

{ #category : #initialization }
GtPythonPostMortemDebugger >> initialize [

	super initialize.
	frameRegex := 'file "(.*)", line (\d+)' asRegexIgnoringCase.
]

{ #category : #accessing }
GtPythonPostMortemDebugger >> sourceStyler [
	"Answer the styler used by the source code editor for this exception"

	^ PythonParser gtStyler
]

{ #category : #private }
GtPythonPostMortemDebugger >> stackFrameFromLine: aString ordinal: ordinal [
	"Answer a frame if the supplied string contains a valid file and line number, or nil"
	<return: #GtPythonPostMortemStackFrame or: nil>
	
	^ (frameRegex search: aString) ifTrue:
		[ GtPythonPostMortemStackFrame new
				ordinal: ordinal;
				displayString: aString;
				exception: exception;
				file: (frameRegex subexpression: 2) asFileReference;
				line: (frameRegex subexpression: 3) asNumber ]
	ifFalse:
		[ nil ]

]

{ #category : #accessing }
GtPythonPostMortemDebugger >> stackFrames [
	"Answer a ordered collection of stack frames.
	This is called many times by the debugger, so cache"
	| ordinal |

	^ stackFrames ifNil:
		[ ordinal := 1.
		stackFrames := OrderedCollection new.
		exception trace lines do: [ :line | 
			(self stackFrameFromLine: line ordinal: ordinal) ifNotNil: [ :frame | 
				stackFrames add: frame.
				ordinal := ordinal + 1 ] ].
		stackFrames ].

]

{ #category : #accessing }
GtPythonPostMortemDebugger >> stderr [
	"Answer the stderr for the receiver's process."

	^ self application stderr
]

{ #category : #accessing }
GtPythonPostMortemDebugger >> stdout [
	"Answer the stdout for the receiver's process."

	^ self application stdout
]
