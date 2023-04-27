"
GtDAPDebuggerElement is the main display element of the DAP debugger UI.

While this is a subclass of GtDebuggerElement, it is able to act as the UI for a remote debugger without the Pharo debug session present.  For debuggering a remote server resulting from a pharo exception (breakpoint), use {{gtClass:name=GtDAPDebugSessionElement}}.

Note that while the name includes DAP, for historical reasons, GtDAPDebuggerElement can work with any remote debugger that has the appropriate API, e.g. the CDT debugger.

"
Class {
	#name : #GtDAPDebuggerElement,
	#superclass : #GtDebuggerElement,
	#instVars : [
		'toolbar',
		'variableList',
		'callFramesList',
		'sourceCode',
		'currentCallFrame',
		'currentThread',
		'debuggerState',
		'stdout',
		'stderr',
		'breakpoints',
		'variablesContainer',
		'modules',
		'debuggerClient'
	],
	#category : #'DebugAdapterProtocol-UI'
}

{ #category : #'instance creation' }
GtDAPDebuggerElement class >> openOnDebugger: aDAPDebugger [
	| space |

	space := BlSpace new.
	space root addChild: (self new debuggerClient: aDAPDebugger).
	space show.
]

{ #category : #callbacks }
GtDAPDebuggerElement >> actOnBrowserClosing: ann [
	"If the remote debugger is stopped, resume it, otherwise the remote is effectively locked up"

	"Tell the debugger directly to resume, since we are already closing"
	(debuggerClient isNotNil and: [ debuggerClient isStopped ]) ifTrue: 
		[ currentThread continue ].
	toolbar actOnBrowserClosing: ann.
	super actOnBrowserClosing: ann
]

{ #category : #callbacks }
GtDAPDebuggerElement >> actOnDebugSessionChanged [

	self debuggerClient announcer 
		when: DAPStateChanged 
		send: #scheduleUpdateUI
		to: self.
	self debuggerClient announcer 
		when: DAPStdoutUpdated 
		send: #scheduleUpdateStdout
		to: self.
	self debuggerClient announcer 
		when: DAPStderrUpdated 
		send: #scheduleUpdateStderr
		to: self.
	self debuggerClient announcer 
		when: DAPBreakpointAdded
		send: #scheduleUpdateBreakpoints
		to: self.
	toolbar actOnDebugSessionChanged.
	self scheduleUpdateUI.
	self scheduleUpdateStdout.
	self scheduleUpdateStderr.
	self scheduleUpdateBreakpoints.
	self scheduleUpdateModules.
]

{ #category : #'private - element creation' }
GtDAPDebuggerElement >> breakpointsTab [

	^ BrTab new 
		aptitude: BrGlamorousTabAptitude;
		label: 'Breakpoints';
		stencil: 
			[ breakpoints ifNil: 
				[ breakpoints := self newBreakpointsList.
				self scheduleUpdateBreakpoints.
				breakpoints ] ]
]

{ #category : #'private - element creation' }
GtDAPDebuggerElement >> buildVariablesHeader [
	| header |

	header := BlElement new
		layout: (BlLinearLayout horizontal alignCenterLeft cellSpacing: self cellSpacing);
		padding: (BlInsets top: 5 bottom: 5);
		labeled: 'Columned Header';
		background: Color white;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ].
	#(Name Value) do: [ :label |
		header addChild: (BrLabel new
			aptitude: BrGlamorousLabelAptitude;
			alignCenterLeft;
			text: (label asRopedText foreground: BrGlamorousColors defaultButtonTextColor)) ].
	header children first padding: (BlInsets left: 20).
	^ header
]

{ #category : #'private - element creation' }
GtDAPDebuggerElement >> buildVariablesTree [
	| tree |

	tree := BrColumnedTree new
		rowStencil: (BrGlamorousColumnedTreeSelectableRowElementStencilBuilder new cellSpacing: self cellSpacing);
		margin: (BlInsets top: 10);
		background: Color white;
		addEventHandler: (GtPhlowListToSelectHandler new 
			transformation: [ :variableNode | variableNode value value ]).

	tree column 
		title: 'Variable';
		cellStencil: [ 
			BrLabel new
				aptitude: (BrGlamorousLabelAptitude new foreground: Color black);
				hMatchParent;
				vFitContent;
				margin: (BlInsets top: 3 left: 10 bottom: 3 right: 0) ];
		dataBinder: [ :aCellElement :anAssociation |
			aCellElement text: anAssociation key asRopedText ].
	tree column
		title: 'Value';
		cellStencil: [
			BrLabel new
				aptitude: BrGlamorousLabelAptitude new;
				hMatchParent;
				vFitContent;
				margin: (BlInsets top: 3 left: 10 bottom: 3 right: 0) ];
		dataBinder: [ :aCellElement :anAssociation |
			aCellElement text: anAssociation value asString asRopedText ].
	^ tree
]

{ #category : #'private - accessing' }
GtDAPDebuggerElement >> cellSpacing [ 

	^ 10
]

{ #category : #'private - accessing' }
GtDAPDebuggerElement >> columnNumber [ 

	^ currentCallFrame columnNumber
]

{ #category : #'private - actions' }
GtDAPDebuggerElement >> dapResume [
	"Continue execution"

	currentThread continue.

]

{ #category : #'private - actions' }
GtDAPDebuggerElement >> dapStepInto [

	currentThread stepInto.
]

{ #category : #'private - actions' }
GtDAPDebuggerElement >> dapStepOut [

	currentThread stepOut.
]

{ #category : #'private - actions' }
GtDAPDebuggerElement >> dapStepOver [

	currentThread stepOver.

]

{ #category : #'private - accessing' }
GtDAPDebuggerElement >> debuggerClient [
	"Answer the debugger"

	^ debuggerClient
]

{ #category : #accessing }
GtDAPDebuggerElement >> debuggerClient: aDAPDebugger [

	debuggerClient := aDAPDebugger.
	self actOnDebugSessionChanged.
]

{ #category : #'private - accessing' }
GtDAPDebuggerElement >> defaultMargin [ 

	^ 5
]

{ #category : #'private - update ui' }
GtDAPDebuggerElement >> displayStackFrame: aDAPStackFrame [
	"Set the supplied frame as the current frame and update the rest of the UI"

	currentCallFrame := aDAPStackFrame.
	toolbar updateUI.
	self updateDisplay.
]

{ #category : #initialization }
GtDAPDebuggerElement >> initialize [
	| container mainPane leftPane rightTabGroup rightPane cfContainer sourceContainer |

	super initialize.
	self 
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal matchParent ].
	container := BrVerticalPane new matchParent.
	mainPane := BrHorizontalPane new matchParent.
	leftPane := BrVerticalPane new
		matchParent;
		constraintsDo: [ :c |
			c linear weight: 1.0 ].
	callFramesList := self newCallFramesList.
	cfContainer := BlElement new 
		aptitude: BrShadowAptitude;
		margin: (BlInsets all: self defaultMargin);
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal matchParent.
			c linear weight: 0.3 ];
		addChild: callFramesList.
	sourceCode := self newSourceEditor.
	sourceContainer := BlElement new.
	sourceContainer
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.
			c linear weight: 1.0 ];
		addChild: sourceCode.
	leftPane
		addChild: cfContainer;
		addChild: sourceContainer.
	rightPane := BrVerticalPane new
		matchParent;
		constraintsDo: [ :c |
			c linear weight: 0.7 ].
	rightTabGroup := self newRightTabGroup.
	debuggerState := self newDebuggerState.
	toolbar := self newToolbar.
	rightPane
		addChild: debuggerState;
		addChild: rightTabGroup.
	mainPane
		addChild: leftPane;
		addChild: rightPane.
	container 
		addChild: toolbar;
		addChild: mainPane.
	self addChild: container.
	self addChild: (BlElement new
				constraintsDo: [ :c | 
					c ignoreByLayout.
					c horizontal matchParent.
					c vertical exact: 5 ];
				background: BrGlamorousColors errorBackgroundColor;
				yourself).

]

{ #category : #testing }
GtDAPDebuggerElement >> isDisplayingTopFrame [
	"Answer a boolean indicating whether the top call frame is being displayed.
	DAP debuggers only allow stepping and continuing from the top frame."

	^ debuggerClient isStopped and: [ currentCallFrame == debuggerClient stoppedThread stackFrames first ]
]

{ #category : #'private - accessing' }
GtDAPDebuggerElement >> lineNumber [ 

	^ currentCallFrame
		ifNil: [ 1 ]
		ifNotNil: [ currentCallFrame line ifNil: [ 1 ] ]
]

{ #category : #'private - element creation' }
GtDAPDebuggerElement >> modulesTab [

	^ BrTab new 
		aptitude: BrGlamorousTabAptitude;
		label: 'Modules';
		stencil: 
			[ modules ifNil: 
				[ modules := self newModulesList.
				self scheduleUpdateModules.
				modules ] ]
]

{ #category : #'instance creation' }
GtDAPDebuggerElement >> newBreakpointsList [
	| list |

	list := BrColumnedList new
		margin: (BlInsets top: 10);
		background: Color white;
		rowStencil: (BrGlamorousColumnedListSelectableRowElementStencilBuilder new);
		addEventHandler: (GtPhlowListToSelectHandler new 
			transformation: [ :aDAPBreakpoint | aDAPBreakpoint ]);
		yourself.

	list column 
		title: 'Id';
		cellStencil: [ 
			BrLabel new
				aptitude: (BrGlamorousLabelAptitude new foreground: Color black);
				hExact: 30;
				vFitContent;
				margin: (BlInsets top: 3 left: 10 bottom: 3 right: 0) ];
		dataBinder: [ :aCellElement :aDAPBreakpoint |
			aCellElement text: aDAPBreakpoint id asString asRopedText ].
	list column 
		title: 'Breakpoint';
		cellStencil: [ 
			BrLabel new
				aptitude: (BrGlamorousLabelAptitude new foreground: Color black);
				hMatchParent;
				vFitContent;
				margin: (BlInsets top: 3 left: 10 bottom: 3 right: 0) ];
		dataBinder: [ :aCellElement :aDAPBreakpoint |
			aCellElement text: aDAPBreakpoint asString asRopedText ].

	^ list
]

{ #category : #'instance creation' }
GtDAPDebuggerElement >> newCallFramesList [
	| list |

	list := BrColumnedList new
		margin: (BlInsets top: 10);
		background: Color white;
		rowStencil: (BrGlamorousColumnedListSelectableRowElementStencilBuilder new);
		addEventHandler: (GtPhlowListToSelectHandler new 
			transformation: [ :aDAPStackFrame | self displayStackFrame: aDAPStackFrame. aDAPStackFrame ]);
		yourself.

	list column 
		title: 'Depth';
		cellStencil: [ 
			BrLabel new
				aptitude: (BrGlamorousLabelAptitude new foreground: Color black);
				hExact: 30;
				vFitContent;
				margin: (BlInsets top: 3 left: 10 bottom: 3 right: 0) ];
		dataBinder: [ :aCellElement :aCDTCallFrame |
			aCellElement text: aCDTCallFrame ordinal asString asRopedText ].
	list column
		title: 'Frame';
		cellStencil: [
			BrLabel new
				aptitude: BrGlamorousLabelAptitude new;
				hMatchParent;
				vFitContent;
				margin: (BlInsets top: 3 left: 10 bottom: 3 right: 0) ];
		dataBinder: [ :aCellElement :aCDTCallFrame |
			aCellElement text: aCDTCallFrame printString asRopedText ].

	^ list
]

{ #category : #'instance creation' }
GtDAPDebuggerElement >> newDebuggerState [

	^ BrEditor new
		aptitude: BrGlamorousEditorAptitude + BrShadowAptitude;
		margin: (BlInsets all: self defaultMargin);
		background: Color white;
		hMatchParent;
		vFitContent;
		beMode: BrTextEditorReadonlyWithoutSelectionMode new.

]

{ #category : #'instance creation' }
GtDAPDebuggerElement >> newModulesList [
	| list |

	list := BrColumnedList new
		margin: (BlInsets top: 10);
		background: Color white;
		rowStencil: (BrGlamorousColumnedListSelectableRowElementStencilBuilder new);
		addEventHandler: (GtPhlowListToSelectHandler new 
			transformation: [ :aDAPBreakpoint | aDAPBreakpoint ]);
		yourself.

	list column 
		title: 'Name';
		cellStencil: [ 
			BrLabel new
				aptitude: (BrGlamorousLabelAptitude new foreground: Color black);
				hExact: 100;
				vFitContent;
				margin: (BlInsets top: 3 left: 10 bottom: 3 right: 0) ];
		dataBinder: [ :aCellElement :aDAPModule |
			aCellElement text: aDAPModule name asString asRopedText ].
	list column 
		title: 'Path';
		cellStencil: [ 
			BrLabel new
				aptitude: (BrGlamorousLabelAptitude new foreground: Color black);
				hMatchParent;
				vFitContent;
				margin: (BlInsets top: 3 left: 10 bottom: 3 right: 0) ];
		dataBinder: [ :aCellElement :aDAPModule |
			aCellElement text: aDAPModule path asString asRopedText ].

	^ list
]

{ #category : #'instance creation' }
GtDAPDebuggerElement >> newRightTabGroup [

	^ BrTabGroup new 
		aptitude: BrGlamorousTabGroupAptitude + BrShadowAptitude;
		margin: (BlInsets all: self defaultMargin);
		background: Color white;
		addTab: self variablesTab;
		addTab: self breakpointsTab;
		addTab: self stdoutTab;
		addTab: self stderrTab;
		addTab: self modulesTab.
]

{ #category : #'private - element creation' }
GtDAPDebuggerElement >> newSourceEditor [

	^ BrEditor new
		aptitude: BrGlamorousCodeEditorAptitude new + BrShadowAptitude new;
		margin: (BlInsets all: self defaultMargin);
		background: Color white.
]

{ #category : #'private - element creation' }
GtDAPDebuggerElement >> newStderrView [

	^ BrEditor new
		aptitude: BrGlamorousCodeEditorAptitude new + BrShadowAptitude new;
		background: Color white.
]

{ #category : #'private - element creation' }
GtDAPDebuggerElement >> newStdoutView [

	^ BrEditor new
		aptitude: BrGlamorousCodeEditorAptitude new + BrShadowAptitude new;
		background: Color white.
]

{ #category : #'private - element creation' }
GtDAPDebuggerElement >> newToolbar [ 

	^ GtDAPDebuggerToolbar new 
		dapDebugElement: self;
		hMatchParent;
		vFitContent;
		background: BrGlamorousColors defaultHeaderBackgroundColor;
		padding: (BlInsets top: 10 left: 0 bottom: 5 right: 10);
		alignCenterRight;
		yourself
]

{ #category : #'instance creation' }
GtDAPDebuggerElement >> newVariablesList [
	| container header tree |

	container := BlElement new
		aptitude: BrShadowAptitude;
		background: Color white;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		layout: BlLinearLayout vertical.
	header := self buildVariablesHeader.
	tree := self buildVariablesTree.
	container 
		addChild: header;
		addChild: tree as: #variablesList.
	^ container
]

{ #category : #private }
GtDAPDebuggerElement >> scheduleUpdateBreakpoints [

	breakpoints ifNotNil:
		[ self enqueueTask: (BlTaskAction new action: [ self updateBreakpoints ]) ].

]

{ #category : #private }
GtDAPDebuggerElement >> scheduleUpdateModules [

	modules ifNotNil:
		[ self enqueueTask: (BlTaskAction new action: [ self updateModules ]) ].

]

{ #category : #private }
GtDAPDebuggerElement >> scheduleUpdateStderr [

	stderr ifNotNil:
		[ self enqueueTask: (BlTaskAction new action: [ self updateStderr ]) ].

]

{ #category : #private }
GtDAPDebuggerElement >> scheduleUpdateStdout [

	stdout ifNotNil:
		[ self enqueueTask: (BlTaskAction new action: [ self updateStdout ]) ].

]

{ #category : #private }
GtDAPDebuggerElement >> scheduleUpdateUI [

	self enqueueTask: (BlTaskAction new action: [ self updateUI ]).

]

{ #category : #'private - accessing' }
GtDAPDebuggerElement >> sourceCode [

	^ currentCallFrame sourceCode
]

{ #category : #'private - accessing' }
GtDAPDebuggerElement >> sourceText [ 
	"Answer the receiver's source code, with the current line highlighted"

	^ currentCallFrame
		ifNil: [ '' ]
		ifNotNil: [ currentCallFrame sourceText ]
]

{ #category : #'private - element creation' }
GtDAPDebuggerElement >> stderrTab [

	^ BrTab new 
		aptitude: BrGlamorousTabAptitude;
		label: 'stderr';
		stencil: 
			[ stderr ifNil: 
				[ stderr := self newStderrView.
				self scheduleUpdateStderr.
				stderr ] ]
]

{ #category : #'private - element creation' }
GtDAPDebuggerElement >> stdoutTab [

	^ BrTab new 
		aptitude: BrGlamorousTabAptitude;
		label: 'stdout';
		stencil: 
			[ stdout ifNil: 
				[ stdout := self newStdoutView.
				self scheduleUpdateStdout.
				stdout ] ]
]

{ #category : #actions }
GtDAPDebuggerElement >> terminateSession [

	super terminateSession.
	debuggerClient ifNotNil: 
		[ debuggerClient announcer unsubscribe: self ]
]

{ #category : #'private - update ui' }
GtDAPDebuggerElement >> updateBreakpoints [

	breakpoints ifNotNil:
		[ breakpoints items: (self debuggerClient breakpoints values sorted: [ :a :b | a id < b id ]) ]

]

{ #category : #'private - update ui' }
GtDAPDebuggerElement >> updateCallFrame [

	callFramesList items: currentThread stackFrames.

]

{ #category : #'private - update ui' }
GtDAPDebuggerElement >> updateDisplay [ 

	self updateCallFrame.
	self updateVariables.
	self updateSource.

]

{ #category : #'private - update ui' }
GtDAPDebuggerElement >> updateModules [

	modules ifNotNil:
		[ modules items: (self debuggerClient modules values sorted: [ :a :b | a name < b name ]) ]

]

{ #category : #'private - update ui' }
GtDAPDebuggerElement >> updateSource [ 

	sourceCode text: self sourceText.
	self lineNumber > 5 ifTrue:
		[ StringSignal emit: 'Scrolling to line: ', self lineNumber asString.
		sourceCode scrollToPosition: self lineNumber + 5 ].

]

{ #category : #callbacks }
GtDAPDebuggerElement >> updateStderr [

	stderr text: self debuggerClient stderr asRopedText
]

{ #category : #callbacks }
GtDAPDebuggerElement >> updateStdout [

	stdout text: self debuggerClient stdout asRopedText
]

{ #category : #callbacks }
GtDAPDebuggerElement >> updateUI [
	"Update the UI to reflect the debugger state."

	StringSignal emit: 'updateUI'.
	debuggerState text: self debuggerClient statusString asRopedText.
	"Always display the stopped threads.
	Currently we only support the threading module, which has green threads, like Pharo.
	This means that if one thread is stopped, none of the others are actually processing."
	currentThread := self debuggerClient stoppedThread.
	currentThread ifNil: [ 
		toolbar updateUI.
		^ self ].

	currentCallFrame := currentThread stackFrames 
		ifEmpty: [ nil ]
		ifNotEmpty: [ :frames | frames first ].

	self updateDisplay.
	callFramesList selectOne: 1.
	toolbar updateUI.

]

{ #category : #'private - update ui' }
GtDAPDebuggerElement >> updateVariables [ 

	variableList 
		items: (currentCallFrame
			ifNil: [ #() ]
			ifNotNil: [ currentCallFrame variablesDictionary associations ])
		immediate: [ :item | 
			item value isDictionary
				ifTrue: [ item value associations ]
				ifFalse: [ (item value isArray and: [ item value allSatisfy: #isDictionary ])
						ifTrue: [ item value collectWithIndex: [ :x :i | i -> x ] ]
						ifFalse: [ #() ] ] ].
	variableList expandAll.

]

{ #category : #'private - element creation' }
GtDAPDebuggerElement >> variablesTab [

	^ BrTab new 
		aptitude: BrGlamorousTabAptitude;
		label: 'Variables';
		stencil: 
			[ variablesContainer ifNil: 
				[ variablesContainer := self newVariablesList.
				variableList := variablesContainer childNamed: #variablesList.
				variablesContainer ] ]
]
