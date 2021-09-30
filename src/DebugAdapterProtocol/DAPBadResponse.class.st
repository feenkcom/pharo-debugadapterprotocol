Class {
	#name : #DAPBadResponse,
	#superclass : #Error,
	#instVars : [
		'response'
	],
	#category : 'DebugAdapterProtocol-Exceptions'
}

{ #category : #accessing }
DAPBadResponse >> response [
	^ response
]

{ #category : #accessing }
DAPBadResponse >> response: aDAPResponse [

	response := aDAPResponse.
	self messageText: aDAPResponse message.
]
