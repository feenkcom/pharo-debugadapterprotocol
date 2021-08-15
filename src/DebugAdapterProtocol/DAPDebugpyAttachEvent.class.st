"
Notification by debugpy that the debuggee(?) is attached.

"
Class {
	#name : 'DAPDebugpyAttachEvent',
	#superclass : 'DAPEvent',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPDebugpyAttachEvent class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : 'accessing' }
DAPDebugpyAttachEvent class >> eventEnums [
	"Enumerated types for the associated attribute"

	^ #(debugpyAttach )
]

{ #category : 'visiting' }
DAPDebugpyAttachEvent >> acceptVisitor: aVisitor [

	^ aVisitor visitDebugpyAttachEvent: self
]

{ #category : 'accessing' }
DAPDebugpyAttachEvent >> body [
	"Auto-generated method"

	^ body
]

{ #category : 'accessing' }
DAPDebugpyAttachEvent >> body: anObject [
	"Auto-generated method"

	body := anObject isDictionary ifTrue:
		[ DAPPythonAttachRequestArguments fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : 'accessing' }
DAPDebugpyAttachEvent >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body )
]
