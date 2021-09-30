"
Arguments for 'disassemble' request.

"
Class {
	#name : #DAPDisassembleArguments,
	#superclass : #DAPObject,
	#instVars : [
		'instructionCount',
		'instructionOffset',
		'memoryReference',
		'offset',
		'resolveSymbols'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPDisassembleArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #memoryReference to: #memoryReference.
		mapping mapAccessor: #offset to: #offset.
		mapping mapAccessor: #instructionOffset to: #instructionOffset.
		mapping mapAccessor: #instructionCount to: #instructionCount.
		mapping mapAccessor: #resolveSymbols to: #resolveSymbols.
		].

]

{ #category : #visiting }
DAPDisassembleArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitDisassembleArguments: self
]

{ #category : #accessing }
DAPDisassembleArguments >> instructionCount [
	"Number of instructions to disassemble starting at the specified location and offset.
An adapter must return exactly this number of instructions - any unavailable instructions should be replaced with an implementation-defined 'invalid instruction' value.
	integer
	Auto-generated method"

	^ instructionCount
]

{ #category : #accessing }
DAPDisassembleArguments >> instructionCount: anObject [
	"Number of instructions to disassemble starting at the specified location and offset.
An adapter must return exactly this number of instructions - any unavailable instructions should be replaced with an implementation-defined 'invalid instruction' value.
	integer
	Auto-generated method"

	instructionCount := anObject

]

{ #category : #accessing }
DAPDisassembleArguments >> instructionOffset [
	"Optional offset (in instructions) to be applied after the byte offset (if any) before disassembling. Can be negative.
	integer
	Auto-generated method"

	^ instructionOffset
]

{ #category : #accessing }
DAPDisassembleArguments >> instructionOffset: anObject [
	"Optional offset (in instructions) to be applied after the byte offset (if any) before disassembling. Can be negative.
	integer
	Auto-generated method"

	instructionOffset := anObject

]

{ #category : #accessing }
DAPDisassembleArguments >> memoryReference [
	"Memory reference to the base location containing the instructions to disassemble.
	string
	Auto-generated method"

	^ memoryReference
]

{ #category : #accessing }
DAPDisassembleArguments >> memoryReference: anObject [
	"Memory reference to the base location containing the instructions to disassemble.
	string
	Auto-generated method"

	memoryReference := anObject

]

{ #category : #accessing }
DAPDisassembleArguments >> offset [
	"Optional offset (in bytes) to be applied to the reference location before disassembling. Can be negative.
	integer
	Auto-generated method"

	^ offset
]

{ #category : #accessing }
DAPDisassembleArguments >> offset: anObject [
	"Optional offset (in bytes) to be applied to the reference location before disassembling. Can be negative.
	integer
	Auto-generated method"

	offset := anObject

]

{ #category : #accessing }
DAPDisassembleArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(instructionCount instructionOffset memoryReference offset resolveSymbols )
]

{ #category : #accessing }
DAPDisassembleArguments >> resolveSymbols [
	"If true, the adapter should attempt to resolve memory addresses and other values to symbolic names.
	boolean
	Auto-generated method"

	^ resolveSymbols
]

{ #category : #accessing }
DAPDisassembleArguments >> resolveSymbols: anObject [
	"If true, the adapter should attempt to resolve memory addresses and other values to symbolic names.
	boolean
	Auto-generated method"

	resolveSymbols := anObject

]
