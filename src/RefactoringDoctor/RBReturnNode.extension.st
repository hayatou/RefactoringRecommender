Extension { #name : #RBReturnNode }

{ #category : #'*RefactoringDoctor' }
RBReturnNode >> abstract [
	^ '^' , self value abstract
]

{ #category : #'*RefactoringDoctor' }
RBReturnNode >> abstractFromContext: aRBProgram [
	^ '^' , (self value abstractFromContext: aRBProgram )
]
