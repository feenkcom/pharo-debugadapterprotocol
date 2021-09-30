"
Response to 'scopes' request.

"
Class {
	#name : #DAPScopesResponse,
	#superclass : #DAPResponse,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPScopesResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #visiting }
DAPScopesResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitScopesResponse: self
]

{ #category : #accessing }
DAPScopesResponse >> allScopes [
	"Answer an Array of DAPScope"

	^ self scopes collect: [ :each | DAPScope fromDictionary: each client: client ]
]

{ #category : #accessing }
DAPScopesResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPScopesResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #ui }
DAPScopesResponse >> gtScopesFor: aView [
	<gtView>

	self scopes ifEmpty: [ ^ aView empty ].
	^ aView list 
		title: 'Scopes';
		priority: 10;
		items: [ self allScopes ]
]

{ #category : #accessing }
DAPScopesResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body scopes )
]

{ #category : #accessing }
DAPScopesResponse >> scopes [
	"The scopes of the stackframe. If the array has length zero, there are no scopes available.
	array
	Auto-generated method"
	| result |

	result := self body at: #scopes ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPScopesResponse >> scopes: anObject [
	"The scopes of the stackframe. If the array has length zero, there are no scopes available.
	array
	Auto-generated method"

	self body at: #scopes put: anObject
]
