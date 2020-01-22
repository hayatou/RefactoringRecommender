Extension { #name : #RBMethodNode }

{ #category : #'*RefactoringDoctor' }
RBMethodNode >> abstract [
	^ self abstractSelectorsPart , self abstractTemporariesPart 
		, self body abstract
]

{ #category : #'*RefactoringDoctor' }
RBMethodNode >> abstractFromContext: aRBProgram [
	^ (self abstractSelectorsPartFromContext: aRBProgram ) , (self abstractTemporariesPartFromContext: aRBProgram)
		, (self body abstractFromContext: aRBProgram) 
]

{ #category : #'*RefactoringDoctor' }
RBMethodNode >> abstractSelectorsPart [
	self selectorParts size = 1
		ifTrue: [ ^ self selector asString ].
	^ ((self selectorParts
		with: (self arguments collect: #abstract) asArray
		collect: [ :a :b | a , b, ' ' ]) inject: '' into: [ :res :el | res , el ])
		, Character cr asString
]

{ #category : #'*RefactoringDoctor' }
RBMethodNode >> abstractSelectorsPartFromContext: aRBProgram [
	self selectorParts size = 1
		ifTrue: [ ^ self selector asString ].
	^ ((self selectorParts
		with: (self arguments collect: [:each | each abstractFromContext:aRBProgram]) asArray
		collect: [ :a :b | a , b , ' ' ])
		inject: ''
		into: [ :res :el | res , el ]) , Character cr asString
]

{ #category : #'*RefactoringDoctor' }
RBMethodNode >> abstractTemporariesPart [
	self temporaries  ifEmpty: [ ^ '' ].
	^ '|'
		,
			(self temporaries 
				inject: ' '
				into: [ :res :each | res , each abstract , ' ' ]) , '| '
		, Character cr asString
]

{ #category : #'*RefactoringDoctor' }
RBMethodNode >> abstractTemporariesPartFromContext: aRBProgram [
	self temporaries ifEmpty: [ ^ '' ].
	^ '|'
		,
			(self temporaries
				inject: ' '
				into: [ :res :each | res , (each abstractFromContext: aRBProgram  ), ' ' ]) , '| '
		, Character cr asString
]
