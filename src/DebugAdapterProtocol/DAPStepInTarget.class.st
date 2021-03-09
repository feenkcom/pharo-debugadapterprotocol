"
A StepInTarget can be used in the 'stepIn' request and determines into which single target the stepIn request should step.
"
Class {
	#name : #DAPStepInTarget,
	#superclass : #DAPObject,
	#instVars : [
		'id',
		'label'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPStepInTarget class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #label to: #label.
		mapping mapAccessor: #id to: #id.
		].

]

{ #category : #visiting }
DAPStepInTarget >> acceptVisitor: aVisitor [

	^ aVisitor visitStepInTarget: self
]

{ #category : #accessing }
DAPStepInTarget >> id [
	"Unique identifier for a stepIn target.
	integer
	Auto-generated method"

	^ id
]

{ #category : #accessing }
DAPStepInTarget >> id: anObject [
	"Unique identifier for a stepIn target.
	integer
	Auto-generated method"

	id := anObject

]

{ #category : #accessing }
DAPStepInTarget >> label [
	"The name of the stepIn target (shown in the UI).
	string
	Auto-generated method"

	^ label
]

{ #category : #accessing }
DAPStepInTarget >> label: anObject [
	"The name of the stepIn target (shown in the UI).
	string
	Auto-generated method"

	label := anObject

]

{ #category : #accessing }
DAPStepInTarget >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(id label )
]
