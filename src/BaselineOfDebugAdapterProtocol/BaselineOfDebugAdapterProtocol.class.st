Class {
	#name : #BaselineOfDebugAdapterProtocol,
	#superclass : #BaselineOf,
	#category : 'BaselineOfDebugAdapterProtocol'
}

{ #category : #baselines }
BaselineOfDebugAdapterProtocol >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			spec postLoadDoIt: #'postLoadSetup:'.
			spec package: 'DebugAdapterProtocol' ]
]

{ #category : #'post load' }
BaselineOfDebugAdapterProtocol >> postLoadSetup: spec [
	"Register the JS debugger"

	GtDAPDebugSessionElement register.
	GtPostMortemSessionElement register.
]
