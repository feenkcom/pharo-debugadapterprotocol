"
Response to 'readMemory' request.
"
Class {
	#name : #DAPReadMemoryResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPReadMemoryResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #visiting }
DAPReadMemoryResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitReadMemoryResponse: self
]

{ #category : #accessing }
DAPReadMemoryResponse >> address [
	"The address of the first byte of data returned.
Treated as a hex value if prefixed with '0x', or as a decimal value otherwise.
	string
	Auto-generated method"
	| result |

	result := self body at: #address ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPReadMemoryResponse >> address: anObject [
	"The address of the first byte of data returned.
Treated as a hex value if prefixed with '0x', or as a decimal value otherwise.
	string
	Auto-generated method"

	self body at: #address put: anObject
]

{ #category : #accessing }
DAPReadMemoryResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPReadMemoryResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPReadMemoryResponse >> data [
	"The bytes read from memory, encoded using base64.
	string
	Auto-generated method"
	| result |

	result := self body at: #data ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPReadMemoryResponse >> data: anObject [
	"The bytes read from memory, encoded using base64.
	string
	Auto-generated method"

	self body at: #data put: anObject
]

{ #category : #accessing }
DAPReadMemoryResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body unreadableBytes data address )
]

{ #category : #accessing }
DAPReadMemoryResponse >> unreadableBytes [
	"The number of unreadable bytes encountered after the last successfully read byte.
This can be used to determine the number of bytes that must be skipped before a subsequent 'readMemory' request will succeed.
	integer
	Auto-generated method"
	| result |

	result := self body at: #unreadableBytes ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPReadMemoryResponse >> unreadableBytes: anObject [
	"The number of unreadable bytes encountered after the last successfully read byte.
This can be used to determine the number of bytes that must be skipped before a subsequent 'readMemory' request will succeed.
	integer
	Auto-generated method"

	self body at: #unreadableBytes put: anObject
]
