"
An ExceptionOptions assigns configuration options to a set of exceptions.

"
Class {
	#name : #DAPExceptionOptions,
	#superclass : #DAPObject,
	#instVars : [
		'breakMode',
		'path'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPExceptionOptions class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #breakMode to: #breakMode.
		mapping mapAccessor: #path to: #path.
		].

]

{ #category : #visiting }
DAPExceptionOptions >> acceptVisitor: aVisitor [

	^ aVisitor visitExceptionOptions: self
]

{ #category : #accessing }
DAPExceptionOptions >> breakMode [
	"Condition when a thrown exception should result in a break.
	#/definitions/ExceptionBreakMode
	Auto-generated method"

	^ breakMode
]

{ #category : #accessing }
DAPExceptionOptions >> breakMode: anObject [
	"Condition when a thrown exception should result in a break.
	#/definitions/ExceptionBreakMode
	Auto-generated method"

	breakMode := anObject isDictionary ifTrue:
		[ DAPExceptionBreakMode fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPExceptionOptions >> path [
	"A path that selects a single or multiple exceptions in a tree. If 'path' is missing, the whole tree is selected.
By convention the first segment of the path is a category that is used to group exceptions in the UI.
	array
	Auto-generated method"

	^ path
]

{ #category : #accessing }
DAPExceptionOptions >> path: anObject [
	"A path that selects a single or multiple exceptions in a tree. If 'path' is missing, the whole tree is selected.
By convention the first segment of the path is a category that is used to group exceptions in the UI.
	array
	Auto-generated method"

	path := anObject

]

{ #category : #accessing }
DAPExceptionOptions >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(breakMode path )
]
