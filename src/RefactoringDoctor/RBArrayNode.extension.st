Extension { #name : #RBArrayNode }

{ #category : #'*RefactoringDoctor' }
RBArrayNode >> abstract [
	

	^ (self statements
		inject: '[ '
		into: [ :res :each | res , each abstract , ' ' ]) , ' ]'

]

{ #category : #'*RefactoringDoctor' }
RBArrayNode >> abstractFromContext: aRBProgram [


	^ (self statements
		inject: '#[ '
		into:
			[ :res :each |  res , (each abstractFromContext: aRBProgram) ])
		, ' ]'
]
