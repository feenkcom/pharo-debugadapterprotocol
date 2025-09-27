Class {
	#name : #DAPMessageSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'message',
		'direction'
	],
	#category : #'DebugAdapterProtocol-Beacon'
}

{ #category : #accessing }
DAPMessageSignal >> direction [
	^ direction
]

{ #category : #accessing }
DAPMessageSignal >> direction: anObject [
	direction := anObject
]

{ #category : #accessing }
DAPMessageSignal >> message [
	^ message
]

{ #category : #accessing }
DAPMessageSignal >> message: anObject [
	message := anObject
]

{ #category : #printing }
DAPMessageSignal >> printOneLineContentsOn: stream [

	message ifNil: 
		[ super printOn: stream ]
	ifNotNil: 
		[ stream 
			<< self direction;
			<< ': '.
		message printOn: stream ]
]
