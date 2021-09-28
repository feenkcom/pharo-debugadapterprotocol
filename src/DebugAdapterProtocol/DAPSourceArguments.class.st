"
Arguments for 'source' request.

"
Class {
	#name : #DAPSourceArguments,
	#superclass : #DAPObject,
	#instVars : [
		'source',
		'sourceReference'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPSourceArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #source to: #source.
		mapping mapAccessor: #sourceReference to: #sourceReference.
		].

]

{ #category : #visiting }
DAPSourceArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitSourceArguments: self
]

{ #category : #accessing }
DAPSourceArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(source sourceReference )
]

{ #category : #accessing }
DAPSourceArguments >> source [
	"Specifies the source content to load. Either source.path or source.sourceReference must be specified.
	#/definitions/Source
	Auto-generated method"

	^ source
]

{ #category : #accessing }
DAPSourceArguments >> source: anObject [
	"Specifies the source content to load. Either source.path or source.sourceReference must be specified.
	#/definitions/Source
	Auto-generated method"

	source := anObject isDictionary ifTrue:
		[ DAPSource fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPSourceArguments >> sourceReference [
	"The reference to the source. This is the same as source.sourceReference.
This is provided for backward compatibility since old backends do not understand the 'source' attribute.
	integer
	Auto-generated method"

	^ sourceReference
]

{ #category : #accessing }
DAPSourceArguments >> sourceReference: anObject [
	"The reference to the source. This is the same as source.sourceReference.
This is provided for backward compatibility since old backends do not understand the 'source' attribute.
	integer
	Auto-generated method"

	sourceReference := anObject

]
