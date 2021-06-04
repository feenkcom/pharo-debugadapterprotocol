"
This event indicates that the debug adapter is ready to accept configuration requests (e.g. SetBreakpointsRequest, SetExceptionBreakpointsRequest).
A debug adapter is expected to send this event when it is ready to accept configuration requests (but not before the 'initialize' request has finished).
The sequence of events/requests is as follows:
- adapters sends 'initialized' event (after the 'initialize' request has returned)
- frontend sends zero or more 'setBreakpoints' requests
- frontend sends one 'setFunctionBreakpoints' request (if capability 'supportsFunctionBreakpoints' is true)
- frontend sends a 'setExceptionBreakpoints' request if one or more 'exceptionBreakpointFilters' have been defined (or if 'supportsConfigurationDoneRequest' is not defined or false)
- frontend sends other future configuration requests
- frontend sends one 'configurationDone' request to indicate the end of the configuration.

"
Class {
	#name : #DAPInitializedEvent,
	#superclass : #DAPEvent,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPInitializedEvent class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #event to: #event.
		].

]

{ #category : #accessing }
DAPInitializedEvent class >> eventEnums [
	"Enumerated types for the associated attribute"

	^ #(initialized )
]

{ #category : #visiting }
DAPInitializedEvent >> acceptVisitor: aVisitor [

	^ aVisitor visitInitializedEvent: self
]

{ #category : #accessing }
DAPInitializedEvent >> event [
	"initialized: 
	Auto-generated method"

	^ event ifNil: [ 'initialized' ]
]

{ #category : #accessing }
DAPInitializedEvent >> event: anObject [
	"initialized: 
	Auto-generated method"

	event := anObject

]

{ #category : #accessing }
DAPInitializedEvent >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(event )
]
