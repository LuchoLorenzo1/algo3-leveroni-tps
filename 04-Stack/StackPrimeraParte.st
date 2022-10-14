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

!StackTest methodsFor: 'tests' stamp: 'alr 10/6/2022 14:33:43'!
test02PushAddsAnElementToTheStack
	| stack |
	
	stack := Stack new.
	
	stack push: 'Algo3'.
	
	self deny: stack isEmpty.! !

!StackTest methodsFor: 'tests' stamp: 'alr 10/6/2022 14:33:51'!
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

!StackTest methodsFor: 'tests' stamp: 'alr 10/6/2022 14:41:50'!
test06TopReturnsLastElementWithoutRemovingItFromTheStack
	| stack |
	
	stack := Stack new.
	
	stack push: 'Messi'.
	
	self assert: (stack top = 'Messi').
	
	self deny: (stack isEmpty).! !


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


!Stack methodsFor: 'operations' stamp: 'alr 10/11/2022 20:39:55'!
pop
	| elementoARemover |
	elementoARemover := self top.
	elementos removeLast.
	^elementoARemover.! !

!Stack methodsFor: 'operations' stamp: 'alr 10/6/2022 11:03:10'!
push: element.
	elementos add: element.! !

!Stack methodsFor: 'operations' stamp: 'alr 10/11/2022 20:42:50'!
top
	(elementos isEmpty) ifTrue: [self error: self emptyStackErrorDescription].
	
	^elementos last.! !


!Stack methodsFor: 'initialization' stamp: 'alr 10/6/2022 11:23:30'!
initialize
	elementos := OrderedCollection new.! !


!Stack methodsFor: 'errors' stamp: 'alr 10/11/2022 20:38:40'!
emptyStackErrorDescription
	^'El stack se encuentra vacio!!'.! !
