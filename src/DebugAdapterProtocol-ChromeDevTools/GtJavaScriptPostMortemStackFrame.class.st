Class {
	#name : 'GtJavaScriptPostMortemStackFrame',
	#superclass : 'Object',
	#instVars : [
		'ordinal',
		'displayString',
		'exception',
		'file',
		'line',
		'column'
	],
	#category : 'DebugAdapterProtocol-ChromeDevTools'
}

{ #category : 'accessing' }
GtJavaScriptPostMortemStackFrame >> column [

	^ column
]

{ #category : 'accessing' }
GtJavaScriptPostMortemStackFrame >> column: anObject [

	column := anObject
]

{ #category : 'accessing' }
GtJavaScriptPostMortemStackFrame >> displayString [

	^ displayString
]

{ #category : 'accessing' }
GtJavaScriptPostMortemStackFrame >> displayString: anObject [

	displayString := anObject
]

{ #category : 'accessing' }
GtJavaScriptPostMortemStackFrame >> exception [

	^ exception
]

{ #category : 'accessing' }
GtJavaScriptPostMortemStackFrame >> exception: anObject [

	exception := anObject
]

{ #category : 'accessing' }
GtJavaScriptPostMortemStackFrame >> file [

	^ file
]

{ #category : 'accessing' }
GtJavaScriptPostMortemStackFrame >> file: anObject [

	file := anObject
]

{ #category : 'accessing' }
GtJavaScriptPostMortemStackFrame >> line [

	^ line
]

{ #category : 'accessing' }
GtJavaScriptPostMortemStackFrame >> line: anObject [

	line := anObject
]

{ #category : 'accessing' }
GtJavaScriptPostMortemStackFrame >> ordinal [

	^ ordinal
]

{ #category : 'accessing' }
GtJavaScriptPostMortemStackFrame >> ordinal: anObject [

	ordinal := anObject
]

{ #category : 'printing' }
GtJavaScriptPostMortemStackFrame >> printOn: aStream [

	displayString
		ifNil: [ super printOn: aStream ]
		ifNotNil: [ aStream << displayString ]
]

{ #category : 'accessing' }
GtJavaScriptPostMortemStackFrame >> sourceText [
	| source text indexes lineNumber |

	file exists ifTrue:
		[ source := file contents.
		lineNumber := line ]
	ifFalse:
		[ source := '<unavailable>'.
		lineNumber := 0 ].
	text := source asRopedText.
	lineNumber = 0 ifTrue: [ ^ text ].
	indexes := source gtIndexOfLineNumber: lineNumber.
	indexes ifNotNil: 
		[ (text from: indexes key + column - 1 to: indexes value) 
			attribute: (BlTextHighlightAttribute paint: BrGlamorousColors errorBackgroundColor)
				beNotOverwritableByStyler  ].
	^ text
]
