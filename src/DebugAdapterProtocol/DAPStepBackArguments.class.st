"
Arguments for 'stepBack' request.

"
Class {
	#name : #DAPStepBackArguments,
	#superclass : #DAPObject,
	#instVars : [
		'granularity',
		'threadId'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPStepBackArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #granularity to: #granularity.
		mapping mapAccessor: #threadId to: #threadId.
		].

]

{ #category : #visiting }
DAPStepBackArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitStepBackArguments: self
]

{ #category : #accessing }
DAPStepBackArguments >> granularity [
	"Optional granularity to step. If no granularity is specified, a granularity of 'statement' is assumed.
	#/definitions/SteppingGranularity
	Auto-generated method"

	^ granularity
]

{ #category : #accessing }
DAPStepBackArguments >> granularity: anObject [
	"Optional granularity to step. If no granularity is specified, a granularity of 'statement' is assumed.
	#/definitions/SteppingGranularity
	Auto-generated method"

	granularity := anObject isDictionary ifTrue:
		[ DAPSteppingGranularity fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPStepBackArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(granularity threadId )
]

{ #category : #accessing }
DAPStepBackArguments >> threadId [
	"Execute 'stepBack' for this thread.
	integer
	Auto-generated method"

	^ threadId
]

{ #category : #accessing }
DAPStepBackArguments >> threadId: anObject [
	"Execute 'stepBack' for this thread.
	integer
	Auto-generated method"

	threadId := anObject

]
