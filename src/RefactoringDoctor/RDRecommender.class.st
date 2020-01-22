"
I am a log of system events (RDCodeChange subclasses), I  add instances of RDCodeChange into me when certain system announcements happen.

My #log contain the events ordered as ""the oldest first"".
 
Examples:
RDRecommender enable  .
RDRecommender compile: 'test ^log size'.
RDRecommender compile: 'test ^debugMode size'.
RDRecommender  removeSelector: (OpalCompiler new parseSelector: 'test').
RDRecommender uniqueInstance inspect.
RDRecommender uniqueInstance disableAll .

Instance Variables
	debugMode:		<Object>
	log:		<Object>
	systemAnnouncer:		<Object>


    Implementation Points
"
Class {
	#name : #RDRecommender,
	#superclass : #Object,
	#instVars : [
		'systemAnnouncer',
		'log',
		'debugMode'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'RefactoringDoctor-Core'
}

{ #category : #'instance creation' }
RDRecommender class >> enable [
	"Answer if there is an instance of this class that is #uniqueInstance (without creating the instance if one not already exists)."

	RDRecommender uniqueInstance 
]

{ #category : #'instance creation' }
RDRecommender class >> hasUniqueInstance [
	"Answer if there is an instance of this class that is #uniqueInstance (without creating the instance if one not already exists)."

	^ uniqueInstance isNotNil
]

{ #category : #'instance creation' }
RDRecommender class >> new [
	^ self basicNew enable
]

{ #category : #initialization }
RDRecommender class >> reset [
	"self reset"

	self hasUniqueInstance
		ifTrue: [ self uniqueInstance disable.
			self uniqueInstance: nil ]
]

{ #category : #'as yet unclassified' }
RDRecommender class >> restart [
	"self restart"

	self reset.
	self uniqueInstance  enable
]

{ #category : #'as yet unclassified' }
RDRecommender class >> uniqueInstance [
	uniqueInstance ifNil: [ uniqueInstance := self  new ].
	^ uniqueInstance
]

{ #category : #'instance creation' }
RDRecommender class >> uniqueInstance: aRDRecommender [ 
	 uniqueInstance := aRDRecommender 
]

{ #category : #'announcement handling' }
RDRecommender >> addEvent: anEvent [ 

		log add: anEvent .
		
]

{ #category : #'as yet unclassified' }
RDRecommender >> allMatchesFor: aPatternExpressionString [
	| result |
	result := OrderedCollection new.
	(RPackageOrganizer default packages collect: #name)
		do: [ :pack | 
			result
				addAll:
					(self allMatchesFor: aPatternExpressionString inPackageNamed: pack) ].
				^result
]

{ #category : #'as yet unclassified' }
RDRecommender >> allMatchesFor: aPatternExpressionString inPackageNamed: aPackageName [
	| matcher result |
	result := OrderedCollection new.

	matcher := RBParser parseRewriteExpression: aPatternExpressionString.
	(RPackageOrganizer default packageNamed: aPackageName) methods
		do: [ :mth | 
			mth ast statements
				do:
					[ :stm |  matcher match: stm onSuccess: [ :m | result add: m ] onFailure: [  ] ] ].
	^ result
]

{ #category : #'announcement handling' }
RDRecommender >> behaviorAdded: aBehaviorAdded [
	
]

{ #category : #'announcement handling' }
RDRecommender >> behaviorModified: aBehaviorModified [
	
]

{ #category : #'announcement handling' }
RDRecommender >> behaviorRemoved: aBehaviorRemoved [
	
]

{ #category : #'announcement handling' }
RDRecommender >> categoryAdded:categoryAdded [
]

{ #category : #'announcement handling' }
RDRecommender >> categoryRemoved:categoryRemoved [
]

{ #category : #'announcement handling' }
RDRecommender >> categoryRenamed:categoryRenamed [
]

{ #category : #'announcement handling' }
RDRecommender >> classCommented:classCommented [
]

{ #category : #'announcement handling' }
RDRecommender >> classRecategorized:classRecategorized [
]

{ #category : #'announcement handling' }
RDRecommender >> classRenamed: aClassRenamed [
	
]

{ #category : #accessing }
RDRecommender >> debugMode [
	^ debugMode ifNil: [ false ]
]

{ #category : #accessing }
RDRecommender >> debugMode: aBoolean [
	debugMode := aBoolean
]

{ #category : #enabling }
RDRecommender >> disable [
	{systemAnnouncer}
		do: [ :each | each ifNotNil: [ :a | a unsubscribe: self ] ].

]

{ #category : #enabling }
RDRecommender >> disableAll [
	(SystemAnnouncer uniqueInstance subscriptions subscriptions select: [ :e | e subscriber asString beginsWith: 'a RDM' ] )do: [:each |  each unregister ]
]

{ #category : #enabling }
RDRecommender >> enable [
	"Enable monitoring IDE announcements."
    log ifNil: [ log := OrderedCollection new ].
	self isEnabled
		ifFalse: [ self subscribeToSystemAnnouncer ]
]

{ #category : #enabling }
RDRecommender >> enabled: aBoolean [
	aBoolean
		ifTrue: [ self enable ]
		ifFalse: [ self disable ]
]

{ #category : #accessing }
RDRecommender >> handleAnyErrorDuring: aBlock [
	aBlock
		on: Error
		do: [ :error | self handleError: error ]
]

{ #category : #accessing }
RDRecommender >> handleError: error [
	self debugMode
		ifTrue: [ error signal ]
		ifFalse:
			[ 'RDRecommender could not log a change. You can enable debugging with "RDRecommender uniqueInstance debugMode: true".'
				traceCr ]
]

{ #category : #initialization }
RDRecommender >> initialize [
log:=OrderedCollection new.
	systemAnnouncer := SystemAnnouncer uniqueInstance.
	self enable
]

{ #category : #testing }
RDRecommender >> isEnabled [
"cc"
systemAnnouncer ifNil: [systemAnnouncer := SystemAnnouncer uniqueInstance].
	^ systemAnnouncer hasSubscriber: self
]

{ #category : #'announcement handling' }
RDRecommender >> methodAdded: aMethodAdded [

	self
		handleAnyErrorDuring: [ self addEvent: (RDMethodAddition content: aMethodAdded)
			"a ajouter les recommanation ici" ]
]

{ #category : #'announcement handling' }
RDRecommender >> methodModified: aMethodModified [
self addEvent: (RDMethodModification content: aMethodModified ).
	"self
		handleAnyErrorDuring: [ (aMethodModified oldMethod sourceCode
				= aMethodModified newMethod sourceCode
				and: [ aMethodModified oldProtocol = aMethodModified newProtocol ])
				ifTrue: [ ^ self ].
			self addEvent: (RDMethodModification content: aMethodModified )
			 ]"
]

{ #category : #'announcement handling' }
RDRecommender >> methodRecategorized:methodRecategorized [
]

{ #category : #'announcement handling' }
RDRecommender >> methodRemoved: aMethodRemoved [

	self
		handleAnyErrorDuring: [ self addEvent: (RDMethodRemoval content: aMethodRemoved)
			"a ajouter les recommanation ici" ]
]

{ #category : #'announcement handling' }
RDRecommender >> monticelloVersionSaved:monticelloVersionSaved [
]

{ #category : #'announcement handling' }
RDRecommender >> protocolAdded:protocolAdded [
]

{ #category : #'announcement handling' }
RDRecommender >> protocolRemoved:protocolRemoved [
]

{ #category : #private }
RDRecommender >> subscribeToSystemAnnouncer [
	{(CategoryAdded -> #categoryAdded:).
	(CategoryRemoved -> #categoryRemoved:).
	(CategoryRenamed -> #categoryRenamed:).
	(ClassAdded -> #behaviorAdded:).
	(ClassRemoved -> #behaviorRemoved:).
	(MethodAdded -> #methodAdded:).
	(MethodRemoved -> #methodRemoved:).
	(ProtocolAdded -> #protocolAdded:).
	(ProtocolRemoved -> #protocolRemoved:).
	(ClassModifiedClassDefinition -> #behaviorModified:).
	(MethodModified -> #methodModified:).
	(ClassRecategorized -> #classRecategorized:).
	(ClassRenamed -> #classRenamed:).
	(ClassCommented -> #classCommented:).
	(MethodRecategorized -> #methodRecategorized:).
	(MCVersionSaved -> #monticelloVersionSaved:)}
		do: [ :pair | systemAnnouncer weak when: pair key send: pair value to: self ]
]

{ #category : #private }
RDRecommender >> unsubscribeToSystemAnnouncer [
	systemAnnouncer unsubscribe: self class uniqueInstance
]
