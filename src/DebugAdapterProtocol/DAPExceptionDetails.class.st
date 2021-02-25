"
Detailed information about an exception that has occurred.
"
Class {
	#name : #DAPExceptionDetails,
	#superclass : #DAPObject,
	#instVars : [
		'stackTrace',
		'message',
		'fullTypeName',
		'innerException',
		'evaluateName',
		'typeName'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPExceptionDetails class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #stackTrace to: #stackTrace.
		mapping mapAccessor: #fullTypeName to: #fullTypeName.
		mapping mapAccessor: #message to: #message.
		mapping mapAccessor: #innerException to: #innerException.
		mapping mapAccessor: #evaluateName to: #evaluateName.
		mapping mapAccessor: #typeName to: #typeName.
		].

]

{ #category : #visiting }
DAPExceptionDetails >> acceptVisitor: aVisitor [

	^ aVisitor visitExceptionDetails: self
]

{ #category : #accessing }
DAPExceptionDetails >> evaluateName [
	"Optional expression that can be evaluated in the current scope to obtain the exception object.
	string
	Auto-generated method"

	^ evaluateName
]

{ #category : #accessing }
DAPExceptionDetails >> evaluateName: anObject [
	"Optional expression that can be evaluated in the current scope to obtain the exception object.
	string
	Auto-generated method"

	evaluateName := anObject

]

{ #category : #accessing }
DAPExceptionDetails >> fullTypeName [
	"Fully-qualified type name of the exception object.
	string
	Auto-generated method"

	^ fullTypeName
]

{ #category : #accessing }
DAPExceptionDetails >> fullTypeName: anObject [
	"Fully-qualified type name of the exception object.
	string
	Auto-generated method"

	fullTypeName := anObject

]

{ #category : #accessing }
DAPExceptionDetails >> innerException [
	"Details of the exception contained by this exception, if any.
	array
	Auto-generated method"

	^ innerException
]

{ #category : #accessing }
DAPExceptionDetails >> innerException: anObject [
	"Details of the exception contained by this exception, if any.
	array
	Auto-generated method"

	innerException := anObject

]

{ #category : #accessing }
DAPExceptionDetails >> message [
	"Message contained in the exception.
	string
	Auto-generated method"

	^ message
]

{ #category : #accessing }
DAPExceptionDetails >> message: anObject [
	"Message contained in the exception.
	string
	Auto-generated method"

	message := anObject

]

{ #category : #accessing }
DAPExceptionDetails >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(stackTrace message fullTypeName innerException evaluateName typeName )
]

{ #category : #accessing }
DAPExceptionDetails >> stackTrace [
	"Stack trace at the time the exception was thrown.
	string
	Auto-generated method"

	^ stackTrace
]

{ #category : #accessing }
DAPExceptionDetails >> stackTrace: anObject [
	"Stack trace at the time the exception was thrown.
	string
	Auto-generated method"

	stackTrace := anObject

]

{ #category : #accessing }
DAPExceptionDetails >> typeName [
	"Short type name of the exception object.
	string
	Auto-generated method"

	^ typeName
]

{ #category : #accessing }
DAPExceptionDetails >> typeName: anObject [
	"Short type name of the exception object.
	string
	Auto-generated method"

	typeName := anObject

]
