"
Arguments for 'stackTrace' request.

"
Class {
	#name : #DAPStackTraceArguments,
	#superclass : #DAPObject,
	#instVars : [
		'format',
		'levels',
		'startFrame',
		'threadId'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPStackTraceArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #threadId to: #threadId.
		mapping mapAccessor: #startFrame to: #startFrame.
		mapping mapAccessor: #levels to: #levels.
		mapping mapAccessor: #format to: #format.
		].

]

{ #category : #visiting }
DAPStackTraceArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitStackTraceArguments: self
]

{ #category : #accessing }
DAPStackTraceArguments >> format [
	"Specifies details on how to format the stack frames.
The attribute is only honored by a debug adapter if the capability 'supportsValueFormattingOptions' is true.
	#/definitions/StackFrameFormat
	Auto-generated method"

	^ format
]

{ #category : #accessing }
DAPStackTraceArguments >> format: anObject [
	"Specifies details on how to format the stack frames.
The attribute is only honored by a debug adapter if the capability 'supportsValueFormattingOptions' is true.
	#/definitions/StackFrameFormat
	Auto-generated method"

	format := anObject isDictionary ifTrue:
		[ DAPStackFrameFormat fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPStackTraceArguments >> levels [
	"The maximum number of frames to return. If levels is not specified or 0, all frames are returned.
	integer
	Auto-generated method"

	^ levels
]

{ #category : #accessing }
DAPStackTraceArguments >> levels: anObject [
	"The maximum number of frames to return. If levels is not specified or 0, all frames are returned.
	integer
	Auto-generated method"

	levels := anObject

]

{ #category : #accessing }
DAPStackTraceArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(format levels startFrame threadId )
]

{ #category : #accessing }
DAPStackTraceArguments >> startFrame [
	"The index of the first frame to return; if omitted frames start at 0.
	integer
	Auto-generated method"

	^ startFrame
]

{ #category : #accessing }
DAPStackTraceArguments >> startFrame: anObject [
	"The index of the first frame to return; if omitted frames start at 0.
	integer
	Auto-generated method"

	startFrame := anObject

]

{ #category : #accessing }
DAPStackTraceArguments >> threadId [
	"Retrieve the stacktrace for this thread.
	integer
	Auto-generated method"

	^ threadId
]

{ #category : #accessing }
DAPStackTraceArguments >> threadId: anObject [
	"Retrieve the stacktrace for this thread.
	integer
	Auto-generated method"

	threadId := anObject

]
