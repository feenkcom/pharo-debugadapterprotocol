"
I am a client that answers canned breakpoint places, so the question of which
form a reader means can be asked without an adapter to ask.
"
Class {
	#name : #DAPTestClient,
	#superclass : #DAPClient,
	#instVars : [
		'places'
	],
	#category : #'DebugAdapterProtocol-Tests'
}

{ #category : #accessing }
DAPTestClient >> breakpointLocationsInSource: aDAPSource line: aLine [
	^ places ifNil: [ #() ]
]

{ #category : #accessing }
DAPTestClient >> places: anArray [
	places := anArray
]
