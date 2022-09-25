# Preguntas

### Abstracción de los tests 01 y 02

#### En los test 01 y 02 hay código repetido. Cuando lo extrajeron crearon algo nuevo. Eso es algo que estaba en la realidad y no estaba representado en nuestro código, por eso teníamos código repetido. ¿Cuál es esa entidad de la realidad que crearon?

Creamos lo que en la realidad entendemos como un cronómetro, y lo implementamos dentro del código para evaluar los milisegundos que tarda en evaluarse una determinada acción.

### Cómo representar en Smalltalk

#### ¿Cuáles son las formas en que podemos representar entes de la realidad en Smalltalk que conocés? Es decir, ¿qué cosas del lenguaje Smalltalk puedo usar para representar entidades de la realidad?

Las clases implementadas por defecto.

### Teoría de Naur

#### ¿Qué relación hay entre sacar código repetido (creando abstracciones) y la teoría del modelo/sistema (del paper de Naur)?

Crear abstracciones en el código (sacar código repetido) nos permite desarrollar una implementación más flexible, lo que nos permite implementar funcionalidades que no sean inmediatamente requeridas, pero que puedan ser útiles en un futuro.
