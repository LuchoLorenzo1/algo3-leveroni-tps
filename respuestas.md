# Preguntas TP

1) ¿Qué crítica le harías al protocolo de #estaHerido y #noEstaHerido? (en vez de tener solo el mensaje #estaHerido y hacer “#estaHerido not” para saber la negación)
2) ¿Qué opinan de que para algunas funcionalidades tenemos 3 tests para el mismo comportamiento pero aplicando a cada uno de los combatientes (Arthas, Mankrik y Olgra)
3) ¿Cómo modelaron el resultado de haber desarrollado un combate? ¿qué opciones consideraron y por qué se quedaron con la que entregaron y por qué descartaron a las otras?

1- Este protocolo es ineficiente innecesariamente, ya que si en algún momento queremos cambiar la forma en la que se verifica si un combatiente está herido, tendremos que hacerlo en 2 partes. Además que uno es la negación del otro, por lo que puedo conseguir uno con el otro.

2- Tiene sentido si pensamos a cada combatiente como un objeto completamente independiente, pero estas pruebas no serían necesarias si tuviésemos un objeto prototipico con ese mensaje implementando y los demás objetos como hijos de este (ya que sabemos que los 3 responden al mensaje de la misma forma), bastaría con una sola prueba de este método con cualquier combatiente.

3- Modelamos el resultado del combate como un objeto `InformeCombate` que sabe responder a todos los mensajes para poder guardar el estado del combate, y también los mensajes que son necesarios para llevar a cabo los tests. Tuvimos otras ideas en cuenta como un simple array ordenado, cuya primera posicion fuera la cantidad de rondas y la segunda el ganador, pero nos parecia muy poco declarativa y dificil de leer. Y para futuras modificaciones de la realización de combates, es mucho más extensible un propio objeto para esa funcionalidad.
