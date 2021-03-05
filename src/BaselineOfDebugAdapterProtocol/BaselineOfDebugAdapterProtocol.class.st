Class {
	#name : #BaselineOfDebugAdapterProtocol,
	#superclass : #BaselineOf,
	#category : #BaselineOfDebugAdapterProtocol
}

{ #category : #baselines }
BaselineOfDebugAdapterProtocol >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			spec package: 'DebugAdapterProtocol' ]
]
