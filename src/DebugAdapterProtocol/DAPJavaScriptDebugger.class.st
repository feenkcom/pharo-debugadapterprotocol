Class {
	#name : #DAPJavaScriptDebugger,
	#superclass : #DAPDebugger,
	#category : #'DebugAdapterProtocol-Client'
}

{ #category : #accessing }
DAPJavaScriptDebugger >> cdtDebugger: aCDTDebugger [ 

	client := CDTDebuggerClient new cdtDebugger: aCDTDebugger debugger: self.

]
