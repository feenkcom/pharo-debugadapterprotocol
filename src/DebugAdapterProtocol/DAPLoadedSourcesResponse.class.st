"
Response to 'loadedSources' request.

"
Class {
	#name : #DAPLoadedSourcesResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPLoadedSourcesResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #visiting }
DAPLoadedSourcesResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitLoadedSourcesResponse: self
]

{ #category : #accessing }
DAPLoadedSourcesResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPLoadedSourcesResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPLoadedSourcesResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body sources )
]

{ #category : #accessing }
DAPLoadedSourcesResponse >> sources [
	"Set of loaded sources.
	array
	Auto-generated method"
	| result |

	result := self body at: #sources ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPLoadedSourcesResponse >> sources: anObject [
	"Set of loaded sources.
	array
	Auto-generated method"

	self body at: #sources put: anObject
]
