"
Arguments for 'gotoTargets' request.

"
Class {
	#name : #DAPGotoTargetsArguments,
	#superclass : #DAPObject,
	#instVars : [
		'column',
		'line',
		'source'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPGotoTargetsArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #source to: #source.
		mapping mapAccessor: #column to: #column.
		mapping mapAccessor: #line to: #line.
		].

]

{ #category : #visiting }
DAPGotoTargetsArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitGotoTargetsArguments: self
]

{ #category : #accessing }
DAPGotoTargetsArguments >> column [
	"An optional column location for which the goto targets are determined.
	integer
	Auto-generated method"

	^ column
]

{ #category : #accessing }
DAPGotoTargetsArguments >> column: anObject [
	"An optional column location for which the goto targets are determined.
	integer
	Auto-generated method"

	column := anObject

]

{ #category : #accessing }
DAPGotoTargetsArguments >> line [
	"The line location for which the goto targets are determined.
	integer
	Auto-generated method"

	^ line
]

{ #category : #accessing }
DAPGotoTargetsArguments >> line: anObject [
	"The line location for which the goto targets are determined.
	integer
	Auto-generated method"

	line := anObject

]

{ #category : #accessing }
DAPGotoTargetsArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(column line source )
]

{ #category : #accessing }
DAPGotoTargetsArguments >> source [
	"The source location for which the goto targets are determined.
	#/definitions/Source
	Auto-generated method"

	^ source
]

{ #category : #accessing }
DAPGotoTargetsArguments >> source: anObject [
	"The source location for which the goto targets are determined.
	#/definitions/Source
	Auto-generated method"

	source := anObject isDictionary ifTrue:
		[ DAPSource fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]
