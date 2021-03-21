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
			spec baseline: 'DebugAdapterProtocol'.
			spec package: 'DebugAdapterProtocol-ChromeDevTools' with: 
				[ spec requires: #(DebugAdapterProtocol) ] ].
]
