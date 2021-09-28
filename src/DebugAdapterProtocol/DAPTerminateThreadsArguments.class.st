"
Arguments for 'terminateThreads' request.

"
Class {
	#name : #DAPTerminateThreadsArguments,
	#superclass : #DAPObject,
	#instVars : [
		'threadIds'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPTerminateThreadsArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #threadIds to: #threadIds.
		].

]

{ #category : #visiting }
DAPTerminateThreadsArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitTerminateThreadsArguments: self
]

{ #category : #accessing }
DAPTerminateThreadsArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(threadIds )
]

{ #category : #accessing }
DAPTerminateThreadsArguments >> threadIds [
	"Ids of threads to be terminated.
	array
	Auto-generated method"

	^ threadIds
]

{ #category : #accessing }
DAPTerminateThreadsArguments >> threadIds: anObject [
	"Ids of threads to be terminated.
	array
	Auto-generated method"

	threadIds := anObject

]
