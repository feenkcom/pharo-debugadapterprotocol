Class {
	#name : #DAPCDTVariable,
	#superclass : #DAPVariable,
	#instVars : [
		'cdtPropertyDescription'
	],
	#category : #'DebugAdapterProtocol-ChromeDevTools'
}

{ #category : #accessing }
DAPCDTVariable >> cdtPropertyDescription [
	^ cdtPropertyDescription
]

{ #category : #accessing }
DAPCDTVariable >> cdtPropertyDescription: anObject [
	cdtPropertyDescription := anObject
]

{ #category : #accessing }
DAPCDTVariable >> evaluateName [ 
	"Assume that the variable can be accessed by its name"

	^ evaluateName ifNil: [ evaluateName := self name ]
]

{ #category : #initialization }
DAPCDTVariable >> initialize [

	super initialize.
	variablesReference := 0.
]

{ #category : #accessing }
DAPCDTVariable >> name [ 

	^ name ifNil: [ name := cdtPropertyDescription name ]
]

{ #category : #accessing }
DAPCDTVariable >> type [

	^ cdtPropertyDescription value ifNotNil: [ :remoteObject | remoteObject  type ]
]

{ #category : #accessing }
DAPCDTVariable >> value [ 

	^ value ifNil: [ value := cdtPropertyDescription value value ]
]
