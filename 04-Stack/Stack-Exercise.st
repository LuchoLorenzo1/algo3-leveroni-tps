!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 18:00:02'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:57'!
test02PushAddElementsToTheStack

	| stack |
	stack := OOStack new.
	
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:50'!
test03PopRemovesElementsFromTheStack

	| stack |
	stack := OOStack new.
	stack push: 'something'.
	
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:43'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack pop! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:56:59'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: secondPushedObject equals: stack pop.
	self assert: firstPushedObject equals: stack pop.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 18:00:26'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack top.
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:27'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: 1 equals: stack size.
	stack top.
	self assert: 1 equals: stack size.
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:44'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:56'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:07'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'alr 10/14/2022 12:28:47'!
test01SentenceFinderReturnsEmptyCollectionWhenEmptyStack
	|sentenceFinder stack|
	sentenceFinder := SentenceFinderByPrefix new.
	
	stack := OOStack new.
	
	self assert: ((sentenceFinder find: 'aaaa' in: stack) isEmpty) equals: true.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'alr 10/14/2022 12:48:23'!
test02SentenceFinderReturnsErrorWhenEmptyPrefix
	|sentenceFinder stack|
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	
	stack push: 'Invente Roman'.
	
	self 
		should: [(sentenceFinder find: '' in: stack)]
		raise: Error
		withExceptionDo: [ :anError | self assert: SentenceFinderByPrefix emptyPrefixErrorDescription equals: anError messageText ]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'alr 10/14/2022 12:54:30'!
test03SentenceFinderReturnsOneCorrectSentence
	|sentenceFinder stack coleccionDeOraciones|
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	
	stack push: 'Invente Roman'.
	stack push: 'No invente Roman'.
	
	coleccionDeOraciones := (sentenceFinder find: 'Invente' in: stack).
	
	self assert: coleccionDeOraciones size equals: 1.
	self assert: coleccionDeOraciones first equals: 'Invente Roman'.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'alr 10/14/2022 13:18:18'!
test04SentenceFinderReturnsMultipleCorrectSentences
	|sentenceFinder stack coleccionDeOraciones|
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	
	stack push: 'Invente Roman'.
	stack push: 'Invente Roman invente'.
	stack push: 'No invente Roman'.
	
	coleccionDeOraciones := (sentenceFinder find: 'Inve' in: stack).
	
	self assert: coleccionDeOraciones size equals: 2.
	self assert: (coleccionDeOraciones at: 1) equals: 'Invente Roman invente'.
	self assert: (coleccionDeOraciones at: 2) equals: 'Invente Roman'.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'alr 10/14/2022 13:08:02'!
test05SentenceFinderReturnsErrorWhenPrefixContainsBlankSpaces
	|sentenceFinder stack|
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	
	stack push: 'Invente Roman'.
	
	self 
		should: [(sentenceFinder find: 'Invente R' in: stack)]
		raise: Error
		withExceptionDo: [ :anError | self assert: SentenceFinderByPrefix invalidPrefixErrorDescription equals: anError messageText ]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'alr 10/14/2022 13:41:00'!
test06SentenceFinderReturnsStringWhenPrefixIsAtStart
	|sentenceFinder stack coleccionDeOraciones|
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	
	stack push: 'winter is coming'.
	stack push: '	Winter is here'.
	stack push: 'winning is everything'.
	stack push: 'The winds of Winter'.
	
	coleccionDeOraciones := sentenceFinder find: 'Wint' in: stack.
	
	self assert: (coleccionDeOraciones size) equals: 1.
	self assert: (coleccionDeOraciones at: 1) equals: 'Winter is here'.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'alr 10/14/2022 13:19:57'!
test07SentenceFinderIsCaseSensitive
	"|sentenceFinder stack coleccionDeOraciones|
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	
	stack push: 'winter is coming'.
	stack push: 'winning is everything'.
	stack push: 'The winds of Winter'.
	stack push: '	Winter is here'.
	
	coleccionDeOraciones := (sentenceFinder find: 'Wint' in: stack).
	
	self assert: coleccionDeOraciones size equals: 2.
	self assert: (coleccionDeOraciones at: 1) equals: 'Invente Roman invente'.
	self assert: (coleccionDeOraciones at: 2) equals: 'Invente Roman'."! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'alr 10/14/2022 13:23:13'!
test08StackIsNotModified
	|sentenceFinder stack coleccionDeOraciones|
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	
	stack push: 'winter is coming'.
	stack push: 'winning is everything'.
	stack push: 'The winds of Winter'.
	stack push: '	Winter is here'.
	
	coleccionDeOraciones := (sentenceFinder find: 'Wint' in: stack).
	
	self assert: (coleccionDeOraciones size) equals: 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefixTest class' category: 'Stack-Exercise'!
SentenceFinderByPrefixTest class
	instanceVariableNames: 'coleccionDeOraciones'!


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'tope'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'operations' stamp: 'alr 10/13/2022 19:11:17'!
pop
	|elementoARemover|
	elementoARemover := self top.
	tope := tope anterior.
	^elementoARemover.! !

!OOStack methodsFor: 'operations' stamp: 'alr 10/13/2022 19:06:39'!
push: aString
	tope := Nodo with: aString over: tope.! !

!OOStack methodsFor: 'operations' stamp: 'alr 10/13/2022 19:04:24'!
top
	^tope value.! !


!OOStack methodsFor: 'testing' stamp: 'alr 10/13/2022 18:00:37'!
isEmpty
	^tope isEmpty.! !

!OOStack methodsFor: 'testing' stamp: 'alr 10/13/2022 19:10:52'!
size
	^tope size.! !


!OOStack methodsFor: 'initialization' stamp: 'alr 10/13/2022 18:37:59'!
initialize
	tope := Base new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackElemento category: 'Stack-Exercise'!
Object subclass: #OOStackElemento
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElemento methodsFor: 'as yet unclassified' stamp: 'alr 10/13/2022 20:24:29'!
isEmpty
	self subclassResponsibility ! !


!classDefinition: #Base category: 'Stack-Exercise'!
OOStackElemento subclass: #Base
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Base methodsFor: 'as yet unclassified' stamp: 'alr 10/13/2022 17:57:33'!
isEmpty
	^true.! !

!Base methodsFor: 'as yet unclassified' stamp: 'alr 10/14/2022 11:57:38'!
pop
	OOStack stackEmptyErrorDescription.! !

!Base methodsFor: 'as yet unclassified' stamp: 'alr 10/13/2022 19:10:21'!
size
	^0.! !

!Base methodsFor: 'as yet unclassified' stamp: 'alr 10/13/2022 19:04:08'!
value
	self error: OOStack stackEmptyErrorDescription.! !


!classDefinition: #Nodo category: 'Stack-Exercise'!
OOStackElemento subclass: #Nodo
	instanceVariableNames: 'dato anterior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Nodo methodsFor: 'testing' stamp: 'alr 10/13/2022 17:57:21'!
isEmpty
	^false.
! !

!Nodo methodsFor: 'testing' stamp: 'alr 10/13/2022 19:10:41'!
size
	^anterior size + 1.! !


!Nodo methodsFor: 'as yet unclassified' stamp: 'alr 10/13/2022 18:40:04'!
anterior
	^anterior! !

!Nodo methodsFor: 'as yet unclassified' stamp: 'alr 10/13/2022 18:09:39'!
initializeWith: aString over: nodoAnterior
	dato := aString.
	anterior := nodoAnterior.! !

!Nodo methodsFor: 'as yet unclassified' stamp: 'alr 10/13/2022 19:03:51'!
value
	^dato! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Nodo class' category: 'Stack-Exercise'!
Nodo class
	instanceVariableNames: ''!

!Nodo class methodsFor: 'as yet unclassified' stamp: 'alr 10/13/2022 18:14:06'!
with: aString over: aNode
	^self new initializeWith: aString over: aNode.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stackAuxiliar'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'alr 10/14/2022 13:39:55'!
find: aPrefixToSearch in: aStack
	| coleccionDeStrings elementoEliminado|
	
	(aPrefixToSearch isEmpty) ifTrue: [self error: self class emptyPrefixErrorDescription].
	(aPrefixToSearch includesSubString: ' ') ifTrue: [self error: self class invalidPrefixErrorDescription].
	
	coleccionDeStrings := OrderedCollection new.
	[aStack isEmpty] whileFalse: [
		elementoEliminado := (aStack pop).
		stackAuxiliar push: elementoEliminado.
		((elementoEliminado findString: aPrefixToSearch startingAt: 1 caseSensitive: true) = 1) ifTrue: [ coleccionDeStrings add: elementoEliminado. ]
	].
	
	[stackAuxiliar isEmpty] whileFalse: [ aStack push: (stackAuxiliar pop). ].
	
	^coleccionDeStrings.! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'alr 10/14/2022 12:06:53'!
initialize
	stackAuxiliar := OOStack new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'alr 10/14/2022 12:41:08'!
emptyPrefixErrorDescription
	^'Prefix is empty!!'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'alr 10/14/2022 13:00:43'!
invalidPrefixErrorDescription
	^'Prefix contains blank spaces!!'
	! !
