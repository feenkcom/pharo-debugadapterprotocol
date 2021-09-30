"
Arguments for 'stepInTargets' request.

"
Class {
	#name : #DAPStepInTargetsArguments,
	#superclass : #DAPObject,
	#instVars : [
		'frameId'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPStepInTargetsArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #frameId to: #frameId.
		].

]

{ #category : #visiting }
DAPStepInTargetsArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitStepInTargetsArguments: self
]

{ #category : #accessing }
DAPStepInTargetsArguments >> frameId [
	"The stack frame for which to retrieve the possible stepIn targets.
	integer
	Auto-generated method"

	^ frameId
]

{ #category : #accessing }
DAPStepInTargetsArguments >> frameId: anObject [
	"The stack frame for which to retrieve the possible stepIn targets.
	integer
	Auto-generated method"

	frameId := anObject

]

{ #category : #accessing }
DAPStepInTargetsArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(frameId )
]
