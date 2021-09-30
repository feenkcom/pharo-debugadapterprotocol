"
Optional properties of a variable that can be used to determine how to render the variable in the UI.

"
Class {
	#name : #DAPVariablePresentationHint,
	#superclass : #DAPObject,
	#instVars : [
		'attributes',
		'kind',
		'visibility'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPVariablePresentationHint class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #attributes to: #attributes.
		mapping mapAccessor: #kind to: #kind.
		mapping mapAccessor: #visibility to: #visibility.
		].

]

{ #category : #visiting }
DAPVariablePresentationHint >> acceptVisitor: aVisitor [

	^ aVisitor visitVariablePresentationHint: self
]

{ #category : #accessing }
DAPVariablePresentationHint >> attributes [
	"Set of attributes represented as an array of strings. Before introducing additional values, try to use the listed values.
	array
	Auto-generated method"

	^ attributes
]

{ #category : #accessing }
DAPVariablePresentationHint >> attributes: anObject [
	"Set of attributes represented as an array of strings. Before introducing additional values, try to use the listed values.
	array
	Auto-generated method"

	attributes := anObject

]

{ #category : #accessing }
DAPVariablePresentationHint >> kind [
	"The kind of variable. Before introducing additional values, try to use the listed values.
	string
	Auto-generated method"

	^ kind
]

{ #category : #accessing }
DAPVariablePresentationHint >> kind: anObject [
	"The kind of variable. Before introducing additional values, try to use the listed values.
	string
	Auto-generated method"

	kind := anObject

]

{ #category : #accessing }
DAPVariablePresentationHint >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(attributes kind visibility )
]

{ #category : #accessing }
DAPVariablePresentationHint >> visibility [
	"Visibility of variable. Before introducing additional values, try to use the listed values.
	string
	Auto-generated method"

	^ visibility
]

{ #category : #accessing }
DAPVariablePresentationHint >> visibility: anObject [
	"Visibility of variable. Before introducing additional values, try to use the listed values.
	string
	Auto-generated method"

	visibility := anObject

]
