!classDefinition: #StackTest category: 'StackPrimeraParte'!
TestCase subclass: #StackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!StackTest methodsFor: 'tests' stamp: 'IL 10/1/2022 19:24:17'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := Stack new.
	
	self assert: stack isEmpty! !

!StackTest methodsFor: 'tests' stamp: 'alr 10/6/2022 11:49:42'!
test02PushAddsAnElementToTheStack
	| stack |
	
	stack := Stack new.
	
	stack push: 'Algo3'.
	
	self assert: stack size = 1.! !

!StackTest methodsFor: 'tests' stamp: 'alr 10/6/2022 11:56:44'!
test03PopRemovesAnElementFromTheStack
	| stack |
	
	stack := Stack new.
	
	stack push: 'Riquelme'.
	
	stack pop.
	
	self assert: stack isEmpty.! !

!StackTest methodsFor: 'tests' stamp: 'alr 10/6/2022 11:57:06'!
test04PopReturnsAnElementRemovedFromTheStack
	| stack |
	
	stack := Stack new.
	
	stack push: 'Palermo'.
	
	self assert: (stack pop = 'Palermo').! !

!StackTest methodsFor: 'tests' stamp: 'alr 10/6/2022 12:24:25'!
test05StackHasLastInFirstOutBehavior
	| stack |
	
	stack := Stack new.
	
	stack push: 10.
	stack push: 'Messi'.
	stack push: 4.5.
	
	self assert: (stack pop = 4.5).
	self assert: (stack pop = 'Messi').
	self assert: (stack pop = 10).! !

!StackTest methodsFor: 'tests' stamp: 'alr 10/6/2022 11:56:19'!
test06TopReturnsLastElementWithoutRemovingItFromTheStack
	| stack |
	
	stack := Stack new.
	
	stack push: 'Messi'.
	 
	self assert: (stack size = 1).
	
	self assert: (stack top = 'Messi').
	
	self assert: (stack size = 1).! !


!classDefinition: #Stack category: 'StackPrimeraParte'!
Object subclass: #Stack
	instanceVariableNames: 'elementos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!Stack methodsFor: 'testing' stamp: 'alr 10/6/2022 11:04:20'!
isEmpty
	^elementos isEmpty.! !

!Stack methodsFor: 'testing' stamp: 'alr 10/6/2022 11:24:31'!
size
	^elementos size.! !


!Stack methodsFor: 'operations' stamp: 'alr 10/6/2022 12:24:11'!
pop
	| elementoARemover |
	(elementos isEmpty) ifTrue: [^self errorRemovingFromEmptyStack].
	
	elementoARemover := elementos last.
	elementos removeLast.
	^elementoARemover.! !

!Stack methodsFor: 'operations' stamp: 'alr 10/6/2022 11:03:10'!
push: element.
	elementos add: element.! !

!Stack methodsFor: 'operations' stamp: 'alr 10/6/2022 11:15:04'!
top
	^elementos last.! !


!Stack methodsFor: 'initialization' stamp: 'alr 10/6/2022 11:23:30'!
initialize
	elementos := OrderedCollection new.! !


!Stack methodsFor: 'errors' stamp: 'alr 10/6/2022 11:42:22'!
errorRemovingFromEmptyStack
	^'No puedo borrar de un stack vacio!!'.! !
