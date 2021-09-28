"
The event indicates that some information about a module has changed.

"
Class {
	#name : #DAPModuleEvent,
	#superclass : #DAPEvent,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPModuleEvent class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #event to: #event.
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #accessing }
DAPModuleEvent class >> eventEnums [
	"Enumerated types for the associated attribute"

	^ #(module )
]

{ #category : #visiting }
DAPModuleEvent >> acceptVisitor: aVisitor [

	^ aVisitor visitModuleEvent: self
]

{ #category : #accessing }
DAPModuleEvent >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPModuleEvent >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPModuleEvent >> event [
	"module: 
	Auto-generated method"

	^ event ifNil: [ 'module' ]
]

{ #category : #accessing }
DAPModuleEvent >> event: anObject [
	"module: 
	Auto-generated method"

	event := anObject

]

{ #category : #accessing }
DAPModuleEvent >> module [
	"The new, changed, or removed module. In case of 'removed' only the module id is used.
	#/definitions/Module
	Auto-generated method"
	| result |

	result := self body at: #module ifAbsent: [ nil ].
	result isDictionary ifTrue:
		[ result := DAPModule fromDictionary: result client: client ].
	^ result
]

{ #category : #accessing }
DAPModuleEvent >> module: anObject [
	"The new, changed, or removed module. In case of 'removed' only the module id is used.
	#/definitions/Module
	Auto-generated method"

	self body at: #module put: anObject
]

{ #category : #printing }
DAPModuleEvent >> printOn: aStream [

	aStream 
		<< 'Module ';
		print: self reason.
	
	self module ifNotNil: [ :module |
		module name ifNotNil: [ :name |
			aStream
				<< ': ';
				<< name ] ]
]

{ #category : #accessing }
DAPModuleEvent >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body event module reason )
]

{ #category : #accessing }
DAPModuleEvent >> reason [
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
DAPModuleEvent >> reason: anObject [
	"The reason for the event.
	string
	new: 
	changed: 
	removed: 
	Auto-generated method"

	self body at: #reason put: anObject
]
