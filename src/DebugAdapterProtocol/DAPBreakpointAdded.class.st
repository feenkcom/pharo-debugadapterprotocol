Class {
	#name : 'DAPBreakpointAdded',
	#superclass : 'DAPAnnouncement',
	#instVars : [
		'breakpoint'
	],
	#category : 'DebugAdapterProtocol-Announcments'
}

{ #category : 'accessing' }
DAPBreakpointAdded >> breakpoint [
	^ breakpoint
]

{ #category : 'accessing' }
DAPBreakpointAdded >> breakpoint: anObject [
	breakpoint := anObject
]
