"
I represent a change in a code entity.



    Instance Variables
	content:		represent the modifcation/addition/removal of a code entity
	matches:		represent all source code entities having same implementation than content


"
Class {
	#name : #RDCodeChange,
	#superclass : #RDRecommender,
	#instVars : [
		'matches',
		'content'
	],
	#category : #'RefactoringDoctor-Core'
}

{ #category : #accessing }
RDCodeChange class >> content: anObject [
	^ self new
		initializeWithContent: anObject;  initializeMatches ; 
		yourself
]

{ #category : #accessing }
RDCodeChange >> content [
	^ content
]

{ #category : #accessing }
RDCodeChange >> content: anObject [
	content := anObject
]

{ #category : #initialization }
RDCodeChange >> initializeWithContent: anObject [
     matches := OrderedCollection new.
     content := anObject
]

{ #category : #accessing }
RDCodeChange >> matches [
	^ matches
]

{ #category : #accessing }
RDCodeChange >> matches: anObject [
	matches := anObject
]

{ #category : #tests }
RDCodeChange >> test [  
^log size
]
