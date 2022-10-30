!classDefinition: #TestMarsRover category: 'TPMarsRover'!
TestCase subclass: #TestMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TPMarsRover'!

!TestMarsRover methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 19:37:11'!
test01RoverSeInicializaCorrectamente
	| robot |
	robot := MarsRover InitializeInPosition: 0 andY: 0 pointingTo: #N.
	
	self assert: (robot direction = #N).
	self assert: (robot position = (0@0)).! !

!TestMarsRover methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:37:22'!
test02RoverPuedeAvanzarUnoHaciaAdelante
	| robot |
	robot := MarsRover InitializeInPosition: 0 andY: 0 pointingTo: #N.
	
	robot command: 'f'.

	self assert: (robot position = (0@1)).! !

!TestMarsRover methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 19:38:01'!
test03RoverNoHaceNadaConUnComandoVacio
	| robot |
	robot := MarsRover InitializeInPosition: 0 andY: 0 pointingTo: #N.
	
	robot command: ''.

	self assert: (robot direction = #N).
	self assert: (robot position = (0@0)).! !

!TestMarsRover methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 19:39:41'!
test04RoverNoCambiaSuPosicionSiAvanzaYRetrocede
	| robot |
	robot := MarsRover InitializeInPosition: 0 andY: 0 pointingTo: #N.
	
	robot command: 'fb'.

	self assert: (robot direction = #N).
	self assert: (robot position = (0@0)).! !

!TestMarsRover methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:27:34'!
test05RoverPuedeCambiarDeDireccion
	| robot |
	robot := MarsRover InitializeInPosition: 0 andY: 0 pointingTo: #N.
	
	robot command: 'l'.

	self assert: (robot direction = #O).! !

!TestMarsRover methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:46:52'!
test06RoverPuedeCambiarDeDireccionYAvanzar
	| robot |
	robot := MarsRover InitializeInPosition: 0 andY: 0 pointingTo: #N.
	
	robot command: 'ffffffffffrrMfffffffffrrrrfffrfrfrfrfrfrfllllllbbbbbbbrl'.

	self assert: (robot direction = #S).
	self assert: (robot position = (0@10)).! !

!TestMarsRover methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:46:01'!
test07RoverPuedeCambiarDeDireccionYAvanzarMultiplesVeces
	| robot |
	robot := MarsRover InitializeInPosition: 0 andY: 0 pointingTo: #N.
	
	robot command: 'flfrfflfffrrfb'.

	self assert: (robot direction = #E).
	self assert: (robot position = (-4@3)).! !

!TestMarsRover methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:47:34'!
test08RoverDejaDeEjecutarLosComandosCuandoEncuentraUnoInvalido
	| robot |
	robot := MarsRover InitializeInPosition: 0 andY: 0 pointingTo: #N.
	
	robot command: 'ffffffffffrrMfffffffffrrrrfffrfrfrfrfrfrfllllllbbbbbbbrl'.

	self assert: (robot direction = #S).
	self assert: (robot position = (0@10)).! !

!TestMarsRover methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:51:29'!
test08RoverHaceUnGiroCompleto
	| robot |
	robot := MarsRover InitializeInPosition: 0 andY: 0 pointingTo: #N.
	
	robot command: 'llll'.

	self assert: (robot direction = #N).
	self assert: (robot position = (0@0)).! !


!classDefinition: #MarsRover category: 'TPMarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'actualPosition actualDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TPMarsRover'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:58:15'!
command: aStringCommand
	| i |
	aStringCommand isEmpty ifTrue: [^self].
	i := 1.

	[i <= aStringCommand size] whileTrue:[
		('fblr' includes: (aStringCommand at: i)) ifFalse: [^self].
		((aStringCommand at: 	i) = $f)  ifTrue: [actualPosition := actualPosition + actualDirection avanzar].
		((aStringCommand at: 	i) = $b) ifTrue: [actualPosition := actualPosition + actualDirection retroceder].
		((aStringCommand at: 	i) = $l)  ifTrue: [actualDirection := actualDirection rotarIzquierda].
		((aStringCommand at: 	i) = $r) ifTrue: [actualDirection := actualDirection rotarDerecha].
		i := i +1.
	].


! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:26:35'!
direction
	^actualDirection class simbolo.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:22:39'!
inPosition: aCardinalPoint pointingTo: aDirection
	
	actualPosition := aCardinalPoint.
	actualDirection := Orientacion initializeWithDirection: aDirection.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 19:29:42'!
position
	^actualPosition ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'TPMarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:18:08'!
InitializeInPosition: anXPosition andY: aYPosition pointingTo: aCardinal 
	^self new inPosition: (anXPosition@aYPosition) pointingTo: aCardinal.! !


!classDefinition: #Orientacion category: 'TPMarsRover'!
Object subclass: #Orientacion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TPMarsRover'!

!Orientacion methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:34:51'!
avanzar
	self subclassResponsibility ! !

!Orientacion methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:33:09'!
retroceder
	self subclassResponsibility ! !

!Orientacion methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:17:53'!
rotarDerecha
	self subclassResponsibility.! !

!Orientacion methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:17:48'!
rotarIzquierda
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Orientacion class' category: 'TPMarsRover'!
Orientacion class
	instanceVariableNames: ''!

!Orientacion class methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:24:38'!
initializeWithDirection: aDireccion
	| subclase |
	subclase := self subclasses detect: [:subclass | subclass simbolo = aDireccion ].
	^subclase new.
! !

!Orientacion class methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:24:32'!
simbolo 
	self subclassResponsibility.! !


!classDefinition: #Este category: 'TPMarsRover'!
Orientacion subclass: #Este
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TPMarsRover'!

!Este methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:35:05'!
avanzar
	^1@0! !

!Este methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:35:11'!
retroceder
	^-1@0! !

!Este methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:28:52'!
rotarDerecha
	^Sur new.! !

!Este methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:28:45'!
rotarIzquierda
	^Norte new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Este class' category: 'TPMarsRover'!
Este class
	instanceVariableNames: ''!

!Este class methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:23:46'!
simbolo
	^#E! !


!classDefinition: #Norte category: 'TPMarsRover'!
Orientacion subclass: #Norte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TPMarsRover'!

!Norte methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:35:38'!
avanzar
	^0@1! !

!Norte methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:35:33'!
retroceder
	^0@-1! !

!Norte methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:27:59'!
rotarDerecha
	^Este new.! !

!Norte methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:27:53'!
rotarIzquierda
	^Oeste new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Norte class' category: 'TPMarsRover'!
Norte class
	instanceVariableNames: ''!

!Norte class methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:23:58'!
simbolo
	^#N! !


!classDefinition: #Oeste category: 'TPMarsRover'!
Orientacion subclass: #Oeste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TPMarsRover'!

!Oeste methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:36:16'!
avanzar
	^-1@0! !

!Oeste methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:36:10'!
retroceder
	^1@0! !

!Oeste methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:28:27'!
rotarDerecha
	^Norte new.! !

!Oeste methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:28:30'!
rotarIzquierda
	^Sur new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Oeste class' category: 'TPMarsRover'!
Oeste class
	instanceVariableNames: ''!

!Oeste class methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:24:16'!
simbolo
	^#O! !


!classDefinition: #Sur category: 'TPMarsRover'!
Orientacion subclass: #Sur
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TPMarsRover'!

!Sur methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:35:59'!
avanzar
	^0@-1! !

!Sur methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:35:52'!
retroceder
	^0@1! !

!Sur methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:28:12'!
rotarDerecha
	^Oeste new.! !

!Sur methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:28:16'!
rotarIzquierda
	^Este new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sur class' category: 'TPMarsRover'!
Sur class
	instanceVariableNames: ''!

!Sur class methodsFor: 'as yet unclassified' stamp: 'LL 10/30/2022 20:24:23'!
simbolo
	^#S! !
