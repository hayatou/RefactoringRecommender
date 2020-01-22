Extension { #name : #EpMethodModification }

{ #category : #'*RefactoringDoctor' }
EpMethodModification >> newMethodChangedStatements [
 ^ self newMethodStatements difference: self oldMethodStatements
]

{ #category : #'*RefactoringDoctor' }
EpMethodModification >> newMethodStatements [
	^ self statementsFor: self newMethod 
]

{ #category : #'*RefactoringDoctor' }
EpMethodModification >> oldMethodChangedStatements [
 ^ self oldMethodStatements difference: self newMethodStatements 
]

{ #category : #'*RefactoringDoctor' }
EpMethodModification >> oldMethodStatements [
	^ self statementsFor: self  oldMethod 
]
