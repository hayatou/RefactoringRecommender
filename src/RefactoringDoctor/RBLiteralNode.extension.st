Extension { #name : #RBLiteralNode }

{ #category : #'*RefactoringDoctor' }
RBLiteralNode >> abstractName [
^'`#literal' 
]

{ #category : #'*RefactoringDoctor' }
RBLiteralNode >> abstractNameFromContext: aRBProgram [

	^ '`#literal' , (aRBProgram levelOf: self) asString
]
