Class {
	#name : #BaselineOfDAPPythonBridge,
	#superclass : #BaselineOf,
	#category : #BaselineOfDAPPythonBridge
}

{ #category : #baseline }
BaselineOfDAPPythonBridge >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'DebugAdapterProtocol' with: [
				spec repository: 'github://feenkcom/pharo-debugadapterprotocol:v0.5.257/src' ].
		spec
			baseline: 'PythonBridge' with: [
				spec repository: 'github://feenkcom/PythonBridge:v0.5.206/src' ].

		spec package: 'DebugAdapterProtocol-PythonBridge' with: [
			spec requires: #('DebugAdapterProtocol' 'PythonBridge') ].
	]
]
