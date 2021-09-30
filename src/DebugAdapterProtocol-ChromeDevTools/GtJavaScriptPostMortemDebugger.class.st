Class {
	#name : #GtJavaScriptPostMortemDebugger,
	#superclass : #Object,
	#instVars : [
		'exception',
		'session',
		'stackFrames',
		'frameRegex'
	],
	#category : 'DebugAdapterProtocol-ChromeDevTools'
}

{ #category : #accessing }
GtJavaScriptPostMortemDebugger >> application [

	^ exception application
]

{ #category : #accessing }
GtJavaScriptPostMortemDebugger >> exception [

	^ exception
]

{ #category : #accessing }
GtJavaScriptPostMortemDebugger >> exception: anObject [

	exception := anObject
]

{ #category : #initialization }
GtJavaScriptPostMortemDebugger >> initialize [

	super initialize.
	frameRegex := '\s+at.+\(([^:]+)\:(\d+)\:(\d+)\)' asRegexIgnoringCase.
]

{ #category : #accessing }
GtJavaScriptPostMortemDebugger >> sourceStyler [
	"Answer the styler used by the source code editor for this exception"

	^ JSParser gtStyler
]

{ #category : #private }
GtJavaScriptPostMortemDebugger >> stackFrameFromLine: aString ordinal: ordinal [
	"Answer a frame if the supplied string contains a valid file and line number, or nil"
	<return: #GtPythonPostMortemStackFrame or: nil>
	| file line column |

	^ (frameRegex search: aString) ifTrue:
		[ file := frameRegex subexpression: 2.
		line := frameRegex subexpression: 3.
		column := frameRegex subexpression: 4.
		GtJavaScriptPostMortemStackFrame new
				ordinal: ordinal;
				displayString: aString;
				exception: exception;
				file: file asFileReference;
				line: line asNumber;
				column: column asNumber ]
	ifFalse:
		[ nil ]

]

{ #category : #accessing }
GtJavaScriptPostMortemDebugger >> stackFrames [
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
GtJavaScriptPostMortemDebugger >> stderr [
	"Answer the stderr for the receiver's process."

	^ self application stderr
]

{ #category : #accessing }
GtJavaScriptPostMortemDebugger >> stdout [
	"Answer the stdout for the receiver's process."

	^ self application stdout
]
