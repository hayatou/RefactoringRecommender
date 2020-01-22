Extension { #name : #RBProgramNode }

{ #category : #'*RefactoringDoctor' }
RBProgramNode >> abstract [
   ^  self abstractName  .
]

{ #category : #'*RefactoringDoctor' }
RBProgramNode >> abstractFromContext: aRBProgram [
	^ self abstractNameFromContext: aRBProgram 
]

{ #category : #'*RefactoringDoctor' }
RBProgramNode >> abstractName [
	^ '`object'
]

{ #category : #'*RefactoringDoctor' }
RBProgramNode >> abstractNameFromContext: aRBProgram [
	^ '`object', (aRBProgram levelOf: self) asString
]

{ #category : #'*RefactoringDoctor' }
RBProgramNode >> levelOf: aNode [
	^ self allChildren asSet asOrderedCollection indexOf: aNode.
]
