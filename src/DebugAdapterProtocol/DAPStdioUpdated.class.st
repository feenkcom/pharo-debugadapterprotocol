Class {
	#name : 'DAPStdioUpdated',
	#superclass : 'DAPAnnouncement',
	#instVars : [
		'string'
	],
	#category : 'DebugAdapterProtocol-Announcments'
}

{ #category : 'accessing' }
DAPStdioUpdated >> string [
	^ string
]

{ #category : 'accessing' }
DAPStdioUpdated >> string: anObject [
	string := anObject
]
