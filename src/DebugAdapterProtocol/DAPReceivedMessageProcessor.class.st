Class {
	#name : 'DAPReceivedMessageProcessor',
	#superclass : 'DAPMessageProcessor',
	#instVars : [
		'client'
	],
	#category : 'DebugAdapterProtocol-Processor'
}

{ #category : 'accessing' }
DAPReceivedMessageProcessor >> client [
	^ client
]

{ #category : 'accessing' }
DAPReceivedMessageProcessor >> client: anObject [
	client := anObject
]

{ #category : 'messages' }
DAPReceivedMessageProcessor >> processMessage: aMessage [
	| result |

	result := aMessage acceptVisitor: (DAPReceivedMessageVisitor new client: client).
	^ result isBoolean ifTrue: [ result ] ifFalse: [ false ]
]
