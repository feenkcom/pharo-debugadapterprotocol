"
Arguments for 'modules' request.
"
Class {
	#name : #DAPModulesArguments,
	#superclass : #DAPObject,
	#instVars : [
		'moduleCount',
		'startModule'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPModulesArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #startModule to: #startModule.
		mapping mapAccessor: #moduleCount to: #moduleCount.
		].

]

{ #category : #visiting }
DAPModulesArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitModulesArguments: self
]

{ #category : #accessing }
DAPModulesArguments >> moduleCount [
	"The number of modules to return. If moduleCount is not specified or 0, all modules are returned.
	integer
	Auto-generated method"

	^ moduleCount
]

{ #category : #accessing }
DAPModulesArguments >> moduleCount: anObject [
	"The number of modules to return. If moduleCount is not specified or 0, all modules are returned.
	integer
	Auto-generated method"

	moduleCount := anObject

]

{ #category : #accessing }
DAPModulesArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(moduleCount startModule )
]

{ #category : #accessing }
DAPModulesArguments >> startModule [
	"The index of the first module to return; if omitted modules start at 0.
	integer
	Auto-generated method"

	^ startModule
]

{ #category : #accessing }
DAPModulesArguments >> startModule: anObject [
	"The index of the first module to return; if omitted modules start at 0.
	integer
	Auto-generated method"

	startModule := anObject

]
