Class {
	#name : #DAPJavaScriptDebugger,
	#superclass : #DAPDebugger,
	#category : #'DebugAdapterProtocol-ChromeDevTools'
}

{ #category : #accessing }
DAPJavaScriptDebugger >> cdtDebugger: aCDTDebugger [ 

	client := CDTDebuggerClient new cdtDebugger: aCDTDebugger debugger: self.

]

{ #category : #'start-stop' }
DAPJavaScriptDebugger >> close [ 

	self disconnect
]
