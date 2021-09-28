"
Arguments for 'disconnect' request.

"
Class {
	#name : #DAPDisconnectArguments,
	#superclass : #DAPObject,
	#instVars : [
		'restart',
		'terminateDebuggee'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPDisconnectArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #terminateDebuggee to: #terminateDebuggee.
		mapping mapAccessor: #restart to: #restart.
		].

]

{ #category : #visiting }
DAPDisconnectArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitDisconnectArguments: self
]

{ #category : #accessing }
DAPDisconnectArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(restart terminateDebuggee )
]

{ #category : #accessing }
DAPDisconnectArguments >> restart [
	"A value of true indicates that this 'disconnect' request is part of a restart sequence.
	boolean
	Auto-generated method"

	^ restart
]

{ #category : #accessing }
DAPDisconnectArguments >> restart: anObject [
	"A value of true indicates that this 'disconnect' request is part of a restart sequence.
	boolean
	Auto-generated method"

	restart := anObject

]

{ #category : #accessing }
DAPDisconnectArguments >> terminateDebuggee [
	"Indicates whether the debuggee should be terminated when the debugger is disconnected.
If unspecified, the debug adapter is free to do whatever it thinks is best.
The attribute is only honored by a debug adapter if the capability 'supportTerminateDebuggee' is true.
	boolean
	Auto-generated method"

	^ terminateDebuggee
]

{ #category : #accessing }
DAPDisconnectArguments >> terminateDebuggee: anObject [
	"Indicates whether the debuggee should be terminated when the debugger is disconnected.
If unspecified, the debug adapter is free to do whatever it thinks is best.
The attribute is only honored by a debug adapter if the capability 'supportTerminateDebuggee' is true.
	boolean
	Auto-generated method"

	terminateDebuggee := anObject

]
