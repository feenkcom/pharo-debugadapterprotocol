Class {
	#name : #DebugAdapterProtocolDefinitionImporter,
	#superclass : #Object,
	#instVars : [
		'filename',
		'rootClass',
		'protocolDictionary',
		'classNamePrefix',
		'visitorMethods',
		'overwrite'
	],
	#category : 'DebugAdapterProtocol-Import'
}

{ #category : #private }
DebugAdapterProtocolDefinitionImporter >> addEnum: name definition: definition to: messageClass [
	"If the current method defines enums, add a class selector"
	| enums methodName source |

	enums := definition at: #enum ifAbsent: [ ^ self ].
	methodName := (name, 'Enums') asSymbol.
	(overwrite not and: [ messageClass class includesSelector: methodName ]) ifTrue: [ ^ self ].
	source := String streamContents: [ :stream |
		stream 
			<< methodName; cr;
			tab; << '"Enumerated types for the associated attribute"'; cr;
			cr;
			tab; << '^ #('.
		enums do: [ :enum |
			stream
				<< enum;
				space ].
		stream << ')' ].

	messageClass class compile: source.
	(messageClass class methodNamed: methodName) protocol: 'accessing'.

]

{ #category : #private }
DebugAdapterProtocolDefinitionImporter >> addJsonMapping: jsonDictionary to: aClass [
	"Add a method setting up the default mapping for the supplied class"
	| methodSource |

	(overwrite not and: [ aClass class includesSelector: #dapJsonMappingFor: ]) ifTrue: [ ^ self ].
	methodSource := String streamContents: [ :stream |
		stream 
			<< 'dapJsonMappingFor: aNeoJSONMapper'; cr;
			cr;
			tab; << 'super dapJsonMappingFor: aNeoJSONMapper.'; cr;
			tab; << 'aNeoJSONMapper for: self do: [ :mapping |'; cr.
		jsonDictionary keysAndValuesDo: [ :property :type |
			stream 
				tab; tab; << 'mapping mapAccessor: #';
				<< property;
				<< ' to: #';
				<< property;
				<< '.'; cr ].
		stream tab; tab; << '].'; cr ].

	aClass class compile: methodSource.
	(aClass class methodNamed: #'dapJsonMappingFor:') protocol: 'json - configuration'.

]

{ #category : #private }
DebugAdapterProtocolDefinitionImporter >> addMethod: name definition: definition to: messageClass jsonDictionary: jsonDictionary [
	"Add the supplied method"
	| getter setter methodComment type |

	(definition includesKey: #'$ref') ifTrue: 
		[ type := classNamePrefix, ($/ split: (definition at: '$ref')) last ].
	jsonDictionary at: name put: type.
	methodComment := self methodCommentFromDefinition: definition.

	(overwrite or: [ (messageClass includesSelector: name asSymbol) not ]) ifTrue:
		[ getter := self methodGetterFromNamed: name definition: definition comment: methodComment.
		messageClass compile: getter.
		(messageClass methodNamed: name asSymbol) protocol: 'accessing' ].

	(overwrite or: [ (messageClass includesSelector: (name, ':') asSymbol) not ]) ifTrue:
		[ setter := self methodSetterFromNamed: name definition: definition comment: methodComment.
		messageClass compile: setter.
		(messageClass methodNamed: (name,':') asSymbol) protocol: 'accessing' ].

	(definition at: #type ifAbsent: [ nil ]) = #object ifTrue:
		[ "The attribute is a dictionary, add getters and setters to the receiver's object"
		self addObjectAccessorsFor: name definition: definition to: messageClass ].

]

{ #category : #private }
DebugAdapterProtocolDefinitionImporter >> addObjectAccessorsFor: name attribute: attribute properties: properties to: messageClass [

	self addObjectGetterFor: name attribute: attribute properties: properties to: messageClass.
	self addObjectSetterFor: name attribute: attribute properties: properties to: messageClass.
]

{ #category : #private }
DebugAdapterProtocolDefinitionImporter >> addObjectAccessorsFor: name definition: definition to: messageClass [
	"Add accessors for the named object"

	"If properties aren't present, do nothing.
	There are #additionalProperties which are currently ignored."
	(definition at: #properties ifAbsent: [ Dictionary new ]) keysAndValuesDo: [ :attribute :properties |
		self addObjectAccessorsFor: name attribute: attribute properties: properties to: messageClass ].
]

{ #category : #private }
DebugAdapterProtocolDefinitionImporter >> addObjectGetterFor: name attribute: attribute properties: properties to: messageClass [
	| source |

	source := self methodObjectGetterFor: name attribute: attribute properties: properties.
	messageClass compile: source.
	(messageClass methodNamed: attribute asSymbol) protocol: 'accessing'.

]

{ #category : #private }
DebugAdapterProtocolDefinitionImporter >> addObjectSetterFor: name attribute: attribute properties: properties to: messageClass [
	| source |

	source := self methodObjectSetterFor: name attribute: attribute properties: properties.
	messageClass compile: source.
	(messageClass methodNamed: (attribute,':') asSymbol) protocol: 'accessing'.

]

{ #category : #accessing }
DebugAdapterProtocolDefinitionImporter >> classNamePrefix [
	^ classNamePrefix
]

{ #category : #accessing }
DebugAdapterProtocolDefinitionImporter >> classNamePrefix: anObject [
	classNamePrefix := anObject
]

{ #category : #private }
DebugAdapterProtocolDefinitionImporter >> defineMessage: message named: key [
	"Define and answer the class associated with the supplied message.
	If it already exists, use the existing definition."
	| classDictionary className newClass properties jsonDictionary newClassResults |

	className := (classNamePrefix, key) asSymbol.
	"className = #DAPModuleEvent ifTrue: [ self halt ]."
	message ifNil: 
		[ "This can happen if the protocol is being extended from a separate file.
		In that case, the superclass MUST already exist"
		^ self class environment at: className ].
	classDictionary := message.
	properties := classDictionary at: #properties ifAbsent: [ Dictionary new ].
	newClassResults := self getSuperclassOf: className message: message properties: properties classDictionary: classDictionary.
	newClass := newClassResults first. 
	classDictionary := newClassResults second. 
	properties := newClassResults third.

	jsonDictionary := Dictionary new.
	self 
		defineMethodsFrom: properties 
		to: newClass 
		required: (classDictionary at: #required ifAbsent: [ #() ])
		jsonDictionary: jsonDictionary.
	self defineVisitor: key in: newClass.
	properties keysDo: [ :property |
		jsonDictionary
			at: property
			ifAbsentPut: [ nil ] ].
	self addJsonMapping: jsonDictionary to: newClass.

	^ newClass
]

{ #category : #private }
DebugAdapterProtocolDefinitionImporter >> defineMethodsFrom: properties to: messageClass required: requiredProperties jsonDictionary: jsonDictionary [
	"Iterate over the supplied properties dictionary and add the methods to messageClass"

	properties keysAndValuesDo: [ :name :definition |
		self 
			addMethod: name 
			definition: definition 
			to: messageClass
			jsonDictionary: jsonDictionary.
		self
			addEnum: name 
			definition: definition 
			to: messageClass ].
	self definePropertyNamesMethodFrom: properties to: messageClass.
]

{ #category : #private }
DebugAdapterProtocolDefinitionImporter >> definePropertyNamesMethodFrom: properties to: messageClass [
	"Add a method that returns the names of all the interesting properties.
	This will then be used to create a general properties inspector view"
	| source propertyNames |

	propertyNames := OrderedCollection new.
	properties keysAndValuesDo: [ :key :value |
		propertyNames add: key.
		value at: #properties ifPresent:
			[ :subProperties |
				subProperties keysDo: [ :subProperty |
					propertyNames add: subProperty ] ] ].
	source := String streamContents: [ :stream |
		stream 
			<< 'propertyNames'; cr;
			tab; << '"Answer the names of all the receiver''s interesting properties"'; cr;
			cr;
			tab; << '^ #('.
		propertyNames sorted do: [ :property |
			stream
				<< property;
				<< ' ' ].
		stream << ')' ].
	messageClass compile: source.
	(messageClass methodNamed: #propertyNames) protocol: 'accessing'.

]

{ #category : #private }
DebugAdapterProtocolDefinitionImporter >> defineSuperclassFrom: classDictionary [
	| allOf superClassName superClass |

	classDictionary size = 1 ifFalse:
		[ self error: 'Expect a single entry for #allOf' ].
	allOf := classDictionary at: #allOf.
	superClassName := ($/ split: (allOf first at: '$ref')) last.
	superClass := self 
			defineMessage: ((self protocolDictionary at: #definitions) at: superClassName ifAbsent: [ nil ]) 
			named: superClassName.
	^ superClass.
]

{ #category : #private }
DebugAdapterProtocolDefinitionImporter >> defineVisitor: key in: messageClass [
	| source visitorMethod |

	(overwrite not and: [ messageClass includesSelector: #acceptVisitor: ]) ifTrue: [ ^ self ].
	visitorMethod := 'visit', key, ':'.
	source := String streamContents: [ :stream |
		stream 
			<< 'acceptVisitor: aVisitor'; cr;
			cr;
			tab; << '^ aVisitor ';
			<< visitorMethod;
			<< ' self' ].

	messageClass compile: source.
	(messageClass methodNamed: #acceptVisitor:) protocol: 'visiting'.

	visitorMethods add: visitorMethod.
]

{ #category : #private }
DebugAdapterProtocolDefinitionImporter >> defineVisitorTrait [
	"Define the trait for visiting the protocol"
	| trait source visitorMethodSymbol |

	trait := (self class environment includesKey: #TDAPProtocolVisitor) ifTrue: 
		[ self class environment at: #TDAPProtocolVisitor ]
	ifFalse:
		[ Trait named: #TDAPProtocolVisitor
			uses: { }
			package: 'DebugAdapterProtocol-Visitors' ].
	visitorMethods do: [ :visitorMethod |
		visitorMethodSymbol := visitorMethod asSymbol.
		(overwrite or: [ (trait includesSelector: visitorMethodSymbol) not ]) ifTrue:
			[ source := String streamContents: [ :stream |
				stream
					<< 	visitorMethod
					<< ' anObject'; cr;
					cr;
					tab; << '^ false halt' ].
			trait compile: source.
			(trait methodNamed: visitorMethodSymbol) protocol: 'visiting' ] ]
]

{ #category : #accessing }
DebugAdapterProtocolDefinitionImporter >> filename [
	^ filename
]

{ #category : #accessing }
DebugAdapterProtocolDefinitionImporter >> filename: aFileReference [

	filename := aFileReference asFileReference.
]

{ #category : #private }
DebugAdapterProtocolDefinitionImporter >> getSuperclassOf: className message: message properties: properties classDictionary: classDictionary [
	| newClass superClass existingInstanceVariables localClassDictionary localProperties instanceVariableNames |

	localClassDictionary := classDictionary.
	localProperties := properties.
	newClass := (overwrite not and: [ self class environment includesKey: className ]) ifTrue:
		[ self class environment at: className ]
	ifFalse:
		[ superClass := rootClass.
		(classDictionary includesKey: #allOf) ifTrue: 
			[ superClass := self defineSuperclassFrom: classDictionary.
			localClassDictionary := (localClassDictionary at: #allOf) second ].

		localProperties := localClassDictionary at: #properties ifAbsent: [ Dictionary new ].
		existingInstanceVariables := Set new.
		superClass withAllSuperclassesDo: [ :cls |
			existingInstanceVariables addAll: cls instVarNames ].
		instanceVariableNames := localProperties keys asSet difference: existingInstanceVariables.

		"If overwriting, keep all existing instance variable names"
		overwrite ifTrue:
			[ self class environment at: className ifPresent: [ :cls |
				instanceVariableNames addAll: cls instVarNames ] ].

		(superClass subclass: className
			instanceVariableNames: (' ' join: instanceVariableNames sorted)
			classVariableNames: ''
			package: 'DebugAdapterProtocol-Protocol')
			comment: (localClassDictionary at: #description);
			yourself ].

	^ { newClass. localClassDictionary. localProperties. }
]

{ #category : #initialization }
DebugAdapterProtocolDefinitionImporter >> initialize [ 

	super initialize.
	filename := '/home/alistair/python/conda1/debugProtocol.json' asFileReference.
	rootClass := DAPObject.
	classNamePrefix := 'DAP'.
	visitorMethods := OrderedCollection new.
	overwrite := false.
]

{ #category : #private }
DebugAdapterProtocolDefinitionImporter >> methodCommentFromDefinition: definition [
	"Answer a method comment based on the supplied property defintion"
	| enums enumDescriptions |

	^ String streamContents: [ :stream |
		stream 
			tab;
			<< '"'.
		(definition includesKey: #description) ifTrue:
			[ stream
				<< (definition at: #description); cr; tab;
				<< (definition at: #type ifAbsent: [ definition at: #'$ref' ]);
				cr; tab ].
		(definition includesKey: #enum) ifTrue:
			[ enums := definition at: #enum.
			enumDescriptions := definition at: #enumDescriptions 
					ifAbsent: [ Array new: enums size withAll: '' ].
			enums doWithIndex: [ :enum :index |
				stream 
					<< enum;
					<< ': ';
					<< (enumDescriptions at: index);
					cr; tab ] ].
		stream << 'Auto-generated method'.
		"stream peekLast = Character tab ifTrue:
			[ stream position: stream position - 2 ]."
		stream << '"' ].

]

{ #category : #private }
DebugAdapterProtocolDefinitionImporter >> methodGetterFromNamed: name definition: definition comment: methodComment [
	| enum |

	^ String streamContents: [ :stream |
		stream
			<< name; cr;
			<< methodComment; cr;
			cr; tab;
			<< '^ ';
			<< name.
		enum := definition at: #enum ifAbsent: [ #() ].
		enum ifNotEmpty: 
			[ stream 
				<< ' ifNil: [ ''';
				<< enum first;
				<< ''' ]' ] ].

]

{ #category : #private }
DebugAdapterProtocolDefinitionImporter >> methodObjectGetterFor: name attribute: attribute properties: properties [
	| enum refClass |

	(properties includesKey: #'$ref') ifTrue: 
		[ refClass := classNamePrefix, ($/ split: (properties at: #'$ref')) last. ].
	^ String streamContents: [ :stream |
		stream
			<< attribute; cr;
			<< (self methodCommentFromDefinition: properties); cr;
			tab; << '| result |'; cr;
			cr;
			tab; << 'result := self ';
				<< name;
				<< ' at: #';
				<< attribute;
				<< ' ifAbsent: [ nil ].'; cr.
		refClass ifNotNil:
			[ stream
				tab; << 'result isDictionary ifTrue:'; cr;
				tab; tab; << '[ result := ';
					<< refClass;
					<< ' fromDictionary: result client: client ].'; cr ].
		enum := properties at: #enum ifAbsent: [ #() ].
		enum ifNotEmpty: 
			[ stream 
				tab; << 'result ifNil:'; cr;
				tab; tab; << '[ result := ''';
					<< enum first;
					<< ''' ].'; cr ].
		stream
			tab; << '^ result' ].

]

{ #category : #private }
DebugAdapterProtocolDefinitionImporter >> methodObjectSetterFor: name attribute: attribute properties: properties [
	"Answer the source code for setting an embedded object.
	Doesn't handle nesting of dictionary objects."

	^ String streamContents: [ :stream |
		stream
			<< attribute; 
			<< ': anObject'; cr;
			<< (self methodCommentFromDefinition: properties); cr;
			cr; tab;
			<< 'self ';
			<< name;
			<< ' at: #';
			<< attribute;
			<< ' put: anObject' ].

]

{ #category : #private }
DebugAdapterProtocolDefinitionImporter >> methodSetterFromNamed: name definition: definition comment: methodComment [
	| refClass |

	^ String streamContents: [ :stream |
		stream
			<< name; 
			<< ': anObject'; cr;
			<< methodComment; cr;
			cr.
		(definition includesKey: #'$ref' ) ifTrue: 
			[ refClass := classNamePrefix, ($/ split: (definition at: #'$ref')) last.
			stream
				tab; << name;
					<< ' := anObject isDictionary ifTrue:'; cr;
				tab; tab; << '[ ';
					<< refClass;
					<< ' fromDictionary: anObject client: client ]'; cr;
				tab; << 'ifFalse:'; cr;
				tab; tab; << '[ anObject ]'; cr ]
		ifFalse:
			[ stream
				tab; << name;
					<< ' := anObject'; cr ] ].
]

{ #category : #accessing }
DebugAdapterProtocolDefinitionImporter >> overwrite [
	"Answer a boolean indicating whether existing definitions should be overwritten"
	<return: #Boolean>

	^ overwrite
]

{ #category : #accessing }
DebugAdapterProtocolDefinitionImporter >> overwrite: anObject [
	overwrite := anObject
]

{ #category : #accessing }
DebugAdapterProtocolDefinitionImporter >> protocolDictionary [
	"Answer the dictionary containing the entire protocol"

	^ protocolDictionary ifNil: [ protocolDictionary := STONJSON fromString: filename contents ]
]

{ #category : #'private - preparation' }
DebugAdapterProtocolDefinitionImporter >> removeClass: aClass [ 

	aClass subclasses do: [ :cls |
		self removeClass: cls ].
	aClass removeFromSystem.
]

{ #category : #preparation }
DebugAdapterProtocolDefinitionImporter >> removeGeneratedClasses [
	"Remove all the previously generated classes, i.e. subclasses of rootClass.
	This must be called manually."

	self removeSubclassesOf: rootClass.
	TDAPProtocolVisitor methodDict keysDo: [ :key |
		TDAPProtocolVisitor removeSelector: key ].
]

{ #category : #'private - preparation' }
DebugAdapterProtocolDefinitionImporter >> removeSubclassesOf: aClass [ 

	aClass subclasses do: [ :cls |
		self removeClass: cls ].

]

{ #category : #accessing }
DebugAdapterProtocolDefinitionImporter >> rootClass [
	^ rootClass
]

{ #category : #accessing }
DebugAdapterProtocolDefinitionImporter >> rootClass: anObject [
	rootClass := anObject
]

{ #category : #running }
DebugAdapterProtocolDefinitionImporter >> run [ 
	"Iterate over the protocol dictionary and generate the required classes.
	If a class already exists, use the existing definition"
	| definitions |

	definitions := self protocolDictionary at: #definitions.
	definitions keysAndValuesDo: [ :key :value | self defineMessage: value named: key ].
	self defineVisitorTrait.
]
