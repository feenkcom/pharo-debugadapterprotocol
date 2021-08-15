"
Properties of a breakpoint location returned from the 'breakpointLocations' request.

"
Class {
	#name : 'DAPBreakpointLocation',
	#superclass : 'DAPObject',
	#instVars : [
		'column',
		'endColumn',
		'endLine',
		'line'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPBreakpointLocation class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #column to: #column.
		mapping mapAccessor: #endLine to: #endLine.
		mapping mapAccessor: #line to: #line.
		mapping mapAccessor: #endColumn to: #endColumn.
		].

]

{ #category : 'visiting' }
DAPBreakpointLocation >> acceptVisitor: aVisitor [

	^ aVisitor visitBreakpointLocation: self
]

{ #category : 'accessing' }
DAPBreakpointLocation >> column [
	"Optional start column of breakpoint location.
	integer
	Auto-generated method"

	^ column
]

{ #category : 'accessing' }
DAPBreakpointLocation >> column: anObject [
	"Optional start column of breakpoint location.
	integer
	Auto-generated method"

	column := anObject

]

{ #category : 'accessing' }
DAPBreakpointLocation >> endColumn [
	"Optional end column of breakpoint location if the location covers a range.
	integer
	Auto-generated method"

	^ endColumn
]

{ #category : 'accessing' }
DAPBreakpointLocation >> endColumn: anObject [
	"Optional end column of breakpoint location if the location covers a range.
	integer
	Auto-generated method"

	endColumn := anObject

]

{ #category : 'accessing' }
DAPBreakpointLocation >> endLine [
	"Optional end line of breakpoint location if the location covers a range.
	integer
	Auto-generated method"

	^ endLine
]

{ #category : 'accessing' }
DAPBreakpointLocation >> endLine: anObject [
	"Optional end line of breakpoint location if the location covers a range.
	integer
	Auto-generated method"

	endLine := anObject

]

{ #category : 'accessing' }
DAPBreakpointLocation >> line [
	"Start line of breakpoint location.
	integer
	Auto-generated method"

	^ line
]

{ #category : 'accessing' }
DAPBreakpointLocation >> line: anObject [
	"Start line of breakpoint location.
	integer
	Auto-generated method"

	line := anObject

]

{ #category : 'accessing' }
DAPBreakpointLocation >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(column endColumn endLine line )
]
