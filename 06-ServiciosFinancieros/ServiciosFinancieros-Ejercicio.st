!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'portfolio account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'alr 11/11/2022 15:11:11'!
test01portfolioWithOneAccountHasTheAccountBalance	
	self assert: (portfolio balance) equals: (account balance)! !

!PortfolioTest methodsFor: 'tests' stamp: 'alr 11/11/2022 15:11:17'!
test02portFolioWithTwoAccountsHasTheTwoAccountsBalance
	|account2|
	
	account2 := ReceptiveAccount new.
	Deposit register: 200 * peso on: account2.	

	portfolio add: account2.

	self assert:(portfolio balance) equals: (300 * peso)! !

!PortfolioTest methodsFor: 'tests' stamp: 'alr 11/11/2022 15:11:23'!
test03balanceBetweenAccountWithPositiveAndNegativeBalancesAddsToPortfolioBalance
	|account2|
	
	account2 := ReceptiveAccount new.
	Withdraw register: 50 * peso on: account2.	

	portfolio add: account2.
	
	self assert:(portfolio balance) equals: (50 * peso)! !

!PortfolioTest methodsFor: 'tests' stamp: 'alr 11/11/2022 15:11:29'!
test04portfolioHasRegisteredTransactionOnOneOfItsAccounts
	|account2 transaccion|
	
	account2 := ReceptiveAccount new.
	transaccion := Withdraw register: 50 * peso on: account2.	

	portfolio add: account2.
	
	self assert:(portfolio hasRegistered: transaccion)! !

!PortfolioTest methodsFor: 'tests' stamp: 'alr 11/11/2022 15:12:16'!
test05portfolioHasTransactionWhenAccountIsInSubPortfolio
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

!PortfolioTest methodsFor: 'tests' stamp: 'alr 11/11/2022 15:32:27'!
test06portfolioKnowsTransactionsOfAccountInSubPortfolio
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
	
	self assert: (portfolio transactionsOf: account3) isEmpty.
	self assert: (portfolio transactionsOf: otroPortfolio) isEmpty not.
	self assert: (otroPortfolio transactionsOf: account3) equals: listaDeTransacciones.! !


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


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: 'cuenta1 cuenta2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'tests' stamp: 'alr 11/11/2022 11:48:05'!
test01transferingPutsMoneyInReceivingAccountAndExtractsFromTransferingAccount	
	Deposit register: (100 * peso) on: cuenta1.
	
	Transfer transfer: (100 * peso) from: cuenta1 to: cuenta2.
	
	self assert: (cuenta2 balance) equals: (100 * peso).
	self assert: (cuenta1 balance) equals: (0 * peso).! !

!TransferTest methodsFor: 'tests' stamp: 'alr 11/11/2022 11:48:05'!
test02cantTransferWhenAccountHasLessMoneyThanIndicated
	self
		should: [ Transfer transfer: (100 * peso) from: cuenta1 to: cuenta2. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: (Transfer transferingAmountIsGreaterThanAccountBalanceErrorDescription) equals: (anError messageText) ].
	
	self assert: (cuenta2 balance) equals: (0 * peso).
	self assert: (cuenta1 balance) equals: (0 * peso).
	! !

!TransferTest methodsFor: 'tests' stamp: 'alr 11/11/2022 12:17:33'!
test03accountsCanMakeMultipleTransfersFromOneToAnother
	Deposit register: (100 * peso) on: cuenta1.
	
	Transfer transfer: (100 * peso) from: cuenta1 to: cuenta2.
	Transfer transfer: (20 * peso) from: cuenta2 to: cuenta1.
	
	self assert: (cuenta2 balance) equals: (80 * peso).
	self assert: (cuenta1 balance) equals: (20 * peso).! !

!TransferTest methodsFor: 'tests' stamp: 'alr 11/11/2022 15:00:59'!
test04eachMovementOfTheTransferKnowsItsCounterpart
	| registroTransferencia |
	Deposit register: (100 * peso) on: cuenta1.
	
	registroTransferencia := Transfer transfer: (100 * peso) from: cuenta1 to: cuenta2.
	
	self assert: (registroTransferencia withdraw counterpart) equals: (cuenta2 transactions last).
	self assert: (registroTransferencia deposit counterpart) equals: (cuenta1 transactions last).! !

!TransferTest methodsFor: 'tests' stamp: 'alr 11/11/2022 12:18:24'!
test05transferValueCantBeNegative
	self
		should: [ Transfer transfer: (-100 * peso) from: cuenta1 to: cuenta2. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: (Transfer negativeValueErrorDescription) equals: (anError messageText) ].
	
	self assert: (cuenta2 balance) equals: (0 * peso).
	self assert: (cuenta1 balance) equals: (0 * peso).
	! !


!TransferTest methodsFor: 'setUp/tearDown' stamp: 'alr 11/10/2022 20:47:38'!
setUp
	cuenta1 := ReceptiveAccount new.
	cuenta2 := ReceptiveAccount new.! !


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


!Deposit class methodsFor: 'addition to accounts' stamp: 'alr 11/8/2022 19:53:18'!
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


!Withdraw class methodsFor: 'addition to accounts' stamp: 'alr 11/8/2022 20:07:05'!
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

!Portfolio methodsFor: 'accessing' stamp: 'alr 11/11/2022 14:48:16'!
balance
	^accounts sum: [ :anAccountOrPortfolio | anAccountOrPortfolio balance ] ifEmpty: [ 0 * peso ]! !


!Portfolio methodsFor: 'initialization' stamp: 'alr 11/8/2022 20:35:44'!
initializeWith: anAccount
	accounts := OrderedCollection new.
	accounts add: anAccount.! !


!Portfolio methodsFor: 'operations' stamp: 'alr 11/10/2022 21:46:05'!
add: anAccountOrPortfolio
	accounts add: anAccountOrPortfolio.! !

!Portfolio methodsFor: 'operations' stamp: 'alr 11/10/2022 21:44:38'!
hasRegistered: aTransaction
	^ accounts anySatisfy: [ :anAccountOrPortfolio | anAccountOrPortfolio hasRegistered: aTransaction ].
! !

!Portfolio methodsFor: 'operations' stamp: 'alr 11/8/2022 21:31:34'!
transactions
	^accounts! !

!Portfolio methodsFor: 'operations' stamp: 'alr 11/11/2022 15:29:45'!
transactionsOf: anAccountOrPortfolio
	(accounts includes: anAccountOrPortfolio) ifFalse: [^OrderedCollection new].
	
	^anAccountOrPortfolio transactions.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'alr 11/8/2022 20:35:06'!
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


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'pataDeposito pataExtraccion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'accessing' stamp: 'alr 11/11/2022 11:50:00'!
counterpart
	self subclassResponsibility! !

!Transfer methodsFor: 'accessing' stamp: 'alr 11/11/2022 12:05:46'!
deposit
	^pataDeposito! !

!Transfer methodsFor: 'accessing' stamp: 'alr 11/11/2022 12:05:42'!
withdraw
	^pataExtraccion! !


!Transfer methodsFor: 'initialization' stamp: 'alr 11/11/2022 14:55:52'!
initializeWith: deposito and: extraccion
	pataDeposito := TransferDeposit withMovement: deposito correspondingToTransfer: self.
	pataExtraccion := TransferWithdraw withMovement: extraccion correspondingToTransfer: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'alr 11/10/2022 21:29:04'!
transfer: aMoneyValue from: transferingAccount to: receivingAccount
	| deposito extraccion |
	(aMoneyValue < 0) ifTrue: [self error: self negativeValueErrorDescription].
	(aMoneyValue > transferingAccount balance) ifTrue: [self error: self transferingAmountIsGreaterThanAccountBalanceErrorDescription].
	extraccion := Withdraw register: aMoneyValue on: transferingAccount.
	deposito := Deposit register: aMoneyValue on: receivingAccount.
	^self new initializeWith: deposito and: extraccion.! !


!Transfer class methodsFor: 'errors' stamp: 'alr 11/10/2022 21:11:38'!
negativeValueErrorDescription
	^'No se puede transferir dinero negativo!!'! !

!Transfer class methodsFor: 'errors' stamp: 'alr 11/10/2022 21:18:19'!
transferingAmountIsGreaterThanAccountBalanceErrorDescription
	^'La cuenta transferente no tiene los fondos suficientes para realizar esta operación'! !


!classDefinition: #TransferDeposit category: 'ServiciosFinancieros-Ejercicio'!
Transfer subclass: #TransferDeposit
	instanceVariableNames: 'deposito transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferDeposit methodsFor: 'accessing' stamp: 'alr 11/11/2022 14:59:13'!
counterpart
	^transfer withdraw movement! !

!TransferDeposit methodsFor: 'accessing' stamp: 'alr 11/11/2022 12:02:47'!
movement
	^deposito! !


!TransferDeposit methodsFor: 'initialization' stamp: 'alr 11/11/2022 14:59:02'!
initializeWith: aDeposit correspondingToTransfer: aTransfer 
	deposito := aDeposit.
	transfer := aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: 'ServiciosFinancieros-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'instance creation' stamp: 'alr 11/11/2022 15:00:27'!
withMovement: aDeposit correspondingToTransfer: aTransfer
	^self new initializeWith: aDeposit correspondingToTransfer: aTransfer
	! !


!classDefinition: #TransferWithdraw category: 'ServiciosFinancieros-Ejercicio'!
Transfer subclass: #TransferWithdraw
	instanceVariableNames: 'extraccion transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferWithdraw methodsFor: 'initialization' stamp: 'alr 11/11/2022 15:01:23'!
initializeWith: aWithdraw correspondingToTransfer: aTransfer 
	extraccion := aWithdraw.
	transfer := aTransfer.! !


!TransferWithdraw methodsFor: 'accessing' stamp: 'alr 11/11/2022 14:59:25'!
counterpart
	^transfer deposit movement! !

!TransferWithdraw methodsFor: 'accessing' stamp: 'alr 11/11/2022 12:03:21'!
movement
	^extraccion! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: 'ServiciosFinancieros-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'instance creation' stamp: 'alr 11/11/2022 15:00:33'!
withMovement: aWithdraw correspondingToTransfer: aTransfer
	^(self new) initializeWith: aWithdraw correspondingToTransfer: aTransfer! !
