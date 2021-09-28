Class {
	#name : 'DAPCDTSource',
	#superclass : 'DAPSource',
	#instVars : [
		'locationDictionary'
	],
	#category : 'DebugAdapterProtocol-ChromeDevTools'
}

{ #category : 'private' }
DAPCDTSource >> gtStyler [ 

	^ JSParser gtStyler
]

{ #category : 'accessing' }
DAPCDTSource >> locationDictionary [
	^ locationDictionary
]

{ #category : 'accessing' }
DAPCDTSource >> locationDictionary: anObject [
	locationDictionary := anObject
]

{ #category : 'accessing' }
DAPCDTSource >> sourceCode [ 

	^ sourceCode ifNil: [ sourceCode := client scriptSourceFor: (locationDictionary at: #scriptId) ]
]
