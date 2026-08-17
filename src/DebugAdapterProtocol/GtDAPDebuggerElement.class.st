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
	"The variables of the stopped frame.

	Names are asked for rather than printed: a debugger that compiled the
	program knows what a variable was called before the compiler wrote it as
	C, and a reader has no use for the written form."

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
			aCellElement text: (self variableName: anAssociation key) asRopedText ].
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

{ #category : #'callbacks' }
GtDAPDebuggerElement >> dapStepInto [
	"Step in. A debugger that knows what its program was compiled from is
	asked to do it, because a step through generated code should not stop in
	generated code; anything else steps as the protocol does."

	(debuggerClient respondsTo: #stepIntoFor:)
		ifTrue: [ [ debuggerClient stepIntoFor: currentThread ] forkNamed: 'dap-step' ]
		ifFalse: [ currentThread stepInto ]
]

{ #category : #'callbacks' }
GtDAPDebuggerElement >> dapStepOut [
	"Step out, through generated code when the debugger knows how."

	(debuggerClient respondsTo: #stepOutFor:)
		ifTrue: [ [ debuggerClient stepOutFor: currentThread ] forkNamed: 'dap-step' ]
		ifFalse: [ currentThread stepOut ]
]

{ #category : #'callbacks' }
GtDAPDebuggerElement >> dapStepOver [
	"Step over, through generated code when the debugger knows how."

	(debuggerClient respondsTo: #stepOverFor:)
		ifTrue: [ [ debuggerClient stepOverFor: currentThread ] forkNamed: 'dap-step' ]
		ifFalse: [ currentThread stepOver ]
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

	^ debuggerClient isStopped
		and: [ currentCallFrame
				== (debuggerClient stoppedThread ifNotNil: [ :thread | thread stackFrames first ]) ]
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

{ #category : #'private - element creation' }
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
		dataBinder: [ :aCellElement :aFrame |
			aCellElement text: aFrame ordinal asString asRopedText ].
	list column
		title: 'Frame';
		cellStencil: [
			BrLabel new
				aptitude: BrGlamorousLabelAptitude new;
				hMatchParent;
				vFitContent;
				margin: (BlInsets top: 3 left: 10 bottom: 3 right: 0) ];
		"A frame says what it is in its name; the path belongs in the column
		that is about where it is. Printing the path here left every row
		showing the same directory prefix and nothing about the frame."
		dataBinder: [ :aCellElement :aFrame |
			aCellElement text: (self frameName: aFrame) asRopedText ].
	list column
		title: 'Source';
		cellStencil: [
			BrLabel new
				aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
				hFitContent;
				vFitContent;
				margin: (BlInsets top: 3 left: 10 bottom: 3 right: 10) ];
		dataBinder: [ :aCellElement :aFrame |
			aCellElement text: (aFrame source
				ifNil: [ '' ]
				ifNotNil: [ :aSource | (aSource name ifNil: [ '' ]), ':', aFrame line asString ]) asRopedText ].

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
	"The source of the frame, and the one place a breakpoint can be pointed
	at: the same shortcut that sets one in a coder sets one here."

	^ BrEditor new
		aptitude: BrGlamorousCodeEditorAptitude new + BrShadowAptitude new;
		margin: (BlInsets all: self defaultMargin);
		background: Color white;
		addShortcut: (BlShortcutWithAction new
			combination: BlKeyCombination primaryY;
			action: [ :anEvent | self toggleBreakpointAtCursor ])
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

{ #category : #private }
GtDAPDebuggerElement >> scheduleUpdateVariables [

	variableList ifNotNil:
		[ self enqueueTask: (BlTaskAction new action: [ self updateVariables ]) ].

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
	"Show the current frame's source, styled by whoever knows the language.

	The element debugs whatever the adapter debugs, so it cannot style the
	text itself; a debugger that knows its language answers styled text. The
	highlight is added first and marked not-overwritable, so styling on top of
	it keeps it, and the breakpoints are marked after styling for the same
	reason."

	| text |
	text := self sourceText.
	(debuggerClient respondsTo: #styleSourceText:)
		ifTrue: [ text := debuggerClient styleSourceText: text ].
	self markBreakpointsIn: text.
	sourceCode text: text.
	self lineNumber > 5 ifTrue: [
		StringSignal emit: 'Scrolling to line: ', self lineNumber asString.
		sourceCode scrollToPosition: self lineNumber + 5 ]
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

{ #category : #'callbacks' }
GtDAPDebuggerElement >> updateVariables [
	"A variable may hold more variables. The adapter says so with a non-zero
	reference, and answers them when asked; a value that is a dictionary or an
	array of them is expanded directly, as before, for adapters that inline
	their structure instead.

	Only the scopes are opened, and locals open first: sorting the scopes by
	name puts Globals ahead of Locals, which buries the handful of values the
	frame is actually about under every global the program has.

	Bookkeeping the compiler introduced is left out. It is named for what it
	does — lifting a reference, hoisting a value — and belongs to a program
	nobody wrote."

	variableList ifNil: [ ^ self ].
	variableList
		items: (currentCallFrame
			ifNil: [ #() ]
			ifNotNil: [ (currentCallFrame variablesDictionary associations
				collect: [ :each | each key -> (self withoutBookkeeping: each value) ])
					sorted: [ :a :b | (self scopeRank: a key) <= (self scopeRank: b key) ] ])
		immediate: [ :item | self childrenOfVariableNode: item value ].
	variableList expandUpTo: 1
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
				self scheduleUpdateVariables.
				variablesContainer ] ]
]

{ #category : #'actions' }
GtDAPDebuggerElement >> dapStepBack [
	"Walk the recording the other way, for adapters that report
	supportsStepBack. The toolbar has always had the button; the method it
	calls was missing."

	currentThread stepBack.
]

{ #category : #'private - updating' }
GtDAPDebuggerElement >> childrenOfVariableNode: aValue [
	"What sits under one row of the variables tree."

	aValue isDictionary ifTrue: [
		^ aValue associations sorted: [ :v | v key asLowercase ] ascending ].
	(aValue isKindOf: DAPVariable) ifTrue: [
		^ aValue children collect: [ :each | each name -> each ] ].
	(aValue isArray and: [ aValue allSatisfy: #isDictionary ]) ifTrue: [
		^ (aValue collectWithIndex: [ :x :i | i -> x ]) sorted: [ :v | v key asLowercase ] ascending ].
	^ #()
]

{ #category : #'private - accessing' }
GtDAPDebuggerElement >> cursorLine [
	"Which line of the displayed source the cursor is on, or the first line
	when the editor has no cursor because it was never clicked in.

	The editor answers its cursors as a cursor object rather than as a
	collection, so the positions are asked for by name, and the line is the
	one the string itself counts: the text is shown with this image's line
	endings, which a hand-rolled count of newlines gets wrong."
	| positions |

	positions := sourceCode editor cursors positions.
	positions isEmpty ifTrue: [ ^ 1 ].
	^ sourceCode text asString lineNumberCorrespondingToIndex: positions first
]

{ #category : #'callbacks' }
GtDAPDebuggerElement >> toggleBreakpointAtCursor [
	"Stop at the form the cursor is in, or stop doing so. A breakpoint belongs
	to a source rather than to a frame, so it is the frame's file that is
	asked, not the frame."

	currentCallFrame ifNil: [ ^ self ].
	currentCallFrame source ifNil: [ ^ self ].
	(debuggerClient respondsTo: #toggleBreakpointInSource:line:column:) ifFalse: [ ^ self ].
	debuggerClient
		toggleBreakpointInSource: currentCallFrame source
		line: self cursorLine
		column: self cursorColumn.
	self scheduleUpdateBreakpoints.
	self enqueueTask: (BlTaskAction new action: [ self updateSource ])
]

{ #category : #'private - update ui' }
GtDAPDebuggerElement >> markBreakpointsIn: aText [
	"Show where the debugger has been told to stop. A breakpoint stands on a
	form rather than on a line, so it is marked where the form starts rather
	than in a margin beside it."
	| string |

	(debuggerClient respondsTo: #breakpointsInSource:) ifFalse: [ ^ aText ].
	currentCallFrame ifNil: [ ^ aText ].
	currentCallFrame source ifNil: [ ^ aText ].
	string := aText asString.
	(debuggerClient breakpointsInSource: currentCallFrame source path) do: [ :each |
		| indexes index |
		each line ifNotNil: [
			indexes := string gtIndexOfLineNumber: each line.
			indexes ifNotNil: [
				index := indexes key + (each column ifNil: [ 1 ]) - 1.
				index := (index max: 2) min: string size.
				(aText from: index - 1 to: index - 1)
					attribute: ((BrTextAdornmentDynamicAttribute new beAppend)
						beNotOverwritableByStyler;
						stencil: [ self newBreakpointMarkerFor: each ]) ] ] ].
	^ aText
]

{ #category : #'private - element creation' }
GtDAPDebuggerElement >> newBreakpointMarkerFor: aDAPBreakpoint [
	"The mark beside a breakpointed form. Clicking it takes the breakpoint
	away, which is the only thing there is to do with one."

	^ BlElement new
		size: 8 @ 8;
		margin: (BlInsets right: 2);
		geometry: BlCircleGeometry new;
		background: (aDAPBreakpoint verified = false
			ifTrue: [ BrGlamorousColors disabledButtonTextColor ]
			ifFalse: [ BrGlamorousColors errorBackgroundColor ]);
		addEventHandlerOn: BlClickEvent
			do: [ :anEvent |
				anEvent consumed: true.
				self toggleBreakpointAt: aDAPBreakpoint ]
]

{ #category : #'callbacks' }
GtDAPDebuggerElement >> toggleBreakpointAt: aDAPBreakpoint [
	"Take away a breakpoint that is already shown."

	aDAPBreakpoint source ifNil: [ ^ self ].
	debuggerClient
		toggleBreakpointInSource: aDAPBreakpoint source
		line: aDAPBreakpoint line.
	self scheduleUpdateBreakpoints.
	self enqueueTask: (BlTaskAction new action: [ self updateSource ])
]

{ #category : #'private - accessing' }
GtDAPDebuggerElement >> cursorColumn [
	"Which column of the displayed source the cursor is on, counting from one.
	The protocol talks in lines and columns; the editor counts characters, and
	a cursor position is an index into the text the way GT's own coder treats
	it."
	| positions position string |

	positions := sourceCode editor cursors positions.
	positions isEmpty ifTrue: [ ^ 1 ].
	position := positions first.
	string := sourceCode text asString.
	^ position
		- (string gtIndexOfLineNumber: (string lineNumberCorrespondingToIndex: position)) key
		+ 1
]

{ #category : #'private - accessing' }
GtDAPDebuggerElement >> frameName: aFrame [
	"What a frame is called. A debugger that compiled the program knows what
	its symbols were before the compiler wrote them, and says so; anything
	else keeps the name the adapter reported."

	(debuggerClient respondsTo: #displayNameForFrame:)
		ifTrue: [ ^ debuggerClient displayNameForFrame: aFrame ].
	^ aFrame name ifNil: [ aFrame printString ]
]

{ #category : #'private - accessing' }
GtDAPDebuggerElement >> scopeRank: aScopeName [
	"Scopes in the order a reader wants them: what this frame binds, then what
	the program holds, then the machine. Ordering is by a key rather than by a
	set of names so an adapter with scopes of its own still sorts."

	| name |
	name := aScopeName asLowercase.
	(name includesSubstring: 'local') ifTrue: [ ^ '0' , name ].
	(name includesSubstring: 'argument') ifTrue: [ ^ '1' , name ].
	(name includesSubstring: 'register') ifTrue: [ ^ '8' , name ].
	^ '5' , name
]

{ #category : #'private - accessing' }
GtDAPDebuggerElement >> withoutBookkeeping: aScope [
	"The variables of one scope, without the ones the compiler made up."

	^ [ aScope isDictionary
		ifTrue: [ | kept |
			kept := aScope class new.
			aScope keysAndValuesDo: [ :name :value |
				(self hidesVariable: name) ifFalse: [ kept at: name put: value ] ].
			kept ]
		ifFalse: [ aScope ] ]
		on: Error
		do: [ :e | aScope ]
]

{ #category : #'private - accessing' }
GtDAPDebuggerElement >> variableName: aName [
	"What to call a variable. A debugger that compiled the program knows what
	its names were before the compiler wrote them."

	^ (debuggerClient respondsTo: #displayNameForVariable:)
		ifTrue: [ debuggerClient displayNameForVariable: aName ]
		ifFalse: [ aName ]
]

{ #category : #'private - accessing' }
GtDAPDebuggerElement >> hidesVariable: aName [
	"Whether a variable is the compiler's own bookkeeping. A debugger that
	knows says so; anything else shows everything it is given."

	^ (debuggerClient respondsTo: #hidesVariable:)
		and: [ debuggerClient hidesVariable: aName ]
]
