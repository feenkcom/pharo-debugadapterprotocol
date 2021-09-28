Class {
	#name : #GtPostMortemDebugger,
	#superclass : #Object,
	#instVars : [
		'exception'
	],
	#category : 'DebugAdapterProtocol-Client'
}

{ #category : #'instance creation' }
GtPostMortemDebugger class >> onException: anException [

	^ self new exception: anException
]

{ #category : #accessing }
GtPostMortemDebugger >> exception [

	^ exception
]

{ #category : #accessing }
GtPostMortemDebugger >> exception: anObject [

	exception := anObject
]
