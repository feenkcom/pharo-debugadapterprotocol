Class {
	#name : #BaselineOfDAPPythonBridge,
	#superclass : #BaselineOf,
	#category : #BaselineOfDAPPythonBridge
}

{ #category : #baselines }
BaselineOfDAPPythonBridge >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			spec baseline: 'DebugAdapterProtocol'.
			spec package: 'DebugAdapterProtocol-PythonBridge' with: 
				[ spec requires: #(DebugAdapterProtocol) ] ].
]
