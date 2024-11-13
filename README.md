
## ENUNCIADO PRÁCTICA

Se desea realizar una aplicación informática que sirva para simular y gestionar los
alumnos de un pequeño colegio. 

De cada alumno se recoge la siguiente información:

- Nombre. Contiene el nombre del alumno.
- Apellidos. Contiene los apellidos del alumno.
- Número de matrícula. Contiene un número único, que se le asigna al alumno cuando entra en el colegio.
- Teléfono de contacto. Contiene el número de teléfono del tutor@ del alumno.
- Año de nacimiento. Contiene el año de nacimiento del alumno, que le hará que se le asigne a un aula concreta.
Para poder matricularse en el colegio debe tener al menos 3 años y como máximo
12. El colegio tiene como máximo 10 aulas, pero puede suceder que alguna esté
cerrada (no tenga alumnos). También tiene una lista de tutores. Un tutor será el
profesor encargado de un aula. De los tutores se guarda únicamente el nombre y la
especialidad. El número máximo de tutores es 15 (alguno de ellos puede no ser
encargado de un aula).

De un aula se almacena la siguiente información:
- El número de alumnos matriculados.
- Edad. La edad de los alumnos de esa aula.
- Alumnos. La lista de todos los alumnos de esa aula. Como máximo, puede tener 25 alumnos.
- Tutor. El profesor encargado del aula.
Cada vez que un alumno se matricula en el colegio, se le asigna un aula u otro
dependiendo de su edad.

El programa permitirá acceder a las siguientes funciones por medio de un menú:

    a) Tutores
    b) Alumnos
    c) Terminar

Si elige Tutores, el sistema le mostrará un menú con las siguientes opciones:

    1. Alta tutor. Permite añadir los datos de un nuevo tutor. Es preciso comprobar que la lista no esté llena (15 tutores máximo). Se comprobará además que el nombre y la especialidad que se elige no está repetido. Es decir, no puede haber dos tutores con el mismo nombre y especialidad.

    2. Baja tutor. Permite dar de baja un tutor. Antes de eliminarlo, se debe comprobar que no sea tutor de ningún aula. Solamente en ese caso, se podrá eliminar.

    3. Asignar tutor a un aula. Permite asignar un tutor existente en la lista de tutores, a una de las aulas abiertas del colegio. Si esa aula ya tenía un tutor asignado, el tutor será sustituido por el nuevo. Un tutor no puede ser tutor de dos o más aulas.

    4. Desasignar tutor a un aula. Permite quitar a un tutor de una de las aulas abiertas del colegio. Esa aula se quedará sin tutor asignado.

    5. Guardar tutores. Almacena en un archivo binario llamado tutores.dat toda la información correspondiente a los tutores registrados. Esta función se ejecuta siempre al finalizar el programa (previa consulta al usuario) y también desde el propio menú.

    6. Cargar tutores. Carga desde el archivo binario llamado tutores.dat la información correspondiente a los tutores. Al realizar esta acción el listado de tutores que hubiera en el sistema se perderá. Esta función se ejecuta al iniciar el programa (previa consulta al usuario) y también desde el menú.

    7. Guardar nombres de tutores. Almacena en un fichero de texto todos los nombres de los tutores con su especialidad ordenados por nombre. 
    
Si elige Alumnos, el sistema le mostrará un menú con las siguientes opciones:

    1. Matricular a un alumno. Recoge la información correspondiente a un alumno y, dependiendo de su año de nacimiento, lo incorpora a un aula u otra. El número de matrícula que se le asigna al alumno coincide con el número de matriculados efectivo en el colegio. El último número de matrícula asignado en el colegio se corresponde con el número de alumnos que han pasado por el colegio, por lo que siempre aumenta (aunque un alumno se dé de baja, el número de matriculados no disminuye).

    2. Anular matricula de un alumno. Para anular la matrícula de un alumno, se solicita el número de matrícula. Se buscará al alumno y si existe, se procederá a eliminarlo del aula en el que se encuentre.

    3. Mostrar alumnos de un aula. Se solicita la edad y muestra por pantalla todos los alumnos de esa aula concreta.

    4. Mostrar todos los alumnos del colegio. Muestra todos los alumnos del colegio.

    5. Buscar alumno. Permite comprobar si un determinado alumno (identificado por su número de matrícula) existe. Si es así, mostrará todos sus datos, así como los datos del aula en la que está matriculado.

    6. Guardar información del colegio. Almacena en un fichero binario llamado colegio.dat la información correspondiente al colegio. Esta función se ejecuta siempre al finalizar el programa (previa consulta al usuario) y también desde el propio menú.

    7. Cargar información del colegio. Carga desde el fichero binario colegio.dat la información correspondiente al colegio que se encuentra en el fichero. Está opción eliminará toda la información previa. Esta función se ejecuta al iniciar el programa (previa consulta al usuario) y también desde el menú.

## TIPOS DE DATOS A UTILIZAR


## AUTORES
- Silvia de Francisco Gil
- Verónica Ramírez Marín
- Loreto Uzquiano Esteban