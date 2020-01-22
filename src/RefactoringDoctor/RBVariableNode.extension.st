Extension { #name : #RBVariableNode }

{ #category : #'*RefactoringDoctor' }
RBVariableNode >> abstractName [
	^ '`variable'
]

{ #category : #'*RefactoringDoctor' }
RBVariableNode >> abstractNameFromContext: aRBProgram [
	^ '`variable' , ((aRBProgram levelOf: self) asString)
]
