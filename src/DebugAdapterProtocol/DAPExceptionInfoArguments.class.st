"
Arguments for 'exceptionInfo' request.

"
Class {
	#name : 'DAPExceptionInfoArguments',
	#superclass : 'DAPObject',
	#instVars : [
		'threadId'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPExceptionInfoArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #threadId to: #threadId.
		].

]

{ #category : 'visiting' }
DAPExceptionInfoArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitExceptionInfoArguments: self
]

{ #category : 'accessing' }
DAPExceptionInfoArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(threadId )
]

{ #category : 'accessing' }
DAPExceptionInfoArguments >> threadId [
	"Thread for which exception information should be retrieved.
	integer
	Auto-generated method"

	^ threadId
]

{ #category : 'accessing' }
DAPExceptionInfoArguments >> threadId: anObject [
	"Thread for which exception information should be retrieved.
	integer
	Auto-generated method"

	threadId := anObject

]
