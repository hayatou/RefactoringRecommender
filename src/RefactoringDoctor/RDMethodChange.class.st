"
I represent a change in the method dictionary of a class or a trait.
"
Class {
	#name : #RDMethodChange,
	#superclass : #RDCodeChange,
	#category : #'RefactoringDoctor-Core'
}

{ #category : #initialization }
RDMethodChange >> initializeMatches [
	self subclassResponsibility 
]

{ #category : #accessing }
RDMethodChange >> method [
	^self content methodAffected ast
]

{ #category : #'as yet unclassified' }
RDMethodChange >> statementsFor: aMethod [
	^ aMethod ast statements
]
