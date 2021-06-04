"
The request returns a stacktrace from the current execution state of a given thread.
A client can request all stack frames by omitting the startFrame and levels arguments. For performance conscious clients and if the debug adapter's 'supportsDelayedStackTraceLoading' capability is true, stack frames can be retrieved in a piecemeal way with the startFrame and levels arguments. The response of the stackTrace request may contain a totalFrames property that hints at the total number of frames in the stack. If a client needs this total number upfront, it can issue a request for a single (first) frame and depending on the value of totalFrames decide how to proceed. In any case a client should be prepared to receive less frames than requested, which is an indication that the end of the stack has been reached.

"
Class {
	#name : #DAPStackTraceRequest,
	#superclass : #DAPRequest,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPStackTraceRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(stackTrace )
]

{ #category : #'json - configuration' }
DAPStackTraceRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPStackTraceRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitStackTraceRequest: self
]

{ #category : #accessing }
DAPStackTraceRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPStackTraceRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPStackTraceArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPStackTraceRequest >> command [
	"stackTrace: 
	Auto-generated method"

	^ command ifNil: [ 'stackTrace' ]
]

{ #category : #accessing }
DAPStackTraceRequest >> command: anObject [
	"stackTrace: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPStackTraceRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
