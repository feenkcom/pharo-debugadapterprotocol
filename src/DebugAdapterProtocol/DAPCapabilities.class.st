"
Information about the capabilities of a debug adapter.

"
Class {
	#name : 'DAPCapabilities',
	#superclass : 'DAPObject',
	#instVars : [
		'additionalModuleColumns',
		'completionTriggerCharacters',
		'exceptionBreakpointFilters',
		'supportedChecksumAlgorithms',
		'supportsBreakpointLocationsRequest',
		'supportsCancelRequest',
		'supportsClipboardContext',
		'supportsCompletionsRequest',
		'supportsConditionalBreakpoints',
		'supportsConfigurationDoneRequest',
		'supportsDataBreakpoints',
		'supportsDebuggerProperties',
		'supportsDelayedStackTraceLoading',
		'supportsDisassembleRequest',
		'supportsEvaluateForHovers',
		'supportsExceptionFilterOptions',
		'supportsExceptionInfoRequest',
		'supportsExceptionOptions',
		'supportsFunctionBreakpoints',
		'supportsGotoTargetsRequest',
		'supportsHitConditionalBreakpoints',
		'supportsInstructionBreakpoints',
		'supportsLoadedSourcesRequest',
		'supportsLogPoints',
		'supportsModulesRequest',
		'supportsReadMemoryRequest',
		'supportsRestartFrame',
		'supportsRestartRequest',
		'supportsSetExpression',
		'supportsSetVariable',
		'supportsStepBack',
		'supportsStepInTargetsRequest',
		'supportsSteppingGranularity',
		'supportsTerminateDebuggee',
		'supportsTerminateRequest',
		'supportsTerminateThreadsRequest',
		'supportsValueFormattingOptions'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : 'json - configuration' }
DAPCapabilities class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #completionTriggerCharacters to: #completionTriggerCharacters.
		mapping mapAccessor: #supportsBreakpointLocationsRequest to: #supportsBreakpointLocationsRequest.
		mapping mapAccessor: #supportsRestartFrame to: #supportsRestartFrame.
		mapping mapAccessor: #supportsReadMemoryRequest to: #supportsReadMemoryRequest.
		mapping mapAccessor: #supportsGotoTargetsRequest to: #supportsGotoTargetsRequest.
		mapping mapAccessor: #additionalModuleColumns to: #additionalModuleColumns.
		mapping mapAccessor: #supportsInstructionBreakpoints to: #supportsInstructionBreakpoints.
		mapping mapAccessor: #supportsTerminateDebuggee to: #supportsTerminateDebuggee.
		mapping mapAccessor: #supportsDebuggerProperties to: #supportsDebuggerProperties.
		mapping mapAccessor: #supportsDisassembleRequest to: #supportsDisassembleRequest.
		mapping mapAccessor: #supportsSteppingGranularity to: #supportsSteppingGranularity.
		mapping mapAccessor: #supportsStepInTargetsRequest to: #supportsStepInTargetsRequest.
		mapping mapAccessor: #supportsStepBack to: #supportsStepBack.
		mapping mapAccessor: #supportsLogPoints to: #supportsLogPoints.
		mapping mapAccessor: #supportsSetExpression to: #supportsSetExpression.
		mapping mapAccessor: #supportsFunctionBreakpoints to: #supportsFunctionBreakpoints.
		mapping mapAccessor: #supportsExceptionInfoRequest to: #supportsExceptionInfoRequest.
		mapping mapAccessor: #supportsCompletionsRequest to: #supportsCompletionsRequest.
		mapping mapAccessor: #supportsHitConditionalBreakpoints to: #supportsHitConditionalBreakpoints.
		mapping mapAccessor: #supportsConfigurationDoneRequest to: #supportsConfigurationDoneRequest.
		mapping mapAccessor: #supportsLoadedSourcesRequest to: #supportsLoadedSourcesRequest.
		mapping mapAccessor: #supportsConditionalBreakpoints to: #supportsConditionalBreakpoints.
		mapping mapAccessor: #supportsDataBreakpoints to: #supportsDataBreakpoints.
		mapping mapAccessor: #supportsValueFormattingOptions to: #supportsValueFormattingOptions.
		mapping mapAccessor: #supportsRestartRequest to: #supportsRestartRequest.
		mapping mapAccessor: #supportsTerminateRequest to: #supportsTerminateRequest.
		mapping mapAccessor: #supportsCancelRequest to: #supportsCancelRequest.
		mapping mapAccessor: #supportsExceptionFilterOptions to: #supportsExceptionFilterOptions.
		mapping mapAccessor: #supportsModulesRequest to: #supportsModulesRequest.
		mapping mapAccessor: #supportedChecksumAlgorithms to: #supportedChecksumAlgorithms.
		mapping mapAccessor: #supportsTerminateThreadsRequest to: #supportsTerminateThreadsRequest.
		mapping mapAccessor: #supportsDelayedStackTraceLoading to: #supportsDelayedStackTraceLoading.
		mapping mapAccessor: #supportsClipboardContext to: #supportsClipboardContext.
		mapping mapAccessor: #supportsExceptionOptions to: #supportsExceptionOptions.
		mapping mapAccessor: #exceptionBreakpointFilters to: #exceptionBreakpointFilters.
		mapping mapAccessor: #supportsEvaluateForHovers to: #supportsEvaluateForHovers.
		mapping mapAccessor: #supportsSetVariable to: #supportsSetVariable.
		].

]

{ #category : 'visiting' }
DAPCapabilities >> acceptVisitor: aVisitor [

	^ aVisitor visitCapabilities: self
]

{ #category : 'accessing' }
DAPCapabilities >> additionalModuleColumns [
	"The set of additional module information exposed by the debug adapter.
	array
	Auto-generated method"

	^ additionalModuleColumns
]

{ #category : 'accessing' }
DAPCapabilities >> additionalModuleColumns: anObject [
	"The set of additional module information exposed by the debug adapter.
	array
	Auto-generated method"

	additionalModuleColumns := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> completionTriggerCharacters [
	"The set of characters that should trigger completion in a REPL. If not specified, the UI should assume the '.' character.
	array
	Auto-generated method"

	^ completionTriggerCharacters
]

{ #category : 'accessing' }
DAPCapabilities >> completionTriggerCharacters: anObject [
	"The set of characters that should trigger completion in a REPL. If not specified, the UI should assume the '.' character.
	array
	Auto-generated method"

	completionTriggerCharacters := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> exceptionBreakpointFilters [
	"Available exception filter options for the 'setExceptionBreakpoints' request.
	array
	Auto-generated method"

	^ exceptionBreakpointFilters
]

{ #category : 'accessing' }
DAPCapabilities >> exceptionBreakpointFilters: anObject [
	"Available exception filter options for the 'setExceptionBreakpoints' request.
	array
	Auto-generated method"

	exceptionBreakpointFilters := anObject

]

{ #category : 'initialization' }
DAPCapabilities >> initialize [ 

	super initialize.
	self propertyNames do: [ :property |
		(property beginsWith: #supports) ifTrue:
			[ self perform: (property, ':') withArguments: { false } ] ].
]

{ #category : 'accessing' }
DAPCapabilities >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(additionalModuleColumns completionTriggerCharacters exceptionBreakpointFilters supportedChecksumAlgorithms supportsBreakpointLocationsRequest supportsCancelRequest supportsClipboardContext supportsCompletionsRequest supportsConditionalBreakpoints supportsConfigurationDoneRequest supportsDataBreakpoints supportsDebuggerProperties supportsDelayedStackTraceLoading supportsDisassembleRequest supportsEvaluateForHovers supportsExceptionFilterOptions supportsExceptionInfoRequest supportsExceptionOptions supportsFunctionBreakpoints supportsGotoTargetsRequest supportsHitConditionalBreakpoints supportsInstructionBreakpoints supportsLoadedSourcesRequest supportsLogPoints supportsModulesRequest supportsReadMemoryRequest supportsRestartFrame supportsRestartRequest supportsSetExpression supportsSetVariable supportsStepBack supportsStepInTargetsRequest supportsSteppingGranularity supportsTerminateDebuggee supportsTerminateRequest supportsTerminateThreadsRequest supportsValueFormattingOptions )
]

{ #category : 'accessing' }
DAPCapabilities >> supportedChecksumAlgorithms [
	"Checksum algorithms supported by the debug adapter.
	array
	Auto-generated method"

	^ supportedChecksumAlgorithms
]

{ #category : 'accessing' }
DAPCapabilities >> supportedChecksumAlgorithms: anObject [
	"Checksum algorithms supported by the debug adapter.
	array
	Auto-generated method"

	supportedChecksumAlgorithms := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsBreakpointLocationsRequest [
	"The debug adapter supports the 'breakpointLocations' request.
	boolean
	Auto-generated method"

	^ supportsBreakpointLocationsRequest
]

{ #category : 'accessing' }
DAPCapabilities >> supportsBreakpointLocationsRequest: anObject [
	"The debug adapter supports the 'breakpointLocations' request.
	boolean
	Auto-generated method"

	supportsBreakpointLocationsRequest := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsCancelRequest [
	"The debug adapter supports the 'cancel' request.
	boolean
	Auto-generated method"

	^ supportsCancelRequest
]

{ #category : 'accessing' }
DAPCapabilities >> supportsCancelRequest: anObject [
	"The debug adapter supports the 'cancel' request.
	boolean
	Auto-generated method"

	supportsCancelRequest := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsClipboardContext [
	"The debug adapter supports the 'clipboard' context value in the 'evaluate' request.
	boolean
	Auto-generated method"

	^ supportsClipboardContext
]

{ #category : 'accessing' }
DAPCapabilities >> supportsClipboardContext: anObject [
	"The debug adapter supports the 'clipboard' context value in the 'evaluate' request.
	boolean
	Auto-generated method"

	supportsClipboardContext := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsCompletionsRequest [
	"The debug adapter supports the 'completions' request.
	boolean
	Auto-generated method"

	^ supportsCompletionsRequest
]

{ #category : 'accessing' }
DAPCapabilities >> supportsCompletionsRequest: anObject [
	"The debug adapter supports the 'completions' request.
	boolean
	Auto-generated method"

	supportsCompletionsRequest := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsConditionalBreakpoints [
	"The debug adapter supports conditional breakpoints.
	boolean
	Auto-generated method"

	^ supportsConditionalBreakpoints
]

{ #category : 'accessing' }
DAPCapabilities >> supportsConditionalBreakpoints: anObject [
	"The debug adapter supports conditional breakpoints.
	boolean
	Auto-generated method"

	supportsConditionalBreakpoints := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsConfigurationDoneRequest [
	"The debug adapter supports the 'configurationDone' request.
	boolean
	Auto-generated method"

	^ supportsConfigurationDoneRequest
]

{ #category : 'accessing' }
DAPCapabilities >> supportsConfigurationDoneRequest: anObject [
	"The debug adapter supports the 'configurationDone' request.
	boolean
	Auto-generated method"

	supportsConfigurationDoneRequest := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsDataBreakpoints [
	"The debug adapter supports data breakpoints.
	boolean
	Auto-generated method"

	^ supportsDataBreakpoints
]

{ #category : 'accessing' }
DAPCapabilities >> supportsDataBreakpoints: anObject [
	"The debug adapter supports data breakpoints.
	boolean
	Auto-generated method"

	supportsDataBreakpoints := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsDebuggerProperties [
	"Manually added.
	boolean
	Auto-generated method"

	^ supportsDebuggerProperties
]

{ #category : 'accessing' }
DAPCapabilities >> supportsDebuggerProperties: anObject [
	"Manually added.
	boolean
	Auto-generated method"

	supportsDebuggerProperties := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsDelayedStackTraceLoading [
	"The debug adapter supports the delayed loading of parts of the stack, which requires that both the 'startFrame' and 'levels' arguments and an optional 'totalFrames' result of the 'StackTrace' request are supported.
	boolean
	Auto-generated method"

	^ supportsDelayedStackTraceLoading
]

{ #category : 'accessing' }
DAPCapabilities >> supportsDelayedStackTraceLoading: anObject [
	"The debug adapter supports the delayed loading of parts of the stack, which requires that both the 'startFrame' and 'levels' arguments and an optional 'totalFrames' result of the 'StackTrace' request are supported.
	boolean
	Auto-generated method"

	supportsDelayedStackTraceLoading := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsDisassembleRequest [
	"The debug adapter supports the 'disassemble' request.
	boolean
	Auto-generated method"

	^ supportsDisassembleRequest
]

{ #category : 'accessing' }
DAPCapabilities >> supportsDisassembleRequest: anObject [
	"The debug adapter supports the 'disassemble' request.
	boolean
	Auto-generated method"

	supportsDisassembleRequest := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsEvaluateForHovers [
	"The debug adapter supports a (side effect free) evaluate request for data hovers.
	boolean
	Auto-generated method"

	^ supportsEvaluateForHovers
]

{ #category : 'accessing' }
DAPCapabilities >> supportsEvaluateForHovers: anObject [
	"The debug adapter supports a (side effect free) evaluate request for data hovers.
	boolean
	Auto-generated method"

	supportsEvaluateForHovers := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsExceptionFilterOptions [
	"The debug adapter supports 'filterOptions' as an argument on the 'setExceptionBreakpoints' request.
	boolean
	Auto-generated method"

	^ supportsExceptionFilterOptions
]

{ #category : 'accessing' }
DAPCapabilities >> supportsExceptionFilterOptions: anObject [
	"The debug adapter supports 'filterOptions' as an argument on the 'setExceptionBreakpoints' request.
	boolean
	Auto-generated method"

	supportsExceptionFilterOptions := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsExceptionInfoRequest [
	"The debug adapter supports the 'exceptionInfo' request.
	boolean
	Auto-generated method"

	^ supportsExceptionInfoRequest
]

{ #category : 'accessing' }
DAPCapabilities >> supportsExceptionInfoRequest: anObject [
	"The debug adapter supports the 'exceptionInfo' request.
	boolean
	Auto-generated method"

	supportsExceptionInfoRequest := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsExceptionOptions [
	"The debug adapter supports 'exceptionOptions' on the setExceptionBreakpoints request.
	boolean
	Auto-generated method"

	^ supportsExceptionOptions
]

{ #category : 'accessing' }
DAPCapabilities >> supportsExceptionOptions: anObject [
	"The debug adapter supports 'exceptionOptions' on the setExceptionBreakpoints request.
	boolean
	Auto-generated method"

	supportsExceptionOptions := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsFunctionBreakpoints [
	"The debug adapter supports function breakpoints.
	boolean
	Auto-generated method"

	^ supportsFunctionBreakpoints
]

{ #category : 'accessing' }
DAPCapabilities >> supportsFunctionBreakpoints: anObject [
	"The debug adapter supports function breakpoints.
	boolean
	Auto-generated method"

	supportsFunctionBreakpoints := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsGotoTargetsRequest [
	"The debug adapter supports the 'gotoTargets' request.
	boolean
	Auto-generated method"

	^ supportsGotoTargetsRequest
]

{ #category : 'accessing' }
DAPCapabilities >> supportsGotoTargetsRequest: anObject [
	"The debug adapter supports the 'gotoTargets' request.
	boolean
	Auto-generated method"

	supportsGotoTargetsRequest := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsHitConditionalBreakpoints [
	"The debug adapter supports breakpoints that break execution after a specified number of hits.
	boolean
	Auto-generated method"

	^ supportsHitConditionalBreakpoints
]

{ #category : 'accessing' }
DAPCapabilities >> supportsHitConditionalBreakpoints: anObject [
	"The debug adapter supports breakpoints that break execution after a specified number of hits.
	boolean
	Auto-generated method"

	supportsHitConditionalBreakpoints := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsInstructionBreakpoints [
	"The debug adapter supports adding breakpoints based on instruction references.
	boolean
	Auto-generated method"

	^ supportsInstructionBreakpoints
]

{ #category : 'accessing' }
DAPCapabilities >> supportsInstructionBreakpoints: anObject [
	"The debug adapter supports adding breakpoints based on instruction references.
	boolean
	Auto-generated method"

	supportsInstructionBreakpoints := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsLoadedSourcesRequest [
	"The debug adapter supports the 'loadedSources' request.
	boolean
	Auto-generated method"

	^ supportsLoadedSourcesRequest
]

{ #category : 'accessing' }
DAPCapabilities >> supportsLoadedSourcesRequest: anObject [
	"The debug adapter supports the 'loadedSources' request.
	boolean
	Auto-generated method"

	supportsLoadedSourcesRequest := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsLogPoints [
	"The debug adapter supports logpoints by interpreting the 'logMessage' attribute of the SourceBreakpoint.
	boolean
	Auto-generated method"

	^ supportsLogPoints
]

{ #category : 'accessing' }
DAPCapabilities >> supportsLogPoints: anObject [
	"The debug adapter supports logpoints by interpreting the 'logMessage' attribute of the SourceBreakpoint.
	boolean
	Auto-generated method"

	supportsLogPoints := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsModulesRequest [
	"The debug adapter supports the 'modules' request.
	boolean
	Auto-generated method"

	^ supportsModulesRequest
]

{ #category : 'accessing' }
DAPCapabilities >> supportsModulesRequest: anObject [
	"The debug adapter supports the 'modules' request.
	boolean
	Auto-generated method"

	supportsModulesRequest := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsReadMemoryRequest [
	"The debug adapter supports the 'readMemory' request.
	boolean
	Auto-generated method"

	^ supportsReadMemoryRequest
]

{ #category : 'accessing' }
DAPCapabilities >> supportsReadMemoryRequest: anObject [
	"The debug adapter supports the 'readMemory' request.
	boolean
	Auto-generated method"

	supportsReadMemoryRequest := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsRestartFrame [
	"The debug adapter supports restarting a frame.
	boolean
	Auto-generated method"

	^ supportsRestartFrame
]

{ #category : 'accessing' }
DAPCapabilities >> supportsRestartFrame: anObject [
	"The debug adapter supports restarting a frame.
	boolean
	Auto-generated method"

	supportsRestartFrame := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsRestartRequest [
	"The debug adapter supports the 'restart' request. In this case a client should not implement 'restart' by terminating and relaunching the adapter but by calling the RestartRequest.
	boolean
	Auto-generated method"

	^ supportsRestartRequest
]

{ #category : 'accessing' }
DAPCapabilities >> supportsRestartRequest: anObject [
	"The debug adapter supports the 'restart' request. In this case a client should not implement 'restart' by terminating and relaunching the adapter but by calling the RestartRequest.
	boolean
	Auto-generated method"

	supportsRestartRequest := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsSetExpression [
	"The debug adapter supports the 'setExpression' request.
	boolean
	Auto-generated method"

	^ supportsSetExpression
]

{ #category : 'accessing' }
DAPCapabilities >> supportsSetExpression: anObject [
	"The debug adapter supports the 'setExpression' request.
	boolean
	Auto-generated method"

	supportsSetExpression := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsSetVariable [
	"The debug adapter supports setting a variable to a value.
	boolean
	Auto-generated method"

	^ supportsSetVariable
]

{ #category : 'accessing' }
DAPCapabilities >> supportsSetVariable: anObject [
	"The debug adapter supports setting a variable to a value.
	boolean
	Auto-generated method"

	supportsSetVariable := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsStepBack [
	"The debug adapter supports stepping back via the 'stepBack' and 'reverseContinue' requests.
	boolean
	Auto-generated method"

	^ supportsStepBack
]

{ #category : 'accessing' }
DAPCapabilities >> supportsStepBack: anObject [
	"The debug adapter supports stepping back via the 'stepBack' and 'reverseContinue' requests.
	boolean
	Auto-generated method"

	supportsStepBack := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsStepInTargetsRequest [
	"The debug adapter supports the 'stepInTargets' request.
	boolean
	Auto-generated method"

	^ supportsStepInTargetsRequest
]

{ #category : 'accessing' }
DAPCapabilities >> supportsStepInTargetsRequest: anObject [
	"The debug adapter supports the 'stepInTargets' request.
	boolean
	Auto-generated method"

	supportsStepInTargetsRequest := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsSteppingGranularity [
	"The debug adapter supports stepping granularities (argument 'granularity') for the stepping requests.
	boolean
	Auto-generated method"

	^ supportsSteppingGranularity
]

{ #category : 'accessing' }
DAPCapabilities >> supportsSteppingGranularity: anObject [
	"The debug adapter supports stepping granularities (argument 'granularity') for the stepping requests.
	boolean
	Auto-generated method"

	supportsSteppingGranularity := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsTerminateDebuggee [
	"The debug adapter supports the 'terminateDebuggee' attribute on the 'disconnect' request.
	boolean
	Auto-generated method"

	^ supportsTerminateDebuggee
]

{ #category : 'accessing' }
DAPCapabilities >> supportsTerminateDebuggee: anObject [
	"The debug adapter supports the 'terminateDebuggee' attribute on the 'disconnect' request.
	boolean
	Auto-generated method"

	supportsTerminateDebuggee := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsTerminateRequest [
	"The debug adapter supports the 'terminate' request.
	boolean
	Auto-generated method"

	^ supportsTerminateRequest
]

{ #category : 'accessing' }
DAPCapabilities >> supportsTerminateRequest: anObject [
	"The debug adapter supports the 'terminate' request.
	boolean
	Auto-generated method"

	supportsTerminateRequest := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsTerminateThreadsRequest [
	"The debug adapter supports the 'terminateThreads' request.
	boolean
	Auto-generated method"

	^ supportsTerminateThreadsRequest
]

{ #category : 'accessing' }
DAPCapabilities >> supportsTerminateThreadsRequest: anObject [
	"The debug adapter supports the 'terminateThreads' request.
	boolean
	Auto-generated method"

	supportsTerminateThreadsRequest := anObject

]

{ #category : 'accessing' }
DAPCapabilities >> supportsValueFormattingOptions [
	"The debug adapter supports a 'format' attribute on the stackTraceRequest, variablesRequest, and evaluateRequest.
	boolean
	Auto-generated method"

	^ supportsValueFormattingOptions
]

{ #category : 'accessing' }
DAPCapabilities >> supportsValueFormattingOptions: anObject [
	"The debug adapter supports a 'format' attribute on the stackTraceRequest, variablesRequest, and evaluateRequest.
	boolean
	Auto-generated method"

	supportsValueFormattingOptions := anObject

]
