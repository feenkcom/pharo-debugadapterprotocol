"
Arguments for 'continue' request.

"
Class {
	#name : #DAPContinueArguments,
	#superclass : #DAPObject,
	#instVars : [
		'threadId'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPContinueArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #threadId to: #threadId.
		].

]

{ #category : #visiting }
DAPContinueArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitContinueArguments: self
]

{ #category : #accessing }
DAPContinueArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(threadId )
]

{ #category : #accessing }
DAPContinueArguments >> threadId [
	"Continue execution for the specified thread (if possible).
If the backend cannot continue on a single thread but will continue on all threads, it should set the 'allThreadsContinued' attribute in the response to true.
	integer
	Auto-generated method"

	^ threadId
]

{ #category : #accessing }
DAPContinueArguments >> threadId: anObject [
	"Continue execution for the specified thread (if possible).
If the backend cannot continue on a single thread but will continue on all threads, it should set the 'allThreadsContinued' attribute in the response to true.
	integer
	Auto-generated method"

	threadId := anObject

]
