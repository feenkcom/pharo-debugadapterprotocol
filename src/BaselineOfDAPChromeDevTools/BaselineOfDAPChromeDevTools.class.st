Class {
	#name : #BaselineOfDAPChromeDevTools,
	#superclass : #BaselineOf,
	#category : #BaselineOfDAPChromeDevTools
}

{ #category : #baselines }
BaselineOfDAPChromeDevTools >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			spec 
				baseline: 'DebugAdapterProtocol';
				baseline: 'Chrome' with: [ 
					spec repository: 'github://feenkcom/Pharo-Chrome/repository' ].
			spec package: 'DebugAdapterProtocol-ChromeDevTools' with: 
				[ spec requires: #(DebugAdapterProtocol Chrome) ] ].
]
