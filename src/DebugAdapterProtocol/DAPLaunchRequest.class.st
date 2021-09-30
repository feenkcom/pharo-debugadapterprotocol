"
This launch request is sent from the client to the debug adapter to start the debuggee with or without debugging (if 'noDebug' is true).
Since launching is debugger/runtime specific, the arguments for this request are not part of this specification.

"
Class {
	#name : #DAPLaunchRequest,
	#superclass : #DAPRequest,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPLaunchRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(launch )
]

{ #category : #'json - configuration' }
DAPLaunchRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		mapping mapAccessor: #arguments to: #arguments.
		].

]

{ #category : #visiting }
DAPLaunchRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitLaunchRequest: self
]

{ #category : #accessing }
DAPLaunchRequest >> arguments [
	"Auto-generated method"

	^ arguments
]

{ #category : #accessing }
DAPLaunchRequest >> arguments: anObject [
	"Auto-generated method"

	arguments := anObject

]

{ #category : #accessing }
DAPLaunchRequest >> command [
	"launch: 
	Auto-generated method"

	^ command ifNil: [ 'launch' ]
]

{ #category : #accessing }
DAPLaunchRequest >> command: anObject [
	"launch: 
	Auto-generated method"

	command := anObject

]

{ #category : #accessing }
DAPLaunchRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(arguments command )
]
