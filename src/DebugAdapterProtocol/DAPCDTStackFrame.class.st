Class {
	#name : #DAPCDTStackFrame,
	#superclass : #DAPStackFrame,
	#instVars : [
		'cdtCallFrame',
		'sourceCode'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPCDTStackFrame >> cdtCallFrame [
	^ cdtCallFrame
]

{ #category : #accessing }
DAPCDTStackFrame >> cdtCallFrame: anObject [
	cdtCallFrame := anObject
]

{ #category : #accessing }
DAPCDTStackFrame >> column [ 

	^ cdtCallFrame columnNumber
]

{ #category : #private }
DAPCDTStackFrame >> getScopes [

	^ cdtCallFrame scopeChain collect: [ :each |
		DAPCDTScope new 
			cdtScope: each;
			client: client ]
]

{ #category : #accessing }
DAPCDTStackFrame >> id [ 

	^ cdtCallFrame callFrameId ordinal
]

{ #category : #initialization }
DAPCDTStackFrame >> initialize [ 

	super initialize.
	canRestart := false.

]

{ #category : #accessing }
DAPCDTStackFrame >> line [ 

	^ cdtCallFrame lineNumber
]

{ #category : #accessing }
DAPCDTStackFrame >> name [ 

	^ cdtCallFrame functionName
]

{ #category : #accessing }
DAPCDTStackFrame >> ordinal [ 

	^ cdtCallFrame callFrameId ordinal
]

{ #category : #accessing }
DAPCDTStackFrame >> scopes [ 

	^ scopes ifNil: [ scopes := self getScopes ]
]

{ #category : #accessing }
DAPCDTStackFrame >> source [ 

	^ source ifNil: [ source := DAPCDTSource new 
		client: client;
		path: cdtCallFrame url;
		locationDictionary: cdtCallFrame location ]
]

{ #category : #ui }
DAPCDTStackFrame >> sourceCode [ 

	^ sourceCode ifNil: [ sourceCode := cdtCallFrame sourceCode ]
]
