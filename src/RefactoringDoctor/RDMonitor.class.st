"
I am a  monitor.

I get Epicea events (ie. subclasses of EpEvent), so that the recommender can use it.
"
Class {
	#name : #RDMonitor,
	#superclass : #Object,
	#instVars : [
		'currentchange',
		'announcer',
		'systemAnnouncer',
		'events'
	],
	#category : #'RefactoringDoctor-Core'
}

{ #category : #'instance creation' }
RDMonitor class >> uniqueInstance [
^ current ifNil: [ current := RDMonitor new  ].

]

{ #category : #accessing }
RDMonitor >> announceMonitorStateUpdated [

	self announcer announce: RDMonitorStateUpdated new.
]

{ #category : #'as yet unclassified' }
RDMonitor >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'as yet unclassified' }
RDMonitor >> block [ 
^[1]
]

{ #category : #accessing }
RDMonitor >> currentchange [
	"get the current  Log"

	^ currentchange
]

{ #category : #protocol }
RDMonitor >> disable [

	{ systemAnnouncer }
		do: [ :each | each ifNotNil: [ :a | a unsubscribe: self ] ].

	self announceMonitorStateUpdated.

]

{ #category : #'as yet unclassified' }
RDMonitor >> enable [
	"Enable monitoring IDE announcements."
	
	self isEnabled ifFalse: [ 			
		self subscribeToSystemAnnouncer.].

	self announceMonitorStateUpdated.
]

{ #category : #'as yet unclassified' }
RDMonitor >> enabled: aBoolean [

	aBoolean 
		ifTrue: [ self enable ]
		ifFalse: [ self disable ]
]

{ #category : #accessing }
RDMonitor >> entries [
	"get  event for this session"

	^ self currentchange log entries collect: #content
]

{ #category : #'instance creation' }
RDMonitor >> handleAnyErrorDuring: aBlock [
	aBlock
		on: Error
		do: [ :error | self handleError: error ]
]

{ #category : #'instance creation' }
RDMonitor >> handleError: error [
	
 error signal 
]

{ #category : #initialization }
RDMonitor >> initialize [ 
 currentchange := EpMonitor current .
systemAnnouncer := SystemAnnouncer uniqueInstance.
]

{ #category : #accessing }
RDMonitor >> isEnabled [
	^ systemAnnouncer hasSubscriber: self
]

{ #category : #'instance creation' }
RDMonitor >> newEvent: anEvent [
	self
		handleAnyErrorDuring: [ anEvent isModification ifTrue:  [ 
			self
				addEvent:
					(RDMethodModification new ) ]]
]

{ #category : #accessing }
RDMonitor >> newestEntrie [
	"get last event for this session "

	^ self entries last
]

{ #category : #private }
RDMonitor >> subscribeToSystemAnnouncer [
	{(EpMonitor  -> #newEvent:).
	(RDMonitorStateUpdated -> #update)}
		do:
			[ :pair | systemAnnouncer weak when: pair key send: pair value to: self ]
]

{ #category : #initialization }
RDMonitor >> update [
	currentchange := EpMonitor current.

]
