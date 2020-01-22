Class {
	#name : #RDMonitorTest,
	#superclass : #TestCase,
	#instVars : [
		'rdmonitor'
	],
	#category : #'RefactoringDoctor-Tests'
}

{ #category : #running }
RDMonitorTest >> addMethodFrom: aSourceCode [
	RDMonitorTest compile: aSourceCode
]

{ #category : #running }
RDMonitorTest >> removeMethod: aSourceCode [

	RDMonitorTest
		removeSelector: (OpalCompiler new parseSelector: aSourceCode)
]

{ #category : #running }
RDMonitorTest >> setUp [
	rdmonitor := RDMonitor uniqueInstance 
]

{ #category : #'as yet unclassified' }
RDMonitorTest >> source [
	^ 'justTestIt: aStream
	| hasPragmas |
	hasPragmas := self pragmas isNotEmpty.
	hasPragmas
		ifTrue: [ aStream nextPut: $( ].
	aStream
		nextPutAll: self class name;
		nextPutAll: '' selector: ''.
	self selector printOn: aStream.
	self isArray ifNotEmpty: [ aStream nextPutAll: '' arguments: {''.
			self arguments
				do: [ :each | 
					each dumpOn: aStream.
					aStream nextPutAll: ''. '' ].
			aStream nextPut: $} ].
	self body
		ifNotNil: [ aStream nextPutAll: '' body: (''.
			self body dumpOn: aStream.
			aStream nextPut: $) ].
	hasPragmas
		ifFalse: [ ^ self ].
	aStream nextPutAll: '') pragmas: {''.
	self pragmas
		do: [ :each | 
			each dumpOn: aStream.
			aStream nextPutAll: ''. '' ].
	aStream nextPut: $}'
]

{ #category : #accessing }
RDMonitorTest >> source1 [
	^ 'justTestIt: aStream
	| hasPragmas |
	hasPragmas := self pragmas isEmpty.
	hasPragmas
		ifTrue: [ aStream nextPut: $( ].
	aStream
		nextPutAll: self class name;
		nextPutAll: '' selector: ''.
	self selector printOn: aStream.
	self isArray ifNotEmpty: [ aStream nextPutAll: '' arguments: {''.
			self arguments
				do: [ :each | 
					each dumpOn: aStream.
					aStream nextPutAll: ''. '' ].
			aStream nextPut: $} ].
	self body
		ifNotNil: [ aStream nextPutAll: '' body: (''.
			self body dumpOn: aStream.
			aStream nextPut: $) ].
	hasPragmas
		ifFalse: [ ^ self ].
	aStream nextPutAll: '') pragmas: {''.
	self pragmas
		do: [ :each | 
			each dumpOn: aStream.
			aStream nextPutAll: ''. '' ].
	aStream nextPut: $}'
]

{ #category : #accessing }
RDMonitorTest >> source2 [
	^ 'justTestIt: aStream
	| hasPragmas |
	hasPragmas := self pragmas isEmpty.
	hasPragmas
		ifTrue: [ aStream nextPut: $( ].
	aStream
		nextPutAll: self class name;
		nextPutAll: '' selector: ''.
	self selector printOn: aStream.
	self isArray ifNotEmpty: [ aStream nextPutAll: '' arguments: {''.
			self arguments
				do: [ :each | 
					each dumpOn: aStream.
					aStream nextPutAll: ''. '' ].
			aStream nextPut: $} ].
	self body
		ifNotNil: [ aStream nextPutAll: '' body: (''.
			self body dumpOn: aStream.
			aStream nextPut: $) ].
	hasPragmas
		ifFalse: [ ^ self ].
	aStream nextPutAll: '') pragmas: {''.
	self pragmas
		do: [ :each | 
			each dumpOn: aStream.
			aStream nextPutAll: ''. '' ].
	aStream nextPut: $}'
]

{ #category : #running }
RDMonitorTest >> testAbstractFromContext [
	| varNode litNode methodNode returnNode seqNode arrayNode assignmentNode blockNode cascadeNode |
	varNode := RBParser parseExpression: 'a'.
	litNode := RBParser parseExpression: '1'.
	methodNode := RBParser
		parseMethod:
			'a: aLit b: aStr c:anOb
	|x y|
	x:=anOb.'.
	returnNode := RBParser parseExpression: '^a+2'.
	seqNode := RBParser parseExpression: '7+11. c:=c+11'.
	arrayNode := RBParser parseExpression: '{2. 3. c}'.
	assignmentNode := RBParser parseExpression: 'a:=b'.
	blockNode := RBParser parseExpression: '[:e | |a|  a:=e+b]'.
	cascadeNode := RBParser parseExpression: 'a size; type; class'.
	self
		assert: (varNode abstractFromContext: varNode)
		equals: '`variable1'.
	self
		assert: (litNode abstractFromContext: litNode)
		equals: '`#literal1'.
	self
		assert: (methodNode abstractFromContext: methodNode)
		equals:
			'a:`variable7 b:`variable8 c:`variable3 
| `variable2 `variable5 | 
 `variable2 := `variable3. 
'.
	self
		assert: (returnNode abstractFromContext: returnNode)
		equals: '^`variable3 +`#literal2'.
	self
		assert: (seqNode abstractFromContext: seqNode)
		equals:
			' `#literal3 +`#literal6. 
`variable1 := `variable1 +`#literal6. 
'.
	self
		assert: (arrayNode abstractFromContext: arrayNode)
		equals: '#[ `#literal3`#literal4`variable1 ]'.
	self
		assert: (assignmentNode abstractFromContext: assignmentNode)
		equals: '`variable1 := `variable2'.
	self
		assert: (blockNode abstractFromContext: blockNode)
		equals:
			' [  :`variable5 | | `variable1 |  `variable1 := `variable5 +`variable6. 
] '.
	self
		assert: (cascadeNode abstractFromContext: cascadeNode)
		equals: '`variable3 size; type; class'
]

{ #category : #'as yet unclassified' }
RDMonitorTest >> testNewestEntrie [
	"adding a method from the string source"
	self addMethodFrom: self source.
	self assert: (rdmonitor newestEntrie selector) equals: (OpalCompiler new parseSelector: self source).
	"removing the method from the string source"
	self removeMethod:  self source
]

{ #category : #running }
RDMonitorTest >> testStatementsFor [
	"adding a method from the string source"
	self addMethodFrom: self source.
	self
		assert:
			(rdmonitor newestEntrie
				statementsFor: rdmonitor newestEntrie methodAdded)
		equals:
			(self class methodDict
				at: (OpalCompiler new parseSelector: self source)) ast statements.
		"removing the method from the string source"
	self removeMethod:  self source
]
