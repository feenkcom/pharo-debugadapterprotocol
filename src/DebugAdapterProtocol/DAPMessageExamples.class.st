"
I show how Debug Adapter Protocol messages are read and written.
A debug adapter sends JSON, so the keys and values of a message are Strings: the protocol objects read and write their body with String keys, and the client compares the values it gets with Strings.
"
Class {
	#name : #DAPMessageExamples,
	#superclass : #Object,
	#category : #'DebugAdapterProtocol-Examples'
}

{ #category : #examples }
DAPMessageExamples >> clientFollowsThreadsFromMessages [
	"A client keeps a model of each thread an adapter reports: a thread event starts it, a threads response names it, and a thread event with the reason 'exited' removes it"
	<gtExample>
	<return: #DAPClient>
	| client |
	client := DAPClient new.
	client processMessage: '{"seq":1,"type":"event","event":"thread","body":{"reason":"started","threadId":1}}' utf8Encoded.
	self assert: (client threads at: 1) state equals: #started.
	client processMessage: '{"seq":2,"type":"response","request_seq":1,"success":true,"command":"threads","body":{"threads":[{"id":1,"name":"MainThread"}]}}' utf8Encoded.
	self assert: (client threads at: 1) name equals: 'MainThread'.
	client processMessage: '{"seq":3,"type":"event","event":"thread","body":{"reason":"exited","threadId":1}}' utf8Encoded.
	self assert: client threads isEmpty.
	^ client
]

{ #category : #examples }
DAPMessageExamples >> outputEventBuiltInTheImage [
	"An event built in the image keeps its body with String keys, like the JSON it is written to and read back from"
	<gtExample>
	<return: #DAPOutputEvent>
	| event json readEvent |
	event := DAPOutputEvent new
		body: Dictionary new;
		yourself.
	event
		category: 'stderr';
		output: 'Oops'.
	self assert: (event body at: 'category') equals: 'stderr'.
	json := String streamContents: [ :aStream | (DAPJson new writerOn: aStream) nextPut: event ].
	readEvent := DAPObject fromJSONDictionary: (STONJSON fromString: json) client: nil.
	self assert: readEvent class equals: DAPOutputEvent.
	self assert: readEvent category equals: 'stderr'.
	self assert: readEvent output equals: 'Oops'.
	^ readEvent
]

{ #category : #examples }
DAPMessageExamples >> outputEventFromJson [
	"An output event read as the client reads it: the JSON has String keys and values"
	<gtExample>
	<return: #DAPOutputEvent>
	| event |
	event := DAPObject
		fromJSONDictionary: (STONJSON fromString: self outputEventJson)
		client: nil.
	self assert: event class equals: DAPOutputEvent.
	self assert: event category equals: 'stdout'.
	self assert: event output equals: 'Hello'.
	^ event
]

{ #category : #examples }
DAPMessageExamples >> outputEventJson [
	"An output event as a debug adapter sends it"

	^ '{"seq":7,"type":"event","event":"output","body":{"category":"stdout","output":"Hello"}}'
]
