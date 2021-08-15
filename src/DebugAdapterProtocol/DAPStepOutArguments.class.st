"
Arguments for 'stepOut' request.

"
Class {
	#name : 'DAPStepOutArguments',
	#superclass : 'DAPObject',
	#instVars : [
		'granularity',
		'threadId'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPStepOutArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #granularity to: #granularity.
		mapping mapAccessor: #threadId to: #threadId.
		].

]

{ #category : 'visiting' }
DAPStepOutArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitStepOutArguments: self
]

{ #category : 'accessing' }
DAPStepOutArguments >> granularity [
	"Optional granularity to step. If no granularity is specified, a granularity of 'statement' is assumed.
	#/definitions/SteppingGranularity
	Auto-generated method"

	^ granularity
]

{ #category : 'accessing' }
DAPStepOutArguments >> granularity: anObject [
	"Optional granularity to step. If no granularity is specified, a granularity of 'statement' is assumed.
	#/definitions/SteppingGranularity
	Auto-generated method"

	granularity := anObject isDictionary ifTrue:
		[ DAPSteppingGranularity fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : 'accessing' }
DAPStepOutArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(granularity threadId )
]

{ #category : 'accessing' }
DAPStepOutArguments >> threadId [
	"Execute 'stepOut' for this thread.
	integer
	Auto-generated method"

	^ threadId
]

{ #category : 'accessing' }
DAPStepOutArguments >> threadId: anObject [
	"Execute 'stepOut' for this thread.
	integer
	Auto-generated method"

	threadId := anObject

]
