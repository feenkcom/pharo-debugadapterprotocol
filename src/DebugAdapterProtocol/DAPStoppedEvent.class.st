"
The event indicates that the execution of the debuggee has stopped due to some condition.
This can be caused by a break point previously set, a stepping request has completed, by executing a debugger statement etc.

"
Class {
	#name : #DAPStoppedEvent,
	#superclass : #DAPEvent,
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPStoppedEvent class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #event to: #event.
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #accessing }
DAPStoppedEvent class >> eventEnums [
	"Enumerated types for the associated attribute"

	^ #(stopped )
]

{ #category : #visiting }
DAPStoppedEvent >> acceptVisitor: aVisitor [

	^ aVisitor visitStoppedEvent: self
]

{ #category : #accessing }
DAPStoppedEvent >> allThreadsStopped [
	"If 'allThreadsStopped' is true, a debug adapter can announce that all threads have stopped.
- The client should use this information to enable that all threads can be expanded to access their stacktraces.
- If the attribute is missing or false, only the thread with the given threadId can be expanded.
	boolean
	Auto-generated method"
	| result |

	result := self body at: #allThreadsStopped ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPStoppedEvent >> allThreadsStopped: anObject [
	"If 'allThreadsStopped' is true, a debug adapter can announce that all threads have stopped.
- The client should use this information to enable that all threads can be expanded to access their stacktraces.
- If the attribute is missing or false, only the thread with the given threadId can be expanded.
	boolean
	Auto-generated method"

	self body at: #allThreadsStopped put: anObject
]

{ #category : #accessing }
DAPStoppedEvent >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPStoppedEvent >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPStoppedEvent >> description [
	"The full reason for the event, e.g. 'Paused on exception'. This string is shown in the UI as is and must be translated.
	string
	Auto-generated method"
	| result |

	result := self body at: #description ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPStoppedEvent >> description: anObject [
	"The full reason for the event, e.g. 'Paused on exception'. This string is shown in the UI as is and must be translated.
	string
	Auto-generated method"

	self body at: #description put: anObject
]

{ #category : #accessing }
DAPStoppedEvent >> event [
	"stopped: 
	Auto-generated method"

	^ event ifNil: [ 'stopped' ]
]

{ #category : #accessing }
DAPStoppedEvent >> event: anObject [
	"stopped: 
	Auto-generated method"

	event := anObject

]

{ #category : #accessing }
DAPStoppedEvent >> preserveFocusHint [
	"A value of true hints to the frontend that this event should not change the focus.
	boolean
	Auto-generated method"
	| result |

	result := self body at: #preserveFocusHint ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPStoppedEvent >> preserveFocusHint: anObject [
	"A value of true hints to the frontend that this event should not change the focus.
	boolean
	Auto-generated method"

	self body at: #preserveFocusHint put: anObject
]

{ #category : #accessing }
DAPStoppedEvent >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(allThreadsStopped body description event preserveFocusHint reason text threadId )
]

{ #category : #accessing }
DAPStoppedEvent >> reason [
	"The reason for the event.
For backward compatibility this string is shown in the UI if the 'description' attribute is missing (but it must not be translated).
	string
	Auto-generated method"
	| result |

	result := self body at: #reason ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPStoppedEvent >> reason: anObject [
	"The reason for the event.
For backward compatibility this string is shown in the UI if the 'description' attribute is missing (but it must not be translated).
	string
	Auto-generated method"

	self body at: #reason put: anObject
]

{ #category : #accessing }
DAPStoppedEvent >> text [
	"Additional information. E.g. if reason is 'exception', text contains the exception name. This string is shown in the UI.
	string
	Auto-generated method"
	| result |

	result := self body at: #text ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPStoppedEvent >> text: anObject [
	"Additional information. E.g. if reason is 'exception', text contains the exception name. This string is shown in the UI.
	string
	Auto-generated method"

	self body at: #text put: anObject
]

{ #category : #accessing }
DAPStoppedEvent >> threadId [
	"The thread which was stopped.
	integer
	Auto-generated method"
	| result |

	result := self body at: #threadId ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPStoppedEvent >> threadId: anObject [
	"The thread which was stopped.
	integer
	Auto-generated method"

	self body at: #threadId put: anObject
]
