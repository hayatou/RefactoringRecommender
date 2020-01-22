Extension { #name : #RBAssignmentNode }

{ #category : #'*RefactoringDoctor' }
RBAssignmentNode >> abstract [
	^ self variable abstract , ' := ',self value abstract
	"self assignmentOperator."
]

{ #category : #'*RefactoringDoctor' }
RBAssignmentNode >> abstractFromContext: aRBProgram [
	^ (self variable abstractFromContext: aRBProgram ), ' := ' , (self value abstractFromContext: aRBProgram)
]
