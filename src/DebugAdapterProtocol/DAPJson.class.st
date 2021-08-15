Class {
	#name : 'DAPJson',
	#superclass : 'Object',
	#category : 'DebugAdapterProtocol-JSON'
}

{ #category : 'private' }
DAPJson >> dapMappingFor: aNeoJSONMapper [

	DAPObject allSubclassesDo: [ :cls |
		cls dapJsonMappingFor: aNeoJSONMapper ]
]

{ #category : 'private' }
DAPJson >> writerOn: aStream [
	"Answer a NewJSONWriter configured for the DAP protocol"
	| writer |

	writer := NeoJSONWriter on: aStream.
	writer prettyPrint: false.
	self dapMappingFor: writer.
	^ writer
]
