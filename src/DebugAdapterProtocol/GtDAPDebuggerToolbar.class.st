"
Display the action buttons for a DAP debugger.

The actions supported by DAP are: restart frame, resume, step back, step into, step over, step out.

The debugger's capabilities indicate whether the restart and step back actions are supported for the current back end.

The buttons are only enabled while the debugger is stopped.
"
Class {
	#name : #GtDAPDebuggerToolbar,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'dapDebugElement',
		'restartFrameButton',
		'resumeButton',
		'stepBackButton',
		'stepIntoButton',
		'stepOverButton',
		'stepOutButton'
	],
	#category : #'DebugAdapterProtocol-UI'
}

{ #category : #callbacks }
GtDAPDebuggerToolbar >> actOnBrowserClosing: ann [
	"No action required at the moment"
]

{ #category : #callbacks }
GtDAPDebuggerToolbar >> actOnDebugSessionChanged [
	| capabilities |

	capabilities := self dapDebugger capabilities.
	capabilities supportsRestartFrame ifFalse: 
		[ restartFrameButton visibility: BlVisibility gone ].
	capabilities supportsStepBack ifFalse:
		[ stepBackButton visibility: BlVisibility gone ].

]

{ #category : #accessing }
GtDAPDebuggerToolbar >> dapDebugElement [
	^ dapDebugElement
]

{ #category : #accessing }
GtDAPDebuggerToolbar >> dapDebugElement: aDAPDebugElement [

	dapDebugElement := aDAPDebugElement.

]

{ #category : #accessing }
GtDAPDebuggerToolbar >> dapDebugger [
	^ dapDebugElement dapDebugger
]

{ #category : #initialization }
GtDAPDebuggerToolbar >> initialize [

	super initialize.
	self vFitContent.
	restartFrameButton := self newRestartFrameButton.
	resumeButton := self newResumeButton.
	stepBackButton := self newStepBackButton.
	stepIntoButton := self newStepIntoButton.
	stepOutButton := self newStepOutButton.
	stepOverButton := self newStepOverButton.
	self addChild: self newInspectButton.
	self addChildren: { restartFrameButton. resumeButton. stepBackButton. stepIntoButton. stepOutButton. stepOverButton. }.

]

{ #category : #'private - element creation' }
GtDAPDebuggerToolbar >> newInspectButton [

	^ BrButton new 
		look: BrGlamorousButtonWithIconLook;
		margin: (BlInsets left: 5);
		label: 'Inspect the DAP Debugger';
		icon: BrGlamorousVectorIcons emphasizedInspect;
		action: [ :aButton | self dapDebugger inspect ]
]

{ #category : #'private - element creation' }
GtDAPDebuggerToolbar >> newRestartFrameButton [

	^ BrButton new 
		look: BrGlamorousButtonWithIconLook;
		margin: (BlInsets left: 5);
		icon: BrGlamorousIcons restart;
		label: 'Restart Frame';
		action: [ :aButton | dapDebugElement dapRestartFrame ]
]

{ #category : #'private - element creation' }
GtDAPDebuggerToolbar >> newResumeButton [

	^ BrButton new 
		look: BrGlamorousButtonWithIconLook;
		margin: (BlInsets left: 5);
		icon: BrGlamorousVectorIcons play;
		label: 'Resume';
		action: [ :aButton | dapDebugElement dapResume ]
]

{ #category : #'private - element creation' }
GtDAPDebuggerToolbar >> newStepBackButton [

	^ BrButton new 
		look: BrGlamorousButtonWithIconLook;
		margin: (BlInsets left: 5);
		icon: BrGlamorousIcons down;
		label: 'Step Back';
		action: [ :aButton | dapDebugElement dapStepBack ]
]

{ #category : #'private - element creation' }
GtDAPDebuggerToolbar >> newStepIntoButton [

	^ BrButton new 
		look: BrGlamorousButtonWithIconLook;
		margin: (BlInsets left: 5);
		icon: BrGlamorousIcons into;
		label: 'Step Into';
		action: [ :aButton | dapDebugElement dapStepInto ]
]

{ #category : #'private - element creation' }
GtDAPDebuggerToolbar >> newStepOutButton [

	^ BrButton new 
		look: BrGlamorousButtonWithIconLook;
		margin: (BlInsets left: 5);
		icon: BrGlamorousIcons down;
		label: 'Step Out';
		action: [ :aButton | dapDebugElement dapStepOut ]
]

{ #category : #'private - element creation' }
GtDAPDebuggerToolbar >> newStepOverButton [

	^ BrButton new 
		look: BrGlamorousButtonWithIconLook;
		margin: (BlInsets left: 5);
		icon: BrGlamorousIcons over;
		label: 'Step Over';
		action: [ :aButton | dapDebugElement dapStepOver ]
]

{ #category : #private }
GtDAPDebuggerToolbar >> updateUI [ 
	"Update the button state to reflect the current debugger state.
	The buttons should only be active if the debugger is stopped and the top call frame is being displayed."
	| actionsAllowed |

	actionsAllowed := dapDebugElement isDisplayingTopFrame.
	StringSignal emit: 'toolbar: ', actionsAllowed asString.
	restartFrameButton enabled: actionsAllowed.
	resumeButton enabled: actionsAllowed.
	stepBackButton enabled: actionsAllowed.
	stepIntoButton enabled: actionsAllowed.
	stepOverButton enabled: actionsAllowed.
	stepOutButton enabled: actionsAllowed.
]
