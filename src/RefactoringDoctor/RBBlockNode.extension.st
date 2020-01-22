Extension { #name : #RBBlockNode }

{ #category : #'*RefactoringDoctor' }
RBBlockNode >> abstract [
	^ ' [ ' , self abstractArgumentsPart  , self abstractTemporariesPart , self body abstract , '] '
]

{ #category : #'*RefactoringDoctor' }
RBBlockNode >> abstractArgumentsPart [
	self arguments ifEmpty: [ ^ '' ].
	^ (self arguments
		inject: ' '
		into: [ :res :each | res , ':' ,each abstract , ' ' ]) , '| '

	", Character cr asString"
]

{ #category : #'*RefactoringDoctor' }
RBBlockNode >> abstractArgumentsPartPartFromContext: aRBProgram [
	self arguments ifEmpty: [ ^ '' ].
	^ 
			(self arguments
				inject: ' '
				into: [ :res :each | res , ':', (each abstractFromContext: aRBProgram) , ' ' ])
		, '| '
	", Character cr asString"
]

{ #category : #'*RefactoringDoctor' }
RBBlockNode >> abstractFromContext: aRBProgram [
	^ ' [ ' ,(self abstractArgumentsPartPartFromContext:  aRBProgram), (self abstractTemporariesPartFromContext: aRBProgram)
		, (self body abstractFromContext: aRBProgram) , '] '
]

{ #category : #'*RefactoringDoctor' }
RBBlockNode >> abstractTemporariesPart [
		self temporaries ifEmpty: [ ^ '' ].
	^ '|'
		,
			(self temporaries
				inject: ' '
				into: [ :res :each | res , each abstract , ' ' ]) , '| '
		", Character cr asString"

	
]

{ #category : #'*RefactoringDoctor' }
RBBlockNode >> abstractTemporariesPartFromContext: aRBProgram [
	self temporaries ifEmpty: [ ^ '' ].
	^ '|'
		,
			(self temporaries
				inject: ' '
				into: [ :res :each | res , (each abstractFromContext: aRBProgram ), ' ' ]) , '| '
	", Character cr asString"
]
