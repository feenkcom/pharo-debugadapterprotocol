Class {
	#name : #DAPThreadStateChanged,
	#superclass : #DAPStateChanged,
	#instVars : [
		'thread'
	],
	#category : #'DebugAdapterProtocol-Announcments'
}

{ #category : #testing }
DAPThreadStateChanged >> isContinued [

	^ thread isContinued
]

{ #category : #testing }
DAPThreadStateChanged >> isStopped [

	^ thread isStopped
]

{ #category : #testing }
DAPThreadStateChanged >> isTerminated [

	^ thread isTerminated
]

{ #category : #accessing }
DAPThreadStateChanged >> thread [
	^ thread
]

{ #category : #accessing }
DAPThreadStateChanged >> thread: anObject [
	thread := anObject
]

{ #category : #accessing }
DAPThreadStateChanged >> threadId [ 

	^ thread threadId
]
