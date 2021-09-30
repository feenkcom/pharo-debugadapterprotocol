"
Arguments for 'reverseContinue' request.

"
Class {
	#name : #DAPReverseContinueArguments,
	#superclass : #DAPObject,
	#instVars : [
		'threadId'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPReverseContinueArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #threadId to: #threadId.
		].

]

{ #category : #visiting }
DAPReverseContinueArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitReverseContinueArguments: self
]

{ #category : #accessing }
DAPReverseContinueArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(threadId )
]

{ #category : #accessing }
DAPReverseContinueArguments >> threadId [
	"Execute 'reverseContinue' for this thread.
	integer
	Auto-generated method"

	^ threadId
]

{ #category : #accessing }
DAPReverseContinueArguments >> threadId: anObject [
	"Execute 'reverseContinue' for this thread.
	integer
	Auto-generated method"

	threadId := anObject

]
