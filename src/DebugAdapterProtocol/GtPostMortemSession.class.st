"
GtPostMortemSession is a debugging session on a post-mortem exception.  So like DebugSession, it is able to model the exception that interrupted processing, and (normally) provide stack and stdio information.  But since the original process is gone, it isn't able to manipulate the process in any way (step into, over, etc.).

GtPostMortemSession works with multiple backends, e.g. Python, JavaScript and GemStone.  The differences are handled by the debuggerClient.
"
Class {
	#name : #GtPostMortemSession,
	#superclass : #DebugSession,
	#category : #'DebugAdapterProtocol-UI'
}

{ #category : #accessing }
GtPostMortemSession >> breakpoints [ 
	"There are never breakpoints in the postmortem debugger"
	<return: #Dictionary>

	^ Dictionary new
]

{ #category : #'private - accessing' }
GtPostMortemSession >> debuggerClient [
	"Answer the debugger, which is specific to the exception type"

	^ self exception debuggerClient

]

{ #category : #'private - accessing' }
GtPostMortemSession >> exception [
	"Answer the exception that triggered the debug session."

	^ exception ifNil: [ exception := self interruptedContext receiver exception ].

]

{ #category : #testing }
GtPostMortemSession >> isStopped [
	"The Post Mortem debugger can't be started"

	^ true
]

{ #category : #accessing }
GtPostMortemSession >> modules [ 
	"There are never loaded modules in the postmortem debugger"
	<return: #Dictionary>

	^ Dictionary new
]
