"
Arguments for 'terminate' request.

"
Class {
	#name : 'DAPTerminateArguments',
	#superclass : 'DAPObject',
	#instVars : [
		'restart'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPTerminateArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #restart to: #restart.
		].

]

{ #category : 'visiting' }
DAPTerminateArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitTerminateArguments: self
]

{ #category : 'accessing' }
DAPTerminateArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(restart )
]

{ #category : 'accessing' }
DAPTerminateArguments >> restart [
	"A value of true indicates that this 'terminate' request is part of a restart sequence.
	boolean
	Auto-generated method"

	^ restart
]

{ #category : 'accessing' }
DAPTerminateArguments >> restart: anObject [
	"A value of true indicates that this 'terminate' request is part of a restart sequence.
	boolean
	Auto-generated method"

	restart := anObject

]
