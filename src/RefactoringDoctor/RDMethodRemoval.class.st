"
I represent a removal of a method in a class or a trait.
"
Class {
	#name : #RDMethodRemoval,
	#superclass : #RDMethodChange,
	#category : #'RefactoringDoctor-Core'
}

{ #category : #initialization }
RDMethodRemoval >> initializeMatches [
	content
		ifNotNil: [ matches
				addAll:
					(self
						allMatchesFor: (self method body abstractFromContext: self method)) ]
]
