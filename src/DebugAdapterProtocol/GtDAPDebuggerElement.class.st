Class {
	#name : #GtDAPDebuggerElement,
	#superclass : #GtDebuggerElement,
	#instVars : [
		'dapDebugger',
		'variableList',
		'callFramesList',
		'sourceCode',
		'currentCallFrame',
		'currentThread',
		'debuggerState'
	],
	#category : #'DebugAdapterProtocol-UI'
}

{ #category : #'instance creation' }
GtDAPDebuggerElement class >> openOnDebugger: aDAPDebugger [
	| space |

	space := BlSpace new.
	space root addChild: (self new dapDebugger: aDAPDebugger).
	space show.
]

{ #category : #callbacks }
GtDAPDebuggerElement >> actOnDebugSessionChanged [

	self dapDebugger announcer 
		when: DAPStateChanged 
		send: #scheduleUpdateUI
		to: self.
	self scheduleUpdateUI.
]

{ #category : #'private - element creation' }
GtDAPDebuggerElement >> buildVariablesHeader [
	| header |

	header := BlElement new
		layout: (BlLinearLayout horizontal alignCenterLeft cellSpacing: self cellSpacing);
		padding: (BlInsets top: 5 bottom: 5);
		labeled: 'Columned Header';
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ].
	#(Name Value) do: [ :label |
		header addChild: (BrLabel new
			look: BrGlamorousLabelLook;
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
		addEventHandler: (GtPhlowListToSelectHandler new 
			transformation: [ :variableNode | variableNode value value ]).

	tree column 
		title: 'Variable';
		cellStencil: [ 
			BrLabel new
				look: (BrGlamorousLabelLook new foreground: Color black);
				hMatchParent;
				vFitContent;
				margin: (BlInsets top: 3 left: 10 bottom: 3 right: 0) ];
		dataBinder: [ :aCellElement :anAssociation |
			aCellElement text: anAssociation key asRopedText ].
	tree column
		title: 'Value';
		cellStencil: [
			BrLabel new
				look: BrGlamorousLabelLook new;
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

{ #category : #'private - accessing' }
GtDAPDebuggerElement >> dapDebugger [
	"Answer the debugger"

	^ dapDebugger
]

{ #category : #accessing }
GtDAPDebuggerElement >> dapDebugger: aDAPDebugger [

	dapDebugger := aDAPDebugger.
	self actOnDebugSessionChanged.
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

{ #category : #initialization }
GtDAPDebuggerElement >> initialize [
	| container mainPane leftPane rightPane variablesContainer |

	super initialize.
	self constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent ].
	container := BrVerticalPane new matchParent.
	mainPane := BrHorizontalPane new.
	leftPane := BrVerticalPane new.
	callFramesList := self newCallFramesList.
	sourceCode := self newSourceEditor.
	leftPane
		addChild: callFramesList;
		addChild: sourceCode.
	rightPane := BrVerticalPane new.
	variablesContainer := self newVariablesList.
	variableList := variablesContainer childNamed: #variablesList.
	debuggerState := self newDebuggerState.
	rightPane
		addChild: debuggerState;
		addChild: variablesContainer.
	mainPane
		addChild: leftPane;
		addChild: rightPane.
	container 
		addChild: self newToolbar;
		addChild: mainPane.
	self addChild: container.
]

{ #category : #'private - accessing' }
GtDAPDebuggerElement >> lineNumber [ 

	^ currentCallFrame
		ifNil: [ 1 ]
		ifNotNil: [ currentCallFrame line ]
]

{ #category : #'instance creation' }
GtDAPDebuggerElement >> newCallFramesList [
	| list |

	list := BrColumnedList new.
	list margin: (BlInsets top: 10).
	list addEventHandler: (GtPhlowListToSelectHandler new 
		transformation: [ :variableNode | variableNode value ]).
	list rowStencil: (BrGlamorousColumnedListSelectableRowElementStencilBuilder new).

	list column 
		title: 'Depth';
		cellStencil: [ 
			BrLabel new
				look: (BrGlamorousLabelLook new foreground: Color black);
				hExact: 30;
				vFitContent;
				margin: (BlInsets top: 3 left: 10 bottom: 3 right: 0) ];
		dataBinder: [ :aCellElement :aCDTCallFrame |
			aCellElement text: aCDTCallFrame ordinal asString asRopedText ].
	list column
		title: 'Frame';
		cellStencil: [
			BrLabel new
				look: BrGlamorousLabelLook new;
				hMatchParent;
				vFitContent;
				margin: (BlInsets top: 3 left: 10 bottom: 3 right: 0) ];
		dataBinder: [ :aCellElement :aCDTCallFrame |
			aCellElement text: aCDTCallFrame printString asRopedText ].

	^ list
]

{ #category : #'instance creation' }
GtDAPDebuggerElement >> newDebuggerState [

	^ BrLabel new
		look: BrGlamorousLabelLook;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ].

]

{ #category : #'private - element creation' }
GtDAPDebuggerElement >> newInspectButton [

	^ BrButton new 
		look: BrGlamorousButtonWithLabelLook;
		margin: (BlInsets left: 5);
		label: 'Inspect Me';
		action: [ :aButton | self inspect ]
]

{ #category : #'private - element creation' }
GtDAPDebuggerElement >> newResumeButton [

	^ BrButton new 
		look: BrGlamorousButtonWithIconLook;
		margin: (BlInsets left: 5);
		icon: BrGlamorousVectorIcons play;
		action: [ :aButton | self dapResume ]
]

{ #category : #'private - element creation' }
GtDAPDebuggerElement >> newSourceEditor [

	^ BrEditor new
		look: BrGlamorousCodeEditorLook new.
]

{ #category : #'private - element creation' }
GtDAPDebuggerElement >> newStepIntoButton [

	^ BrButton new 
		look: BrGlamorousButtonWithIconLook;
		margin: (BlInsets left: 5);
		icon: BrGlamorousIcons into;
		action: [ :aButton | self dapStepInto ]
]

{ #category : #'private - element creation' }
GtDAPDebuggerElement >> newStepOutButton [

	^ BrButton new 
		look: BrGlamorousButtonWithIconLook;
		margin: (BlInsets left: 5);
		icon: BrGlamorousIcons down;
		action: [ :aButton | self dapStepOut ]
]

{ #category : #'private - element creation' }
GtDAPDebuggerElement >> newStepOverButton [

	^ BrButton new 
		look: BrGlamorousButtonWithIconLook;
		margin: (BlInsets left: 5);
		icon: BrGlamorousIcons over;
		action: [ :aButton | self dapStepOver ]
]

{ #category : #'private - element creation' }
GtDAPDebuggerElement >> newToolbar [ 
	| toolbar |

	toolbar := BrHorizontalPane new 
		vFitContent;
		background: BrGlamorousColors defaultHeaderBackgroundColor;
		padding: (BlInsets top: 5 bottom: 5);
		alignCenterRight.
	toolbar
		addChild: self newInspectButton;
		addChild: self newResumeButton;
		addChild: self newStepIntoButton;
		addChild: self newStepOverButton;
		addChild: self newStepOutButton.
	^ toolbar
]

{ #category : #'instance creation' }
GtDAPDebuggerElement >> newVariablesList [
	| container header tree |

	container := BlElement new
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

{ #category : #actions }
GtDAPDebuggerElement >> terminateSession [

	super terminateSession.
	self dapDebugger ifNotNil: 
		[ dapDebugger announcer unsubscribe: self ]
]

{ #category : #callbacks }
GtDAPDebuggerElement >> updateUI [
	"Update the UI to reflect the debugger state."

	StringSignal emit: 'updateUI'.
	debuggerState text: self dapDebugger statusString asRopedText.
	"Always display the stopped threads.
	Currently we only support the threading module, which has green threads, like Pharo.
	This means that if one thread is stopped, none of the others are actually processing."
	currentThread := self dapDebugger stoppedThread.
	currentThread ifNil: 
		[ ^ self ].
	currentCallFrame := currentThread stackFrames 
		ifEmpty: [ nil ]
		ifNotEmpty: [ :frames | frames first ].
	callFramesList items: currentThread stackFrames.
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
	sourceCode text: self sourceText.
	self lineNumber > 5 ifTrue:
		[ StringSignal emit: 'Scrolling to line: ', self lineNumber asString.
		sourceCode scrollToPosition: self lineNumber + 5 ].

]
