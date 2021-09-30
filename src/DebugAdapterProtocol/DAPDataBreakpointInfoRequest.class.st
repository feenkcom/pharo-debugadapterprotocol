"
Obtains information on a possible data breakpoint that could be set on an expression or variable.
Clients should only call this request if the capability 'supportsDataBreakpoints' is true.

"
Class {
	#name : #DAPDataBreakpointInfoRequest,
	#superclass : #DAPRequest,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPDataBreakpointInfoRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(dataBreakpointInfo )
]

{ #category : #'json - configuration' }
DAPDataBreakpointInfoRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPDataBreakpointInfoRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitDataBreakpointInfoRequest: self
]

{ #category : #accessing }
DAPDataBreakpointInfoRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPDataBreakpointInfoRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPDataBreakpointInfoArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPDataBreakpointInfoRequest >> command [
	"dataBreakpointInfo: 
	Auto-generated method"

	^ command ifNil: [ 'dataBreakpointInfo' ]
]

{ #category : #accessing }
DAPDataBreakpointInfoRequest >> command: anObject [
	"dataBreakpointInfo: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPDataBreakpointInfoRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
