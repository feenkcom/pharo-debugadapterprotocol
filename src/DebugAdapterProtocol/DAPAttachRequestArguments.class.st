"
Arguments for 'attach' request. Additional attributes are implementation specific.

"
Class {
	#name : 'DAPAttachRequestArguments',
	#superclass : 'DAPObject',
	#instVars : [
		'__restart'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPAttachRequestArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #__restart to: #__restart.
		].

]

{ #category : 'accessing' }
DAPAttachRequestArguments >> __restart [
	"Optional data from the previous, restarted session.
The data is sent as the 'restart' attribute of the 'terminated' event.
The client should leave the data intact.
	arraybooleanintegernullnumberobjectstring
	Auto-generated method"

	^ __restart
]

{ #category : 'accessing' }
DAPAttachRequestArguments >> __restart: anObject [
	"Optional data from the previous, restarted session.
The data is sent as the 'restart' attribute of the 'terminated' event.
The client should leave the data intact.
	arraybooleanintegernullnumberobjectstring
	Auto-generated method"

	__restart := anObject

]

{ #category : 'visiting' }
DAPAttachRequestArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitAttachRequestArguments: self
]

{ #category : 'accessing' }
DAPAttachRequestArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(__restart )
]
