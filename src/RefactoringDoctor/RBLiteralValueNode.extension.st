Extension { #name : #RBLiteralValueNode }

{ #category : #'*RefactoringDoctor' }
RBLiteralValueNode >> abstract [
^self abstractName 
]

{ #category : #'*RefactoringDoctor' }
RBLiteralValueNode >> abstractFromContext: aRBProgram [

	^ self abstractNameFromContext: aRBProgram
]
