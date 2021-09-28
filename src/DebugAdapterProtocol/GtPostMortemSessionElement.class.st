"
GtPostMortemSessionElement is the UI component that displays a {{gtClass::GtPostMortemSession}}.  See {{gtClass::GtPostMortemSession}} for the intention and use behind it.
"
Class {
	#name : #GtPostMortemSessionElement,
	#superclass : #GtDAPDebuggerElement,
	#category : #'DebugAdapterProtocol-UI'
}

{ #category : #testing }
GtPostMortemSessionElement class >> availableAutomatically [
	"The DAP debugger should be displayed automatically when opened
	as the Pharo stack only shows that the server paused signal has been received."
	
	^ true
]

{ #category : #initialization }
GtPostMortemSessionElement class >> defaultTitle [ 

	^ 'Post Mortem Inspector'
]

{ #category : #testing }
GtPostMortemSessionElement class >> handlesContext: aContext [ 
	"This is currently determined by checking the class of the receiver and its value, which will be different for each snippet type.  This should be changed to the signalling method having the appropriate pragma (<dapOpenDebugger>)"
	| result |

	result := (aContext method hasPragmaNamed: #remoteDebuggerSignal) and:
		[ (aContext receiver exception respondsTo: #debuggerClient) and:
		[ aContext receiver exception isPaused not ] ].
	^ result
]

{ #category : #'tools registry' }
GtPostMortemSessionElement class >> registerToolsOn: registry [
	"self register"
	registry registerDebugger: self withRank: 1100.
]

{ #category : #accessing }
GtPostMortemSessionElement class >> sessionClass [

	^ GtPostMortemSession 
]

{ #category : #callbacks }
GtPostMortemSessionElement >> actOnBrowserClosing: ann [
	"If the remote debugger is stopped, resume it, otherwise the remote is effectively locked up"

	"Tell the debugger directly to resume, since we are already closing"
	toolbar actOnBrowserClosing: ann.

]

{ #category : #callbacks }
GtPostMortemSessionElement >> actOnDebugSessionChanged [

	currentCallFrame := self debuggerClient stackFrames first.
	sourceCode styler: self debuggerClient sourceStyler.
	self scheduleUpdateUI.
]

{ #category : #'private - actions' }
GtPostMortemSessionElement >> dapResume [
	"Continue execution"

	self error: 'Not Supported'.
]

{ #category : #'private - accessing' }
GtPostMortemSessionElement >> debuggerClient [ 

	^ dapDebugger ifNil: [ dapDebugger := debuggingSession ifNotNil: [ debuggingSession debuggerClient ] ]
]

{ #category : #testing }
GtPostMortemSessionElement >> isDisplayingTopFrame [ 
	"This is used to determine whether to enable the toolbar buttons,
	but since the post-mortem debugger doesn't have actions, always answer false"

	^ false
]

{ #category : #'private - update ui' }
GtPostMortemSessionElement >> updateCallFrame [

	callFramesList items: self debuggerClient stackFrames.

]

{ #category : #updating }
GtPostMortemSessionElement >> updateUI [

	debuggerState text: 'Post Mortem Inspection' asRopedText.
	self updateDisplay.
]

{ #category : #private }
GtPostMortemSessionElement >> updateVariables [
]
