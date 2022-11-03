!classDefinition: #MarsRoverTest category: 'TPMarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'explorador'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TPMarsRover'!

!MarsRoverTest methodsFor: 'tests' stamp: 'ALR 10/31/2022 17:32:10'!
test01RoverSeInicializaCorrectamente
	self assertQueElMarsRover: explorador tieneSuPosicionEn: (0@0) yEstaMirandoHacia: #N.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ALR 10/31/2022 19:55:37'!
test02RoverPuedeAvanzarUnoHaciaAdelante
	explorador moveWithStringCommand: 'f'.
	self assertQueElMarsRover: explorador tieneSuPosicionEn: (0@1) yEstaMirandoHacia: #N.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ALR 10/31/2022 19:55:37'!
test03RoverNoHaceNadaConUnComandoVacio
	explorador moveWithStringCommand: ''.
	self assertQueElMarsRover: explorador tieneSuPosicionEn: (0@0) yEstaMirandoHacia: #N.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ALR 10/31/2022 19:55:37'!
test04RoverNoCambiaSuPosicionSiAvanzaYRetrocede
	explorador moveWithStringCommand: 'fb'.
	self assertQueElMarsRover: explorador tieneSuPosicionEn: (0@0) yEstaMirandoHacia: #N.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ALR 10/31/2022 19:55:37'!
test05RoverPuedeCambiarDeDireccion
	explorador moveWithStringCommand: 'l'.
	self assertQueElMarsRover: explorador tieneSuPosicionEn: (0@0) yEstaMirandoHacia: #O.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ALR 10/31/2022 19:55:37'!
test06RoverPuedeCambiarDeDireccionYAvanzarMultiplesVeces
	explorador moveWithStringCommand: 'flfrfflfffrrfb'.
	self assertQueElMarsRover: explorador tieneSuPosicionEn: (-4@3) yEstaMirandoHacia: #E.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ALR 10/31/2022 19:55:37'!
test07RoverDejaDeEjecutarLosComandosCuandoEncuentraUnoInvalido
	explorador moveWithStringCommand: 'ffffffffffrrMfffffffffrrrrfffrfrfrfrfrfrfllllllbbbbbbbrl'.
	self assertQueElMarsRover: explorador tieneSuPosicionEn: (0@10) yEstaMirandoHacia: #S.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ALR 10/31/2022 19:55:37'!
test08RoverHaceUnGiroCompleto
	explorador moveWithStringCommand: 'llll'.
	self assertQueElMarsRover: explorador tieneSuPosicionEn: (0@0) yEstaMirandoHacia: #N.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ALR 11/3/2022 15:32:32'!
test09InicializarRoverConCardinalInvalidoLevantaUnError
	self
		should: [ MarsRover deployInPositionX: 0 andY: 0 pointingTo: #F ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: MarsRover invalidCardinalDescription equals: anError messageText ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ALR 11/3/2022 15:32:32'!
test10InicializarRoverConXInvalidaLevantaUnError
	self
		should: [ MarsRover deployInPositionX: 'cuarenta y ocho' andY: 0 pointingTo: #N ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: MarsRover invalidXPositionDescription equals: anError messageText ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'ALR 11/3/2022 15:32:32'!
test11InicializarRoverConYInvalidaLevantaUnError
	self
		should: [ MarsRover deployInPositionX: 0 andY: 'setenta y cuatro' pointingTo: #N ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: MarsRover invalidYPositionDescription equals: anError messageText ]! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'ALR 10/31/2022 21:55:04'!
assertQueElMarsRover: unMarsRover tieneSuPosicionEn: unaPosicionEsperada yEstaMirandoHacia: unPuntoCardinalEsperado
	self assert: (unMarsRover direction) equals: unPuntoCardinalEsperado.
	self assert: (unMarsRover position) equals: unaPosicionEsperada.! !


!MarsRoverTest methodsFor: 'setUp/tearDown' stamp: 'ALR 11/3/2022 15:32:32'!
setUp
	explorador := MarsRover deployInPositionX: 0 andY: 0 pointingTo: #N.! !


!classDefinition: #MarsRover category: 'TPMarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'actualPosition actualDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TPMarsRover'!

!MarsRover methodsFor: 'accesing' stamp: 'LL 10/30/2022 20:26:35'!
direction
	^actualDirection class simbolo.! !

!MarsRover methodsFor: 'accesing' stamp: 'LL 10/30/2022 19:29:42'!
position
	^actualPosition ! !


!MarsRover methodsFor: 'operations' stamp: 'ALR 10/31/2022 19:57:17'!
moveWithStringCommand: aStringCommand
	| posicionDelCaracterAEvaluar |
	aStringCommand isEmpty ifTrue: [^self].
	posicionDelCaracterAEvaluar := 1.

	[posicionDelCaracterAEvaluar <= aStringCommand size] whileTrue:[
		('fblr' includes: (aStringCommand at: posicionDelCaracterAEvaluar)) ifFalse: [^self].
		((aStringCommand at: 	posicionDelCaracterAEvaluar) = $f)  ifTrue: [actualPosition := actualPosition + actualDirection avanzar].
		((aStringCommand at: 	posicionDelCaracterAEvaluar) = $b) ifTrue: [actualPosition := actualPosition + actualDirection retroceder].
		((aStringCommand at: 	posicionDelCaracterAEvaluar) = $l)  ifTrue: [actualDirection := actualDirection rotarIzquierda].
		((aStringCommand at: 	posicionDelCaracterAEvaluar) = $r) ifTrue: [actualDirection := actualDirection rotarDerecha].
		posicionDelCaracterAEvaluar := posicionDelCaracterAEvaluar + 1.
	].


! !


!MarsRover methodsFor: 'initialization' stamp: 'ALR 10/31/2022 17:50:27'!
initializeInPosition: aCardinalPoint pointingTo: aDirection
	
	actualPosition := aCardinalPoint.
	actualDirection := MarsRoverOrientacion initializeWithDirection: aDirection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'TPMarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'ALR 11/3/2022 15:32:32'!
deployInPositionX: anXPosition andY: anYPosition pointingTo: aPotentialCardinal
	| puntosCardinales |
	
	(anXPosition isKindOf: Number) ifFalse: [ self error: self invalidXPositionDescription ].
	(anYPosition isKindOf: Number) ifFalse: [ self error: self invalidYPositionDescription ].
	
	puntosCardinales := #(#N, #O, #S, #E).
	(puntosCardinales includes: aPotentialCardinal) ifFalse: [ self error: self invalidCardinalDescription ].
	
	^self new initializeInPosition: (anXPosition@anYPosition) pointingTo: aPotentialCardinal.! !


!MarsRover class methodsFor: 'errors' stamp: 'ALR 10/31/2022 19:22:20'!
invalidCardinalDescription
	^'El punto cardinal ingresado no es válido'.! !

!MarsRover class methodsFor: 'errors' stamp: 'ALR 10/31/2022 20:02:16'!
invalidXPositionDescription
	^'El punto X ingresado no es válido'.! !

!MarsRover class methodsFor: 'errors' stamp: 'ALR 10/31/2022 20:02:25'!
invalidYPositionDescription
	^'El punto Y ingresado no es válido'.! !


!classDefinition: #MarsRoverOrientacion category: 'TPMarsRover'!
Object subclass: #MarsRoverOrientacion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TPMarsRover'!

!MarsRoverOrientacion methodsFor: 'orders' stamp: 'LL 10/30/2022 20:34:51'!
avanzar
	self subclassResponsibility ! !

!MarsRoverOrientacion methodsFor: 'orders' stamp: 'LL 10/30/2022 20:33:09'!
retroceder
	self subclassResponsibility ! !

!MarsRoverOrientacion methodsFor: 'orders' stamp: 'LL 10/30/2022 20:17:53'!
rotarDerecha
	self subclassResponsibility.! !

!MarsRoverOrientacion methodsFor: 'orders' stamp: 'LL 10/30/2022 20:17:48'!
rotarIzquierda
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverOrientacion class' category: 'TPMarsRover'!
MarsRoverOrientacion class
	instanceVariableNames: ''!

!MarsRoverOrientacion class methodsFor: 'accessing' stamp: 'LL 10/30/2022 20:24:32'!
simbolo 
	self subclassResponsibility.! !


!MarsRoverOrientacion class methodsFor: 'instance creation' stamp: 'LL 10/30/2022 20:24:38'!
initializeWithDirection: aDireccion
	| subclase |
	subclase := self subclasses detect: [:subclass | subclass simbolo = aDireccion ].
	^subclase new.
! !


!classDefinition: #MarsRoverOrientacionEste category: 'TPMarsRover'!
MarsRoverOrientacion subclass: #MarsRoverOrientacionEste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TPMarsRover'!

!MarsRoverOrientacionEste methodsFor: 'orders' stamp: 'LL 10/30/2022 20:35:05'!
avanzar
	^1@0! !

!MarsRoverOrientacionEste methodsFor: 'orders' stamp: 'LL 10/30/2022 20:35:11'!
retroceder
	^-1@0! !

!MarsRoverOrientacionEste methodsFor: 'orders' stamp: 'ALR 10/31/2022 17:29:34'!
rotarDerecha
	^MarsRoverOrientacionSur new.! !

!MarsRoverOrientacionEste methodsFor: 'orders' stamp: 'ALR 10/31/2022 17:29:08'!
rotarIzquierda
	^MarsRoverOrientacionNorte new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverOrientacionEste class' category: 'TPMarsRover'!
MarsRoverOrientacionEste class
	instanceVariableNames: ''!

!MarsRoverOrientacionEste class methodsFor: 'accessing' stamp: 'LL 10/30/2022 20:23:46'!
simbolo
	^#E! !


!classDefinition: #MarsRoverOrientacionNorte category: 'TPMarsRover'!
MarsRoverOrientacion subclass: #MarsRoverOrientacionNorte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TPMarsRover'!

!MarsRoverOrientacionNorte methodsFor: 'orders' stamp: 'LL 10/30/2022 20:35:38'!
avanzar
	^0@1! !

!MarsRoverOrientacionNorte methodsFor: 'orders' stamp: 'LL 10/30/2022 20:35:33'!
retroceder
	^0@-1! !

!MarsRoverOrientacionNorte methodsFor: 'orders' stamp: 'ALR 10/31/2022 17:28:51'!
rotarDerecha
	^MarsRoverOrientacionEste new.! !

!MarsRoverOrientacionNorte methodsFor: 'orders' stamp: 'ALR 10/31/2022 17:29:23'!
rotarIzquierda
	^MarsRoverOrientacionOeste new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverOrientacionNorte class' category: 'TPMarsRover'!
MarsRoverOrientacionNorte class
	instanceVariableNames: ''!

!MarsRoverOrientacionNorte class methodsFor: 'accessing' stamp: 'LL 10/30/2022 20:23:58'!
simbolo
	^#N! !


!classDefinition: #MarsRoverOrientacionOeste category: 'TPMarsRover'!
MarsRoverOrientacion subclass: #MarsRoverOrientacionOeste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TPMarsRover'!

!MarsRoverOrientacionOeste methodsFor: 'orders' stamp: 'LL 10/30/2022 20:36:16'!
avanzar
	^-1@0! !

!MarsRoverOrientacionOeste methodsFor: 'orders' stamp: 'LL 10/30/2022 20:36:10'!
retroceder
	^1@0! !

!MarsRoverOrientacionOeste methodsFor: 'orders' stamp: 'ALR 10/31/2022 17:29:08'!
rotarDerecha
	^MarsRoverOrientacionNorte new.! !

!MarsRoverOrientacionOeste methodsFor: 'orders' stamp: 'ALR 10/31/2022 17:29:34'!
rotarIzquierda
	^MarsRoverOrientacionSur new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverOrientacionOeste class' category: 'TPMarsRover'!
MarsRoverOrientacionOeste class
	instanceVariableNames: ''!

!MarsRoverOrientacionOeste class methodsFor: 'accessing' stamp: 'LL 10/30/2022 20:24:16'!
simbolo
	^#O! !


!classDefinition: #MarsRoverOrientacionSur category: 'TPMarsRover'!
MarsRoverOrientacion subclass: #MarsRoverOrientacionSur
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TPMarsRover'!

!MarsRoverOrientacionSur methodsFor: 'orders' stamp: 'LL 10/30/2022 20:35:59'!
avanzar
	^0@-1! !

!MarsRoverOrientacionSur methodsFor: 'orders' stamp: 'LL 10/30/2022 20:35:52'!
retroceder
	^0@1! !

!MarsRoverOrientacionSur methodsFor: 'orders' stamp: 'ALR 10/31/2022 17:29:23'!
rotarDerecha
	^MarsRoverOrientacionOeste new.! !

!MarsRoverOrientacionSur methodsFor: 'orders' stamp: 'ALR 10/31/2022 17:28:51'!
rotarIzquierda
	^MarsRoverOrientacionEste new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverOrientacionSur class' category: 'TPMarsRover'!
MarsRoverOrientacionSur class
	instanceVariableNames: ''!

!MarsRoverOrientacionSur class methodsFor: 'accessing' stamp: 'LL 10/30/2022 20:24:23'!
simbolo
	^#S! !
