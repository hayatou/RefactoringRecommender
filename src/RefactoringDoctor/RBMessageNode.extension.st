Extension { #name : #RBMessageNode }

{ #category : #'*RefactoringDoctor' }
RBMessageNode >> abstract [
	^ self receiver abstract asString , ' '
		,
			self abstractArgumentsPart 
]

{ #category : #'*RefactoringDoctor' }
RBMessageNode >> abstractArgumentsPart [
	self arguments ifNil: [^'' ].
	^ self arguments
		inject: self selector asString
		into: [ :res :arg | res , arg abstract ]
]

{ #category : #'*RefactoringDoctor' }
RBMessageNode >> abstractArgumentsPartFromContext: aRBProgram [
	self arguments ifNil: [ ^ '' ].
	^ self arguments
		inject: self selector asString
		into: [ :res :arg | res , (arg abstractFromContext: aRBProgram )]
]

{ #category : #'*RefactoringDoctor' }
RBMessageNode >> abstractFromContext: aRBProgram [
	^ (self receiver abstractFromContext: aRBProgram) asString , ' ' , (self abstractArgumentsPartFromContext: aRBProgram)
]
