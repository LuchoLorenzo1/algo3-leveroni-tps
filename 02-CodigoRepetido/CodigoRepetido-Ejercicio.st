!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'LL 9/25/2022 17:39:33'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assert: (self timingTestingDifference: [customerBook addCustomerNamed: 'John Lennon'.]) < (50 * millisecond).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LL 9/25/2022 17:38:54'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self assert: (self timingTestingDifference: [customerBook removeCustomerNamed: paulMcCartney.]) < (100 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LL 9/25/2022 18:45:36'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self try: [ customerBook addCustomerNamed: ''.] except: Error thenDo: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LL 9/25/2022 18:44:15'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self try: [ customerBook removeCustomerNamed: 'Paul McCartney'.] except: NotFound thenDo: [ self assertThatIsAlone: johnLennon in: customerBook ].
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LL 9/25/2022 18:06:11'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self compareNumberOfCustomers: #(0 1 1) in: customerBook.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LL 9/25/2022 18:06:00'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self compareNumberOfCustomers: #(0 0 0) in: customerBook.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LL 9/25/2022 18:44:15'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self try: [ customerBook suspendCustomerNamed: 'Ringo Starr'. ] except: CantSuspend thenDo: [
		self assertThatIsAlone: johnLennon in: customerBook ].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LL 9/25/2022 18:44:15'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self try: [ customerBook suspendCustomerNamed: johnLennon.] except: CantSuspend thenDo: [
		self assertThatIsAlone: johnLennon in: customerBook ].
	

! !


!CustomerBookTest methodsFor: 'utils' stamp: 'LL 9/25/2022 18:40:38'!
assertThatIsAlone: someone in: customerBook
	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: someone) ! !

!CustomerBookTest methodsFor: 'utils' stamp: 'LL 9/25/2022 18:08:17'!
compareNumberOfCustomers: anArray in: customerBook
	self assert: (anArray at: 1) equals: customerBook numberOfActiveCustomers.
	self assert: (anArray at: 2) equals: customerBook numberOfSuspendedCustomers.
	self assert: (anArray at: 3) equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'utils' stamp: 'LL 9/25/2022 17:37:51'!
timingTestingDifference: aClosure
	| millisecondsBeforeRunning |
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	^((Time millisecondClockValue * millisecond) - millisecondsBeforeRunning)! !

!CustomerBookTest methodsFor: 'utils' stamp: 'LL 9/25/2022 18:44:15'!
try: aClosure except: error thenDo:  errorClosure 
	aClosure
		on: error
		do: errorClosure.
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'LL 9/25/2022 17:22:09'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended := OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'LL 9/25/2022 18:48:25'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'LL 9/25/2022 18:23:29'!
removeCustomerNamed: aName 
 	(self searchIn: active andRemove: aName) ifTrue: [^aName].
	(self searchIn: suspended andRemove: aName) ifTrue: [^aName].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'as yet unclassified' stamp: 'LL 9/25/2022 18:22:20'!
searchIn: anArray andRemove: aValue
	1 to: anArray size do: 
	[ :index |
		aValue = (anArray at: index)
			ifTrue: [
				anArray removeAt: index.
				^ true 
			] 
	].
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
