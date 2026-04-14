Class {
	#name : #GtPythonPostMortemStackFrame,
	#superclass : #Object,
	#instVars : [
		'ordinal',
		'displayString',
		'exception',
		'file',
		'line',
		'functionName',
		'localVariables',
		'sourceString'
	],
	#category : #'DebugAdapterProtocol-PythonBridge'
}

{ #category : #'instance creation' }
GtPythonPostMortemStackFrame class >> fromStructuredFrame: aDictionary ordinal: anInteger exception: anException [
	| filename function script |

	filename := aDictionary at: 'filename' ifAbsent: [ '<unavailable>' ].
	function := aDictionary at: 'function' ifAbsent: [ '<unknown>' ].
	(filename = '<string>' and: [ function = '<module>' ]) ifTrue:
		[ script := anException script ].
	^ self new
		ordinal: anInteger;
    exception: anException;
    file: (filename asFileReference);
    line: (aDictionary at: 'lineno' ifAbsent: [ 0 ]);
    functionName: function;
    localVariables: (aDictionary at: 'locals' ifAbsent: [ Dictionary new ]);
    sourceString: script;
    displayString: (String streamContents: [ :stream |
    	stream
        << (aDictionary at: 'function' ifAbsent: [ '<unknown>' ]);
        << ' in ';
        << ((aDictionary at: 'filename' ifAbsent: [ '<unavailable>' ]) asString);
        << ':';
        << ((aDictionary at: 'lineno' ifAbsent: [ 0 ]) asString) ]);
    yourself
]

{ #category : #accessing }
GtPythonPostMortemStackFrame >> displayString [

	^ displayString
]

{ #category : #accessing }
GtPythonPostMortemStackFrame >> displayString: anObject [

	displayString := anObject
]

{ #category : #accessing }
GtPythonPostMortemStackFrame >> exception [

	^ exception
]

{ #category : #accessing }
GtPythonPostMortemStackFrame >> exception: anObject [

	exception := anObject
]

{ #category : #accessing }
GtPythonPostMortemStackFrame >> file [

	^ file
]

{ #category : #accessing }
GtPythonPostMortemStackFrame >> file: anObject [

	file := anObject
]

{ #category : #accessing }
GtPythonPostMortemStackFrame >> functionName [
	^ functionName
]

{ #category : #accessing }
GtPythonPostMortemStackFrame >> functionName: anObject [
	functionName := anObject
]

{ #category : #ui }
GtPythonPostMortemStackFrame >> gtViewLocalsFor: aView [
    <gtView>
    self localVariables isEmpty ifTrue: [ ^ aView empty ].
    ^ aView columnedList
        title: 'Locals';
        priority: 20;
        items: [ self localVariables associations ];
        column: 'Name' text: [ :assoc | assoc key asString ];
        column: 'Type' text: [ :assoc |
            ((assoc value at: 'type' ifAbsent: [ nil ]) ifNil: [ '' ]) asString ];
        column: 'Value' text: [ :assoc |
            ((assoc value at: 'repr' ifAbsent: [ assoc value printString ])) asString ]
]

{ #category : #ui }
GtPythonPostMortemStackFrame >> gtViewSourceFor: aView [
    <gtView>
    
    ^ aView textEditor
        title: 'Source';
        priority: 10;
        aptitude: BrGlamorousCodeEditorAptitude;
        text: [ self sourceText ]
]

{ #category : #ui }
GtPythonPostMortemStackFrame >> gtViewSummaryFor: aView [
    <gtView>
    ^ aView text
        title: 'Summary';
        priority: 5;
        text: [
            (String streamContents: [ :stream |
                stream
                    << 'Function: '; << (self functionName ifNil: [ '<unknown>' ]); cr;
                    << 'File: '; << self file fullName; cr;
                    << 'Line: '; << self line asString ]) asRopedText ]
]

{ #category : #accessing }
GtPythonPostMortemStackFrame >> line [

	^ line
]

{ #category : #accessing }
GtPythonPostMortemStackFrame >> line: anObject [

	line := anObject
]

{ #category : #accessing }
GtPythonPostMortemStackFrame >> localVariables [
	"Answer the local variables dictionary in the format supplied by the python runtime"
	<return: #Dictionary>

	^ localVariables
]

{ #category : #accessing }
GtPythonPostMortemStackFrame >> localVariables: anObject [
	localVariables := anObject
]

{ #category : #accessing }
GtPythonPostMortemStackFrame >> ordinal [

	^ ordinal
]

{ #category : #accessing }
GtPythonPostMortemStackFrame >> ordinal: anObject [

	ordinal := anObject
]

{ #category : #printing }
GtPythonPostMortemStackFrame >> printOn: aStream [
    displayString ifNotNil: [ ^ aStream << displayString ].
    functionName ifNotNil: [
        aStream
            << functionName;
            << ' in ';
            << file fullName;
            << ':';
            << line asString.
        ^ self ].
    super printOn: aStream
]

{ #category : #accessing }
GtPythonPostMortemStackFrame >> sourceString [
	^ sourceString
]

{ #category : #accessing }
GtPythonPostMortemStackFrame >> sourceString: anObject [
	sourceString := anObject
]

{ #category : #accessing }
GtPythonPostMortemStackFrame >> sourceText [
	| source text indexes lineNumber |

	sourceString ifNil:
		[ file exists ifTrue:
			[ source := file contents.
			lineNumber := line ]
		ifFalse:
			[ source := '<unavailable>'.
			lineNumber := 0 ] ]
	ifNotNil:
		[ source := sourceString.
		lineNumber := line ].
	text := source asRopedText.
	lineNumber = 0 ifTrue: [ ^ text ].
	indexes := source gtIndexOfLineNumber: lineNumber.
	indexes ifNotNil: 
		[ (text from: indexes key to: indexes value) 
			attribute: (BlTextUnderlayAttribute paint: BrGlamorousColors debuggerTextHighlightColor)
				beNotOverwritableByStyler  ].
	^ text
]

{ #category : #accessing }
GtPythonPostMortemStackFrame >> variablesDictionary [
	"Answer the variables dictionary in the format expected by the debugger element"
	| localsDict variablesDict |

	variablesDict := Dictionary new.
	localVariables ifNotNil:
		[ localsDict := Dictionary new.
		localVariables keysAndValuesDo: [ :key :val |
			localsDict at: key put: (val at: 'repr') ].
		variablesDict at: 'Locals' put: localsDict ].
	^ variablesDict
]
