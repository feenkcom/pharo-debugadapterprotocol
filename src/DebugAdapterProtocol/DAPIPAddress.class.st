"
A host name and port to connect to

"
Class {
	#name : #DAPIPAddress,
	#superclass : #DAPObject,
	#instVars : [
		'host',
		'port'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPIPAddress class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #host to: #host.
		mapping mapAccessor: #port to: #port.
		].

]

{ #category : #visiting }
DAPIPAddress >> acceptVisitor: aVisitor [

	^ aVisitor visitIPAddress: self
]

{ #category : #accessing }
DAPIPAddress >> host [
	"The fully qualified domain name
	string
	Auto-generated method"

	^ host
]

{ #category : #accessing }
DAPIPAddress >> host: anObject [
	"The fully qualified domain name
	string
	Auto-generated method"

	host := anObject

]

{ #category : #accessing }
DAPIPAddress >> port [
	"The port number
	integer
	Auto-generated method"

	^ port
]

{ #category : #accessing }
DAPIPAddress >> port: anObject [
	"The port number
	integer
	Auto-generated method"

	port := anObject

]

{ #category : #printing }
DAPIPAddress >> printOn: aStream [

	super printOn: aStream.
	aStream
		<< '(';
		print: host;
		<< ': ';
		print: port;
		<< ')'
]

{ #category : #accessing }
DAPIPAddress >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(port host )
]
