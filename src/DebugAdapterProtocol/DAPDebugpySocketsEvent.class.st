Class {
	#name : #DAPDebugpySocketsEvent,
	#superclass : #DAPEvent,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #accessing }
DAPDebugpySocketsEvent class >> eventEnums [
	"Enumerated types for the associated attribute"

	^ #(debugpySockets)
]

{ #category : #visiting }
DAPDebugpySocketsEvent >> acceptVisitor: aVisitor [

	^ aVisitor visitDebugpySocketsEvent: self
]

{ #category : #accessing }
DAPDebugpySocketsEvent >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(sockets)
]

{ #category : #accessing }
DAPDebugpySocketsEvent >> sockets [
	^ self body at: #sockets
]
