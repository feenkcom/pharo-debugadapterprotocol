"
Response to 'completions' request.

"
Class {
	#name : #DAPCompletionsResponse,
	#superclass : #DAPResponse,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPCompletionsResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #visiting }
DAPCompletionsResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitCompletionsResponse: self
]

{ #category : #accessing }
DAPCompletionsResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPCompletionsResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPCompletionsResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body targets )
]

{ #category : #accessing }
DAPCompletionsResponse >> targets [
	"The possible completions for .
	array
	Auto-generated method"
	| result |

	result := self body at: #targets ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPCompletionsResponse >> targets: anObject [
	"The possible completions for .
	array
	Auto-generated method"

	self body at: #targets put: anObject
]
