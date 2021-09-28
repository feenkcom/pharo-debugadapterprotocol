"
GtDAPDebugSessionElement is the main UI for a remote DAP session, when initiated by an remote paused notification.

"
Class {
	#name : #GtDAPDebugSessionElement,
	#superclass : #GtDAPDebuggerElement,
	#category : #'DebugAdapterProtocol-UI'
}

{ #category : #testing }
GtDAPDebugSessionElement class >> availableAutomatically [
	"The DAP debugger should be displayed automatically when opened
	as the Pharo stack only shows that the server paused signal has been received."
	
	^ true
]

{ #category : #initialization }
GtDAPDebugSessionElement class >> defaultTitle [ 

	^ 'Debug Adapter Protocol'
]

{ #category : #testing }
GtDAPDebugSessionElement class >> handlesContext: aContext [ 
	"This is currently determined by checking the class of the receiver and its value, which will be different for each snippet type.  This should be changed to the signalling method having the appropriate pragma (<dapOpenDebugger>)"
	| result |

	result := (aContext method hasPragmaNamed: #remoteDebuggerSignal) and:
		[ (aContext receiver exception respondsTo: #debuggerClient) and:
		[ aContext receiver exception isPaused ] ].
	^ result
]

{ #category : #'tools registry' }
GtDAPDebugSessionElement class >> registerToolsOn: registry [
	"self register"
	registry registerDebugger: self withRank: 1100.
]

{ #category : #accessing }
GtDAPDebugSessionElement class >> sessionClass [

	^ GtDAPDebugSession
]

{ #category : #'private - actions' }
GtDAPDebugSessionElement >> dapResume [
	"Continue execution"

	self session dapResume.
	(ResumeDebugAction forDebugger: self) executeAction.
]

{ #category : #'private - accessing' }
GtDAPDebugSessionElement >> debuggerClient [ 

	^ dapDebugger ifNil: [ dapDebugger := debuggingSession debuggerClient ]
]
