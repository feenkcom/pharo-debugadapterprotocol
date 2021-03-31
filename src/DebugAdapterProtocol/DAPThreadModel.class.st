Class {
	#name : #DAPThreadModel,
	#superclass : #Object,
	#instVars : [
		'client',
		'threadId',
		'name',
		'latestEvent',
		'stackFrames',
		'totalStackFrames',
		'state'
	],
	#category : #'DebugAdapterProtocol-Model'
}

{ #category : #accessing }
DAPThreadModel >> client [
	^ client
]

{ #category : #accessing }
DAPThreadModel >> client: anObject [
	client := anObject
]

{ #category : #actions }
DAPThreadModel >> continue [ 
	"Continue execution of the receiver's thread"

	^ client continueThreadId: self threadId
]

{ #category : #accessing }
DAPThreadModel >> displayName [
	"Answer a string which represents the receiver"

	^ self name ifNil: [ 'Thread-', self threadId asString ]
]

{ #category : #ui }
DAPThreadModel >> gtStackFor: aView [
	<gtView>

	(self isStopped not or: 
		[ client isNil or: 
		[ client isTerminated or: 
		[ self stackFrames isNil or: 
		[ self stackFrames isEmpty	]]]]) ifTrue: 
			[ ^ aView empty ].

	^ aView columnedList
		title: 'Stack';
		priority: 10;
		items: [ self stackFrames collectWithIndex: [ :each :index | index -> each ] ];
		column: '#' text: [ :item | item key asString ] width: 50;
		column: 'Frame' text: [ :item | item value asString ];
		send: [ :item | item value ];
		actionUpdateButtonTooltip: 'Update Stack'

]

{ #category : #ui }
DAPThreadModel >> gtTopSourceFor: aView [
	<gtView>

	(self isStopped not or: 
		[ client isNil or: 
		[ client isTerminated or: 
		[ self stackFrames isNil or: 
		[ self stackFrames isEmpty	]]]]) ifTrue: 
			[ ^ aView empty ].
	^ aView textEditor
		title: 'Source';
		priority: 100;
		styler: PythonParser2 gtStyler;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self stackFrames first sourceText ];
		actionUpdateButtonTooltip: 'Update Source'

]

{ #category : #ui }
DAPThreadModel >> gtTopVariablesFor: aView [
	<gtView>

	(self isStopped not or: 
		[ client isNil or: 
		[ client isTerminated or: 
		[ self stackFrames isNil or: 
		[ self stackFrames isEmpty	]]]]) ifTrue: 
			[ ^ aView empty ].
	^ aView columnedTree
		title: 'Variables';
		priority: 10;
		items: [ self stackFrames first valuesDictionary associations ];
		children: [ :each | 
			each value isDictionary
				ifTrue: [ each value associations ]
				ifFalse: [ (each value isArray and: [ each value allSatisfy: #isDictionary ])
						ifTrue: [ each value collectWithIndex: [ :x :i | i -> x ] ]
						ifFalse: [ #() ] ] ];
		column: 'Key' text: [ :assoc | assoc key ];
		column: 'Value' text: [ :assoc | assoc value ];
		send: [ :assoc | assoc value ];
		actionUpdateButtonTooltip: 'Update Variables'

]

{ #category : #testing }
DAPThreadModel >> isContinued [

	^ self state = #continued
]

{ #category : #testing }
DAPThreadModel >> isStopped [

	^ self state = #stopped
]

{ #category : #testing }
DAPThreadModel >> isTerminated [

	^ self state = #terminated
]

{ #category : #accessing }
DAPThreadModel >> latestEvent [
	^ latestEvent
]

{ #category : #accessing }
DAPThreadModel >> latestEvent: anObject [
	latestEvent := anObject
]

{ #category : #accessing }
DAPThreadModel >> name [
	^ name
]

{ #category : #accessing }
DAPThreadModel >> name: anObject [
	name := anObject
]

{ #category : #actions }
DAPThreadModel >> next [
	"Step over the next statement"

	^ client nextInThreadId: self threadId
]

{ #category : #printing }
DAPThreadModel >> printOn: aStream [

	aStream
		<< 'Thread(';
		print: name;
		<< ', ';
		print: threadId;
		<< ', ';
		print: state;
		<< ')'
]

{ #category : #accessing }
DAPThreadModel >> stackFrames [
	^ stackFrames
]

{ #category : #accessing }
DAPThreadModel >> stackFrames: aCollection [ 

	stackFrames := aCollection.
	stackFrames doWithIndex: [ :frame :index | frame ordinal: index ].
]

{ #category : #accessing }
DAPThreadModel >> state [
	"The state of the receiver.
	One of: nil (no activity), #started, #continued, #stopped, #terminated"
	<return: #String>

	^ state
]

{ #category : #accessing }
DAPThreadModel >> state: aString [

	state := aString.
	state = #exited ifTrue:
		[ client removeThreadId: self threadId ].
	client announce: (DAPThreadStateChanged new thread: self)
]

{ #category : #actions }
DAPThreadModel >> stepBack [
	"Step over the next statement"

	^ client stepBackInThreadId: self threadId
]

{ #category : #actions }
DAPThreadModel >> stepInto [
	"Step over the next statement"

	^ client stepIntoInThreadId: self threadId
]

{ #category : #actions }
DAPThreadModel >> stepOut [
	"Step over the next statement"

	^ client stepOutInThreadId: self threadId
]

{ #category : #actions }
DAPThreadModel >> stepOver [
	"Step over the next statement"

	^ client stepOverInThreadId: self threadId
]

{ #category : #accessing }
DAPThreadModel >> threadId [
	^ threadId
]

{ #category : #accessing }
DAPThreadModel >> threadId: anObject [
	threadId := anObject
]

{ #category : #events }
DAPThreadModel >> threadTerminated [
	"Notification that the thread has been terminated"

	self state: #terminated.
	stackFrames := #().
	totalStackFrames := 0.
]

{ #category : #accessing }
DAPThreadModel >> totalStackFrames [
	^ totalStackFrames
]

{ #category : #accessing }
DAPThreadModel >> totalStackFrames: anObject [
	totalStackFrames := anObject
]

{ #category : #actions }
DAPThreadModel >> updateStack [

	client requestStackTraceForThreadId: self threadId startFrame: 0 levels: 20
]
