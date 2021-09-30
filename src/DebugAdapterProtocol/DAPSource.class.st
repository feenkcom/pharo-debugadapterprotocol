"
A Source is a descriptor for source code.
It is returned from the debug adapter as part of a StackFrame and it is used by clients when specifying breakpoints.

"
Class {
	#name : #DAPSource,
	#superclass : #DAPObject,
	#instVars : [
		'adapterData',
		'checksums',
		'name',
		'origin',
		'path',
		'presentationHint',
		'sourceCode',
		'sourceReference',
		'sources'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPSource class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #checksums to: #checksums.
		mapping mapAccessor: #presentationHint to: #presentationHint.
		mapping mapAccessor: #sources to: #sources.
		mapping mapAccessor: #origin to: #origin.
		mapping mapAccessor: #sourceReference to: #sourceReference.
		mapping mapAccessor: #path to: #path.
		mapping mapAccessor: #name to: #name.
		mapping mapAccessor: #adapterData to: #adapterData.
		].

]

{ #category : #accessing }
DAPSource class >> presentationHintEnums [
	"Enumerated types for the associated attribute"

	^ #(normal emphasize deemphasize )
]

{ #category : #visiting }
DAPSource >> acceptVisitor: aVisitor [

	^ aVisitor visitSource: self
]

{ #category : #accessing }
DAPSource >> adapterData [
	"Optional data that a debug adapter might want to loop through the client.
The client should leave the data intact and persist it across sessions. The client should not interpret the data.
	arraybooleanintegernullnumberobjectstring
	Auto-generated method"

	^ adapterData
]

{ #category : #accessing }
DAPSource >> adapterData: anObject [
	"Optional data that a debug adapter might want to loop through the client.
The client should leave the data intact and persist it across sessions. The client should not interpret the data.
	arraybooleanintegernullnumberobjectstring
	Auto-generated method"

	adapterData := anObject

]

{ #category : #accessing }
DAPSource >> checksums [
	"The checksums associated with this file.
	array
	Auto-generated method"

	^ checksums
]

{ #category : #accessing }
DAPSource >> checksums: anObject [
	"The checksums associated with this file.
	array
	Auto-generated method"

	checksums := anObject

]

{ #category : #ui }
DAPSource >> gtSourceFor: aView [
	<gtView>
	| view |

	client ifNil: [ ^ aView empty ].
	view := aView textEditor
		title: 'Source';
		priority: 100;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self sourceCode asRopedText ];
		actionUpdateButtonTooltip: 'Update Source'.
	self gtStyler ifNotNil: [ :gtStyler |
		view styler: gtStyler ].
	^ view

]

{ #category : #private }
DAPSource >> gtStyler [ 
	"Answer the styler to be used for the receiver"
	| dotExtension parser |

	(self path isNil or: [ self path isEmpty ]) ifTrue: [ ^ nil ].
	dotExtension := '.' , self path extension.
	parser := SmaCCParser allSubclasses
				detect: [ :each | each fileExtensions includes: dotExtension ]
				ifNone: [ ^ nil ].
	^ parser ifNotNil: [ parser gtStyler ]
]

{ #category : #accessing }
DAPSource >> name [
	"The short name of the source. Every source returned from the debug adapter has a name.
When sending a source to the debug adapter this name is optional.
	string
	Auto-generated method"

	^ name
]

{ #category : #accessing }
DAPSource >> name: anObject [
	"The short name of the source. Every source returned from the debug adapter has a name.
When sending a source to the debug adapter this name is optional.
	string
	Auto-generated method"

	name := anObject

]

{ #category : #accessing }
DAPSource >> origin [
	"The (optional) origin of this source: possible values 'internal module', 'inlined content from source map', etc.
	string
	Auto-generated method"

	^ origin
]

{ #category : #accessing }
DAPSource >> origin: anObject [
	"The (optional) origin of this source: possible values 'internal module', 'inlined content from source map', etc.
	string
	Auto-generated method"

	origin := anObject

]

{ #category : #accessing }
DAPSource >> path [
	"The path of the source to be shown in the UI.
It is only used to locate and load the content of the source if no sourceReference is specified (or its value is 0).
	string
	Auto-generated method"

	^ path
]

{ #category : #accessing }
DAPSource >> path: anObject [
	"The path of the source to be shown in the UI.
It is only used to locate and load the content of the source if no sourceReference is specified (or its value is 0).
	string
	Auto-generated method"

	path := anObject

]

{ #category : #accessing }
DAPSource >> presentationHint [
	"An optional hint for how to present the source in the UI.
A value of 'deemphasize' can be used to indicate that the source is not available or that it is skipped on stepping.
	string
	normal: 
	emphasize: 
	deemphasize: 
	Auto-generated method"

	^ presentationHint ifNil: [ 'normal' ]
]

{ #category : #accessing }
DAPSource >> presentationHint: anObject [
	"An optional hint for how to present the source in the UI.
A value of 'deemphasize' can be used to indicate that the source is not available or that it is skipped on stepping.
	string
	normal: 
	emphasize: 
	deemphasize: 
	Auto-generated method"

	presentationHint := anObject

]

{ #category : #accessing }
DAPSource >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(adapterData checksums name origin path presentationHint sourceReference sources )
]

{ #category : #accessing }
DAPSource >> sourceCode [ 
	"Answer the receiver's source code.
	For now, cheat, if the debug server won't get it and we have access, load directly from the file."

	^ sourceCode ifNil: [ sourceCode := [ client sourceCodeFor: self ]
		on: DAPBadResponse 
		do: [ :ex | | fileReference |
			fileReference := path asFileReference.
			fileReference isReadable 
				ifTrue: [ fileReference contents ]
				ifFalse: [ 'N/A' ] ] ]
]

{ #category : #accessing }
DAPSource >> sourceReference [
	"If sourceReference > 0 the contents of the source must be retrieved through the SourceRequest (even if a path is specified).
A sourceReference is only valid for a session, so it must not be used to persist a source.
The value should be less than or equal to 2147483647 (2^31-1).
	integer
	Auto-generated method"

	^ sourceReference
]

{ #category : #accessing }
DAPSource >> sourceReference: anObject [
	"If sourceReference > 0 the contents of the source must be retrieved through the SourceRequest (even if a path is specified).
A sourceReference is only valid for a session, so it must not be used to persist a source.
The value should be less than or equal to 2147483647 (2^31-1).
	integer
	Auto-generated method"

	sourceReference := anObject

]

{ #category : #accessing }
DAPSource >> sources [
	"An optional list of sources that are related to this source. These may be the source that generated this source.
	array
	Auto-generated method"

	^ sources
]

{ #category : #accessing }
DAPSource >> sources: anObject [
	"An optional list of sources that are related to this source. These may be the source that generated this source.
	array
	Auto-generated method"

	sources := anObject

]
