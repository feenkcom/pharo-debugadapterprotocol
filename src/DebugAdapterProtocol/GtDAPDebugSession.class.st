Class {
	#name : #GtDAPDebugSession,
	#superclass : #DebugSession,
	#instVars : [
		'signal',
		'nodeJSDebugger'
	],
	#category : #'DebugAdapterProtocol-UI'
}

{ #category : #'private - accessing' }
GtDAPDebugSession >> dapDebugger [
	"Answer the debugger client to the NodeJS server"

	^ nodeJSDebugger ifNil: [ nodeJSDebugger := self signal debugger ].

]

{ #category : #'js - actions' }
GtDAPDebugSession >> dapResume [
	"Continue execution.
	Flag the promise to wait again as the value should be returned (or the debugger opened again).
	This only instructs the NodeJS server to resume.  Control of the Pharo session is up to the owner of the receiver."

	self signal setWaitAgain.
	self dapDebugger resume.

]

{ #category : #'js - actions' }
GtDAPDebugSession >> dapStepInto [

	self dapDebugger stepInto.

]

{ #category : #'js - actions' }
GtDAPDebugSession >> dapStepOut [

	self dapDebugger stepOut.

]

{ #category : #'js - actions' }
GtDAPDebugSession >> dapStepOver [

	self dapDebugger stepOver.

]

{ #category : #'private - accessing' }
GtDAPDebugSession >> signal [
	"Answer the signal that triggered the debug session."

	signal ifNotNil: [ ^ signal ].

	"Confirm that the NodeJS server is in fact paused in the debugger"
	signal := self interruptedContext receiver value.
	(signal respondsTo: #debugger) ifFalse:
		[ self error: 'Unable to retrieve JS debugger' ].

	^ signal
]
