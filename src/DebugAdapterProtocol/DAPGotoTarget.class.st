"
A GotoTarget describes a code location that can be used as a target in the 'goto' request.
The possible goto targets can be determined via the 'gotoTargets' request.

"
Class {
	#name : 'DAPGotoTarget',
	#superclass : 'DAPObject',
	#instVars : [
		'column',
		'endColumn',
		'endLine',
		'id',
		'instructionPointerReference',
		'label',
		'line'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPGotoTarget class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #endColumn to: #endColumn.
		mapping mapAccessor: #line to: #line.
		mapping mapAccessor: #column to: #column.
		mapping mapAccessor: #endLine to: #endLine.
		mapping mapAccessor: #id to: #id.
		mapping mapAccessor: #label to: #label.
		mapping mapAccessor: #instructionPointerReference to: #instructionPointerReference.
		].

]

{ #category : 'visiting' }
DAPGotoTarget >> acceptVisitor: aVisitor [

	^ aVisitor visitGotoTarget: self
]

{ #category : 'accessing' }
DAPGotoTarget >> column [
	"An optional column of the goto target.
	integer
	Auto-generated method"

	^ column
]

{ #category : 'accessing' }
DAPGotoTarget >> column: anObject [
	"An optional column of the goto target.
	integer
	Auto-generated method"

	column := anObject

]

{ #category : 'accessing' }
DAPGotoTarget >> endColumn [
	"An optional end column of the range covered by the goto target.
	integer
	Auto-generated method"

	^ endColumn
]

{ #category : 'accessing' }
DAPGotoTarget >> endColumn: anObject [
	"An optional end column of the range covered by the goto target.
	integer
	Auto-generated method"

	endColumn := anObject

]

{ #category : 'accessing' }
DAPGotoTarget >> endLine [
	"An optional end line of the range covered by the goto target.
	integer
	Auto-generated method"

	^ endLine
]

{ #category : 'accessing' }
DAPGotoTarget >> endLine: anObject [
	"An optional end line of the range covered by the goto target.
	integer
	Auto-generated method"

	endLine := anObject

]

{ #category : 'accessing' }
DAPGotoTarget >> id [
	"Unique identifier for a goto target. This is used in the goto request.
	integer
	Auto-generated method"

	^ id
]

{ #category : 'accessing' }
DAPGotoTarget >> id: anObject [
	"Unique identifier for a goto target. This is used in the goto request.
	integer
	Auto-generated method"

	id := anObject

]

{ #category : 'accessing' }
DAPGotoTarget >> instructionPointerReference [
	"Optional memory reference for the instruction pointer value represented by this target.
	string
	Auto-generated method"

	^ instructionPointerReference
]

{ #category : 'accessing' }
DAPGotoTarget >> instructionPointerReference: anObject [
	"Optional memory reference for the instruction pointer value represented by this target.
	string
	Auto-generated method"

	instructionPointerReference := anObject

]

{ #category : 'accessing' }
DAPGotoTarget >> label [
	"The name of the goto target (shown in the UI).
	string
	Auto-generated method"

	^ label
]

{ #category : 'accessing' }
DAPGotoTarget >> label: anObject [
	"The name of the goto target (shown in the UI).
	string
	Auto-generated method"

	label := anObject

]

{ #category : 'accessing' }
DAPGotoTarget >> line [
	"The line of the goto target.
	integer
	Auto-generated method"

	^ line
]

{ #category : 'accessing' }
DAPGotoTarget >> line: anObject [
	"The line of the goto target.
	integer
	Auto-generated method"

	line := anObject

]

{ #category : 'accessing' }
DAPGotoTarget >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(column endColumn endLine id instructionPointerReference label line )
]
