"
The event indicates that some source has been added, changed, or removed from the set of all loaded sources.
"
Class {
	#name : #DAPLoadedSourceEvent,
	#superclass : #DAPEvent,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPLoadedSourceEvent class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #event to: #event.
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #accessing }
DAPLoadedSourceEvent class >> eventEnums [
	"Enumerated types for the associated attribute"

	^ #(loadedSource )
]

{ #category : #visiting }
DAPLoadedSourceEvent >> acceptVisitor: aVisitor [

	^ aVisitor visitLoadedSourceEvent: self
]

{ #category : #accessing }
DAPLoadedSourceEvent >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPLoadedSourceEvent >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPLoadedSourceEvent >> event [
	"loadedSource: 
	Auto-generated method"

	^ event ifNil: [ 'loadedSource' ]
]

{ #category : #accessing }
DAPLoadedSourceEvent >> event: anObject [
	"loadedSource: 
	Auto-generated method"

	event := anObject

]

{ #category : #accessing }
DAPLoadedSourceEvent >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body event reason source )
]

{ #category : #accessing }
DAPLoadedSourceEvent >> reason [
	"The reason for the event.
	string
	new: 
	changed: 
	removed: 
	Auto-generated method"
	| result |

	result := self body at: #reason ifAbsent: [ nil ].
	result ifNil:
		[ result := 'new' ].
	^ result
]

{ #category : #accessing }
DAPLoadedSourceEvent >> reason: anObject [
	"The reason for the event.
	string
	new: 
	changed: 
	removed: 
	Auto-generated method"

	self body at: #reason put: anObject
]

{ #category : #accessing }
DAPLoadedSourceEvent >> source [
	"The new, changed, or removed source.
	#/definitions/Source
	Auto-generated method"
	| result |

	result := self body at: #source ifAbsent: [ nil ].
	result isDictionary ifTrue:
		[ result := DAPSource fromDictionary: result client: client ].
	^ result
]

{ #category : #accessing }
DAPLoadedSourceEvent >> source: anObject [
	"The new, changed, or removed source.
	#/definitions/Source
	Auto-generated method"

	self body at: #source put: anObject
]
