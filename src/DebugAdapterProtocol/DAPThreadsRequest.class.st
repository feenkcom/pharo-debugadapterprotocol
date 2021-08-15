"
The request retrieves a list of all threads.

"
Class {
	#name : 'DAPThreadsRequest',
	#superclass : 'DAPRequest',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'accessing' }
DAPThreadsRequest class >> commandEnums [
	"Enumerated types for the associated attribute"

	^ #(threads )
]

{ #category : 'json - configuration' }
DAPThreadsRequest class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #command to: #command.
		].

]

{ #category : 'visiting' }
DAPThreadsRequest >> acceptVisitor: aVisitor [

	^ aVisitor visitThreadsRequest: self
]

{ #category : 'accessing' }
DAPThreadsRequest >> command [
	"threads: 
	Auto-generated method"

	^ command ifNil: [ 'threads' ]
]

{ #category : 'accessing' }
DAPThreadsRequest >> command: anObject [
	"threads: 
	Auto-generated method"

	command := anObject

]

{ #category : 'accessing' }
DAPThreadsRequest >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(command )
]
