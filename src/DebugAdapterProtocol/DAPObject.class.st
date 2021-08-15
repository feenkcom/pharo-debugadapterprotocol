Class {
	#name : 'DAPObject',
	#superclass : 'Object',
	#instVars : [
		'client'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPObject class >> dapJsonMappingFor: aNeoJSONMapper [
]

{ #category : 'requirements' }
DAPObject class >> empty [ 

	^ self new dictionary: Dictionary new.
]

{ #category : 'accessing' }
DAPObject class >> eventEnums [
	"Enumerated types for the associated attribute"

	^ #()
]

{ #category : 'instance creation' }
DAPObject class >> fromDictionary: aDictionary client: client [
	| instance |

	aDictionary ifNil: [ ^ nil ].
	instance := self new client: client.
	aDictionary keysAndValuesDo: [ :key :value |
		instance
			perform: (key, ':') asSymbol
			with: value ].
	^ instance.
]

{ #category : 'instance creation' }
DAPObject class >> fromJSONDictionary: aDictionary client: client [
	aDictionary at: #type ifPresent: [ :type |
		type = #event ifTrue:
			[ aDictionary at: #event ifPresent: [ :event |
				self allSubclasses 
					detect: [ :subcls | subcls eventEnums = { event } ]
					ifFound: [ :cls | ^ cls fromDictionary: aDictionary client: client ] ] ].
		type = #response ifTrue: 
			[ aDictionary at: #command ifPresent: [ :response | | cls |
				cls := self class environment at: ('DAP', response capitalized, 'Response') asSymbol.
				^ cls fromDictionary: aDictionary client: client ] ].
		type = #request ifTrue:
			[ aDictionary at: #command ifPresent: [ :request | | cls |
				cls := self class environment at: ('DAP', request capitalized, 'Request') asSymbol.
				^ cls fromDictionary: aDictionary client: client ] ] ].
	self error: 'Unrecognised message'.
]

{ #category : 'accessing' }
DAPObject class >> typeEnums [
	"Enumerated types for the associated attribute"

	^ #()
]

{ #category : 'accessing' }
DAPObject >> client [
	^ client
]

{ #category : 'accessing' }
DAPObject >> client: anObject [
	client := anObject
]

{ #category : 'accessing' }
DAPObject >> gtPropertiesFor: aView [
	<gtView>

	self propertyNames ifEmpty: [ ^ aView empty ].
	^ aView columnedList 
		title: 'Properties';
		priority: 20;
		items: [ self propertyNames collect: [ :name |
				{ name. self perform: name. } ] ];
		actionUpdateButtonTooltip: 'Update List';
		column: 'Name' text: [ :item | item first ];
		column: 'Value' text: [ :item | item second asString ];
		send: [ :item | item second ].
]

{ #category : 'accessing' }
DAPObject >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #()
]

{ #category : 'accessing' }
DAPObject >> request_seq [ 
	"Allow any message to answer a request_seq, which removes the need for type testing in the message processors"

	^ nil
]
