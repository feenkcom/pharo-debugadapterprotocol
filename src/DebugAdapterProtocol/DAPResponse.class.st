"
Response for a request.
"
Class {
	#name : #DAPResponse,
	#superclass : #DAPProtocolMessage,
	#instVars : [
		'body',
		'command',
		'message',
		'request_seq',
		'success'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #request_seq to: #request_seq.
		mapping mapAccessor: #body to: #body.
		mapping mapAccessor: #message to: #message.
		mapping mapAccessor: #success to: #success.
		mapping mapAccessor: #type to: #type.
		mapping mapAccessor: #command to: #command.
		].

]

{ #category : #accessing }
DAPResponse class >> typeEnums [
	"Enumerated types for the associated attribute"

	^ #(response )
]

{ #category : #visiting }
DAPResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitResponse: self
]

{ #category : #accessing }
DAPResponse >> body [
	"Contains request result if success is true and optional error details if success is false.
	arraybooleanintegernullnumberobjectstring
	Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPResponse >> body: anObject [
	"Contains request result if success is true and optional error details if success is false.
	arraybooleanintegernullnumberobjectstring
	Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPResponse >> command [
	"The command requested.
	string
	Auto-generated method"

	^ command
]

{ #category : #accessing }
DAPResponse >> command: anObject [
	"The command requested.
	string
	Auto-generated method"

	command := anObject

]

{ #category : #initialization }
DAPResponse >> initialize [

	super initialize.
	body := Dictionary new.
]

{ #category : #accessing }
DAPResponse >> message [
	"Contains the raw error in short form if 'success' is false.
This raw error might be interpreted by the frontend and is not shown in the UI.
Some predefined values exist.
	string
	Auto-generated method"

	^ message
]

{ #category : #accessing }
DAPResponse >> message: anObject [
	"Contains the raw error in short form if 'success' is false.
This raw error might be interpreted by the frontend and is not shown in the UI.
Some predefined values exist.
	string
	Auto-generated method"

	message := anObject

]

{ #category : #printing }
DAPResponse >> printOn: aStream [

	super printOn: aStream.
	success ifNotNil: 
		[ success ifTrue: 
			[ aStream << '(successful)' ]
		ifFalse:
			[ aStream
				<< '(unsuccessful, ';
				print: message;
				<< ')' ] ]
]

{ #category : #accessing }
DAPResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body command message request_seq success type )
]

{ #category : #accessing }
DAPResponse >> request_seq [
	"Sequence number of the corresponding request.
	integer
	Auto-generated method"

	^ request_seq
]

{ #category : #accessing }
DAPResponse >> request_seq: anObject [
	"Sequence number of the corresponding request.
	integer
	Auto-generated method"

	request_seq := anObject

]

{ #category : #accessing }
DAPResponse >> success [
	"Outcome of the request.
If true, the request was successful and the 'body' attribute may contain the result of the request.
If the value is false, the attribute 'message' contains the error in short form and the 'body' may contain additional information (see 'ErrorResponse.body.error').
	boolean
	Auto-generated method"

	^ success
]

{ #category : #accessing }
DAPResponse >> success: anObject [
	"Outcome of the request.
If true, the request was successful and the 'body' attribute may contain the result of the request.
If the value is false, the attribute 'message' contains the error in short form and the 'body' may contain additional information (see 'ErrorResponse.body.error').
	boolean
	Auto-generated method"

	success := anObject

]

{ #category : #accessing }
DAPResponse >> type [
	"response: 
	Auto-generated method"

	^ type ifNil: [ 'response' ]
]

{ #category : #accessing }
DAPResponse >> type: anObject [
	"response: 
	Auto-generated method"

	type := anObject

]
