"
Response to 'source' request.

"
Class {
	#name : #DAPSourceResponse,
	#superclass : #DAPResponse,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPSourceResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #visiting }
DAPSourceResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitSourceResponse: self
]

{ #category : #accessing }
DAPSourceResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPSourceResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPSourceResponse >> content [
	"Content of the source reference.
	string
	Auto-generated method"
	| result |

	result := self body at: #content ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPSourceResponse >> content: anObject [
	"Content of the source reference.
	string
	Auto-generated method"

	self body at: #content put: anObject
]

{ #category : #accessing }
DAPSourceResponse >> mimeType [
	"Optional content type (mime type) of the source.
	string
	Auto-generated method"
	| result |

	result := self body at: #mimeType ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPSourceResponse >> mimeType: anObject [
	"Optional content type (mime type) of the source.
	string
	Auto-generated method"

	self body at: #mimeType put: anObject
]

{ #category : #accessing }
DAPSourceResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body content mimeType )
]
