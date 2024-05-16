Class {
	#name : #DAPSubprocessComms,
	#superclass : #DAPServerComms,
	#instVars : [
		'serverExecutable',
		'subprocess',
		'readProcess',
		'inStream',
		'outStream',
		'errStream',
		'stdout',
		'stderr',
		'readDelay'
	],
	#category : #'DebugAdapterProtocol-Client'
}

{ #category : #running }
DAPSubprocessComms >> connect [

	self error: 'I need updating to use GtExternalProcessBuilder'.
	"Streams are named from the debugger process' perspective"
	"inStream := OSSVMProcess vmProcess systemAccessor makeBlockingPipe.
	outStream := OSSVMProcess vmProcess systemAccessor makeNonBlockingPipe.
	errStream := OSSVMProcess vmProcess systemAccessor makeNonBlockingPipe.

	subprocess := OSSUnixSubprocess new 
		redirectStdinTo: inStream;
		redirectStdoutTo: outStream;
		redirectStderrTo: errStream;
		command: serverExecutable fullName;
		arguments: #();
		terminateOnShutdown;
		yourself.
	subprocess run.

	readProcess := [ self readFromSubprocess ] forkAt: Processor userSchedulingPriority - 1."
]

{ #category : #running }
DAPSubprocessComms >> disconnect [ 


	subprocess terminate.
	subprocess closeAndCleanStreams.
	readProcess terminate.
]

{ #category : #accessing }
DAPSubprocessComms >> flush [ 

	inStream flush.
]

{ #category : #private }
DAPSubprocessComms >> initialize [ 

	super initialize.
	stdout := ''.
	stderr := ''.
	self serverExecutable: '/home/alistair/.vscode/extensions/ms-vscode.cpptools-1.2.2/debugAdapters/OpenDebugAD7'.
	readDelay := 100 milliSeconds.
]

{ #category : #testing }
DAPSubprocessComms >> isConnected [ 

	^ subprocess isRunning
]

{ #category : #testing }
DAPSubprocessComms >> isDisconnected [

	^ subprocess isTerminated
]

{ #category : #accessing }
DAPSubprocessComms >> nextPutAll: aBuffer [

	inStream nextPutAll: aBuffer
]

{ #category : #private }
DAPSubprocessComms >> processStdout [
	| index contentLength contentLengthLine start end content |

	index := stdout indexOfSubCollection: String crlf.
	index < 1 ifTrue: [ ^ self ].
	contentLengthLine := stdout copyFrom: 1 to: index-1.
	"We can use #asString here since it should only be digits"
	contentLength := (contentLengthLine copyFrom: 17 to: contentLengthLine size)  asString trimBoth asNumber.
	self assert: [ contentLength > 2 ].
	start := index + 4.
	end := start + contentLength - 1.
	end > stdout size ifTrue: [ ^ self ].
	content := stdout copyFrom: start to: end.
	stdout := stdout copyFrom: end+1 to: stdout size.
	client nextPutReceivedMessage: content asByteArray.
]

{ #category : #private }
DAPSubprocessComms >> readFromOutput [
	| buf read |

	[ buf := outStream next: 1000.
	read := buf size.
	stdout := stdout, buf.
	buf := errStream next: 1000.
	read := read + buf size.
	stderr := stderr, buf.
	self processStdout.
	readDelay := (read = 0 and: [ readDelay < 1 second ]) ifTrue: 
		[ readDelay + 100 milliSeconds ]
	ifFalse:
		[ 100 milliSeconds ].
	read > 0 ] whileTrue.
]

{ #category : #private }
DAPSubprocessComms >> readFromSubprocess [

	[ subprocess isRunning ] whileTrue:
		[ self readFromOutput.
		readDelay wait. ]
]

{ #category : #accessing }
DAPSubprocessComms >> serverExecutable [
	^ serverExecutable
]

{ #category : #accessing }
DAPSubprocessComms >> serverExecutable: aFileReference [

	serverExecutable := aFileReference asFileReference
]
