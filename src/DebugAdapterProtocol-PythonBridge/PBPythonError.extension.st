Extension { #name : #PBPythonError }

{ #category : #'*DebugAdapterProtocol-PythonBridge' }
PBPythonError >> debuggerClient [

	^ GtPythonPostMortemDebugger new exception: self
]
