!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |

	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.

	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |

	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.

	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.

	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |

	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.

	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |

	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.

	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.

	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |

	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.

	portfolioTransactions := portfolio transactions.

	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |

	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.

	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.

	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

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


!classDefinition: #ReportTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: 'account accountBoca accountLeveroni accountMessi'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReportTest methodsFor: 'tests' stamp: 'LJKLDSf 11/18/2022 11:57:41'!
test01accountSummaryOfEmptyAccountHasNoTransactions
	self assert: (AccountSummaryReport on: account) equals: 'Balance = 0 * pesos'! !

!ReportTest methodsFor: 'tests' stamp: 'LJKLDSf 11/18/2022 11:57:41'!
test02accountSummaryOfOneDeposit
	Deposit register: (100 * peso) on: account.
	self assert: (AccountSummaryReport on: account) equals: 'Depósito por 100 * pesos', String newLineString,'Balance = 100 * pesos'! !

!ReportTest methodsFor: 'tests' stamp: 'LJKLDSf 11/18/2022 11:57:41'!
test03accountSummaryOfOneWithdraw
	Withdraw register: (100 * peso) on: account.
	self assert: (AccountSummaryReport on: account) equals: 'Extracción por 100 * pesos', String newLineString,'Balance = -100 * pesos'
! !

!ReportTest methodsFor: 'tests' stamp: 'LJKLDSf 11/18/2022 11:57:41'!
test04accountSummaryOfWithdrawAndDeposit
	Deposit register: (100 * peso) on: account.
	Withdraw register: (80 * peso) on: account.

	self assert: (AccountSummaryReport on: account) equals: 'Depósito por 100 * pesos', String newLineString,'Extracción por 80 * pesos', String newLineString,'Balance = 20 * pesos'
! !

!ReportTest methodsFor: 'tests' stamp: 'LJKLDSf 11/18/2022 11:57:41'!
test05accountSummaryOfTransferedAccountShowsTransfer

	| destinationAccount originAccount |

	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.

	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.

	Transfer amount: 2 * peso from: originAccount to: destinationAccount.

	self assert: (AccountSummaryReport on: originAccount) equals: 'Depósito por 10 * pesos', String newLineString,'Salida por transferencia de 2 * pesos', String newLineString,'Balance = 8 * pesos'.! !

!ReportTest methodsFor: 'tests' stamp: 'LJKLDSf 11/18/2022 11:58:08'!
test06netTransferOnEmptyAccountIsZero
	self assert: (NetTransferReport on: account) equals: 0.

! !

!ReportTest methodsFor: 'tests' stamp: 'LJKLDSf 11/18/2022 11:58:08'!
test07netTransferOnAccountWithADepositAndNoTransfersIsZero
	Deposit register: (100 * peso) on: account.
	self assert: (NetTransferReport on: account) equals: 0 * peso.
! !

!ReportTest methodsFor: 'tests' stamp: 'LJKLDSf 11/18/2022 11:58:08'!
test08netTransferOnAccountWithAWithdrawAndNoTransfersIsZero
	Withdraw register: (100 * peso) on: account.
	self assert: (NetTransferReport on: account) equals: 0 * peso.
! !

!ReportTest methodsFor: 'tests' stamp: 'LJKLDSf 11/18/2022 11:58:08'!
test09netTransferOnAccountWithCounterTransactionsIsZero
	Withdraw register: (100 * peso) on: account.
	Deposit register: (-100 * peso) on: account.

	self assert: (NetTransferReport on: account) equals: 0 * peso.
! !

!ReportTest methodsFor: 'tests' stamp: 'LJKLDSf 11/18/2022 11:58:08'!
test10

	| destinationAccount originAccount transfer |

	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.

	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.

	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.

	self assert: (NetTransferReport on: destinationAccount) equals: 2 * peso.

! !

!ReportTest methodsFor: 'tests' stamp: 'LJKLDSf 11/18/2022 11:58:08'!
test11

	| destinationAccount portfolioDestinationAccount originAccount|

	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.

	destinationAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: destinationAccount.
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	portfolioDestinationAccount := Portfolio with: destinationAccount.

	self assert: (NetTransferReport on: portfolioDestinationAccount) equals: 2 * peso.! !

!ReportTest methodsFor: 'tests' stamp: 'LL 11/18/2022 10:22:40'!
test12EmtpyPortfolioOnlyReturnsName
	|riquelmePortfolio arbol|
	riquelmePortfolio := Portfolio named: 'Portfolio de Riquelme'.

	arbol := OrderedCollection new.
	arbol add: 'Portfolio de Riquelme'.

	self assert: (PortfolioTreePrinter on: riquelmePortfolio) equals: arbol
	! !

!ReportTest methodsFor: 'tests' stamp: 'LL 11/18/2022 10:23:08'!
test13EmtpyPortfolioCanBeNamedWithDifferentNames
	|palermoPortfolio arbol|
	palermoPortfolio := Portfolio named: 'Portfolio de Palermo'.

	arbol := OrderedCollection new.
	arbol add: 'Portfolio de Palermo'.

	self assert: (PortfolioTreePrinter on: palermoPortfolio) equals: arbol! !

!ReportTest methodsFor: 'tests' stamp: 'LL 11/18/2022 10:24:56'!
test14
	|palermoPortfolio arbol|

	palermoPortfolio := Portfolio named: 'Portfolio de Palermo' with: accountBoca.

	arbol := OrderedCollection new.
	arbol add: 'Portfolio de Palermo'.
	arbol add: '#Cuenta boca'.

	self assert: (PortfolioTreePrinter on: palermoPortfolio) equals: arbol.! !

!ReportTest methodsFor: 'tests' stamp: 'LL 11/18/2022 10:26:31'!
test15
	|palermoPortfolio arbol|

	palermoPortfolio := Portfolio named: 'Portfolio de Palermo' with: accountBoca with: accountLeveroni.

	arbol := OrderedCollection new.
	arbol add: 'Portfolio de Palermo'.
	arbol add: '#Cuenta boca'.
	arbol add: '#Cuenta leveroni'.

	self assert: (PortfolioTreePrinter on: palermoPortfolio) equals: arbol.! !

!ReportTest methodsFor: 'tests' stamp: 'LL 11/18/2022 11:05:58'!
test16
	|palermoPortfolio arbol afaPortfolio |

	afaPortfolio := Portfolio named: 'Portfolio de Afa' with: accountBoca with: accountMessi.
	palermoPortfolio := Portfolio named: 'Portfolio de Palermo' with: accountLeveroni with: afaPortfolio.

	arbol := OrderedCollection new.
	arbol add: 'Portfolio de Palermo'.
	arbol add: '#Cuenta leveroni'.
	arbol add: '#Portfolio de Afa'.
	arbol add: '##Cuenta boca'.
	arbol add: '##Cuenta messi'.

	self assert: (PortfolioTreePrinter on: palermoPortfolio) equals: arbol.! !

!ReportTest methodsFor: 'tests' stamp: 'LL 11/18/2022 11:55:18'!
test17DetailedTreePrinterWithoutTransactions
	|palermoPortfolio arbol afaPortfolio |

	afaPortfolio := Portfolio named: 'Portfolio de Afa' with: accountBoca with: accountMessi.
	palermoPortfolio := Portfolio named: 'Portfolio de Palermo' with: accountLeveroni with: afaPortfolio.

	arbol := OrderedCollection new.
	arbol add: 'Portfolio de Palermo'.
	arbol add: '#Cuenta leveroni'.
	arbol add: '##Balance = 0 * pesos'.
	arbol add: '#Portfolio de Afa'.
	arbol add: '##Cuenta boca'.
	arbol add: '###Balance = 0 * pesos'.
	arbol add: '##Cuenta messi'.
	arbol add: '###Balance = 0 * pesos'.
	arbol add: '##Balance = 0 * pesos'.
	arbol add: '#Balance = 0 * pesos'.

	self assert: (PortfolioDetailedTreePrinter on: palermoPortfolio) equals: arbol.! !

!ReportTest methodsFor: 'tests' stamp: 'LL 11/18/2022 11:55:08'!
test18DetailedTreePrinterWithSimpleTransactions
	|palermoPortfolio arbol afaPortfolio |

	afaPortfolio := Portfolio named: 'Portfolio de Afa' with: accountBoca with: accountMessi.
	palermoPortfolio := Portfolio named: 'Portfolio de Palermo' with: accountLeveroni with: afaPortfolio.

	Deposit register: 100 * peso on: accountBoca.
	Deposit register: 100 * peso on: accountMessi.


	arbol := OrderedCollection new.
	arbol add: 'Portfolio de Palermo'.
	arbol add: '#Cuenta leveroni'.
	arbol add: '##Balance = 0 * pesos'.
	arbol add: '#Portfolio de Afa'.
	arbol add: '##Cuenta boca'.
	arbol add: '###Depósito por 100 * pesos'.
	arbol add: '###Balance = 100 * pesos'.
	arbol add: '##Cuenta messi'.
	arbol add: '###Depósito por 100 * pesos'.
	arbol add: '###Balance = 100 * pesos'.
	arbol add: '##Balance = 200 * pesos'.
	arbol add: '#Balance = 200 * pesos'.

	self assert: (PortfolioDetailedTreePrinter on: palermoPortfolio) equals: arbol.! !

!ReportTest methodsFor: 'tests' stamp: 'LL 11/18/2022 11:51:50'!
test19DetailedTreePrinterWithMultipleTransactions
	|palermoPortfolio arbol afaPortfolio |

	afaPortfolio := Portfolio named: 'Portfolio de Afa' with: accountBoca with: accountMessi.
	palermoPortfolio := Portfolio named: 'Portfolio de Palermo' with: accountLeveroni with: afaPortfolio.

	Deposit register: 100 * peso on: accountBoca.
	Withdraw register: 50 * peso on: accountBoca.
	Deposit register: 100 * peso on: accountMessi.

	Transfer amount: 20 * peso from: accountMessi to: accountLeveroni.

	arbol := OrderedCollection new.
	arbol add: 'Portfolio de Palermo'.
	arbol add: '#Cuenta leveroni'.
	arbol add: '##Entrada por transferencia de 20 * pesos'.
	arbol add: '##Balance = 20 * pesos'.
	arbol add: '#Portfolio de Afa'.
	arbol add: '##Cuenta boca'.
	arbol add: '###Depósito por 100 * pesos'.
	arbol add: '###Extracción por 50 * pesos'.
	arbol add: '###Balance = 50 * pesos'.
	arbol add: '##Cuenta messi'.
	arbol add: '###Depósito por 100 * pesos'.
	arbol add: '###Salida por transferencia de 20 * pesos'.
	arbol add: '###Balance = 80 * pesos'.
	arbol add: '##Balance = 130 * pesos'.
	arbol add: '#Balance = 150 * pesos'.

	self assert: (PortfolioDetailedTreePrinter on: palermoPortfolio) equals: arbol.! !


!ReportTest methodsFor: 'setUp/tearDown' stamp: 'LL 11/18/2022 10:26:03'!
setUp
	account := ReceptiveAccount new.
	accountBoca := ReceptiveAccount named: 'Cuenta boca'.
	accountLeveroni := ReceptiveAccount named: 'Cuenta leveroni'.
	accountMessi := ReceptiveAccount named: 'Cuenta messi'.! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |

	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.

	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.

	Transfer amount: 2 * peso from: originAccount to: destinationAccount.

	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |

	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.

	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.

	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.

	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |

	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.

	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.

	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.

	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |

	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.

	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.

	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.

	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |

	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.

	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |

	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.

	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.

	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!Account methodsFor: 'as yet unclassified' stamp: 'LL 11/16/2022 22:26:28'!
accept: aVisitor
	self subclassResponsibility ! !

!Account methodsFor: 'as yet unclassified' stamp: 'LL 11/18/2022 09:38:14'!
name
	^name! !

!Account methodsFor: 'as yet unclassified' stamp: 'LL 11/18/2022 09:36:48'!
withName: aName
	name := aName! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'ServiciosFinancieros-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'as yet unclassified' stamp: 'LL 11/18/2022 09:31:53'!
named: aName
	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'LL 7/1/2021 03:21:03'!
initialize

	accounts := OrderedCollection new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'LL 11/18/2022 09:59:20'!
accounts
	^accounts! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:19:36'!
balance

	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'LL 11/18/2022 09:34:34'!
transactions
	| transactions |

	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].

	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'LL 7/1/2021 03:21:12'!
add: accountToAdd

	accounts add: accountToAdd.
	! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'LL 11/16/2022 22:26:41'!
accept: aVisitor
	^aVisitor visitPortfolio: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'LL 11/18/2022 09:50:02'!
named: aName
	^self new withName: aName! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'LL 11/18/2022 09:50:31'!
named: aName with: anAccount
	^(self with: anAccount) withName: aName! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'LL 11/18/2022 09:50:15'!
named: aName with: anAccount with: anotherAccount
	^(self with: anAccount with: anotherAccount) withName: aName! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'LL 11/18/2022 09:13:55'!
balance

	^transactions
		inject: 0 * peso
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
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


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'Menem 11/15/2022 21:37:39'!
accept: aVisitor
	^aVisitor visitReceptiveAccount: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'LL 11/18/2022 09:39:32'!
named: aName
	^self new withName: aName! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'LL 11/16/2022 22:26:55'!
accept: aVisitor
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |

	transaction := self for: aValue.
	account register: transaction.

	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'LL 11/16/2022 22:28:57'!
accept: aVisitor
	^aVisitor visitDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !


!TransferLeg methodsFor: 'as yet unclassified' stamp: 'LL 11/16/2022 22:27:11'!
accept: aVisitor
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |

	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.

	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'as yet unclassified' stamp: 'LL 11/16/2022 22:27:25'!
accept: aVisitor
	^aVisitor visitTransferDepositLeg: self.! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferWithdrawLeg methodsFor: 'as yet unclassified' stamp: 'LL 11/16/2022 22:28:09'!
accept: aVisitor
	^aVisitor visitTransferWithdrawLeg: self.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'LL 11/16/2022 22:28:35'!
accept: aVisitor
	^aVisitor visitWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Report methodsFor: 'as yet unclassified' stamp: 'LL 11/16/2022 22:06:48'!
visitDeposit: aDeposit
	self subclassResponsibility ! !

!Report methodsFor: 'as yet unclassified' stamp: 'LL 11/16/2022 22:07:32'!
visitPortfolio: aPortfolio
	self subclassResponsibility ! !

!Report methodsFor: 'as yet unclassified' stamp: 'Menem 11/15/2022 21:40:24'!
visitReceptiveAccount: aReceptiveAccount
	self subclassResponsibility ! !

!Report methodsFor: 'as yet unclassified' stamp: 'LL 11/16/2022 22:07:22'!
visitTransferDepositLeg: aTransferDepositLeg
	self subclassResponsibility ! !

!Report methodsFor: 'as yet unclassified' stamp: 'LL 11/16/2022 22:07:15'!
visitTransferWithdrawLeg: aTransferWithdrawLeg
	self subclassResponsibility ! !

!Report methodsFor: 'as yet unclassified' stamp: 'LL 11/16/2022 22:06:56'!
visitWithdraw: aWithdraw
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'ServiciosFinancieros-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'alr 11/17/2022 20:14:34'!
on: anAccount
	self subclassResponsibility! !


!classDefinition: #AccountSummaryReport category: 'ServiciosFinancieros-Solucion'!
Report subclass: #AccountSummaryReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'LL 11/16/2022 22:18:31'!
visitDeposit: aDeposit
	^'Depósito por ', (aDeposit value asString)
! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'LL 11/18/2022 09:29:44'!
visitPortfolio: aPortfolio
	| cadena |
	cadena := String new.
	aPortfolio transactions do: [:aTransaction | cadena := (cadena, (aTransaction accept: self),  String newLineString)].
	^cadena, 'Balance = ', aPortfolio balance asString! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'LL 11/18/2022 09:23:07'!
visitReceptiveAccount: anAccount
	| cadena |
	cadena := String new.
	anAccount transactions do: [:aTransaction | cadena := (cadena, (aTransaction accept: self),  String newLineString)].
	^cadena, 'Balance = ', anAccount balance asString! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'LL 11/16/2022 22:18:03'!
visitTransferDepositLeg: aTransferDepositLeg
	^'Entrada por transferencia de ', (aTransferDepositLeg value asString)
! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'LL 11/16/2022 22:13:46'!
visitTransferWithdrawLeg: aTransferWithdrawLeg
	^'Salida por transferencia de ', (aTransferWithdrawLeg value asString)
! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'LL 11/16/2022 22:18:47'!
visitWithdraw: aWithdraw
	^'Extracción por ', (aWithdraw value asString)
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummaryReport class' category: 'ServiciosFinancieros-Solucion'!
AccountSummaryReport class
	instanceVariableNames: ''!

!AccountSummaryReport class methodsFor: 'instance creation' stamp: 'alr 11/17/2022 20:11:05'!
on: anAccount
	^anAccount accept: (self new) ! !


!classDefinition: #NetTransferReport category: 'ServiciosFinancieros-Solucion'!
Report subclass: #NetTransferReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!NetTransferReport methodsFor: 'as yet unclassified' stamp: 'LL 11/16/2022 22:10:17'!
visitDeposit: aDeposit
	^0 * peso.
! !

!NetTransferReport methodsFor: 'as yet unclassified' stamp: 'LL 11/16/2022 22:11:05'!
visitPortfolio: aPortfolio
	| net |
	net := 0 * peso.
	aPortfolio transactions	do: [:aTransaction | net := net + (aTransaction accept: self)].
	^net
! !

!NetTransferReport methodsFor: 'as yet unclassified' stamp: 'LL 11/16/2022 22:30:17'!
visitReceptiveAccount: anAccount
	| net |
	net := 0 * peso.
	anAccount transactions	do: [:aTransaction | net := net + (aTransaction accept: self)].
	^net
! !

!NetTransferReport methodsFor: 'as yet unclassified' stamp: 'LL 11/16/2022 22:19:26'!
visitTransferDepositLeg: aTransferDepositLeg
	^aTransferDepositLeg value
! !

!NetTransferReport methodsFor: 'as yet unclassified' stamp: 'LL 11/16/2022 22:20:03'!
visitTransferWithdrawLeg: aTransferWithdrawLeg
	^(aTransferWithdrawLeg value) * -1! !

!NetTransferReport methodsFor: 'as yet unclassified' stamp: 'LL 11/16/2022 22:10:12'!
visitWithdraw: aWithdraw
	^0 * peso.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NetTransferReport class' category: 'ServiciosFinancieros-Solucion'!
NetTransferReport class
	instanceVariableNames: ''!

!NetTransferReport class methodsFor: 'instance creation' stamp: 'alr 11/17/2022 20:13:10'!
on: anAccount
	^anAccount accept: (self new)! !


!classDefinition: #PortfolioDetailedTreePrinter category: 'ServiciosFinancieros-Solucion'!
Report subclass: #PortfolioDetailedTreePrinter
	instanceVariableNames: 'indice summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioDetailedTreePrinter methodsFor: 'visitors' stamp: 'LL 11/18/2022 11:31:19'!
visitDeposit: aDeposit
	| subArbol |
	indice := indice + 1.
	subArbol := OrderedCollection with: (self tabulacion, (summary visitDeposit: aDeposit)).
	indice := indice - 1.
	^subArbol.

! !

!PortfolioDetailedTreePrinter methodsFor: 'visitors' stamp: 'LL 11/18/2022 11:45:46'!
visitPortfolio: aPortfolio
	| arbol |
	indice := indice + 1.

	arbol := OrderedCollection new.
	arbol add: (self tabulacion, aPortfolio name).
	aPortfolio accounts do: [:anAccount | arbol addAllLast: (anAccount accept: self) ].

	indice := indice + 1.
	arbol add: (self tabulacion, 'Balance = ', aPortfolio balance asString).
	indice := indice - 2.
	^arbol
! !

!PortfolioDetailedTreePrinter methodsFor: 'visitors' stamp: 'LL 11/18/2022 11:34:08'!
visitReceptiveAccount: anAccount
	| subArbol |
	indice := indice + 1.

	subArbol := OrderedCollection with: (self tabulacion, anAccount name).
	anAccount transactions do: [:aTransaction | subArbol addAllLast: (aTransaction accept: self) ].
	indice := indice + 1.
	subArbol add: (self tabulacion, 'Balance = ', anAccount balance asString).
	indice := indice - 2.
	^subArbol.
! !

!PortfolioDetailedTreePrinter methodsFor: 'visitors' stamp: 'LL 11/18/2022 11:31:34'!
visitTransferDepositLeg: aTransferDepositLeg
	| subArbol |
	indice := indice + 1.
	subArbol := OrderedCollection with: (self tabulacion, (summary visitTransferDepositLeg: aTransferDepositLeg)).
	indice := indice - 1.
	^subArbol.! !

!PortfolioDetailedTreePrinter methodsFor: 'visitors' stamp: 'LL 11/18/2022 11:31:29'!
visitTransferWithdrawLeg: aTransferWithdrawLeg
	| subArbol |
	indice := indice + 1.
	subArbol := OrderedCollection with: (self tabulacion, (summary visitTransferWithdrawLeg: aTransferWithdrawLeg)).
	indice := indice - 1.
	^subArbol.! !

!PortfolioDetailedTreePrinter methodsFor: 'visitors' stamp: 'LL 11/18/2022 11:31:24'!
visitWithdraw: aWithdraw
	| subArbol |
	indice := indice + 1.
	subArbol := OrderedCollection with: (self tabulacion, (summary visitWithdraw: aWithdraw)).
	indice := indice - 1.
	^subArbol.! !


!PortfolioDetailedTreePrinter methodsFor: 'tabs' stamp: 'LL 11/18/2022 11:13:10'!
tab
	^'#'! !

!PortfolioDetailedTreePrinter methodsFor: 'tabs' stamp: 'LL 11/18/2022 11:13:10'!
tabulacion
	|cadena|
	cadena := String new.
	indice timesRepeat: [cadena := cadena, self tab].
	^cadena.! !


!PortfolioDetailedTreePrinter methodsFor: 'initialization' stamp: 'LJKLDSf 11/18/2022 11:57:41'!
initialize
	summary := AccountSummaryReport new.
	indice := -1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioDetailedTreePrinter class' category: 'ServiciosFinancieros-Solucion'!
PortfolioDetailedTreePrinter class
	instanceVariableNames: ''!

!PortfolioDetailedTreePrinter class methodsFor: 'instance creation' stamp: 'LL 11/18/2022 11:13:10'!
on: aPortfolio
	^aPortfolio accept: (self new)! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros-Solucion'!
Report subclass: #PortfolioTreePrinter
	instanceVariableNames: 'indice'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinter methodsFor: 'visitors' stamp: 'LL 11/18/2022 11:09:21'!
visitDeposit: aDeposit

! !

!PortfolioTreePrinter methodsFor: 'visitors' stamp: 'LL 11/18/2022 11:00:56'!
visitPortfolio: aPortfolio
	| arbol |
	indice := indice + 1.

	arbol := OrderedCollection new.
	arbol add: (self tabulacion, aPortfolio name).
	aPortfolio accounts do: [:anAccount | arbol addAllLast: (anAccount accept: self) ].

	indice := indice - 1.
	^arbol
! !

!PortfolioTreePrinter methodsFor: 'visitors' stamp: 'LL 11/18/2022 11:09:36'!
visitReceptiveAccount: anAccount
	| subArbol |
	indice := indice + 1.
	subArbol := OrderedCollection with: (self tabulacion, anAccount name).
	indice := indice - 1.
	^subArbol.
! !

!PortfolioTreePrinter methodsFor: 'visitors' stamp: 'LL 11/18/2022 11:09:53'!
visitTransferDepositLeg: aTransferDepositLeg

! !

!PortfolioTreePrinter methodsFor: 'visitors' stamp: 'LL 11/18/2022 11:09:29'!
visitTransferWithdrawLeg: aTransferWithdrawLeg
! !

!PortfolioTreePrinter methodsFor: 'visitors' stamp: 'LL 11/18/2022 11:09:32'!
visitWithdraw: aWithdraw
	! !


!PortfolioTreePrinter methodsFor: 'tabs' stamp: 'LL 11/18/2022 11:06:22'!
tab
	^'#'! !

!PortfolioTreePrinter methodsFor: 'tabs' stamp: 'LL 11/18/2022 10:59:35'!
tabulacion
	|cadena|
	cadena := String new.
	indice timesRepeat: [cadena := cadena, self tab].
	^cadena.! !


!PortfolioTreePrinter methodsFor: 'initialization' stamp: 'LL 11/18/2022 11:07:53'!
initialize
	indice := -1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinter class' category: 'ServiciosFinancieros-Solucion'!
PortfolioTreePrinter class
	instanceVariableNames: ''!

!PortfolioTreePrinter class methodsFor: 'instance creation' stamp: 'LL 11/18/2022 11:08:02'!
on: aPortfolio
	^aPortfolio accept: (self new)! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg

	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription

	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin

	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount

	| transfer depositLeg withdrawLeg |

	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.

	transfer := self new.

	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.

	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg


	! !
