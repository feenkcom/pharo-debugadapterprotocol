Class {
	#name : 'GtPythonPostMortemStackFrame',
	#superclass : 'Object',
	#instVars : [
		'ordinal',
		'displayString',
		'exception',
		'file',
		'line'
	],
	#category : 'DebugAdapterProtocol-PythonBridge'
}

{ #category : 'accessing' }
GtPythonPostMortemStackFrame >> displayString [

	^ displayString
]

{ #category : 'accessing' }
GtPythonPostMortemStackFrame >> displayString: anObject [

	displayString := anObject
]

{ #category : 'accessing' }
GtPythonPostMortemStackFrame >> exception [

	^ exception
]

{ #category : 'accessing' }
GtPythonPostMortemStackFrame >> exception: anObject [

	exception := anObject
]

{ #category : 'accessing' }
GtPythonPostMortemStackFrame >> file [

	^ file
]

{ #category : 'accessing' }
GtPythonPostMortemStackFrame >> file: anObject [

	file := anObject
]

{ #category : 'accessing' }
GtPythonPostMortemStackFrame >> line [

	^ line
]

{ #category : 'accessing' }
GtPythonPostMortemStackFrame >> line: anObject [

	line := anObject
]

{ #category : 'accessing' }
GtPythonPostMortemStackFrame >> ordinal [

	^ ordinal
]

{ #category : 'accessing' }
GtPythonPostMortemStackFrame >> ordinal: anObject [

	ordinal := anObject
]

{ #category : 'printing' }
GtPythonPostMortemStackFrame >> printOn: aStream [

	displayString
		ifNil: [ super printOn: aStream ]
		ifNotNil: [ aStream << displayString ]
]

{ #category : 'accessing' }
GtPythonPostMortemStackFrame >> sourceText [
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
		[ (text from: indexes key to: indexes value) 
			attribute: (BlTextHighlightAttribute paint: BrGlamorousColors errorBackgroundColor)
				beNotOverwritableByStyler  ].
	^ text
]
