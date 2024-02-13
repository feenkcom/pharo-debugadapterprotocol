"
GtPostMortemSessionElement is the UI component that displays a {{gtClass::GtPostMortemSession}}.  See {{gtClass::GtPostMortemSession}} for the intention and use behind it.
"
Class {
	#name : #GtPostMortemSessionElement,
	#superclass : #GtDAPDebuggerElement,
	#instVars : [
		'summary'
	],
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
	registry registerDebugger: self withRank: 900.
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
	self terminateSession

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

	^ debuggerClient ifNil: [ debuggerClient := debuggingSession ifNotNil: [ debuggingSession debuggerClient ] ]
]

{ #category : #'private - accessing' }
GtPostMortemSessionElement >> exception [

	^ self debuggerClient exception
]

{ #category : #testing }
GtPostMortemSessionElement >> isDisplayingTopFrame [ 
	"This is used to determine whether to enable the toolbar buttons,
	but since the post-mortem debugger doesn't have actions, always answer false"

	^ false
]

{ #category : #'instance creation' }
GtPostMortemSessionElement >> newRightTabGroup [

	^ BrTabGroup new 
		aptitude: BrGlamorousTabGroupAptitude + BrShadowAptitude;
		margin: (BlInsets all: self defaultMargin);
		background: Color white;
		addTab: self summaryTab;
		addTab: self stdoutTab;
		addTab: self stderrTab;
		addTab: self variablesTab

]

{ #category : #'private - element creation' }
GtPostMortemSessionElement >> newSummaryView [

	^ BrEditor new
		aptitude: BrGlamorousCodeEditorAptitude new + BrShadowAptitude new;
		background: Color white.
]

{ #category : #private }
GtPostMortemSessionElement >> scheduleUpdateSummary [

	summary ifNotNil:
		[ self enqueueTask: (BlTaskAction new action: [ self updateSummary ]) ].

]

{ #category : #'private - element creation' }
GtPostMortemSessionElement >> summaryTab [

	^ BrTab new 
		aptitude: BrGlamorousTabAptitude;
		label: 'Summary';
		stencil: 
			[ summary ifNil: 
				[ summary := self newSummaryView.
				self scheduleUpdateSummary.
				summary ] ]
]

{ #category : #'private - update ui' }
GtPostMortemSessionElement >> updateCallFrame [

	callFramesList items: self debuggerClient stackFrames.

]

{ #category : #callbacks }
GtPostMortemSessionElement >> updateSummary [

	summary text: self exception summaryText
]

{ #category : #updating }
GtPostMortemSessionElement >> updateUI [

	debuggerState text: 'Post Mortem Inspection' asRopedText.
	self updateDisplay.
	toolbar updateUI.
]

{ #category : #private }
GtPostMortemSessionElement >> updateVariables [
]
