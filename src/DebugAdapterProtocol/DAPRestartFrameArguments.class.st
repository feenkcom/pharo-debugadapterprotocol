"
Arguments for 'restartFrame' request.

"
Class {
	#name : #DAPRestartFrameArguments,
	#superclass : #DAPObject,
	#instVars : [
		'frameId'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPRestartFrameArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #frameId to: #frameId.
		].

]

{ #category : #visiting }
DAPRestartFrameArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitRestartFrameArguments: self
]

{ #category : #accessing }
DAPRestartFrameArguments >> frameId [
	"Restart this stackframe.
	integer
	Auto-generated method"

	^ frameId
]

{ #category : #accessing }
DAPRestartFrameArguments >> frameId: anObject [
	"Restart this stackframe.
	integer
	Auto-generated method"

	frameId := anObject

]

{ #category : #accessing }
DAPRestartFrameArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(frameId )
]
