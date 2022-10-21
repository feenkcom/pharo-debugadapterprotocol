Class {
	#name : #BaselineOfDAPChromeDevTools,
	#superclass : #BaselineOf,
	#category : #BaselineOfDAPChromeDevTools
}

{ #category : #baseline }
BaselineOfDAPChromeDevTools >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'DebugAdapterProtocol' with: [
				spec repository: 'github://feenkcom/pharo-debugadapterprotocol:v0.5.185/src' ].
		spec
			baseline: 'Chrome' with: [
				spec repository: 'github://feenkcom/Pharo-Chrome:v0.5.149/repository' ].

		spec package: 'DebugAdapterProtocol-ChromeDevTools' with: [
			spec requires: #('DebugAdapterProtocol' 'Chrome') ].
	]
]
