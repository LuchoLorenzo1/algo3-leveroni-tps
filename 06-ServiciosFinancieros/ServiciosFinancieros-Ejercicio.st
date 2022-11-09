!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'portfolio account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'alr 11/8/2022 20:46:54'!
test01PortfolioWithOneAccountHasTheAccountBalance	
	self assert: (portfolio balance) equals: (account balance)! !

!PortfolioTest methodsFor: 'tests' stamp: 'alr 11/8/2022 20:48:25'!
test02xxx
	|account2|
	
	account2 := ReceptiveAccount new.
	Deposit register: 200 * peso on: account2.	

	portfolio addAccount: account2.

	self assert:(portfolio balance) equals: (300 * peso)! !

!PortfolioTest methodsFor: 'tests' stamp: 'alr 11/8/2022 20:51:13'!
test03xxx
	|account2|
	
	account2 := ReceptiveAccount new.
	Withdraw register: 50 * peso on: account2.	

	portfolio addAccount: account2.
	
	self assert:(portfolio balance) equals: (50 * peso)! !

!PortfolioTest methodsFor: 'tests' stamp: 'alr 11/8/2022 20:56:08'!
test04xxx
	|account2 transaccion|
	
	account2 := ReceptiveAccount new.
	transaccion := Withdraw register: 50 * peso on: account2.	

	portfolio addAccount: account2.
	
	self assert:(portfolio hasRegistered: transaccion)! !

!PortfolioTest methodsFor: 'tests' stamp: 'alr 11/8/2022 21:09:42'!
test05xxx
	| otroPortfolio account2 account3 account4 transaccion |
	
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	account4 := ReceptiveAccount new.
	
	transaccion := Deposit register: 100 * peso on: account3.
	
	otroPortfolio := Portfolio newWithAccount: account2.
	otroPortfolio addAccount: account2.
	otroPortfolio addAccount: account3.
	otroPortfolio addAccount: account4.
	portfolio addAccount: otroPortfolio.
	
	self assert: (portfolio hasRegistered: transaccion).! !

!PortfolioTest methodsFor: 'tests' stamp: 'alr 11/8/2022 21:25:32'!
test06xxx
	| otroPortfolio account2 account3 account4 listaDeTransacciones|
	
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	account4 := ReceptiveAccount new.
	
	otroPortfolio := Portfolio newWithAccount: account2.
	otroPortfolio addAccount: account2.
	otroPortfolio addAccount: account3.
	otroPortfolio addAccount: account4.
	portfolio addAccount: otroPortfolio.
	
	listaDeTransacciones := OrderedCollection new.
	listaDeTransacciones add: (Deposit register: 100 * peso on: account3).
	listaDeTransacciones add: (Withdraw register: 50 * peso on: account3).
	
	self assert: (portfolio getAccountTransactions: account3) equals: (listaDeTransacciones).! !


!PortfolioTest methodsFor: 'setUp/tearDown' stamp: 'alr 11/8/2022 20:46:42'!
setUp
	account := ReceptiveAccount new.	
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio newWithAccount: account.! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'alr 11/8/2022 19:51:42'!
register: aValue on: account

	self subclassResponsibility .! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'alr 11/8/2022 20:22:39'!
netValue
	^ value! !

!Deposit methodsFor: 'value' stamp: 'alr 11/8/2022 20:21:07'!
value
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: 'account'!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'as yet unclassified' stamp: 'alr 11/8/2022 19:53:18'!
register: aValue on: anAccount
	| transaction |
	
	transaction := self for: aValue.
	anAccount register: transaction.
		
	^ transaction! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'alr 11/8/2022 20:22:39'!
netValue
	^ value * (-1)! !

!Withdraw methodsFor: 'value' stamp: 'alr 11/8/2022 20:21:51'!
value
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'as yet unclassified' stamp: 'alr 11/8/2022 20:07:05'!
register: aValue on: anAccount
	| transaction |
	
	transaction := self for: aValue.
	anAccount register: transaction.
		
	^ transaction! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'alr 11/8/2022 20:42:56'!
addAccount: anAccount
	accounts add: anAccount.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'alr 11/8/2022 20:36:43'!
balance
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'alr 11/8/2022 21:23:26'!
getAccountTransactions: anAccount
	(accounts includes: anAccount) ifFalse: [^OrderedCollection new].
	
	^anAccount transactions.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'alr 11/8/2022 20:59:36'!
hasRegistered: aTransaction

	^ accounts do: [ :anAccount | (anAccount hasRegistered: aTransaction) ifTrue: [^true] ].
! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'alr 11/8/2022 20:35:44'!
initializeWith: anAccount
	accounts := OrderedCollection new.
	accounts add: anAccount.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'alr 11/8/2022 21:31:34'!
transactions
	^accounts! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'alr 11/8/2022 20:35:06'!
newWithAccount: anAccount
	^self new initializeWith: anAccount.! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'alr 11/8/2022 20:22:39'!
balance

	^transactions sum: [ :aTransaction | aTransaction netValue ] ifEmpty: [ 0 ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !

