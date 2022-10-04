#Preguntas

### Aporte de los mensajes de DD

#### En un double dispatch (DD), ¿qué información aporta cada uno de los dos llamados?

El primer llamado nos da información sobre el receptor del mensaje, y el segundo del parámetro, teniendo en cuenta también que cualquiera de los dos puede variar en cuanto al tipo de clase.

### Lógica de instanciado

#### Con lo que vieron y saben hasta ahora, ¿donde les parece mejor tener la lógica de cómo instanciar un objeto? ¿por qué? ¿Y si se crea ese objeto desde diferentes lugares y de diferentes formas? ¿cómo lo resuelven?

La lógica para instanciar debe estar en la superclase, de esta forma sabemos bien qué subclase debemos inicializar. En el caso de que el objeto se crea desde lugares diferentes y de formas diferentes, habría que resolverlo utilizando polimorfismos, eliminando todos esos posibles lugares de creación y creando formas de instanciamiento las cuales hagan el llamado polimórfico.

### Nombres de las categorías de métodos

#### Con lo que vieron y trabajaron hasta ahora, ¿qué criterio están usando para categorizar métodos?

La categorización la hacemos en base a lo que devuelve cada método y el qué de estos, teniendo en cuenta también si pueden ser o no utilizados por fuera de la clase, en caso de que no lo sean, los categorizaremos como métodos privados.

### Subclass Responsibility

#### Si todas las subclases saben responder un mismo mensaje, ¿por qué ponemos ese mensaje sólo con un “self subclassResponsibility” en la superclase? ¿para qué sirve?

Sirve fundamentalmente por 2 motivos: Primero, para dejar explicito en el código que ese mensaje es respondido por las subclases de esta clase, y segundo y más importante, para que si se crean nuevas subclases en el futuro, tengan que tener implementado ese mensaje obligatoriamente.

### No rompas

#### ¿Por qué está mal/qué problemas trae romper encapsulamiento?

Además de estar mal porque se rompe con el concepto de abstracción, sabemos que una clase puede tener miles de formas de implementarse. En el caso de que se quiera cambiar con esta implementación (ya sea porque se encontró otra implementación mejor en términos de complejidad) no solo deberiamos cambiar la implementación de esta clase si no que tambien de la clase que esta rompiendo con el encapsulamiento.
