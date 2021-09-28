"
Arguments for 'next' request.

"
Class {
	#name : #DAPNextArguments,
	#superclass : #DAPObject,
	#instVars : [
		'granularity',
		'threadId'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPNextArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #granularity to: #granularity.
		mapping mapAccessor: #threadId to: #threadId.
		].

]

{ #category : #visiting }
DAPNextArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitNextArguments: self
]

{ #category : #accessing }
DAPNextArguments >> granularity [
	"Optional granularity to step. If no granularity is specified, a granularity of 'statement' is assumed.
	#/definitions/SteppingGranularity
	Auto-generated method"

	^ granularity
]

{ #category : #accessing }
DAPNextArguments >> granularity: anObject [
	"Optional granularity to step. If no granularity is specified, a granularity of 'statement' is assumed.
	#/definitions/SteppingGranularity
	Auto-generated method"

	granularity := anObject isDictionary ifTrue:
		[ DAPSteppingGranularity fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPNextArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(granularity threadId )
]

{ #category : #accessing }
DAPNextArguments >> threadId [
	"Execute 'next' for this thread.
	integer
	Auto-generated method"

	^ threadId
]

{ #category : #accessing }
DAPNextArguments >> threadId: anObject [
	"Execute 'next' for this thread.
	integer
	Auto-generated method"

	threadId := anObject

]
