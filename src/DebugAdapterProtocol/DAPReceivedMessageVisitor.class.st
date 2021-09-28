Class {
	#name : 'DAPReceivedMessageVisitor',
	#superclass : 'Object',
	#traits : 'TDAPProtocolVisitor',
	#classTraits : 'TDAPProtocolVisitor classTrait',
	#instVars : [
		'client'
	],
	#category : 'DebugAdapterProtocol-Visitors'
}

{ #category : 'accessing' }
DAPReceivedMessageVisitor >> client [
	^ client
]

{ #category : 'accessing' }
DAPReceivedMessageVisitor >> client: anObject [
	client := anObject
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitAttachResponse: anObject [

	client serverState: #attached.
	^ true
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitBreakpointEvent: aDAPBreakpointEvent [

	client registerBreakpoint: aDAPBreakpointEvent breakpoint.
	^ false
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitCapabilitiesEvent: aDAPCapabilitiesEvent [

	client capabilities: aDAPCapabilitiesEvent capabilities.
	^ false
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitConfigurationDoneResponse: anObject [
	"Answer false to check the status later"

	^ false
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitContinueResponse: anObject [
	"The answer is returned immediately"

	^ false
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitContinuedEvent: aDAPContinuedEvent [

	(client atThreadId: aDAPContinuedEvent threadId) state: #continued.
	client serverState: #continued.
	^ false
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitDebugpyAttachEvent: anObject [

	client serverAttributes at: #debugpyCapabilities put: anObject body.
	^ true
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitDebugpyWaitingForServerEvent: anObject [
	"Mark the server state as waiting for debugpy.
	The IP address is assumed to be correct"

	client serverState: #debugpyWaitingForServer.
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitExitedEvent: aDAPExitedEvent [

	client serverState: #exited.
	^ false
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitInitializeResponse: anObject [

	client serverAttributes at: #capabilities put: anObject body.
	^ true
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitInitializedEvent: anObject [

	client serverState: #initialized
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitLaunchResponse: anObject [

	^ false
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitModuleEvent: aDAPModuleEvent [

	client modules at: aDAPModuleEvent module id put: aDAPModuleEvent module.
	^ true
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitNextResponse: anObject [
	"The result is handled by the caller"

	^ false
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitOutputEvent: aDAPOutputEvent [

	"Append stdout and stderr to the client's stream.  Just store other output."

	| clientOutput stream |
	"What is the variablesReference for?"
	aDAPOutputEvent variablesReference ifNotNil: [ self halt ].

	aDAPOutputEvent category = #stdout ifTrue: [ 
		client stdoutNextPutAll:
			aDAPOutputEvent output withInternalLineEndings.
		^ false ].
	aDAPOutputEvent category = #stderr ifTrue: [ 
		client stderrNextPutAll:
			aDAPOutputEvent output withSqueakLineEndings.
		^ false ].


	"Not yet sure what output covers, just append it to the server attributes"
	clientOutput := client serverAttributes
		                at: #output
		                ifAbsentPut: [ OrderedCollection new ].
	clientOutput add: aDAPOutputEvent body.
	^ false
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitProcessEvent: anObject [

	client serverProcessDetailsEvent: anObject.
	^ true
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitRunInTerminalRequest: aDAPRunInTerminalRequest [

	self error: 'Not supported'.	
	^ false
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitScopesResponse: anObject [
	"Value is returned in confirmation message"

	^ false
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitSetExceptionBreakpointsResponse: anObject [
	"Answer false, which will check the status later"

	^ false
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitSetFunctionBreakpointsResponse: anObject [

	^ false
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitSourceResponse: anObject [
	"Do nothing, it is handled by the request initiator"

	^ false
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitStackTraceResponse: anObject [
	"Stack trace responses are handled by the caller.  Answer false to check response status"

	^ false
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitStepBackResponse: anObject [
	"The result is handled by the caller"

	^ false
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitStepInResponse: anObject [
	"The result is handled by the caller"

	^ false
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitStepOutResponse: anObject [
	"The result is handled by the caller"

	^ false
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitStoppedEvent: aDAPStoppedEvent [
	| thread |

	[ thread := client atThreadId: aDAPStoppedEvent threadId.
	thread
		latestEvent: aDAPStoppedEvent;
		updateStack;
		state: #stopped.
	client serverState: #stopped.
	 ] forkAt: Processor userSchedulingPriority named: 'DAP Thread Update: ', aDAPStoppedEvent threadId asString.

	^ true
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitTerminateResponse: aDAPTerminateResponse [

	client serverState: #terminated.
	^ true
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitTerminatedEvent: anObject [

	client serverTerminated.
	^ false
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitThreadEvent: aDAPThreadEvent [

	(client atThreadId: aDAPThreadEvent threadId) 
		state: aDAPThreadEvent reason;
		latestEvent: aDAPThreadEvent.
	^ true
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitThreadsResponse: aDAPThreadsResponse [

	aDAPThreadsResponse threads do: [ :thread |
		(client atThreadId: (thread at: #id)) name: (thread at: #name) ].
	^ true
]

{ #category : 'visiting' }
DAPReceivedMessageVisitor >> visitVariablesResponse: anObject [
	"The response is handled by the requester"

	^ false
]
