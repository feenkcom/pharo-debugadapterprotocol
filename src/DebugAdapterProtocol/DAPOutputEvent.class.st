"
The event indicates that the target has produced some output.

"
Class {
	#name : #DAPOutputEvent,
	#superclass : #DAPEvent,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPOutputEvent class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #event to: #event.
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #accessing }
DAPOutputEvent class >> eventEnums [
	"Enumerated types for the associated attribute"

	^ #(output )
]

{ #category : #visiting }
DAPOutputEvent >> acceptVisitor: aVisitor [

	^ aVisitor visitOutputEvent: self
]

{ #category : #accessing }
DAPOutputEvent >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPOutputEvent >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPOutputEvent >> category [
	"The output category. If not specified, 'console' is assumed.
	string
	Auto-generated method"
	| result |

	result := self body at: #category ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPOutputEvent >> category: anObject [
	"The output category. If not specified, 'console' is assumed.
	string
	Auto-generated method"

	self body at: #category put: anObject
]

{ #category : #accessing }
DAPOutputEvent >> column [
	"An optional source location column where the output was produced.
	integer
	Auto-generated method"
	| result |

	result := self body at: #column ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPOutputEvent >> column: anObject [
	"An optional source location column where the output was produced.
	integer
	Auto-generated method"

	self body at: #column put: anObject
]

{ #category : #accessing }
DAPOutputEvent >> data [
	"Optional data to report. For the 'telemetry' category the data will be sent to telemetry, for the other categories the data is shown in JSON format.
	arraybooleanintegernullnumberobjectstring
	Auto-generated method"
	| result |

	result := self body at: #data ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPOutputEvent >> data: anObject [
	"Optional data to report. For the 'telemetry' category the data will be sent to telemetry, for the other categories the data is shown in JSON format.
	arraybooleanintegernullnumberobjectstring
	Auto-generated method"

	self body at: #data put: anObject
]

{ #category : #accessing }
DAPOutputEvent >> event [
	"output: 
	Auto-generated method"

	^ event ifNil: [ 'output' ]
]

{ #category : #accessing }
DAPOutputEvent >> event: anObject [
	"output: 
	Auto-generated method"

	event := anObject

]

{ #category : #accessing }
DAPOutputEvent >> group [
	"Support for keeping an output log organized by grouping related messages.
	string
	start: Start a new group in expanded mode. Subsequent output events are members of the group and should be shown indented.
The 'output' attribute becomes the name of the group and is not indented.
	startCollapsed: Start a new group in collapsed mode. Subsequent output events are members of the group and should be shown indented (as soon as the group is expanded).
The 'output' attribute becomes the name of the group and is not indented.
	end: End the current group and decreases the indentation of subsequent output events.
A non empty 'output' attribute is shown as the unindented end of the group.
	Auto-generated method"
	| result |

	result := self body at: #group ifAbsent: [ nil ].
	result ifNil:
		[ result := 'start' ].
	^ result
]

{ #category : #accessing }
DAPOutputEvent >> group: anObject [
	"Support for keeping an output log organized by grouping related messages.
	string
	start: Start a new group in expanded mode. Subsequent output events are members of the group and should be shown indented.
The 'output' attribute becomes the name of the group and is not indented.
	startCollapsed: Start a new group in collapsed mode. Subsequent output events are members of the group and should be shown indented (as soon as the group is expanded).
The 'output' attribute becomes the name of the group and is not indented.
	end: End the current group and decreases the indentation of subsequent output events.
A non empty 'output' attribute is shown as the unindented end of the group.
	Auto-generated method"

	self body at: #group put: anObject
]

{ #category : #accessing }
DAPOutputEvent >> line [
	"An optional source location line where the output was produced.
	integer
	Auto-generated method"
	| result |

	result := self body at: #line ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPOutputEvent >> line: anObject [
	"An optional source location line where the output was produced.
	integer
	Auto-generated method"

	self body at: #line put: anObject
]

{ #category : #accessing }
DAPOutputEvent >> output [
	"The output to report.
	string
	Auto-generated method"
	| result |

	result := self body at: #output ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPOutputEvent >> output: anObject [
	"The output to report.
	string
	Auto-generated method"

	self body at: #output put: anObject
]

{ #category : #accessing }
DAPOutputEvent >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body category column data event group line output source variablesReference )
]

{ #category : #accessing }
DAPOutputEvent >> source [
	"An optional source location where the output was produced.
	#/definitions/Source
	Auto-generated method"
	| result |

	result := self body at: #source ifAbsent: [ nil ].
	result isDictionary ifTrue:
		[ result := DAPSource fromDictionary: result client: client ].
	^ result
]

{ #category : #accessing }
DAPOutputEvent >> source: anObject [
	"An optional source location where the output was produced.
	#/definitions/Source
	Auto-generated method"

	self body at: #source put: anObject
]

{ #category : #accessing }
DAPOutputEvent >> variablesReference [
	"If an attribute 'variablesReference' exists and its value is > 0, the output contains objects which can be retrieved by passing 'variablesReference' to the 'variables' request. The value should be less than or equal to 2147483647 (2^31-1).
	integer
	Auto-generated method"
	| result |

	result := self body at: #variablesReference ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPOutputEvent >> variablesReference: anObject [
	"If an attribute 'variablesReference' exists and its value is > 0, the output contains objects which can be retrieved by passing 'variablesReference' to the 'variables' request. The value should be less than or equal to 2147483647 (2^31-1).
	integer
	Auto-generated method"

	self body at: #variablesReference put: anObject
]
