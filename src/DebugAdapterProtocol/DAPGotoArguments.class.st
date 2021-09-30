"
Arguments for 'goto' request.

"
Class {
	#name : #DAPGotoArguments,
	#superclass : #DAPObject,
	#instVars : [
		'targetId',
		'threadId'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPGotoArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #targetId to: #targetId.
		mapping mapAccessor: #threadId to: #threadId.
		].

]

{ #category : #visiting }
DAPGotoArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitGotoArguments: self
]

{ #category : #accessing }
DAPGotoArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(targetId threadId )
]

{ #category : #accessing }
DAPGotoArguments >> targetId [
	"The location where the debuggee will continue to run.
	integer
	Auto-generated method"

	^ targetId
]

{ #category : #accessing }
DAPGotoArguments >> targetId: anObject [
	"The location where the debuggee will continue to run.
	integer
	Auto-generated method"

	targetId := anObject

]

{ #category : #accessing }
DAPGotoArguments >> threadId [
	"Set the goto target for this thread.
	integer
	Auto-generated method"

	^ threadId
]

{ #category : #accessing }
DAPGotoArguments >> threadId: anObject [
	"Set the goto target for this thread.
	integer
	Auto-generated method"

	threadId := anObject

]
