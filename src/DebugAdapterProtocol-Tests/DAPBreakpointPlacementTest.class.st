"
I cover the two questions a breakpoint asks that have no adapter in them:
which form on a line a reader means, and which breakpoint they mean when the
back end has moved one.
"
Class {
	#name : #DAPBreakpointPlacementTest,
	#superclass : #TestCase,
	#instVars : [
		'client',
		'source'
	],
	#category : #'DebugAdapterProtocol-Tests'
}

{ #category : #running }
DAPBreakpointPlacementTest >> placeAtColumn: aColumn to: anEndColumn [
	^ { 'line' -> 2. 'column' -> aColumn. 'endColumn' -> anEndColumn } asDictionary
]

{ #category : #running }
DAPBreakpointPlacementTest >> setUp [
	"Four places on one line, outermost first, the way an adapter reports the
	nested forms of `(println (fmt (twice (+ 1 2))))`."

	super setUp.
	source := DAPSource new.
	client := DAPTestClient new.
	client places: {
		self placeAtColumn: 1 to: 40.
		self placeAtColumn: 18 to: 38.
		self placeAtColumn: 25 to: 36.
		self placeAtColumn: 31 to: 35 }
]

{ #category : #tests }
DAPBreakpointPlacementTest >> testAdapterWithNoPlacesAnswersTheLineAsAsked [
	client places: #().
	self assert: ((client breakpointPlaceIn: source line: 2 column: 7) at: 'line') equals: 2.
	self deny: ((client breakpointPlaceIn: source line: 2 column: 7) includesKey: 'column')
]

{ #category : #tests }
DAPBreakpointPlacementTest >> testBreakpointIsFoundByTheLineItWasAskedFor [
	| spec |
	spec := client specForLine: 3 column: nil.
	self assert: (client entry: spec -> 4 isAt: 3 column: nil)
]

{ #category : #tests }
DAPBreakpointPlacementTest >> testBreakpointIsFoundByTheLineTheBackEndMovedItTo [
	"lldb-dap puts a breakpoint on the next line that has code, so a reader
	pointing at the line it ended up on means that breakpoint too."

	| spec |
	spec := client specForLine: 3 column: nil.
	self assert: (client entry: spec -> 4 isAt: 4 column: nil).
	self deny: (client entry: spec -> 4 isAt: 5 column: nil)
]

{ #category : #tests }
DAPBreakpointPlacementTest >> testCursorInsideNestedFormsMeansTheInnermost [
	self assert: ((client breakpointPlaceIn: source line: 2 column: 32) at: 'column') equals: 31.
	self assert: ((client breakpointPlaceIn: source line: 2 column: 26) at: 'column') equals: 25
]

{ #category : #tests }
DAPBreakpointPlacementTest >> testCursorOutsideEveryFormMeansTheFirstPlace [
	self assert: ((client breakpointPlaceIn: source line: 2 column: 45) at: 'column') equals: 1
]

{ #category : #tests }
DAPBreakpointPlacementTest >> testNoColumnMeansTheOutermostFormOnTheLine [
	"A caller pointing at the line rather than into a form says so with no
	column, or with a zero, which is the same statement in the protocol's
	terms. Both used to be answered as if the cursor sat before every form."

	self assert: ((client breakpointPlaceIn: source line: 2 column: nil) at: 'column') equals: 1.
	self assert: ((client breakpointPlaceIn: source line: 2 column: 0) at: 'column') equals: 1
]

{ #category : #tests }
DAPBreakpointPlacementTest >> testSpecsAreRememberedWithWhereTheyEndedUp [
	| specs confirmed entries |
	specs := { client specForLine: 3 column: nil. client specForLine: 9 column: nil }.
	confirmed := { { 'line' -> 4 } asDictionary. { 'line' -> 9 } asDictionary }.
	client rememberSpecs: specs resolvedFrom: confirmed inSource: '/tmp/a.carp'.
	entries := client breakpointEntriesInSource: '/tmp/a.carp'.
	self assert: (entries collect: [ :each | each value ]) asArray equals: #(4 9).
	self assert: ((entries first key) at: 'line') equals: 3
]
