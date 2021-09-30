"
A client or debug adapter initiated request.

"
Class {
	#name : #DAPRequest,
	#superclass : #DAPProtocolMessage,
	#instVars : [
		'arguments',
		'command'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #type to: #type.
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #accessing }
DAPRequest class >> typeEnums [
	"Enumerated types for the associated attribute"

	^ #(request )
]

{ #category : #visiting }
DAPRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitRequest: self
]

{ #category : #accessing }
DAPRequest >> arguments [
	"Object containing arguments for the command.
	arraybooleanintegernullnumberobjectstring
	Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPRequest >> arguments: anObject [
	"Object containing arguments for the command.
	arraybooleanintegernullnumberobjectstring
	Auto-generated method"

	arguments := anObject

]

{ #category : #accessing }
DAPRequest >> command [
	"The command to execute.
	string
	Auto-generated method"

	^ command
]

{ #category : #accessing }
DAPRequest >> command: anObject [
	"The command to execute.
	string
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command type )
]

{ #category : #accessing }
DAPRequest >> type [
	"request: 
	Auto-generated method"

	^ type ifNil: [ 'request' ]
]

{ #category : #accessing }
DAPRequest >> type: anObject [
	"request: 
	Auto-generated method"

	type := anObject

]
