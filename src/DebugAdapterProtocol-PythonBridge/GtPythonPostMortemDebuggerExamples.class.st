Class {
	#name : #GtPythonPostMortemDebuggerExamples,
	#superclass : #Object,
	#category : #'DebugAdapterProtocol-PythonBridge-Examples'
}

{ #category : #examples }
GtPythonPostMortemDebuggerExamples >> debuggerFallsBackToTraceParsing [
    <gtExample>
    <return: #GtPythonPostMortemDebugger>
    | debugger |
    debugger := GtPythonPostMortemDebugger new
        exception: self textOnlyFailure;
        yourself.

    self assert: debugger stackFrames notEmpty.
    self assert: debugger stackFrames last line equals: 12.

    ^ debugger
]

{ #category : #examples }
GtPythonPostMortemDebuggerExamples >> debuggerWithStructuredFrames [
    <gtExample>
    <return: #GtPythonPostMortemDebugger>
    | debugger |
    debugger := GtPythonPostMortemDebugger new
        exception: self structuredFailure;
        yourself.

    self assert: debugger stackFrames size equals: 2.
    self assert: debugger stackFrames last line equals: 12.
    self assert: debugger stackFrames last file fullName equals: '/tmp/example.py'.

    ^ debugger
]

{ #category : #examples }
GtPythonPostMortemDebuggerExamples >> frameSourceText [
    <gtExample>
    <return: #GtPythonPostMortemStackFrame>
    | frame source |
    frame := self lastStructuredFrame.
    source := frame sourceText.

    self assert: source isNotNil.

    ^ frame
]

{ #category : #examples }
GtPythonPostMortemDebuggerExamples >> lastStructuredFrame [
    <gtExample>
    <return: #GtPythonPostMortemStackFrame>
    | frame |
    frame := self debuggerWithStructuredFrames stackFrames last.

    self assert: frame functionName equals: 'divide'.
    self assert: (frame localVariables includesKey: 'x').
    self assert: ((frame localVariables at: 'x') at: 'type') equals: 'int'.
    self assert: ((frame localVariables at: 'y') at: 'repr') equals: '0'.

    ^ frame
]

{ #category : #examples }
GtPythonPostMortemDebuggerExamples >> structuredFailure [
    <gtExample>
    <return: #PharoLinkRemoteError>
    | error exceptionData |
    error := PharoLinkRemoteError new.
    exceptionData := Dictionary new.
    exceptionData 
    	at: 'exception_message' put: 'division by zero';
    	at: 'exception_type' put: 'ZeroDivisionError';
    	at: 'frames' put: {
            (Dictionary new
                at: 'function' put: 'divide';
                at: 'filename' put: '/tmp/example.py';
                at: 'lineno' put: 12;
                at: 'locals' put: (Dictionary new
                    at: 'x' put: (Dictionary new
                        at: 'type' put: 'int';
                        at: 'repr' put: '1';
                        yourself);
                    at: 'y' put: (Dictionary new
                        at: 'type' put: 'int';
                        at: 'repr' put: '0';
                        yourself);
                    yourself);
                yourself).
            (Dictionary new
                at: 'function' put: 'main';
                at: 'filename' put: '/tmp/example.py';
                at: 'lineno' put: 20;
                at: 'locals' put: (Dictionary new
                    at: 'result' put: (Dictionary new
                        at: 'type' put: 'NoneType';
                        at: 'repr' put: 'None';
                        yourself);
                    yourself);
                yourself) }.
    error
        errorMessage: 'ZeroDivisionError: division by zero';
        trace: 'Traceback (most recent call last)';
        exceptionData: exceptionData.
    ^ error
]

{ #category : #examples }
GtPythonPostMortemDebuggerExamples >> textOnlyFailure [
    <gtExample>
    <return: #LanguageLinkErrorMessage>
    | failure |
    failure := LanguageLinkErrorMessage new.
    failure
        errorMessage: 'ZeroDivisionError';
        trace: 'Traceback (most recent call last)
  File "/tmp/example.py", line 12, in divide
    return x / y
  File "/tmp/example.py", line 20, in main
    divide(1, 0)'.
    ^ failure
]
