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
				spec repository: 'github://feenkcom/pharo-debugadapterprotocol:main/src' ];
			baseline: 'Chrome' with: [
				spec repository: 'github://feenkcom/Pharo-Chrome:main/repository' ].
		spec package: 'DebugAdapterProtocol-ChromeDevTools' with: [
				spec requires: #('DebugAdapterProtocol' 'Chrome' ). ]. ].

]
