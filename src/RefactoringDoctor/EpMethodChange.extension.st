Extension { #name : #EpMethodChange }

{ #category : #'*RefactoringDoctor' }
EpMethodChange >> statementsFor: aMethod [
	^ aMethod ast statements
]
