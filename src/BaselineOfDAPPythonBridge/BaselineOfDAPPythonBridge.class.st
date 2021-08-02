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
				spec repository: 'github://feenkcom/pharo-debugadapterprotocol:main/src' ];
			baseline: 'PythonBridge' with: [
				spec repository: 'github://feenkcom/PythonBridge:main/src' ].
		spec package: 'DebugAdapterProtocol-PythonBridge' with: [
				spec requires: #('DebugAdapterProtocol' 'PythonBridge' ). ]. ].

]
