Class {
	#name : #DAPSocketComms,
	#superclass : #DAPServerComms,
	#instVars : [
		'host',
		'port',
		'socketStream',
		'socketState',
		'messageListener'
	],
	#category : #'DebugAdapterProtocol-Client'
}

{ #category : #running }
DAPSocketComms >> connect [ 

	socketStream := DAPSocketStream openConnectionToHost: host port: port.
	"Messages are presumed to be UTF-8 encoded text, which appears as binary to the Socket"
	socketStream 
		binary;
		noTimeout.
	socketState := #connected.
	self startMessageListener.
]

{ #category : #running }
DAPSocketComms >> disconnect [ 

	socketStream close.
	socketState := #disconnected.
]

{ #category : #accessing }
DAPSocketComms >> flush [ 

	socketStream flush
]

{ #category : #accessing }
DAPSocketComms >> host [
	^ host
]

{ #category : #accessing }
DAPSocketComms >> host: anObject [
	host := anObject
]

{ #category : #testing }
DAPSocketComms >> isConnected [
	"Answer a boolean indicating whether the connection to the remote debugger is open"

	^ socketState = #connected
]

{ #category : #testing }
DAPSocketComms >> isDisconnected [
	"Answer a boolean indicating whether the connection to the remote debugger is disconnected"

	^ socketState = #disconnected
]

{ #category : #accessing }
DAPSocketComms >> nextPutAll: aByteArray [

	socketStream nextPutAll: aByteArray
]

{ #category : #accessing }
DAPSocketComms >> port [
	^ port
]

{ #category : #accessing }
DAPSocketComms >> port: anObject [
	port := anObject
]

{ #category : #'private - communication' }
DAPSocketComms >> readNextMessage [
	"Read a message from the remote debugger.
	All messages begin with 'Content-Length: <an Integer><CRLF><CRLF>'"
	| contentLengthLine contentLength lineEnd |

	contentLengthLine := socketStream upToAll: String crlf asByteArray.
	"We can use #asString here since it should only be digits"
	contentLength := (contentLengthLine copyFrom: 17 to: contentLengthLine size)  asString trimBoth asNumber.
	self assert: [ contentLength > 2 ].
	"The first CRLF has been consumed, grab the second"
	lineEnd := socketStream next: 2.
	self assert: [ lineEnd = String crlf asByteArray ].
	^ socketStream next: contentLength.
]

{ #category : #'private - communication' }
DAPSocketComms >> startMessageListener [
	"Start the process for receiving and processing messages from the remote debugger."

	messageListener := [ [ self isConnected ] whileTrue: 
		[ [ client nextPutReceivedMessage: self readNextMessage ]
			on: ConnectionClosed 
			do: [ :ex | socketState := #disconnected ] ].
		] forkAt: Processor userSchedulingPriority - 1 named: 'DAP Listener'.
]
