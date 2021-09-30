"
Arguments for 'setExceptionBreakpoints' request.

"
Class {
	#name : #DAPSetExceptionBreakpointsArguments,
	#superclass : #DAPObject,
	#instVars : [
		'exceptionOptions',
		'filterOptions',
		'filters'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPSetExceptionBreakpointsArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #exceptionOptions to: #exceptionOptions.
		mapping mapAccessor: #filterOptions to: #filterOptions.
		mapping mapAccessor: #filters to: #filters.
		].

]

{ #category : #visiting }
DAPSetExceptionBreakpointsArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitSetExceptionBreakpointsArguments: self
]

{ #category : #accessing }
DAPSetExceptionBreakpointsArguments >> exceptionOptions [
	"Configuration options for selected exceptions.
The attribute is only honored by a debug adapter if the capability 'supportsExceptionOptions' is true.
	array
	Auto-generated method"

	^ exceptionOptions
]

{ #category : #accessing }
DAPSetExceptionBreakpointsArguments >> exceptionOptions: anObject [
	"Configuration options for selected exceptions.
The attribute is only honored by a debug adapter if the capability 'supportsExceptionOptions' is true.
	array
	Auto-generated method"

	exceptionOptions := anObject

]

{ #category : #accessing }
DAPSetExceptionBreakpointsArguments >> filterOptions [
	"Set of exception filters and their options. The set of all possible exception filters is defined by the 'exceptionBreakpointFilters' capability. This attribute is only honored by a debug adapter if the capability 'supportsExceptionFilterOptions' is true. The 'filter' and 'filterOptions' sets are additive.
	array
	Auto-generated method"

	^ filterOptions
]

{ #category : #accessing }
DAPSetExceptionBreakpointsArguments >> filterOptions: anObject [
	"Set of exception filters and their options. The set of all possible exception filters is defined by the 'exceptionBreakpointFilters' capability. This attribute is only honored by a debug adapter if the capability 'supportsExceptionFilterOptions' is true. The 'filter' and 'filterOptions' sets are additive.
	array
	Auto-generated method"

	filterOptions := anObject

]

{ #category : #accessing }
DAPSetExceptionBreakpointsArguments >> filters [
	"Set of exception filters specified by their ID. The set of all possible exception filters is defined by the 'exceptionBreakpointFilters' capability. The 'filter' and 'filterOptions' sets are additive.
	array
	Auto-generated method"

	^ filters
]

{ #category : #accessing }
DAPSetExceptionBreakpointsArguments >> filters: anObject [
	"Set of exception filters specified by their ID. The set of all possible exception filters is defined by the 'exceptionBreakpointFilters' capability. The 'filter' and 'filterOptions' sets are additive.
	array
	Auto-generated method"

	filters := anObject

]

{ #category : #accessing }
DAPSetExceptionBreakpointsArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(exceptionOptions filterOptions filters )
]
