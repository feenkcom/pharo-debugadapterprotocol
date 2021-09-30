"
Arguments for 'setBreakpoints' request.

"
Class {
	#name : #DAPSetBreakpointsArguments,
	#superclass : #DAPObject,
	#instVars : [
		'breakpoints',
		'lines',
		'source',
		'sourceModified'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPSetBreakpointsArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #source to: #source.
		mapping mapAccessor: #lines to: #lines.
		mapping mapAccessor: #breakpoints to: #breakpoints.
		mapping mapAccessor: #sourceModified to: #sourceModified.
		].

]

{ #category : #visiting }
DAPSetBreakpointsArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitSetBreakpointsArguments: self
]

{ #category : #accessing }
DAPSetBreakpointsArguments >> breakpoints [
	"The code locations of the breakpoints.
	array
	Auto-generated method"

	^ breakpoints
]

{ #category : #accessing }
DAPSetBreakpointsArguments >> breakpoints: anObject [
	"The code locations of the breakpoints.
	array
	Auto-generated method"

	breakpoints := anObject

]

{ #category : #accessing }
DAPSetBreakpointsArguments >> lines [
	"Deprecated: The code locations of the breakpoints.
	array
	Auto-generated method"

	^ lines
]

{ #category : #accessing }
DAPSetBreakpointsArguments >> lines: anObject [
	"Deprecated: The code locations of the breakpoints.
	array
	Auto-generated method"

	lines := anObject

]

{ #category : #accessing }
DAPSetBreakpointsArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(breakpoints lines source sourceModified )
]

{ #category : #accessing }
DAPSetBreakpointsArguments >> source [
	"The source location of the breakpoints; either 'source.path' or 'source.reference' must be specified.
	#/definitions/Source
	Auto-generated method"

	^ source
]

{ #category : #accessing }
DAPSetBreakpointsArguments >> source: anObject [
	"The source location of the breakpoints; either 'source.path' or 'source.reference' must be specified.
	#/definitions/Source
	Auto-generated method"

	source := anObject isDictionary ifTrue:
		[ DAPSource fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPSetBreakpointsArguments >> sourceModified [
	"A value of true indicates that the underlying source has been modified which results in new breakpoint locations.
	boolean
	Auto-generated method"

	^ sourceModified
]

{ #category : #accessing }
DAPSetBreakpointsArguments >> sourceModified: anObject [
	"A value of true indicates that the underlying source has been modified which results in new breakpoint locations.
	boolean
	Auto-generated method"

	sourceModified := anObject

]
