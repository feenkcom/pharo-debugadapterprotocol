"
The 'cancel' request is used by the frontend in two situations:
- to indicate that it is no longer interested in the result produced by a specific request issued earlier
- to cancel a progress sequence. Clients should only call this request if the capability 'supportsCancelRequest' is true.
This request has a hint characteristic: a debug adapter can only be expected to make a 'best effort' in honouring this request but there are no guarantees.
The 'cancel' request may return an error if it could not cancel an operation but a frontend should refrain from presenting this error to end users.
A frontend client should only call this request if the capability 'supportsCancelRequest' is true.
The request that got canceled still needs to send a response back. This can either be a normal result ('success' attribute true)
or an error response ('success' attribute false and the 'message' set to 'cancelled').
Returning partial results from a cancelled request is possible but please note that a frontend client has no generic way for detecting that a response is partial or not.
 The progress that got cancelled still needs to send a 'progressEnd' event back.
 A client should not assume that progress just got cancelled after sending the 'cancel' request.

"
Class {
	#name : #DAPCancelRequest,
	#superclass : #DAPRequest,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPCancelRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(cancel )
]

{ #category : #'json - configuration' }
DAPCancelRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPCancelRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitCancelRequest: self
]

{ #category : #accessing }
DAPCancelRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPCancelRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPCancelArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPCancelRequest >> command [
	"cancel: 
	Auto-generated method"

	^ command ifNil: [ 'cancel' ]
]

{ #category : #accessing }
DAPCancelRequest >> command: anObject [
	"cancel: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPCancelRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
