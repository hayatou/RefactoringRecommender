Extension { #name : #RBCascadeNode }

{ #category : #'*RefactoringDoctor' }
RBCascadeNode >> abstract [
	| i |
	i := 0.
	^ self messages
		inject: self receiver abstract
		into: [ :res :arg | 
			i := i + 1.
			res , ' ' , arg abstractArgumentsPart , (self separatorFor: i) ]
]

{ #category : #'*RefactoringDoctor' }
RBCascadeNode >> abstractFromContext: aRBProgram [
	| i |
	i := 0.
	^ self messages
		inject: (self receiver abstractFromContext: aRBProgram)
		into: [ :res :arg | 
			i := i + 1.
			res , ' ' , (arg abstractArgumentsPart)
				, (self separatorFor: i) ]
]

{ #category : #'*RefactoringDoctor' }
RBCascadeNode >> separatorFor: anInt [
	 (anInt <  self messages size) ifTrue: [^';'] ifFalse:[^''].
]
