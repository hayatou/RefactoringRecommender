Extension { #name : #RBLiteralArrayNode }

{ #category : #'*RefactoringDoctor' }
RBLiteralArrayNode >> abstract [
   ^   self contents inject: '' into: [ :res :val | res, val abstract ] .
]

{ #category : #'*RefactoringDoctor' }
RBLiteralArrayNode >> abstractFromContext: aRBProgram [
	^ self contents inject: '' into: [ :res :val | res , val abstractFromContext: aRBProgram ]
]
