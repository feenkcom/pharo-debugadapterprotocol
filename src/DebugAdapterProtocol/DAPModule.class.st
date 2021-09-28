"
A Module object represents a row in the modules view.
Two attributes are mandatory: an id identifies a module in the modules view and is used in a ModuleEvent for identifying a module for adding, updating or deleting.
The name is used to minimally render the module in the UI.

Additional attributes can be added to the module. They will show up in the module View if they have a corresponding ColumnDescriptor.

To avoid an unnecessary proliferation of additional attributes with similar semantics but different names
we recommend to re-use attributes from the 'recommended' list below first, and only introduce new attributes if nothing appropriate could be found.

"
Class {
	#name : #DAPModule,
	#superclass : #DAPObject,
	#instVars : [
		'addressRange',
		'dateTimeStamp',
		'id',
		'isOptimized',
		'isUserCode',
		'name',
		'package',
		'path',
		'symbolFilePath',
		'symbolStatus',
		'version',
		'vsIs64Bit',
		'vsModuleSize',
		'vsLoadAddress',
		'vsTimestampUTC',
		'vsPreferredLoadAddress',
		'vsLoadOrder'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPModule class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #addressRange to: #addressRange.
		mapping mapAccessor: #symbolFilePath to: #symbolFilePath.
		mapping mapAccessor: #symbolStatus to: #symbolStatus.
		mapping mapAccessor: #version to: #version.
		mapping mapAccessor: #path to: #path.
		mapping mapAccessor: #id to: #id.
		mapping mapAccessor: #name to: #name.
		mapping mapAccessor: #isUserCode to: #isUserCode.
		mapping mapAccessor: #isOptimized to: #isOptimized.
		mapping mapAccessor: #package to: #package.
		mapping mapAccessor: #dateTimeStamp to: #dateTimeStamp.
		].

]

{ #category : #visiting }
DAPModule >> acceptVisitor: aVisitor [

	^ aVisitor visitModule: self
]

{ #category : #accessing }
DAPModule >> addressRange [
	"Address range covered by this module.
	string
	Auto-generated method"

	^ addressRange
]

{ #category : #accessing }
DAPModule >> addressRange: anObject [
	"Address range covered by this module.
	string
	Auto-generated method"

	addressRange := anObject

]

{ #category : #accessing }
DAPModule >> dateTimeStamp [
	"Module created or modified.
	string
	Auto-generated method"

	^ dateTimeStamp
]

{ #category : #accessing }
DAPModule >> dateTimeStamp: anObject [
	"Module created or modified.
	string
	Auto-generated method"

	dateTimeStamp := anObject

]

{ #category : #ui }
DAPModule >> gtSourceFor: aView [
	<gtView>
	| fileReference |

	path ifNil: [ ^ aView empty ].
	fileReference := path asFileReference.
	fileReference isReadable ifFalse: [ ^ aView empty ].
	^ aView forward 
		title: 'Source';
		priority: 10;
		object: [ fileReference ];
		view: #gtStyledCodeFor:.
]

{ #category : #accessing }
DAPModule >> id [
	"Unique identifier for the module.
	integerstring
	Auto-generated method"

	^ id
]

{ #category : #accessing }
DAPModule >> id: anObject [
	"Unique identifier for the module.
	integerstring
	Auto-generated method"

	id := anObject

]

{ #category : #accessing }
DAPModule >> isOptimized [
	"True if the module is optimized.
	boolean
	Auto-generated method"

	^ isOptimized
]

{ #category : #accessing }
DAPModule >> isOptimized: anObject [
	"True if the module is optimized.
	boolean
	Auto-generated method"

	isOptimized := anObject

]

{ #category : #accessing }
DAPModule >> isUserCode [
	"True if the module is considered 'user code' by a debugger that supports 'Just My Code'.
	boolean
	Auto-generated method"

	^ isUserCode
]

{ #category : #accessing }
DAPModule >> isUserCode: anObject [
	"True if the module is considered 'user code' by a debugger that supports 'Just My Code'.
	boolean
	Auto-generated method"

	isUserCode := anObject

]

{ #category : #accessing }
DAPModule >> name [
	"A name of the module.
	string
	Auto-generated method"

	^ name
]

{ #category : #accessing }
DAPModule >> name: anObject [
	"A name of the module.
	string
	Auto-generated method"

	name := anObject

]

{ #category : #accessing }
DAPModule >> package [
	"The package that owns the module.
	string
	Auto-generated method"

	^ package
]

{ #category : #accessing }
DAPModule >> package: anObject [
	"The package that owns the module.
	string
	Auto-generated method"

	package := anObject

]

{ #category : #accessing }
DAPModule >> path [
	"optional but recommended attributes.
always try to use these first before introducing additional attributes.

Logical full path to the module. The exact definition is implementation defined, but usually this would be a full path to the on-disk file for the module.
	string
	Auto-generated method"

	^ path
]

{ #category : #accessing }
DAPModule >> path: anObject [
	"optional but recommended attributes.
always try to use these first before introducing additional attributes.

Logical full path to the module. The exact definition is implementation defined, but usually this would be a full path to the on-disk file for the module.
	string
	Auto-generated method"

	path := anObject

]

{ #category : #printing }
DAPModule >> printOn: aStream [

	aStream
		<< 'Module: ';
		print: name
]

{ #category : #accessing }
DAPModule >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(addressRange dateTimeStamp id isOptimized isUserCode name package path symbolFilePath symbolStatus version )
]

{ #category : #accessing }
DAPModule >> symbolFilePath [
	"Logical full path to the symbol file. The exact definition is implementation defined.
	string
	Auto-generated method"

	^ symbolFilePath
]

{ #category : #accessing }
DAPModule >> symbolFilePath: anObject [
	"Logical full path to the symbol file. The exact definition is implementation defined.
	string
	Auto-generated method"

	symbolFilePath := anObject

]

{ #category : #accessing }
DAPModule >> symbolStatus [
	"User understandable description of if symbols were found for the module (ex: 'Symbols Loaded', 'Symbols not found', etc.
	string
	Auto-generated method"

	^ symbolStatus
]

{ #category : #accessing }
DAPModule >> symbolStatus: anObject [
	"User understandable description of if symbols were found for the module (ex: 'Symbols Loaded', 'Symbols not found', etc.
	string
	Auto-generated method"

	symbolStatus := anObject

]

{ #category : #accessing }
DAPModule >> version [
	"Version of Module.
	string
	Auto-generated method"

	^ version
]

{ #category : #accessing }
DAPModule >> version: anObject [
	"Version of Module.
	string
	Auto-generated method"

	version := anObject

]

{ #category : #accessing }
DAPModule >> vsIs64Bit [
	^ vsIs64Bit
]

{ #category : #accessing }
DAPModule >> vsIs64Bit: anObject [
	vsIs64Bit := anObject
]

{ #category : #accessing }
DAPModule >> vsLoadAddress [
	^ vsLoadAddress
]

{ #category : #accessing }
DAPModule >> vsLoadAddress: anObject [
	vsLoadAddress := anObject
]

{ #category : #accessing }
DAPModule >> vsLoadOrder [
	^ vsLoadOrder
]

{ #category : #accessing }
DAPModule >> vsLoadOrder: anObject [
	vsLoadOrder := anObject
]

{ #category : #accessing }
DAPModule >> vsModuleSize [
	^ vsModuleSize
]

{ #category : #accessing }
DAPModule >> vsModuleSize: anObject [
	vsModuleSize := anObject
]

{ #category : #accessing }
DAPModule >> vsPreferredLoadAddress [
	^ vsPreferredLoadAddress
]

{ #category : #accessing }
DAPModule >> vsPreferredLoadAddress: anObject [
	vsPreferredLoadAddress := anObject
]

{ #category : #accessing }
DAPModule >> vsTimestampUTC [
	^ vsTimestampUTC
]

{ #category : #accessing }
DAPModule >> vsTimestampUTC: anObject [
	vsTimestampUTC := anObject
]
