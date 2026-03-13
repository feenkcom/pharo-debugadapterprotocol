"
Arguments for 'setDataBreakpoints' request.

"
Class {
	#name : #DAPSetDataBreakpointsArguments,
	#superclass : #DAPObject,
	#instVars : [
		'breakpoints'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPSetDataBreakpointsArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #breakpoints to: #breakpoints.
		].

]

{ #category : #visiting }
DAPSetDataBreakpointsArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitSetDataBreakpointsArguments: self
]

{ #category : #accessing }
DAPSetDataBreakpointsArguments >> breakpoints [
	"The contents of this array replaces all existing data breakpoints. An empty array clears all data breakpoints.
	array
	Auto-generated method"

	^ breakpoints
]

{ #category : #accessing }
DAPSetDataBreakpointsArguments >> breakpoints: anObject [
	"The contents of this array replaces all existing data breakpoints. An empty array clears all data breakpoints.
	array
	Auto-generated method"

	breakpoints := anObject

]

{ #category : #accessing }
DAPSetDataBreakpointsArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(breakpoints )
]
