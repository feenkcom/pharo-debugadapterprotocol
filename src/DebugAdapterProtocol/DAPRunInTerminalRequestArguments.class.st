"
Arguments for 'runInTerminal' request.

"
Class {
	#name : #DAPRunInTerminalRequestArguments,
	#superclass : #DAPObject,
	#instVars : [
		'args',
		'cwd',
		'env',
		'kind',
		'title'
	],
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPRunInTerminalRequestArguments class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #args to: #args.
		mapping mapAccessor: #cwd to: #cwd.
		mapping mapAccessor: #kind to: #kind.
		mapping mapAccessor: #title to: #title.
		mapping mapAccessor: #env to: #env.
		].

]

{ #category : #accessing }
DAPRunInTerminalRequestArguments class >> kindEnums [
	"Enumerated types for the associated attribute"

	^ #(integrated external )
]

{ #category : #visiting }
DAPRunInTerminalRequestArguments >> acceptVisitor: aVisitor [

	^ aVisitor visitRunInTerminalRequestArguments: self
]

{ #category : #accessing }
DAPRunInTerminalRequestArguments >> args [
	"List of arguments. The first argument is the command to run.
	array
	Auto-generated method"

	^ args
]

{ #category : #accessing }
DAPRunInTerminalRequestArguments >> args: anObject [
	"List of arguments. The first argument is the command to run.
	array
	Auto-generated method"

	args := anObject

]

{ #category : #accessing }
DAPRunInTerminalRequestArguments >> cwd [
	"Working directory for the command. For non-empty, valid paths this typically results in execution of a change directory command.
	string
	Auto-generated method"

	^ cwd
]

{ #category : #accessing }
DAPRunInTerminalRequestArguments >> cwd: anObject [
	"Working directory for the command. For non-empty, valid paths this typically results in execution of a change directory command.
	string
	Auto-generated method"

	cwd := anObject

]

{ #category : #accessing }
DAPRunInTerminalRequestArguments >> env [
	"Environment key-value pairs that are added to or removed from the default environment.
	object
	Auto-generated method"

	^ env
]

{ #category : #accessing }
DAPRunInTerminalRequestArguments >> env: anObject [
	"Environment key-value pairs that are added to or removed from the default environment.
	object
	Auto-generated method"

	env := anObject

]

{ #category : #accessing }
DAPRunInTerminalRequestArguments >> kind [
	"What kind of terminal to launch.
	string
	integrated: 
	external: 
	Auto-generated method"

	^ kind ifNil: [ 'integrated' ]
]

{ #category : #accessing }
DAPRunInTerminalRequestArguments >> kind: anObject [
	"What kind of terminal to launch.
	string
	integrated: 
	external: 
	Auto-generated method"

	kind := anObject

]

{ #category : #accessing }
DAPRunInTerminalRequestArguments >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(args cwd env kind title )
]

{ #category : #accessing }
DAPRunInTerminalRequestArguments >> title [
	"Optional title of the terminal.
	string
	Auto-generated method"

	^ title
]

{ #category : #accessing }
DAPRunInTerminalRequestArguments >> title: anObject [
	"Optional title of the terminal.
	string
	Auto-generated method"

	title := anObject

]
