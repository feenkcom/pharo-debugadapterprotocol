"
Arguments for attaching to a Python debugpy server.    See https://code.visualstudio.com/docs/python/debugging for additional information.

"
Class {
	#name : #DAPPythonAttachRequestArguments,
	#superclass : #DAPObject,
	#instVars : [
		'pathMappings',
		'justMyCode',
		'debugOptions',
		'name',
		'request',
		'type',
		'subProcessId',
		'showReturnValue',
		'pythonPath',
		'connect',
		'workspaceFolder',
		'__sessionId'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPPythonAttachRequestArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #debugOptions to: #debugOptions.
		mapping mapAccessor: #justMyCode to: #justMyCode.
		mapping mapAccessor: #name to: #name.
		mapping mapAccessor: #pathMappings to: #pathMappings.
		mapping mapAccessor: #pythonPath to: #pythonPath.
		mapping mapAccessor: #workspaceFolder to: #workspaceFolder.
		mapping mapAccessor: #__sessionId to: #__sessionId.
		mapping mapAccessor: #connect to: #connect.
		mapping mapAccessor: #type to: #type.
		mapping mapAccessor: #request to: #request.
		mapping mapAccessor: #showReturnValue to: #showReturnValue.
		].

]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> __sessionId [
	"A UUID
	string
	Auto-generated method"

	^ __sessionId
]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> __sessionId: anObject [
	"A UUID
	string
	Auto-generated method"

	__sessionId := anObject

]

{ #category : #visiting }
DAPPythonAttachRequestArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitPythonAttachRequestArguments: self
]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> connect [
	"Auto-generated method"

	^ connect
]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> connect: anObject [
	"Auto-generated method"

	connect := anObject isDictionary ifTrue:
		[ DAPIPAddress fromDictionary: anObject client: client ]
	ifFalse:
		[ anObject ]

]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> debugOptions [
	"RedirectOutput, UnixClient, ShowReturnValue and others?
	array
	Auto-generated method"

	^ debugOptions
]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> debugOptions: anObject [
	"RedirectOutput, UnixClient, ShowReturnValue and others?
	array
	Auto-generated method"

	debugOptions := anObject

]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> justMyCode [
	"When omitted or set to true (the default), restricts debugging to user-written code only. Set to false to also enable debugging of standard library functions.
	boolean
	Auto-generated method"

	^ justMyCode
]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> justMyCode: anObject [
	"???
	boolean
	Auto-generated method"

	justMyCode := anObject

]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> name [
	"???
	string
	Auto-generated method"

	^ name
]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> name: anObject [
	"???
	string
	Auto-generated method"

	name := anObject

]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> pathMappings [
	"Array with an object with localRoot and remoteRoot attributes
	array
	Auto-generated method"

	^ pathMappings
]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> pathMappings: anObject [
	"Array with an object with localRoot and remoteRoot attributes
	array
	Auto-generated method"

	pathMappings := anObject

]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(debugOptions justMyCode name pathMappings pythonPath workspaceFolder __sessionId connect type request showReturnValue )
]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> pythonPath [
	"The path to the python executable
	string
	Auto-generated method"

	^ pythonPath
]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> pythonPath: anObject [
	"The path to the python executable
	string
	Auto-generated method"

	pythonPath := anObject

]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> request [
	"???
	string
	Auto-generated method"

	^ request
]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> request: anObject [
	"???
	string
	Auto-generated method"

	request := anObject

]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> showReturnValue [
	"???
	boolean
	Auto-generated method"

	^ showReturnValue
]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> showReturnValue: anObject [
	"???
	boolean
	Auto-generated method"

	showReturnValue := anObject

]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> subProcessId [
	"Only used as part of the response
	integer
	Auto-generated method"

	^ subProcessId
]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> subProcessId: anObject [
	"Only used as part of the response
	integer
	Auto-generated method"

	subProcessId := anObject

]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> type [
	"Identifies the type of debugger to use; leave this set to python for Python code.
	string
	Auto-generated method"

	^ type
]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> type: anObject [
	"???
	string
	Auto-generated method"

	type := anObject

]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> workspaceFolder [
	"The path to the working directory
	string
	Auto-generated method"

	^ workspaceFolder
]

{ #category : #accessing }
DAPPythonAttachRequestArguments >> workspaceFolder: anObject [
	"The path to the working directory
	string
	Auto-generated method"

	workspaceFolder := anObject

]
