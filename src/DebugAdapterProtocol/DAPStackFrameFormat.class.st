"
Provides formatting information for a stack frame.

"
Class {
	#name : 'DAPStackFrameFormat',
	#superclass : 'DAPValueFormat',
	#instVars : [
		'includeAll',
		'line',
		'module',
		'parameterNames',
		'parameterTypes',
		'parameterValues',
		'parameters'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPStackFrameFormat class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #module to: #module.
		mapping mapAccessor: #parameterValues to: #parameterValues.
		mapping mapAccessor: #parameters to: #parameters.
		mapping mapAccessor: #parameterTypes to: #parameterTypes.
		mapping mapAccessor: #line to: #line.
		mapping mapAccessor: #includeAll to: #includeAll.
		mapping mapAccessor: #parameterNames to: #parameterNames.
		].

]

{ #category : 'visiting' }
DAPStackFrameFormat >> acceptVisitor: aVisitor [

	^ aVisitor visitStackFrameFormat: self
]

{ #category : 'accessing' }
DAPStackFrameFormat >> includeAll [
	"Includes all stack frames, including those the debug adapter might otherwise hide.
	boolean
	Auto-generated method"

	^ includeAll
]

{ #category : 'accessing' }
DAPStackFrameFormat >> includeAll: anObject [
	"Includes all stack frames, including those the debug adapter might otherwise hide.
	boolean
	Auto-generated method"

	includeAll := anObject

]

{ #category : 'accessing' }
DAPStackFrameFormat >> line [
	"Displays the line number of the stack frame.
	boolean
	Auto-generated method"

	^ line
]

{ #category : 'accessing' }
DAPStackFrameFormat >> line: anObject [
	"Displays the line number of the stack frame.
	boolean
	Auto-generated method"

	line := anObject

]

{ #category : 'accessing' }
DAPStackFrameFormat >> module [
	"Displays the module of the stack frame.
	boolean
	Auto-generated method"

	^ module
]

{ #category : 'accessing' }
DAPStackFrameFormat >> module: anObject [
	"Displays the module of the stack frame.
	boolean
	Auto-generated method"

	module := anObject

]

{ #category : 'accessing' }
DAPStackFrameFormat >> parameterNames [
	"Displays the names of parameters for the stack frame.
	boolean
	Auto-generated method"

	^ parameterNames
]

{ #category : 'accessing' }
DAPStackFrameFormat >> parameterNames: anObject [
	"Displays the names of parameters for the stack frame.
	boolean
	Auto-generated method"

	parameterNames := anObject

]

{ #category : 'accessing' }
DAPStackFrameFormat >> parameterTypes [
	"Displays the types of parameters for the stack frame.
	boolean
	Auto-generated method"

	^ parameterTypes
]

{ #category : 'accessing' }
DAPStackFrameFormat >> parameterTypes: anObject [
	"Displays the types of parameters for the stack frame.
	boolean
	Auto-generated method"

	parameterTypes := anObject

]

{ #category : 'accessing' }
DAPStackFrameFormat >> parameterValues [
	"Displays the values of parameters for the stack frame.
	boolean
	Auto-generated method"

	^ parameterValues
]

{ #category : 'accessing' }
DAPStackFrameFormat >> parameterValues: anObject [
	"Displays the values of parameters for the stack frame.
	boolean
	Auto-generated method"

	parameterValues := anObject

]

{ #category : 'accessing' }
DAPStackFrameFormat >> parameters [
	"Displays parameters for the stack frame.
	boolean
	Auto-generated method"

	^ parameters
]

{ #category : 'accessing' }
DAPStackFrameFormat >> parameters: anObject [
	"Displays parameters for the stack frame.
	boolean
	Auto-generated method"

	parameters := anObject

]

{ #category : 'accessing' }
DAPStackFrameFormat >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(includeAll line module parameterNames parameterTypes parameterValues parameters )
]
