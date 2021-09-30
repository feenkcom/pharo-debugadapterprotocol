"
Arguments for 'launch' request. Additional attributes are implementation specific.

"
Class {
	#name : #DAPLaunchRequestArguments,
	#superclass : #DAPObject,
	#instVars : [
		'__restart',
		'noDebug'
	],
	#category : 'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPLaunchRequestArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #__restart to: #__restart.
		mapping mapAccessor: #noDebug to: #noDebug.
		].

]

{ #category : #accessing }
DAPLaunchRequestArguments >> __restart [
	"Optional data from the previous, restarted session.
The data is sent as the 'restart' attribute of the 'terminated' event.
The client should leave the data intact.
	arraybooleanintegernullnumberobjectstring
	Auto-generated method"

	^ __restart
]

{ #category : #accessing }
DAPLaunchRequestArguments >> __restart: anObject [
	"Optional data from the previous, restarted session.
The data is sent as the 'restart' attribute of the 'terminated' event.
The client should leave the data intact.
	arraybooleanintegernullnumberobjectstring
	Auto-generated method"

	__restart := anObject

]

{ #category : #visiting }
DAPLaunchRequestArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitLaunchRequestArguments: self
]

{ #category : #accessing }
DAPLaunchRequestArguments >> noDebug [
	"If noDebug is true the launch request should launch the program without enabling debugging.
	boolean
	Auto-generated method"

	^ noDebug
]

{ #category : #accessing }
DAPLaunchRequestArguments >> noDebug: anObject [
	"If noDebug is true the launch request should launch the program without enabling debugging.
	boolean
	Auto-generated method"

	noDebug := anObject

]

{ #category : #accessing }
DAPLaunchRequestArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(__restart noDebug )
]
