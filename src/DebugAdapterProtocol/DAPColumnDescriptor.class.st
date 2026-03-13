"
A ColumnDescriptor specifies what module attribute to show in a column of the ModulesView, how to format it,
and what the column's label should be.
It is only used if the underlying UI actually supports this level of customization.

"
Class {
	#name : #DAPColumnDescriptor,
	#superclass : #DAPObject,
	#instVars : [
		'attributeName',
		'format',
		'label',
		'type',
		'width'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPColumnDescriptor class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #format to: #format.
		mapping mapAccessor: #attributeName to: #attributeName.
		mapping mapAccessor: #type to: #type.
		mapping mapAccessor: #label to: #label.
		mapping mapAccessor: #width to: #width.
		].

]

{ #category : #accessing }
DAPColumnDescriptor class >> typeEnums [
	"Enumerated types for the associated attribute"

	^ #(string number boolean unixTimestampUTC )
]

{ #category : #visiting }
DAPColumnDescriptor >> acceptVisitor: aVisitor [

	^ aVisitor visitColumnDescriptor: self
]

{ #category : #accessing }
DAPColumnDescriptor >> attributeName [
	"Name of the attribute rendered in this column.
	string
	Auto-generated method"

	^ attributeName
]

{ #category : #accessing }
DAPColumnDescriptor >> attributeName: anObject [
	"Name of the attribute rendered in this column.
	string
	Auto-generated method"

	attributeName := anObject

]

{ #category : #accessing }
DAPColumnDescriptor >> format [
	"Format to use for the rendered values in this column. TBD how the format strings looks like.
	string
	Auto-generated method"

	^ format
]

{ #category : #accessing }
DAPColumnDescriptor >> format: anObject [
	"Format to use for the rendered values in this column. TBD how the format strings looks like.
	string
	Auto-generated method"

	format := anObject

]

{ #category : #accessing }
DAPColumnDescriptor >> label [
	"Header UI label of column.
	string
	Auto-generated method"

	^ label
]

{ #category : #accessing }
DAPColumnDescriptor >> label: anObject [
	"Header UI label of column.
	string
	Auto-generated method"

	label := anObject

]

{ #category : #accessing }
DAPColumnDescriptor >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(attributeName format label type width )
]

{ #category : #accessing }
DAPColumnDescriptor >> type [
	"Datatype of values in this column.  Defaults to 'string' if not specified.
	string
	string: 
	number: 
	boolean: 
	unixTimestampUTC: 
	Auto-generated method"

	^ type ifNil: [ 'string' ]
]

{ #category : #accessing }
DAPColumnDescriptor >> type: anObject [
	"Datatype of values in this column.  Defaults to 'string' if not specified.
	string
	string: 
	number: 
	boolean: 
	unixTimestampUTC: 
	Auto-generated method"

	type := anObject

]

{ #category : #accessing }
DAPColumnDescriptor >> width [
	"Width of this column in characters (hint only).
	integer
	Auto-generated method"

	^ width
]

{ #category : #accessing }
DAPColumnDescriptor >> width: anObject [
	"Width of this column in characters (hint only).
	integer
	Auto-generated method"

	width := anObject

]
