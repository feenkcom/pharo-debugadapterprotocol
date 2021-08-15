"
Response to 'exceptionInfo' request.

"
Class {
	#name : 'DAPExceptionInfoResponse',
	#superclass : 'DAPResponse',
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPExceptionInfoResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : 'visiting' }
DAPExceptionInfoResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitExceptionInfoResponse: self
]

{ #category : 'accessing' }
DAPExceptionInfoResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : 'accessing' }
DAPExceptionInfoResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : 'accessing' }
DAPExceptionInfoResponse >> breakMode [
	"Mode that caused the exception notification to be raised.
	#/definitions/ExceptionBreakMode
	Auto-generated method"
	| result |

	result := self body at: #breakMode ifAbsent: [ nil ].
	result isDictionary ifTrue:
		[ result := DAPExceptionBreakMode fromDictionary: result client: client ].
	^ result
]

{ #category : 'accessing' }
DAPExceptionInfoResponse >> breakMode: anObject [
	"Mode that caused the exception notification to be raised.
	#/definitions/ExceptionBreakMode
	Auto-generated method"

	self body at: #breakMode put: anObject
]

{ #category : 'accessing' }
DAPExceptionInfoResponse >> description [
	"Descriptive text for the exception provided by the debug adapter.
	string
	Auto-generated method"
	| result |

	result := self body at: #description ifAbsent: [ nil ].
	^ result
]

{ #category : 'accessing' }
DAPExceptionInfoResponse >> description: anObject [
	"Descriptive text for the exception provided by the debug adapter.
	string
	Auto-generated method"

	self body at: #description put: anObject
]

{ #category : 'accessing' }
DAPExceptionInfoResponse >> details [
	"Detailed information about the exception.
	#/definitions/ExceptionDetails
	Auto-generated method"
	| result |

	result := self body at: #details ifAbsent: [ nil ].
	result isDictionary ifTrue:
		[ result := DAPExceptionDetails fromDictionary: result client: client ].
	^ result
]

{ #category : 'accessing' }
DAPExceptionInfoResponse >> details: anObject [
	"Detailed information about the exception.
	#/definitions/ExceptionDetails
	Auto-generated method"

	self body at: #details put: anObject
]

{ #category : 'accessing' }
DAPExceptionInfoResponse >> exceptionId [
	"ID of the exception that was thrown.
	string
	Auto-generated method"
	| result |

	result := self body at: #exceptionId ifAbsent: [ nil ].
	^ result
]

{ #category : 'accessing' }
DAPExceptionInfoResponse >> exceptionId: anObject [
	"ID of the exception that was thrown.
	string
	Auto-generated method"

	self body at: #exceptionId put: anObject
]

{ #category : 'accessing' }
DAPExceptionInfoResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body breakMode description details exceptionId )
]
