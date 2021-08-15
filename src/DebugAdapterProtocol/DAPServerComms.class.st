"
DAPServerComms subclasses are responisble for low level communications with the remote server, sending and receiving DAP packets, which are of the format:

`Content-Length: <length><CRLF><CRLF>{ <JSON encoded object }`

It is up to the debugger to configure the server comms object appropriately and pass it to the client.  The client will then send #run to start the comms.

"
Class {
	#name : 'DAPServerComms',
	#superclass : 'Object',
	#instVars : [
		'client'
	],
	#category : 'DebugAdapterProtocol-Client'
}

{ #category : 'accessing' }
DAPServerComms >> client [
	^ client
]

{ #category : 'accessing' }
DAPServerComms >> client: anObject [
	client := anObject
]

{ #category : 'running' }
DAPServerComms >> connect [

	self subclassResponsibility
]

{ #category : 'running' }
DAPServerComms >> disconnect [

	self subclassResponsibility
]

{ #category : 'accessing' }
DAPServerComms >> flush [ 

	self subclassResponsibility
]

{ #category : 'testing' }
DAPServerComms >> isConnected [ 

	^ self subclassResponsibility 
]

{ #category : 'testing' }
DAPServerComms >> isDisconnected [ 

	^ self subclassResponsibility 
]

{ #category : 'accessing' }
DAPServerComms >> nextPutAll: aByteArray [

	self subclassResponsibility 
]
