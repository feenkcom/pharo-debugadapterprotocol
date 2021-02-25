"
Arguments for 'breakpointLocations' request.
"
Class {
	#name : #DAPBreakpointLocationsArguments,
	#superclass : #DAPObject,
	#instVars : [
		'source',
		'line',
		'column',
		'endColumn',
		'endLine'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPBreakpointLocationsArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #source to: #source.
		mapping mapAccessor: #endColumn to: #endColumn.
		mapping mapAccessor: #line to: #line.
		mapping mapAccessor: #column to: #column.
		mapping mapAccessor: #endLine to: #endLine.
		].

]

{ #category : #visiting }
DAPBreakpointLocationsArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitBreakpointLocationsArguments: self
]

{ #category : #accessing }
DAPBreakpointLocationsArguments >> column [
	"Optional start column of range to search possible breakpoint locations in. If no start column is given, the first column in the start line is assumed.
	integer
	Auto-generated method"

	^ column
]

{ #category : #accessing }
DAPBreakpointLocationsArguments >> column: anObject [
	"Optional start column of range to search possible breakpoint locations in. If no start column is given, the first column in the start line is assumed.
	integer
	Auto-generated method"

	column := anObject

]

{ #category : #accessing }
DAPBreakpointLocationsArguments >> endColumn [
	"Optional end column of range to search possible breakpoint locations in. If no end column is given, then it is assumed to be in the last column of the end line.
	integer
	Auto-generated method"

	^ endColumn
]

{ #category : #accessing }
DAPBreakpointLocationsArguments >> endColumn: anObject [
	"Optional end column of range to search possible breakpoint locations in. If no end column is given, then it is assumed to be in the last column of the end line.
	integer
	Auto-generated method"

	endColumn := anObject

]

{ #category : #accessing }
DAPBreakpointLocationsArguments >> endLine [
	"Optional end line of range to search possible breakpoint locations in. If no end line is given, then the end line is assumed to be the start line.
	integer
	Auto-generated method"

	^ endLine
]

{ #category : #accessing }
DAPBreakpointLocationsArguments >> endLine: anObject [
	"Optional end line of range to search possible breakpoint locations in. If no end line is given, then the end line is assumed to be the start line.
	integer
	Auto-generated method"

	endLine := anObject

]

{ #category : #accessing }
DAPBreakpointLocationsArguments >> line [
	"Start line of range to search possible breakpoint locations in. If only the line is specified, the request returns all possible locations in that line.
	integer
	Auto-generated method"

	^ line
]

{ #category : #accessing }
DAPBreakpointLocationsArguments >> line: anObject [
	"Start line of range to search possible breakpoint locations in. If only the line is specified, the request returns all possible locations in that line.
	integer
	Auto-generated method"

	line := anObject

]

{ #category : #accessing }
DAPBreakpointLocationsArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(source endColumn line column endLine )
]

{ #category : #accessing }
DAPBreakpointLocationsArguments >> source [
	"The source location of the breakpoints; either 'source.path' or 'source.reference' must be specified.
	#/definitions/Source
	Auto-generated method"

	^ source
]

{ #category : #accessing }
DAPBreakpointLocationsArguments >> source: anObject [
	"The source location of the breakpoints; either 'source.path' or 'source.reference' must be specified.
	#/definitions/Source
	Auto-generated method"

	source := anObject isDictionary ifTrue:
		[ DAPSource fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]
