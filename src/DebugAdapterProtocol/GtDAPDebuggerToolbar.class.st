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

	capabilities := self debuggerClient capabilities.
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
GtDAPDebuggerToolbar >> debuggerClient [
	^ dapDebugElement debuggerClient
]

{ #category : #'initialization' }
GtDAPDebuggerToolbar >> initialize [
	"Left to right: proceed, then the three ways to step forward in the order
	they are usually reached for, then the reverse of the first of them, then
	restart. Inspecting the debugger is not a debugging action, so it sits at
	the end rather than in front of them."

	super initialize.
	self vFitContent.
	resumeButton := self newResumeButton.
	stepOverButton := self newStepOverButton.
	stepIntoButton := self newStepIntoButton.
	stepOutButton := self newStepOutButton.
	stepBackButton := self newStepBackButton.
	restartFrameButton := self newRestartFrameButton.
	self addChildren: {
		resumeButton.
		stepOverButton.
		stepIntoButton.
		stepOutButton.
		stepBackButton.
		restartFrameButton.
		self newInspectButton }
]

{ #category : #'private - element creation' }
GtDAPDebuggerToolbar >> newInspectButton [
	^ BrButton new 
		aptitude: BrGlamorousButtonWithIconAptitude;
		margin: (BlInsets left: 15);
		label: 'Inspect the DAP Debugger';
		icon: BrGlamorousVectorIcons emphasizedInspect;
		action: [ :aButton | self inspect ]
]

{ #category : #'private - element creation' }
GtDAPDebuggerToolbar >> newRestartFrameButton [

	^ BrButton new 
		aptitude: BrGlamorousButtonWithIconAptitude;
		margin: (BlInsets left: 5);
		icon: BrGlamorousVectorIcons restart;
		label: 'Restart Frame';
		action: [ :aButton | dapDebugElement dapRestartFrame ]
]

{ #category : #'private - element creation' }
GtDAPDebuggerToolbar >> newResumeButton [

	^ BrButton new 
		aptitude: BrGlamorousButtonWithIconAptitude;
		margin: (BlInsets left: 5);
		icon: BrGlamorousVectorIcons play;
		label: 'Resume';
		action: [ :aButton | dapDebugElement dapResume ]
]

{ #category : #'private - element creation' }
GtDAPDebuggerToolbar >> newStepBackButton [

	^ BrButton new 
		aptitude: BrGlamorousButtonWithIconAptitude;
		margin: (BlInsets left: 5);
		icon: BrGlamorousVectorIcons down;
		label: 'Step Back';
		action: [ :aButton | dapDebugElement dapStepBack ]
]

{ #category : #'private - element creation' }
GtDAPDebuggerToolbar >> newStepIntoButton [

	^ BrButton new 
		aptitude: BrGlamorousButtonWithIconAptitude;
		margin: (BlInsets left: 5);
		icon: BrGlamorousVectorIcons into;
		label: 'Step Into';
		action: [ :aButton | dapDebugElement dapStepInto ]
]

{ #category : #'private - element creation' }
GtDAPDebuggerToolbar >> newStepOutButton [

	^ BrButton new 
		aptitude: BrGlamorousButtonWithIconAptitude;
		margin: (BlInsets left: 5);
		icon: BrGlamorousVectorIcons down;
		label: 'Step Out';
		action: [ :aButton | dapDebugElement dapStepOut ]
]

{ #category : #'private - element creation' }
GtDAPDebuggerToolbar >> newStepOverButton [

	^ BrButton new 
		aptitude: BrGlamorousButtonWithIconAptitude;
		margin: (BlInsets left: 5);
		icon: BrGlamorousVectorIcons over;
		label: 'Step Over';
		action: [ :aButton | dapDebugElement dapStepOver ]
]

{ #category : #'updating' }
GtDAPDebuggerToolbar >> updateUI [
	"Update the button state to reflect the current debugger state.
	The buttons should only be active if the debugger is stopped and the top
	call frame is being displayed, and only if the adapter says it can do the
	thing: stepping backwards and restarting a frame are optional in the
	protocol, and an adapter that does not offer them should not be offered
	a live button for them."
	| actionsAllowed capabilities |

	actionsAllowed := dapDebugElement isDisplayingTopFrame.
	capabilities := [ self debuggerClient capabilities ] on: Error do: [ :e | nil ].
	restartFrameButton enabled: (actionsAllowed and: [ capabilities notNil
		and: [ capabilities supportsRestartFrame = true ] ]).
	stepBackButton enabled: (actionsAllowed and: [ capabilities notNil
		and: [ capabilities supportsStepBack = true ] ]).
	resumeButton enabled: actionsAllowed.
	stepIntoButton enabled: actionsAllowed.
	stepOverButton enabled: actionsAllowed.
	stepOutButton enabled: actionsAllowed.
]
