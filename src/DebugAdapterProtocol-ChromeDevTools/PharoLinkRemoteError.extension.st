Extension { #name : #PharoLinkRemoteError }

{ #category : #'*DebugAdapterProtocol-ChromeDevTools' }
PharoLinkRemoteError >> debuggerClient [

	^ self application debuggerClientFor: self
]
