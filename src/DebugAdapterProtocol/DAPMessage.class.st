"
A structured message object. Used to return errors from requests.

"
Class {
	#name : #DAPMessage,
	#superclass : #DAPObject,
	#instVars : [
		'format',
		'id',
		'sendTelemetry',
		'showUser',
		'url',
		'urlLabel',
		'variables'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPMessage class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #format to: #format.
		mapping mapAccessor: #url to: #url.
		mapping mapAccessor: #showUser to: #showUser.
		mapping mapAccessor: #urlLabel to: #urlLabel.
		mapping mapAccessor: #variables to: #variables.
		mapping mapAccessor: #id to: #id.
		mapping mapAccessor: #sendTelemetry to: #sendTelemetry.
		].

]

{ #category : #visiting }
DAPMessage >> acceptVisitor: aVisitor [

	^ aVisitor visitMessage: self
]

{ #category : #accessing }
DAPMessage >> format [
	"A format string for the message. Embedded variables have the form '{name}'.
If variable name starts with an underscore character, the variable does not contain user data (PII) and can be safely used for telemetry purposes.
	string
	Auto-generated method"

	^ format
]

{ #category : #accessing }
DAPMessage >> format: anObject [
	"A format string for the message. Embedded variables have the form '{name}'.
If variable name starts with an underscore character, the variable does not contain user data (PII) and can be safely used for telemetry purposes.
	string
	Auto-generated method"

	format := anObject

]

{ #category : #accessing }
DAPMessage >> id [
	"Unique identifier for the message.
	integer
	Auto-generated method"

	^ id
]

{ #category : #accessing }
DAPMessage >> id: anObject [
	"Unique identifier for the message.
	integer
	Auto-generated method"

	id := anObject

]

{ #category : #accessing }
DAPMessage >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(format id sendTelemetry showUser url urlLabel variables )
]

{ #category : #accessing }
DAPMessage >> sendTelemetry [
	"If true send to telemetry.
	boolean
	Auto-generated method"

	^ sendTelemetry
]

{ #category : #accessing }
DAPMessage >> sendTelemetry: anObject [
	"If true send to telemetry.
	boolean
	Auto-generated method"

	sendTelemetry := anObject

]

{ #category : #accessing }
DAPMessage >> showUser [
	"If true show user.
	boolean
	Auto-generated method"

	^ showUser
]

{ #category : #accessing }
DAPMessage >> showUser: anObject [
	"If true show user.
	boolean
	Auto-generated method"

	showUser := anObject

]

{ #category : #accessing }
DAPMessage >> url [
	"An optional url where additional information about this message can be found.
	string
	Auto-generated method"

	^ url
]

{ #category : #accessing }
DAPMessage >> url: anObject [
	"An optional url where additional information about this message can be found.
	string
	Auto-generated method"

	url := anObject

]

{ #category : #accessing }
DAPMessage >> urlLabel [
	"An optional label that is presented to the user as the UI for opening the url.
	string
	Auto-generated method"

	^ urlLabel
]

{ #category : #accessing }
DAPMessage >> urlLabel: anObject [
	"An optional label that is presented to the user as the UI for opening the url.
	string
	Auto-generated method"

	urlLabel := anObject

]

{ #category : #accessing }
DAPMessage >> variables [
	"An object used as a dictionary for looking up the variables in the format string.
	object
	Auto-generated method"

	^ variables
]

{ #category : #accessing }
DAPMessage >> variables: anObject [
	"An object used as a dictionary for looking up the variables in the format string.
	object
	Auto-generated method"

	variables := anObject

]
