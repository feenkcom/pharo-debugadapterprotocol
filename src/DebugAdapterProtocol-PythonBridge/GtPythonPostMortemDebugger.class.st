Class {
	#name : #GtPythonPostMortemDebugger,
	#superclass : #Object,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'exception',
		'session',
		'stackFrames',
		'frameRegex',
		'announcer'
	],
	#category : #'DebugAdapterProtocol-PythonBridge'
}

{ #category : #announcer }
GtPythonPostMortemDebugger >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
GtPythonPostMortemDebugger >> application [

	^ exception application
]

{ #category : #accessing }
GtPythonPostMortemDebugger >> exception [
	<return: #PharoLinkRemoteError>

	^ exception
]

{ #category : #accessing }
GtPythonPostMortemDebugger >> exception: aPharoLinkRemoteError [

	exception := aPharoLinkRemoteError
]

{ #category : #testing }
GtPythonPostMortemDebugger >> hasStructuredFrames [
	"Answer a boolean indicating whether the stack frames are based on information returned from the python server, or scraped from the stack string"

	^ exception isNotNil and:
		[ exception exceptionData isNotNil ]
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
		self hasStructuredFrames ifTrue:
			[ exception stackFrames do: [ :frame |
				stackFrames add: (GtPythonPostMortemStackFrame
					fromStructuredFrame: frame
					ordinal: ordinal
					exception: exception) ] ]
		ifFalse:
			[ 	exception trace lines do: [ :line | 
				(self stackFrameFromLine: line ordinal: ordinal) ifNotNil: [ :frame | 
					stackFrames add: frame.
					ordinal := ordinal + 1 ] ] ].
		stackFrames := stackFrames reversed asArray.
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
