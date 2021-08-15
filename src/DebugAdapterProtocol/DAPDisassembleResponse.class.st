"
Response to 'disassemble' request.

"
Class {
	#name : 'DAPDisassembleResponse',
	#superclass : 'DAPResponse',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPDisassembleResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : 'visiting' }
DAPDisassembleResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitDisassembleResponse: self
]

{ #category : 'accessing' }
DAPDisassembleResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : 'accessing' }
DAPDisassembleResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : 'accessing' }
DAPDisassembleResponse >> instructions [
	"The list of disassembled instructions.
	array
	Auto-generated method"
	| result |

	result := self body at: #instructions ifAbsent: [ nil ].
	^ result
]

{ #category : 'accessing' }
DAPDisassembleResponse >> instructions: anObject [
	"The list of disassembled instructions.
	array
	Auto-generated method"

	self body at: #instructions put: anObject
]

{ #category : 'accessing' }
DAPDisassembleResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body instructions )
]
