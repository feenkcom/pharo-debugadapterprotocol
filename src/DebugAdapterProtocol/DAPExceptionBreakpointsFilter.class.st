"
An ExceptionBreakpointsFilter is shown in the UI as an filter option for configuring how exceptions are dealt with.

"
Class {
	#name : #DAPExceptionBreakpointsFilter,
	#superclass : #DAPObject,
	#instVars : [
		'conditionDescription',
		'default',
		'description',
		'filter',
		'label',
		'supportsCondition'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPExceptionBreakpointsFilter class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #description to: #description.
		mapping mapAccessor: #default to: #default.
		mapping mapAccessor: #supportsCondition to: #supportsCondition.
		mapping mapAccessor: #filter to: #filter.
		mapping mapAccessor: #label to: #label.
		mapping mapAccessor: #conditionDescription to: #conditionDescription.
		].

]

{ #category : #visiting }
DAPExceptionBreakpointsFilter >> acceptVisitor: aVisitor [

	^ aVisitor visitExceptionBreakpointsFilter: self
]

{ #category : #accessing }
DAPExceptionBreakpointsFilter >> conditionDescription [
	"An optional help text providing information about the condition. This string is shown as the placeholder text for a text box and must be translated.
	string
	Auto-generated method"

	^ conditionDescription
]

{ #category : #accessing }
DAPExceptionBreakpointsFilter >> conditionDescription: anObject [
	"An optional help text providing information about the condition. This string is shown as the placeholder text for a text box and must be translated.
	string
	Auto-generated method"

	conditionDescription := anObject

]

{ #category : #accessing }
DAPExceptionBreakpointsFilter >> default [
	"Initial value of the filter option. If not specified a value 'false' is assumed.
	boolean
	Auto-generated method"

	^ default
]

{ #category : #accessing }
DAPExceptionBreakpointsFilter >> default: anObject [
	"Initial value of the filter option. If not specified a value 'false' is assumed.
	boolean
	Auto-generated method"

	default := anObject

]

{ #category : #accessing }
DAPExceptionBreakpointsFilter >> description [
	"An optional help text providing additional information about the exception filter. This string is typically shown as a hover and must be translated.
	string
	Auto-generated method"

	^ description
]

{ #category : #accessing }
DAPExceptionBreakpointsFilter >> description: anObject [
	"An optional help text providing additional information about the exception filter. This string is typically shown as a hover and must be translated.
	string
	Auto-generated method"

	description := anObject

]

{ #category : #accessing }
DAPExceptionBreakpointsFilter >> filter [
	"The internal ID of the filter option. This value is passed to the 'setExceptionBreakpoints' request.
	string
	Auto-generated method"

	^ filter
]

{ #category : #accessing }
DAPExceptionBreakpointsFilter >> filter: anObject [
	"The internal ID of the filter option. This value is passed to the 'setExceptionBreakpoints' request.
	string
	Auto-generated method"

	filter := anObject

]

{ #category : #accessing }
DAPExceptionBreakpointsFilter >> label [
	"The name of the filter option. This will be shown in the UI.
	string
	Auto-generated method"

	^ label
]

{ #category : #accessing }
DAPExceptionBreakpointsFilter >> label: anObject [
	"The name of the filter option. This will be shown in the UI.
	string
	Auto-generated method"

	label := anObject

]

{ #category : #accessing }
DAPExceptionBreakpointsFilter >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(conditionDescription default description filter label supportsCondition )
]

{ #category : #accessing }
DAPExceptionBreakpointsFilter >> supportsCondition [
	"Controls whether a condition can be specified for this filter option. If false or missing, a condition can not be set.
	boolean
	Auto-generated method"

	^ supportsCondition
]

{ #category : #accessing }
DAPExceptionBreakpointsFilter >> supportsCondition: anObject [
	"Controls whether a condition can be specified for this filter option. If false or missing, a condition can not be set.
	boolean
	Auto-generated method"

	supportsCondition := anObject

]
