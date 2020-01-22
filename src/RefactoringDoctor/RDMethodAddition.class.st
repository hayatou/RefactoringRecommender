"
I represent a removal of a method in a class or a trait.
"
Class {
	#name : #RDMethodAddition,
	#superclass : #RDMethodChange,
	#category : #'RefactoringDoctor-Core'
}

{ #category : #initialization }
RDMethodAddition >> initializeMatches [
	content
		ifNotNil: [ matches
				addAll:
					(self
						allMatchesFor:
							(self method body
								abstractFromContext: self method)) ]
]
