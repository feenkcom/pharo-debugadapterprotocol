Class {
	#name : #DAPCDTScope,
	#superclass : #DAPScope,
	#instVars : [
		'cdtScope'
	],
	#category : #'DebugAdapterProtocol-ChromeDevTools'
}

{ #category : #accessing }
DAPCDTScope >> cdtScope [
	^ cdtScope
]

{ #category : #accessing }
DAPCDTScope >> cdtScope: anObject [
	cdtScope := anObject
]

{ #category : #private }
DAPCDTScope >> getVariables [

	^ cdtScope properties collect: [ :each |
		DAPCDTVariable new
			client: client;
			cdtPropertyDescription: each;
			scope: self ]
]

{ #category : #initialization }
DAPCDTScope >> initialize [

	super initialize.
	expensive := false.
]

{ #category : #accessing }
DAPCDTScope >> name [ 

	^ name ifNil: [ name := cdtScope displayName ]
]

{ #category : #accessing }
DAPCDTScope >> presentationHint [ 

	^ presentationHint ifNil: [ presentationHint := cdtScope typeOrNil ]
]

{ #category : #accessing }
DAPCDTScope >> variables [

	^ variables ifNil: [ variables := self getVariables ]
]
