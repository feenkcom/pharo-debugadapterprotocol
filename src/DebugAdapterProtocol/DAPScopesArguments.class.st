"
Arguments for 'scopes' request.

"
Class {
	#name : #DAPScopesArguments,
	#superclass : #DAPObject,
	#instVars : [
		'frameId'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPScopesArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #frameId to: #frameId.
		].

]

{ #category : #visiting }
DAPScopesArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitScopesArguments: self
]

{ #category : #accessing }
DAPScopesArguments >> frameId [
	"Retrieve the scopes for this stackframe.
	integer
	Auto-generated method"

	^ frameId
]

{ #category : #accessing }
DAPScopesArguments >> frameId: anObject [
	"Retrieve the scopes for this stackframe.
	integer
	Auto-generated method"

	frameId := anObject

]

{ #category : #accessing }
DAPScopesArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(frameId )
]
