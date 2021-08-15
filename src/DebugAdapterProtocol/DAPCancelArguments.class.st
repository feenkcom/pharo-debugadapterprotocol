"
Arguments for 'cancel' request.

"
Class {
	#name : 'DAPCancelArguments',
	#superclass : 'DAPObject',
	#instVars : [
		'progressId',
		'requestId'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPCancelArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #requestId to: #requestId.
		mapping mapAccessor: #progressId to: #progressId.
		].

]

{ #category : 'visiting' }
DAPCancelArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitCancelArguments: self
]

{ #category : 'accessing' }
DAPCancelArguments >> progressId [
	"The ID (attribute 'progressId') of the progress to cancel. If missing no progress is cancelled.
Both a 'requestId' and a 'progressId' can be specified in one request.
	string
	Auto-generated method"

	^ progressId
]

{ #category : 'accessing' }
DAPCancelArguments >> progressId: anObject [
	"The ID (attribute 'progressId') of the progress to cancel. If missing no progress is cancelled.
Both a 'requestId' and a 'progressId' can be specified in one request.
	string
	Auto-generated method"

	progressId := anObject

]

{ #category : 'accessing' }
DAPCancelArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(progressId requestId )
]

{ #category : 'accessing' }
DAPCancelArguments >> requestId [
	"The ID (attribute 'seq') of the request to cancel. If missing no request is cancelled.
Both a 'requestId' and a 'progressId' can be specified in one request.
	integer
	Auto-generated method"

	^ requestId
]

{ #category : 'accessing' }
DAPCancelArguments >> requestId: anObject [
	"The ID (attribute 'seq') of the request to cancel. If missing no request is cancelled.
Both a 'requestId' and a 'progressId' can be specified in one request.
	integer
	Auto-generated method"

	requestId := anObject

]
