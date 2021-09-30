"
The ModulesViewDescriptor is the container for all declarative configuration options of a ModuleView.
For now it only specifies the columns to be shown in the modules view.

"
Class {
	#name : #DAPModulesViewDescriptor,
	#superclass : #DAPObject,
	#instVars : [
		'columns'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPModulesViewDescriptor class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #columns to: #columns.
		].

]

{ #category : #visiting }
DAPModulesViewDescriptor >> acceptVisitor: aVisitor [

	^ aVisitor visitModulesViewDescriptor: self
]

{ #category : #accessing }
DAPModulesViewDescriptor >> columns [
	"Auto-generated method"

	^ columns
]

{ #category : #accessing }
DAPModulesViewDescriptor >> columns: anObject [
	"Auto-generated method"

	columns := anObject

]

{ #category : #accessing }
DAPModulesViewDescriptor >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(columns )
]
