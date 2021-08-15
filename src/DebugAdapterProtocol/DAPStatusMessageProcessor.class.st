Class {
	#name : 'DAPStatusMessageProcessor',
	#superclass : 'DAPMessageProcessor',
	#instVars : [
		'id',
		'result'
	],
	#category : 'DebugAdapterProtocol-Processor'
}

{ #category : 'instance creation' }
DAPStatusMessageProcessor class >> forMessageId: anInteger [

	^self new id: anInteger
]

{ #category : 'accessing' }
DAPStatusMessageProcessor >> id [
	^ id
]

{ #category : 'accessing' }
DAPStatusMessageProcessor >> id: anObject [
	id := anObject
]

{ #category : 'printing' }
DAPStatusMessageProcessor >> printOn: aStream [

	aStream
		<< 'DAP Status(id=';
		print: id;
		<< ', signalled=';
		print: semaphore isSignaled;
		<< ')'
]

{ #category : 'messages' }
DAPStatusMessageProcessor >> processMessage: aMessage [

	aMessage request_seq = id ifFalse: [ ^ false ].
	result := aMessage.
	semaphore signal.
	^ true
]

{ #category : 'accessing' }
DAPStatusMessageProcessor >> result [
	^ result
]
