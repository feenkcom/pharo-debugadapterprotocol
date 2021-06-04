"
Arguments for 'initialize' request.

"
Class {
	#name : #DAPInitializeRequestArguments,
	#superclass : #DAPObject,
	#instVars : [
		'adapterID',
		'clientID',
		'clientName',
		'columnsStartAt1',
		'linesStartAt1',
		'locale',
		'pathFormat',
		'supportsInvalidatedEvent',
		'supportsMemoryReferences',
		'supportsProgressReporting',
		'supportsRunInTerminalRequest',
		'supportsVariablePaging',
		'supportsVariableType'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPInitializeRequestArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #supportsMemoryReferences to: #supportsMemoryReferences.
		mapping mapAccessor: #supportsRunInTerminalRequest to: #supportsRunInTerminalRequest.
		mapping mapAccessor: #adapterID to: #adapterID.
		mapping mapAccessor: #supportsVariablePaging to: #supportsVariablePaging.
		mapping mapAccessor: #supportsProgressReporting to: #supportsProgressReporting.
		mapping mapAccessor: #columnsStartAt1 to: #columnsStartAt1.
		mapping mapAccessor: #clientName to: #clientName.
		mapping mapAccessor: #linesStartAt1 to: #linesStartAt1.
		mapping mapAccessor: #clientID to: #clientID.
		mapping mapAccessor: #locale to: #locale.
		mapping mapAccessor: #supportsVariableType to: #supportsVariableType.
		mapping mapAccessor: #pathFormat to: #pathFormat.
		mapping mapAccessor: #supportsInvalidatedEvent to: #supportsInvalidatedEvent.
		].

]

{ #category : #visiting }
DAPInitializeRequestArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitInitializeRequestArguments: self
]

{ #category : #accessing }
DAPInitializeRequestArguments >> adapterID [
	"The ID of the debug adapter.
	string
	Auto-generated method"

	^ adapterID
]

{ #category : #accessing }
DAPInitializeRequestArguments >> adapterID: anObject [
	"The ID of the debug adapter.
	string
	Auto-generated method"

	adapterID := anObject

]

{ #category : #accessing }
DAPInitializeRequestArguments >> clientID [
	"The ID of the (frontend) client using this adapter.
	string
	Auto-generated method"

	^ clientID
]

{ #category : #accessing }
DAPInitializeRequestArguments >> clientID: anObject [
	"The ID of the (frontend) client using this adapter.
	string
	Auto-generated method"

	clientID := anObject

]

{ #category : #accessing }
DAPInitializeRequestArguments >> clientName [
	"The human readable name of the (frontend) client using this adapter.
	string
	Auto-generated method"

	^ clientName
]

{ #category : #accessing }
DAPInitializeRequestArguments >> clientName: anObject [
	"The human readable name of the (frontend) client using this adapter.
	string
	Auto-generated method"

	clientName := anObject

]

{ #category : #accessing }
DAPInitializeRequestArguments >> columnsStartAt1 [
	"If true all column numbers are 1-based (default).
	boolean
	Auto-generated method"

	^ columnsStartAt1
]

{ #category : #accessing }
DAPInitializeRequestArguments >> columnsStartAt1: anObject [
	"If true all column numbers are 1-based (default).
	boolean
	Auto-generated method"

	columnsStartAt1 := anObject

]

{ #category : #accessing }
DAPInitializeRequestArguments >> linesStartAt1 [
	"If true all line numbers are 1-based (default).
	boolean
	Auto-generated method"

	^ linesStartAt1
]

{ #category : #accessing }
DAPInitializeRequestArguments >> linesStartAt1: anObject [
	"If true all line numbers are 1-based (default).
	boolean
	Auto-generated method"

	linesStartAt1 := anObject

]

{ #category : #accessing }
DAPInitializeRequestArguments >> locale [
	"The ISO-639 locale of the (frontend) client using this adapter, e.g. en-US or de-CH.
	string
	Auto-generated method"

	^ locale
]

{ #category : #accessing }
DAPInitializeRequestArguments >> locale: anObject [
	"The ISO-639 locale of the (frontend) client using this adapter, e.g. en-US or de-CH.
	string
	Auto-generated method"

	locale := anObject

]

{ #category : #accessing }
DAPInitializeRequestArguments >> pathFormat [
	"Determines in what format paths are specified. The default is 'path', which is the native format.
	string
	Auto-generated method"

	^ pathFormat
]

{ #category : #accessing }
DAPInitializeRequestArguments >> pathFormat: anObject [
	"Determines in what format paths are specified. The default is 'path', which is the native format.
	string
	Auto-generated method"

	pathFormat := anObject

]

{ #category : #accessing }
DAPInitializeRequestArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(adapterID clientID clientName columnsStartAt1 linesStartAt1 locale pathFormat supportsInvalidatedEvent supportsMemoryReferences supportsProgressReporting supportsRunInTerminalRequest supportsVariablePaging supportsVariableType )
]

{ #category : #accessing }
DAPInitializeRequestArguments >> supportsInvalidatedEvent [
	"Client supports the invalidated event.
	boolean
	Auto-generated method"

	^ supportsInvalidatedEvent
]

{ #category : #accessing }
DAPInitializeRequestArguments >> supportsInvalidatedEvent: anObject [
	"Client supports the invalidated event.
	boolean
	Auto-generated method"

	supportsInvalidatedEvent := anObject

]

{ #category : #accessing }
DAPInitializeRequestArguments >> supportsMemoryReferences [
	"Client supports memory references.
	boolean
	Auto-generated method"

	^ supportsMemoryReferences
]

{ #category : #accessing }
DAPInitializeRequestArguments >> supportsMemoryReferences: anObject [
	"Client supports memory references.
	boolean
	Auto-generated method"

	supportsMemoryReferences := anObject

]

{ #category : #accessing }
DAPInitializeRequestArguments >> supportsProgressReporting [
	"Client supports progress reporting.
	boolean
	Auto-generated method"

	^ supportsProgressReporting
]

{ #category : #accessing }
DAPInitializeRequestArguments >> supportsProgressReporting: anObject [
	"Client supports progress reporting.
	boolean
	Auto-generated method"

	supportsProgressReporting := anObject

]

{ #category : #accessing }
DAPInitializeRequestArguments >> supportsRunInTerminalRequest [
	"Client supports the runInTerminal request.
	boolean
	Auto-generated method"

	^ supportsRunInTerminalRequest
]

{ #category : #accessing }
DAPInitializeRequestArguments >> supportsRunInTerminalRequest: anObject [
	"Client supports the runInTerminal request.
	boolean
	Auto-generated method"

	supportsRunInTerminalRequest := anObject

]

{ #category : #accessing }
DAPInitializeRequestArguments >> supportsVariablePaging [
	"Client supports the paging of variables.
	boolean
	Auto-generated method"

	^ supportsVariablePaging
]

{ #category : #accessing }
DAPInitializeRequestArguments >> supportsVariablePaging: anObject [
	"Client supports the paging of variables.
	boolean
	Auto-generated method"

	supportsVariablePaging := anObject

]

{ #category : #accessing }
DAPInitializeRequestArguments >> supportsVariableType [
	"Client supports the optional type attribute for variables.
	boolean
	Auto-generated method"

	^ supportsVariableType
]

{ #category : #accessing }
DAPInitializeRequestArguments >> supportsVariableType: anObject [
	"Client supports the optional type attribute for variables.
	boolean
	Auto-generated method"

	supportsVariableType := anObject

]
