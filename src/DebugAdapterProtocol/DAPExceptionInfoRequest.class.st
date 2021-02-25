"
Retrieves the details of the exception that caused this event to be raised.
Clients should only call this request if the capability 'supportsExceptionInfoRequest' is true.
"
Class {
	#name : #DAPExceptionInfoRequest,
	#superclass : #DAPRequest,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPExceptionInfoRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(exceptionInfo )
]

{ #category : #'json - configuration' }
DAPExceptionInfoRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPExceptionInfoRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitExceptionInfoRequest: self
]

{ #category : #accessing }
DAPExceptionInfoRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPExceptionInfoRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject isDictionary ifTrue:
		[ DAPExceptionInfoArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPExceptionInfoRequest >> command [
	"exceptionInfo: 
	Auto-generated method"

	^ command ifNil: [ 'exceptionInfo' ]
]

{ #category : #accessing }
DAPExceptionInfoRequest >> command: anObject [
	"exceptionInfo: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPExceptionInfoRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(command arguments )
]
