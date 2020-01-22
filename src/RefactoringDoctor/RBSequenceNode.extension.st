Extension { #name : #RBSequenceNode }

{ #category : #'*RefactoringDoctor' }
RBSequenceNode >> abstract [
	^ self statements
		inject: ' '
		into: [ :res :stm | res , (stm abstract) , '. ' , Character cr asString ]
]

{ #category : #'*RefactoringDoctor' }
RBSequenceNode >> abstractFromContext: aRBProgram [
	^ self statements
		inject: ' '
		into: [ :res :stm | res , (stm abstractFromContext: aRBProgram ) , '. ' , Character cr asString ]
]
