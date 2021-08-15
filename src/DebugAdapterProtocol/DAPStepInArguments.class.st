"
Arguments for 'stepIn' request.

"
Class {
	#name : 'DAPStepInArguments',
	#superclass : 'DAPObject',
	#instVars : [
		'granularity',
		'targetId',
		'threadId'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPStepInArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #targetId to: #targetId.
		mapping mapAccessor: #threadId to: #threadId.
		mapping mapAccessor: #granularity to: #granularity.
		].

]

{ #category : 'visiting' }
DAPStepInArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitStepInArguments: self
]

{ #category : 'accessing' }
DAPStepInArguments >> granularity [
	"Optional granularity to step. If no granularity is specified, a granularity of 'statement' is assumed.
	#/definitions/SteppingGranularity
	Auto-generated method"

	^ granularity
]

{ #category : 'accessing' }
DAPStepInArguments >> granularity: anObject [
	"Optional granularity to step. If no granularity is specified, a granularity of 'statement' is assumed.
	#/definitions/SteppingGranularity
	Auto-generated method"

	granularity := anObject isDictionary ifTrue:
		[ DAPSteppingGranularity fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : 'accessing' }
DAPStepInArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(granularity targetId threadId )
]

{ #category : 'accessing' }
DAPStepInArguments >> targetId [
	"Optional id of the target to step into.
	integer
	Auto-generated method"

	^ targetId
]

{ #category : 'accessing' }
DAPStepInArguments >> targetId: anObject [
	"Optional id of the target to step into.
	integer
	Auto-generated method"

	targetId := anObject

]

{ #category : 'accessing' }
DAPStepInArguments >> threadId [
	"Execute 'stepIn' for this thread.
	integer
	Auto-generated method"

	^ threadId
]

{ #category : 'accessing' }
DAPStepInArguments >> threadId: anObject [
	"Execute 'stepIn' for this thread.
	integer
	Auto-generated method"

	threadId := anObject

]
