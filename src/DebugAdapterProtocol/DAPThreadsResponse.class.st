"
Response to 'threads' request.
"
Class {
	#name : #DAPThreadsResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPThreadsResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #visiting }
DAPThreadsResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitThreadsResponse: self
]

{ #category : #accessing }
DAPThreadsResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPThreadsResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPThreadsResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body threads )
]

{ #category : #accessing }
DAPThreadsResponse >> threads [
	"All threads.
	array
	Auto-generated method"
	| result |

	result := self body at: #threads ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPThreadsResponse >> threads: anObject [
	"All threads.
	array
	Auto-generated method"

	self body at: #threads put: anObject
]
