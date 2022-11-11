!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'portfolio account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'alr 11/8/2022 20:46:54'!
test01PortfolioWithOneAccountHasTheAccountBalance	
	self assert: (portfolio balance) equals: (account balance)! !

!PortfolioTest methodsFor: 'tests' stamp: 'alr 11/10/2022 21:50:47'!
test02PortFolioWithTwoAccountsHasTheTwoAccountsBalance
	|account2|
	
	account2 := ReceptiveAccount new.
	Deposit register: 200 * peso on: account2.	

	portfolio add: account2.

	self assert:(portfolio balance) equals: (300 * peso)! !

!PortfolioTest methodsFor: 'tests' stamp: 'alr 11/10/2022 21:46:05'!
test03xxx
	|account2|
	
	account2 := ReceptiveAccount new.
	Withdraw register: 50 * peso on: account2.	

	portfolio add: account2.
	
	self assert:(portfolio balance) equals: (50 * peso)! !

!PortfolioTest methodsFor: 'tests' stamp: 'alr 11/10/2022 21:46:05'!
test04xxx
	|account2 transaccion|
	
	account2 := ReceptiveAccount new.
	transaccion := Withdraw register: 50 * peso on: account2.	

	portfolio add: account2.
	
	self assert:(portfolio hasRegistered: transaccion)! !

!PortfolioTest methodsFor: 'tests' stamp: 'alr 11/10/2022 21:46:05'!
test05xxx
	| otroPortfolio account2 account3 account4 transaccion |
	
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	account4 := ReceptiveAccount new.
	
	transaccion := Deposit register: 100 * peso on: account3.
	
	otroPortfolio := Portfolio newWithAccount: account2.
	otroPortfolio add: account2.
	otroPortfolio add: account3.
	otroPortfolio add: account4.
	portfolio add: otroPortfolio.
	
	self assert: (portfolio hasRegistered: transaccion).! !

!PortfolioTest methodsFor: 'tests' stamp: 'alr 11/10/2022 21:49:45'!
test06xxx
	| otroPortfolio account2 account3 account4 listaDeTransacciones|
	
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	account4 := ReceptiveAccount new.
	
	otroPortfolio := Portfolio newWithAccount: account2.
	otroPortfolio add: account2.
	otroPortfolio add: account3.
	otroPortfolio add: account4.
	portfolio add: otroPortfolio.
	
	listaDeTransacciones := OrderedCollection new.
	listaDeTransacciones add: (Deposit register: 100 * peso on: account3).
	listaDeTransacciones add: (Withdraw register: 50 * peso on: account3).
	
	self assert: (portfolio transactionsOf: account3) isEmpty.! !


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


!classDefinition: #TransferenciaTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferenciaTest
	instanceVariableNames: 'cuenta1 cuenta2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenciaTest methodsFor: 'as yet unclassified' stamp: 'alr 11/10/2022 20:47:38'!
setUp
	cuenta1 := ReceptiveAccount new.
	cuenta2 := ReceptiveAccount new.! !

!TransferenciaTest methodsFor: 'as yet unclassified' stamp: 'alr 11/10/2022 21:39:35'!
test01transferingPutsMoneyInReceivingAccountAndExtractsFromTransferingAccount	
	Deposit register: (100 * peso) on: cuenta1.
	
	Transferencia transfer: (100 * peso) from: cuenta1 to: cuenta2.
	
	self assert: (cuenta2 balance) equals: (100 * peso).
	self assert: (cuenta1 balance) equals: (0 * peso).! !

!TransferenciaTest methodsFor: 'as yet unclassified' stamp: 'alr 11/10/2022 21:40:13'!
test02cantTransferWhenAccountHasLessMoneyThanIndicated
	self
		should: [ Transferencia transfer: (100 * peso) from: cuenta1 to: cuenta2. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: (Transferencia transferingAmountIsGreaterThanAccountBalanceErrorDescription) equals: (anError messageText) ].
	
	self assert: (cuenta2 balance) equals: (0 * peso).
	self assert: (cuenta1 balance) equals: (0 * peso).
	! !

!TransferenciaTest methodsFor: 'as yet unclassified' stamp: 'alr 11/10/2022 21:27:04'!
test03
	Deposit register: (100 * peso) on: cuenta1.
	
	Transferencia transfer: (100 * peso) from: cuenta1 to: cuenta2.
	Transferencia transfer: (20 * peso) from: cuenta2 to: cuenta1.
	
	self assert: (cuenta2 balance) equals: (80 * peso).
	self assert: (cuenta1 balance) equals: (20 * peso).! !

!TransferenciaTest methodsFor: 'as yet unclassified' stamp: 'alr 11/10/2022 21:37:26'!
test04
	| registroTransferencia |
	Deposit register: (100 * peso) on: cuenta1.
	
	registroTransferencia := Transferencia transfer: (100 * peso) from: cuenta1 to: cuenta2.
	
	self assert: (registroTransferencia contraPataExtraccion) equals: (cuenta2 transactions last).
	self assert: (registroTransferencia contraPataDeposito) equals: (cuenta1 transactions last).! !

!TransferenciaTest methodsFor: 'as yet unclassified' stamp: 'alr 11/10/2022 21:38:00'!
test05
	self
		should: [ Transferencia transfer: (-100 * peso) from: cuenta1 to: cuenta2. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: (Transferencia negativeValueErrorDescription) equals: (anError messageText) ].
	
	self assert: (cuenta2 balance) equals: (0 * peso).
	self assert: (cuenta1 balance) equals: (0 * peso).
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

!Portfolio methodsFor: 'as yet unclassified' stamp: 'alr 11/10/2022 21:46:05'!
add: anAccountOrPortfolio
	accounts add: anAccountOrPortfolio.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'alr 11/10/2022 21:40:52'!
balance
	^accounts sum: [ :anAccountOrPortfolio | anAccountOrPortfolio balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'alr 11/10/2022 21:44:38'!
hasRegistered: aTransaction
	^ accounts anySatisfy: [ :anAccountOrPortfolio | anAccountOrPortfolio hasRegistered: aTransaction ].
! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'alr 11/8/2022 20:35:44'!
initializeWith: anAccount
	accounts := OrderedCollection new.
	accounts add: anAccount.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'alr 11/8/2022 21:31:34'!
transactions
	^accounts! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'alr 11/10/2022 21:43:31'!
transactionsOf: anAccountOrPortfolio
	(accounts includes: anAccountOrPortfolio) ifFalse: [^OrderedCollection new].
	
	^anAccountOrPortfolio transactions.! !

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



!classDefinition: #Transferencia category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transferencia
	instanceVariableNames: 'pataDeposito pataExtraccion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transferencia methodsFor: 'as yet unclassified' stamp: 'alr 11/10/2022 21:33:15'!
contraPataDeposito
	^pataExtraccion! !

!Transferencia methodsFor: 'as yet unclassified' stamp: 'alr 11/10/2022 21:33:08'!
contraPataExtraccion
	^pataDeposito! !

!Transferencia methodsFor: 'as yet unclassified' stamp: 'alr 11/10/2022 21:32:19'!
initializeWith: deposito and: extraccion
	pataDeposito := deposito.
	pataExtraccion := extraccion.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transferencia class' category: 'ServiciosFinancieros-Ejercicio'!
Transferencia class
	instanceVariableNames: ''!

!Transferencia class methodsFor: 'as yet unclassified' stamp: 'alr 11/10/2022 21:11:38'!
negativeValueErrorDescription
	^'No se puede transferir dinero negativo!!'! !

!Transferencia class methodsFor: 'as yet unclassified' stamp: 'alr 11/10/2022 21:29:04'!
transfer: aMoneyValue from: transferingAccount to: receivingAccount
	| deposito extraccion |
	(aMoneyValue < 0) ifTrue: [self error: self negativeValueErrorDescription].
	(aMoneyValue > transferingAccount balance) ifTrue: [self error: self transferingAmountIsGreaterThanAccountBalanceErrorDescription].
	extraccion := Withdraw register: aMoneyValue on: transferingAccount.
	deposito := Deposit register: aMoneyValue on: receivingAccount.
	^self new initializeWith: deposito and: extraccion.! !

!Transferencia class methodsFor: 'as yet unclassified' stamp: 'alr 11/10/2022 21:18:19'!
transferingAmountIsGreaterThanAccountBalanceErrorDescription
	^'La cuenta transferente no tiene los fondos suficientes para realizar esta operación'! !
