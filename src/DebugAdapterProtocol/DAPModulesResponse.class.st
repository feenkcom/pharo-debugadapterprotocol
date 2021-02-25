"
Response to 'modules' request.
"
Class {
	#name : #DAPModulesResponse,
	#superclass : #DAPResponse,
	#category : #'DebugAdapterProtocol-Protocol'
}

{ #category : #'json - configuration' }
DAPModulesResponse class >> dapJsonMappingFor: aNeoJSONMapper [

	super dapJsonMappingFor: aNeoJSONMapper.
	aNeoJSONMapper for: self do: [ :mapping |
		mapping mapAccessor: #body to: #body.
		].

]

{ #category : #visiting }
DAPModulesResponse >> acceptVisitor: aVisitor [

	^ aVisitor visitModulesResponse: self
]

{ #category : #accessing }
DAPModulesResponse >> body [
	"Auto-generated method"

	^ body
]

{ #category : #accessing }
DAPModulesResponse >> body: anObject [
	"Auto-generated method"

	body := anObject

]

{ #category : #accessing }
DAPModulesResponse >> modules [
	"All modules or range of modules.
	array
	Auto-generated method"
	| result |

	result := self body at: #modules ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPModulesResponse >> modules: anObject [
	"All modules or range of modules.
	array
	Auto-generated method"

	self body at: #modules put: anObject
]

{ #category : #accessing }
DAPModulesResponse >> propertyNames [
	"Answer the names of all the receiver's interesting properties"

	^ #(body modules totalModules )
]

{ #category : #accessing }
DAPModulesResponse >> totalModules [
	"The total number of modules available.
	integer
	Auto-generated method"
	| result |

	result := self body at: #totalModules ifAbsent: [ nil ].
	^ result
]

{ #category : #accessing }
DAPModulesResponse >> totalModules: anObject [
	"The total number of modules available.
	integer
	Auto-generated method"

	self body at: #totalModules put: anObject
]
