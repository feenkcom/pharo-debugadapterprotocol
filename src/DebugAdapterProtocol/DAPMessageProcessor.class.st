Class {
	#name : #DAPMessageProcessor,
	#superclass : #Object,
	#instVars : [
		'semaphore',
		'maxWaitSeconds'
	],
	#category : #'DebugAdapterProtocol-Processor'
}

{ #category : #initialize }
DAPMessageProcessor >> initialize [

	super initialize.
	semaphore := Semaphore new.
	maxWaitSeconds := 60.
]

{ #category : #accessing }
DAPMessageProcessor >> maxWaitSeconds [
	^ maxWaitSeconds
]

{ #category : #accessing }
DAPMessageProcessor >> maxWaitSeconds: anObject [
	maxWaitSeconds := anObject
]

{ #category : #messages }
DAPMessageProcessor >> processAnnouncement: anAnnouncement [

	self processMessage: anAnnouncement rawData.
]

{ #category : #messages }
DAPMessageProcessor >> processMessage: aMessage [
	"If appropriate, process the supplied message.
	Answer a boolean indicating whether the message has been handled."

	^ self subclassResponsibility
]

{ #category : #messages }
DAPMessageProcessor >> signal [
	"Flag the receivers request as complete"
	
	semaphore signal
]

{ #category : #messages }
DAPMessageProcessor >> wait [
	"Wait for the receivers message to be processed"

	semaphore waitTimeoutSeconds: maxWaitSeconds
		onCompletion: nil
		onTimeout: [ ChromeLoadTimeout new 
				processor: self;
				signal: 'Exceeded ', maxWaitSeconds asString, ' seconds' ].
]
