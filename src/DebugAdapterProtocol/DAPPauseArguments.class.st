"
Arguments for 'pause' request.

"
Class {
	#name : 'DAPPauseArguments',
	#superclass : 'DAPObject',
	#instVars : [
		'threadId'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPPauseArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #threadId to: #threadId.
		].

]

{ #category : 'visiting' }
DAPPauseArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitPauseArguments: self
]

{ #category : 'accessing' }
DAPPauseArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(threadId )
]

{ #category : 'accessing' }
DAPPauseArguments >> threadId [
	"Pause execution for this thread.
	integer
	Auto-generated method"

	^ threadId
]

{ #category : 'accessing' }
DAPPauseArguments >> threadId: anObject [
	"Pause execution for this thread.
	integer
	Auto-generated method"

	threadId := anObject

]
