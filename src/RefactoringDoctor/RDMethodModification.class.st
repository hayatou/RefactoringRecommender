"
I represent a modification of a method in a class or a trait.
"
Class {
	#name : #RDMethodModification,
	#superclass : #RDMethodChange,
	#category : #'RefactoringDoctor-Core'
}

{ #category : #initialization }
RDMethodModification >> initialize [
	super initialize.
	self initializeMatches 
]

{ #category : #initialization }
RDMethodModification >> initializeMatches [
	content
		ifNotNil: [ self oldMethodChangedStatements
				do: [ :stm | 
					matches
						addAll: (self allMatchesFor: (stm abstractFromContext: self oldMethod ast)) ] ]
]

{ #category : #'instance creation' }
RDMethodModification >> newMethod [
	^ self content newMethod
]

{ #category : #'instance creation' }
RDMethodModification >> newMethodChangedStatements [
	^ self newMethodStatements difference: self oldMethodStatements
]

{ #category : #'instance creation' }
RDMethodModification >> newMethodStatements [
	^ self statementsFor: self newMethod
]

{ #category : #'as yet unclassified' }
RDMethodModification >> oldMethod [
	^ self content oldMethod
]

{ #category : #'as yet unclassified' }
RDMethodModification >> oldMethodChangedStatements [
	^ self oldMethodStatements difference: self newMethodStatements
]

{ #category : #'as yet unclassified' }
RDMethodModification >> oldMethodStatements [
	^ self statementsFor: self  oldMethod
]
