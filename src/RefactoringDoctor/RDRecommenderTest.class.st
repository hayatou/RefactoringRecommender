Class {
	#name : #RDRecommenderTest,
	#superclass : #TestCase,
	#instVars : [
		'recommender',
		'method1',
		'method2'
	],
	#category : #'RefactoringDoctor-Tests'
}

{ #category : #adding }
RDRecommenderTest >> addMethodFrom: aSourceCode [
	self class compile: aSourceCode
]

{ #category : #removing }
RDRecommenderTest >> removeMethod: aSourceCode [
	self class
		removeSelector: (OpalCompiler new parseSelector: aSourceCode)
]

{ #category : #initialization }
RDRecommenderTest >> setUp [
	recommender := RDRecommender new.
	method1 := RBParser parseMethod: self source.
	
]

{ #category : #initialization }
RDRecommenderTest >> source [
	"Answer the current capacity of the receiver."

	^'a: aLit b: aStr c:anOb
|x y|
anOb myMethod. 
a.
1.
7+11. c:=c+11.
{2. 3. c}.
a:=b.
[:e | |a|  a:=e+b].
a size; type; class.
^a+2.'
]

{ #category : #initialization }
RDRecommenderTest >> testAllMatchesForInPackageNamed [
	| matches varNode litNode messageNode returnNode seqNode arrayNode assignmentNode blockNode cascadeNode  |
	varNode := RBParser parseExpression: 'x'.
	litNode := RBParser parseExpression: '8'.
	messageNode := RBParser
		parseExpression: 'x myMethod.'.
	returnNode := RBParser parseExpression: '^v+9'.
	seqNode := RBParser parseExpression: '7+11. c:=c+11'.
	arrayNode := RBParser parseExpression: '{2. 3. c}'.
	assignmentNode := RBParser parseExpression: 'a:=b'.
	blockNode := RBParser parseExpression: '[:e | |a|  a:=e+b]'.
	cascadeNode := RBParser parseExpression: 'a size; type; class'.
	self addMethodFrom: self source. 
	"test for message node"
	matches := recommender
		allMatchesFor: (messageNode abstract) 
		inPackageNamed: 'RefactoringDoctor'.
	self
		assertCollection:
			(((matches flatCollect: #values) collect: #methodNode)
				collect: #compiledMethod)
		hasSameElements: {(RDRecommenderTest >> #a:b:c:)}.
"test for return node"
matches := recommender
		allMatchesFor: (returnNode  abstract) 
		inPackageNamed: 'RefactoringDoctor'.
	self
		assertCollection:
			(((matches flatCollect: #values) collect: #methodNode)
				collect: #compiledMethod)
		hasSameElements: {(RDRecommenderTest >> #a:b:c:)}.

	self removeMethod: self source
]
