"
Represents a single disassembled instruction.

"
Class {
	#name : #DAPDisassembledInstruction,
	#superclass : #DAPObject,
	#instVars : [
		'address',
		'column',
		'endColumn',
		'endLine',
		'instruction',
		'instructionBytes',
		'line',
		'location',
		'symbol'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPDisassembledInstruction class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #symbol to: #symbol.
		mapping mapAccessor: #endColumn to: #endColumn.
		mapping mapAccessor: #instruction to: #instruction.
		mapping mapAccessor: #line to: #line.
		mapping mapAccessor: #instructionBytes to: #instructionBytes.
		mapping mapAccessor: #address to: #address.
		mapping mapAccessor: #column to: #column.
		mapping mapAccessor: #endLine to: #endLine.
		mapping mapAccessor: #location to: #location.
		].

]

{ #category : #visiting }
DAPDisassembledInstruction >> acceptVisitor: aVisitor [

	^ aVisitor visitDisassembledInstruction: self
]

{ #category : #accessing }
DAPDisassembledInstruction >> address [
	"The address of the instruction. Treated as a hex value if prefixed with '0x', or as a decimal value otherwise.
	string
	Auto-generated method"

	^ address
]

{ #category : #accessing }
DAPDisassembledInstruction >> address: anObject [
	"The address of the instruction. Treated as a hex value if prefixed with '0x', or as a decimal value otherwise.
	string
	Auto-generated method"

	address := anObject

]

{ #category : #accessing }
DAPDisassembledInstruction >> column [
	"The column within the line that corresponds to this instruction, if any.
	integer
	Auto-generated method"

	^ column
]

{ #category : #accessing }
DAPDisassembledInstruction >> column: anObject [
	"The column within the line that corresponds to this instruction, if any.
	integer
	Auto-generated method"

	column := anObject

]

{ #category : #accessing }
DAPDisassembledInstruction >> endColumn [
	"The end column of the range that corresponds to this instruction, if any.
	integer
	Auto-generated method"

	^ endColumn
]

{ #category : #accessing }
DAPDisassembledInstruction >> endColumn: anObject [
	"The end column of the range that corresponds to this instruction, if any.
	integer
	Auto-generated method"

	endColumn := anObject

]

{ #category : #accessing }
DAPDisassembledInstruction >> endLine [
	"The end line of the range that corresponds to this instruction, if any.
	integer
	Auto-generated method"

	^ endLine
]

{ #category : #accessing }
DAPDisassembledInstruction >> endLine: anObject [
	"The end line of the range that corresponds to this instruction, if any.
	integer
	Auto-generated method"

	endLine := anObject

]

{ #category : #accessing }
DAPDisassembledInstruction >> instruction [
	"Text representing the instruction and its operands, in an implementation-defined format.
	string
	Auto-generated method"

	^ instruction
]

{ #category : #accessing }
DAPDisassembledInstruction >> instruction: anObject [
	"Text representing the instruction and its operands, in an implementation-defined format.
	string
	Auto-generated method"

	instruction := anObject

]

{ #category : #accessing }
DAPDisassembledInstruction >> instructionBytes [
	"Optional raw bytes representing the instruction and its operands, in an implementation-defined format.
	string
	Auto-generated method"

	^ instructionBytes
]

{ #category : #accessing }
DAPDisassembledInstruction >> instructionBytes: anObject [
	"Optional raw bytes representing the instruction and its operands, in an implementation-defined format.
	string
	Auto-generated method"

	instructionBytes := anObject

]

{ #category : #accessing }
DAPDisassembledInstruction >> line [
	"The line within the source location that corresponds to this instruction, if any.
	integer
	Auto-generated method"

	^ line
]

{ #category : #accessing }
DAPDisassembledInstruction >> line: anObject [
	"The line within the source location that corresponds to this instruction, if any.
	integer
	Auto-generated method"

	line := anObject

]

{ #category : #accessing }
DAPDisassembledInstruction >> location [
	"Source location that corresponds to this instruction, if any.
Should always be set (if available) on the first instruction returned,
but can be omitted afterwards if this instruction maps to the same source file as the previous instruction.
	#/definitions/Source
	Auto-generated method"

	^ location
]

{ #category : #accessing }
DAPDisassembledInstruction >> location: anObject [
	"Source location that corresponds to this instruction, if any.
Should always be set (if available) on the first instruction returned,
but can be omitted afterwards if this instruction maps to the same source file as the previous instruction.
	#/definitions/Source
	Auto-generated method"

	location := anObject isDictionary ifTrue:
		[ DAPSource fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPDisassembledInstruction >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(address column endColumn endLine instruction instructionBytes line location symbol )
]

{ #category : #accessing }
DAPDisassembledInstruction >> symbol [
	"Name of the symbol that corresponds with the location of this instruction, if any.
	string
	Auto-generated method"

	^ symbol
]

{ #category : #accessing }
DAPDisassembledInstruction >> symbol: anObject [
	"Name of the symbol that corresponds with the location of this instruction, if any.
	string
	Auto-generated method"

	symbol := anObject

]
