"
Response to 'variables' request.
"
Class {
	#name : #DAPVariablesResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPVariablesResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #visiting }
DAPVariablesResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitVariablesResponse: self
]

{ #category : #accessing }
DAPVariablesResponse >> allVariables [
	"Answer an Array of DAPVariable"

	^ self variables collect: [ :each | DAPVariable fromDictionary: each client: client ]
]

{ #category : #accessing }
DAPVariablesResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPVariablesResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #ui }
DAPVariablesResponse >> gtVariablesFor: aView [
	<gtView>

	self variables ifEmpty: [ ^ aView empty ].
	^ aView columnedList
		title: 'Variables';
		priority: 20;
		items: [ self allVariables ];
		column: 'Name' text: [ :item | item name ];
		column: 'Value' text: [ :item | item value ]
]

{ #category : #accessing }
DAPVariablesResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body variables )
]

{ #category : #accessing }
DAPVariablesResponse >> variables [
	"All (or a range) of variables for the given variable reference.
	array
	Auto-generated method"
	| result |

	result := self body ifNotNil: [ :anObject | anObject at: #variables ifAbsent: [ nil ] ].
	^ result
]

{ #category : #accessing }
DAPVariablesResponse >> variables: anObject [
	"All (or a range) of variables for the given variable reference.
	array
	Auto-generated method"

	self body at: #variables put: anObject
]
