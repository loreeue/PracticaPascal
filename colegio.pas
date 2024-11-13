PROGRAM pracGrupal;
CONST
	MAXALUMNOS = 25; {numero maximo de alumnos}
	MAXTUTORES = 15; {numero maximo de tutores}
	MAXAULAS = 10; {numero maximo de aulas}
	EDADMINIMA = 3;
	EDADMAXIMA = 12;
TYPE
{tipo Alumno}
	tAlumno = RECORD
		nombre: string;
		apellidos: string;
		numMatricula: integer;
		telefonoContacto: string;
		annoNacimiento: integer;
	END; {tAlumno}
{tipo Tutor}
	tTutor = RECORD
		nombre: string;
		especialidad: string;
	END; {tTutor}
{tipo lista de alumnos}
	tIndiceAlumno = 1..MAXALUMNOS;
	tListaAlumnos = ARRAY [tIndiceAlumno] OF tAlumno;
{tipo Aula}
	tAula = RECORD
		capacidadMaxima:integer;
		numeroAlumnos: integer;
		alumnos : tListaAlumnos;
		edad: integer;
		tutor: tTutor;
	END; {tAula}
{tipo lista de tutores}
	tIndiceTutor = 1..MAXTUTORES;
	tListaTutores = ARRAY [tIndiceTutor] OF tTutor;
{Array parcialmente lleno para tutores}
	tTutores = RECORD
		listadoTutores: tListaTutores;
		tope: integer;
	END; {tTutores}
{tipo lista de Aulas}
	tIndiceAula = 1..MAXAULAS;
	tListaAulas = ARRAY [tIndiceAula] OF tAula;
{tipo Colegio. Array parcialmente lleno para aulas}
	tColegio = RECORD
		aulas: tListaAulas;
		aulasAbiertas: integer;
		nombreColegio: string;
	END; {tColegio}
{tipo archivos binarios}
	tArchivoTutores = FILE OF tTutor;
	tArchivoColegio = FILE OF tColegio;
VAR
	tutor: tTutor;
	tutores: tTutores;
	colegio: tColegio;
	aula: tAula;
	nombre: string;
	opcionMenu1, opcionMenu2, opcionMenu3, opcion4: char;
	numMatriculas, edad, num, i, encontrado: integer;
	ficheroColegio: tArchivoColegio;
	ficheroTutores: tArchivoTutores;
	archivoGuardarTutoresTexto: text;

PROCEDURE menu1;
BEGIN
	writeln;
	writeln('************* MENU **************');
	writeln('Selecciona una de las siguientes opciones:');
	writeln;
	writeln('	1. Tutores');
	writeln('	2. Alumnos');
	writeln('	3. Terminar');
	writeln;
	writeln('Introduce una opcion del menu:');
END; {menu1}

PROCEDURE menu2;
BEGIN
	writeln;
	writeln('************* MENU **************');
	writeln('Selecciona una de las siguientes opciones:');
	writeln;
	writeln('	a) Alta tutor');
	writeln('	b) Baja tutor');
	writeln('	c) Asignar tutor a un aula');
	writeln('	d) Desasignar tutor a un aula');
	writeln('	e) Guardar tutores');
	writeln('	f) Cargar tutores');
	writeln('	g) Guardar nombres de tutores');
	writeln('	h) Volver al menu principal');
	writeln;
	writeln('Introduce una opcion del menu:');
END; {menu2}

PROCEDURE menu3;
BEGIN
	writeln;
	writeln('************* MENU **************');
	writeln('Selecciona una de las siguientes opciones:');
	writeln;
	writeln('	a) Matricular a un alumno');
	writeln('	b) Anular matricula de un alumno');
	writeln('	c) Mostrar alumnos de un aula');
	writeln('	d) Mostrar todos los alumnos del colegio');
	writeln('	e) Buscar alumno');
	writeln('	f) Guardar informacion del colegio');
	writeln('	g) Cargar informacion del colegio');
	writeln('	h) Volver al menu principal');
	writeln;
	writeln('Introduce una opcion del menu:');
END; {menu3}

PROCEDURE pedirDatosTutor (VAR tutorNuevo: tTutor);
VAR
	nombreTutor, especialidadTutor: string;
BEGIN
	nombreTutor := tutorNuevo.nombre;
	especialidadtutor := tutorNuevo.especialidad;

	writeln('Introduce un nombre');
	readln(tutorNuevo.nombre);

	writeln('Introduce la especialidad');
	readln(tutorNuevo.especialidad);
END; {pedirDatosTutor}

FUNCTION existeNombreTutor (nombre: string; tutores: tTutores): integer;
VAR
	i, j, numTope : integer;
BEGIN
	j := -1;
	numTope := tutores.tope;
	FOR i:= 1 TO numTope DO BEGIN
		IF (tutores.listadoTutores[i].nombre = nombre) THEN
			j:= i;
	END;
	existeNombreTutor := j;
END; {existeNombreTutor}

FUNCTION comprobarEspecialidad (especialidad: string; tutores:tTutores): integer;
VAR
	i, j, numTope : integer;
BEGIN
	j := -1;
	numTope := tutores.tope;
	FOR i:= 1 TO numTope DO BEGIN
		IF (tutores.listadoTutores[i].especialidad = especialidad) THEN
			j:= i;
	END;
	comprobarEspecialidad := j;
END; {comprobarEspecialidad}

FUNCTION insertarTutor (tutorNuevo: tTutor; VAR tutores: tTutores): boolean;
VAR
	nombre, especialidad: string;
	numTope : integer;
	insertado : boolean;
BEGIN
	nombre := tutorNuevo.nombre;
	especialidad := tutorNuevo.especialidad;
	insertado := FALSE;
	numTope := tutores.tope;

	IF (existeNombreTutor(nombre, tutores) > 0) AND (comprobarEspecialidad(especialidad, tutores) > 0) THEN
	BEGIN
		writeln;
		writeln('Este tutor no se puede insertar ya que coincide en nombre y especialidad')
	END

	ELSE BEGIN
		IF (numTope < MAXTUTORES) THEN BEGIN
			tutores.tope := tutores.tope + 1;
			tutores.listadoTutores[tutores.tope].nombre := nombre;
			tutores.listadoTutores[tutores.tope].especialidad := especialidad;
			insertado := TRUE;
		END
		ELSE
		BEGIN
			writeln;
	    	writeln('Ya existe el numero maximo de tutores inscritos');
	    END;
	END;
	insertarTutor:= insertado;
END; {insertarTutor}

PROCEDURE mostrarTutores (tutores: tTutores);
VAR
	contador: integer;
BEGIN
	IF tutores.tope <> 0 THEN
	BEGIN
		writeln('	NOMBRE			ESPECIALIDAD');
		FOR contador:= 1 TO tutores.tope DO
		BEGIN
			WITH tutores DO
				write('	',listadoTutores[contador].nombre,'			', listadoTutores[contador].especialidad);
		writeln;
		END; {FOR}
	END {IF}
	ELSE
		writeln('No existen tutores');
END; {mostrarTutores}

FUNCTION existeAulaTutor (nombre: string; colegio: tColegio): boolean;
VAR
	i, numTope : integer;
	existe: boolean;
BEGIN
	existe := FALSE;
	numTope := colegio.aulasAbiertas;
	FOR i:= 1 TO numTope DO BEGIN
		IF (colegio.aulas[i].tutor.nombre = nombre) THEN
			existe := TRUE;
	END;
	existeAulaTutor := existe;
END; {existeAulaTutor}

FUNCTION bajaTutor (nombre: string; VAR tutores:tTutores; colegio: tColegio) : boolean;
VAR
	i, tope, numTutor : integer;
	eliminado, res: boolean;
BEGIN
	eliminado := FALSE;
	tope := tutores.tope;
	res := existeAulaTutor(nombre, colegio);
	IF (res = FALSE) THEN BEGIN
		numTutor := existeNombreTutor(nombre, tutores);
		IF numTutor > 0 THEN BEGIN
			FOR i := numTutor +1 TO MAXTUTORES -1 DO
				tutores.listadoTutores[i-1] := tutores.listadoTutores[i];
			tutores.tope := tutores.tope -1;
			eliminado := TRUE;
		END
		ELSE BEGIN
			writeln;
			writeln('No se ha encontrado ningun tutor con ese nombre');
			eliminado := FALSE;
		END; {ELSE}
	END {IF}
	ELSE BEGIN
		writeln;
		writeln('No se puede eliminar el tutor porque esta asignado a un aula');
		eliminado := FALSE;
	END;
	bajaTutor := eliminado;
END; {bajaTutor}

FUNCTION buscaTutor(tutores: tTutores; nomb: string):boolean;
VAR
    encontrado: boolean;
    num, contador: integer;
BEGIN
    encontrado := FALSE;
    num := tutores.tope;
    contador := 1;
	WHILE (NOT encontrado) AND (contador <= num) DO
	BEGIN
		IF (tutores.listadoTutores[contador].nombre = nomb) THEN
			encontrado := TRUE;
		contador := contador + 1;
	END; {WHILE}
	buscaTutor:= encontrado;
END; {buscaTutor}

PROCEDURE asignarTutor (VAR asignarAula: tAula; VAR colegio: tColegio; tutores: tTutores);
VAR
	aula, i: integer;
	nombre: string;
	contador: integer;
	encontrado: boolean;
BEGIN
	encontrado:= FALSE;
	REPEAT
		writeln;
		writeln('Introduzca el tutor que desea asignar a un aula');
		readln(nombre);
		IF NOT buscaTutor(tutores, nombre) THEN
		BEGIN
			writeln;
			writeln('El tutor introducido no existe');
		END; {IF}
	UNTIL buscaTutor(tutores, nombre);
	writeln('El numero de aulas abiertas es: ', colegio.aulasAbiertas);
	REPEAT
		writeln('Introduzca el numero de aula en el cual quiere asignar el tutor');
		readln(aula);
		IF aula > colegio.aulasAbiertas THEN
			writeln('El numero de aula introducido es incorrecto');
	UNTIL aula <= colegio.aulasAbiertas;
	IF colegio.aulasAbiertas <> 0 THEN
	BEGIN
		FOR contador:= 1 TO colegio.aulasAbiertas DO
		BEGIN
			IF colegio.aulas[contador].tutor.nombre = nombre THEN
			BEGIN
				writeln('El tutor ya esta asignado a un aula, por lo que no se puede volver a asignar');
				encontrado:= TRUE;
			END; {IF}
		END; {FOR}
		IF NOT encontrado THEN
		BEGIN
			writeln;
			colegio.aulas[aula].tutor.nombre:= nombre;
			writeln('El tutor se ha asignado correctamente');
		END; {IF}
	END {IF}
END; {asignarTutor}

PROCEDURE desasignarTutor (VAR colegio: tColegio; tutores: tTutores);
VAR
	nombre: string;
	contador: integer;
	encontrado: boolean;
BEGIN
	REPEAT
		writeln;
		writeln('Introduzca el tutor que desea eliminar');
		readln(nombre);
		IF NOT buscaTutor(tutores, nombre) THEN
		BEGIN
			writeln;
			writeln('El tutor introducido no existe');
		END; {IF}
	UNTIL buscaTutor(tutores, nombre);
	IF colegio.aulasAbiertas <> 0 THEN
	BEGIN
		FOR contador:= 1 TO colegio.aulasAbiertas DO
		BEGIN
			IF colegio.aulas[contador].tutor.nombre = nombre THEN
			BEGIN
				writeln;
				writeln('El tutor se ha desasignado correctamente');
				encontrado:= TRUE;
				colegio.aulas[contador].tutor.nombre:= '';
			END; {IF}
		END; {FOR}
		IF encontrado = FALSE THEN
		BEGIN
			writeln;
			writeln('El tutor no tiene un aula asignada, por lo que no se puede desasignar de un aula');
		END; {IF}
	END {IF}
END; {desasignarTutor}

PROCEDURE guardarTutoresBin (VAR archivoTutores: tArchivoTutores; tutores: tTutores);
VAR
	i, j:integer;
	opcion1: char;
BEGIN
	REPEAT
		writeln('Desea guardar la informacion de los tutores en un archivo? (s/n)');;
		readln(opcion1);
		IF (opcion1 <> 's') AND (opcion1 <> 'S') AND (opcion1 <> 'N') AND (opcion1 <> 'n') THEN
			writeln('La opcion introducida no es valida');
	UNTIL (opcion1 = 's') OR (opcion1 = 'S') OR (opcion1 = 'N') OR (opcion1 = 'n');

	IF (opcion1 = 's') OR (opcion1 = 'S') THEN BEGIN
		j := tutores.tope;
		rewrite(archivoTutores);
		FOR i := 1 TO j DO
	    	write(archivoTutores, tutores.listadoTutores[i]);
		writeln;
  		writeln('Los tutores se han guardado en el fichero binario con exito.');
  		writeln;
   		close(archivoTutores);
   	END;
END; {guardarTutoresBin}

PROCEDURE cargarTutores (VAR ficheroTutores: tArchivoTutores; VAR tutores: tTutores);
VAR
	existe: boolean;
	tutor: tTutor;
BEGIN
	tutores.tope:= 0;
	{$I-} {se desactiva para controlar la apertura para lectura}
	reset(ficheroTutores);
	{$I+}  {se activa para que detecte otros posibles errores que nosotros no vamos a controlar}
	existe := (IOResult= 0);
  	IF existe THEN
	BEGIN
		WHILE (NOT EOF(ficheroTutores)) AND (tutores.tope < MAXTUTORES)  DO BEGIN
			read(ficheroTutores,tutor);
			tutores.tope := tutores.tope + 1;
			tutores.listadoTutores[tutores.tope]:= tutor;
		END; {WHILE}
		close(ficheroTutores);
		writeln;
		writeln('El fichero se ha cargado con exito');
		writeln;
	END {IF}
	ELSE
	BEGIN
		writeln;
		writeln('No existe el fichero Tutores');
		writeln;
	END;
END; {cargarTutores}

PROCEDURE cargarTutoresPrograma;
VAR
	opcion5: char;
	ficheroTutores: tArchivoTutores;
	tutores: tTutores;
BEGIN
	REPEAT
		writeln('Desea cargar la informacion de los tutores? (s/n)');
		readln(opcion5);
		IF (opcion5 <> 's') AND (opcion5 <> 'S') AND (opcion5 <> 'n') AND (opcion5 <> 'N') THEN
		BEGIN
			writeln;
			writeln('La opcion introducida no es correcta');
			writeln;
		END;
	UNTIL (opcion5 = 'N') OR (opcion5 = 'n') OR (opcion5 = 's') OR (opcion5 = 'S');
	IF (opcion5 = 's') OR (opcion5 = 'S') THEN
	BEGIN
		cargarTutores (ficheroTutores, tutores);
	END {IF}
	ELSE IF (opcion5 = 'n') OR (opcion5 = 'N') THEN
	BEGIN
		writeln;
		writeln('El archivo de tutores no se cargara');
		writeln;
	END {ELSE IF}
END; {cargarTutoresPrograma}

FUNCTION compararCaracteres (caracter1, caracter2: char): integer
VAR
	char1, char2: integer;
BEGIN
	char1 := ord(caracter1);
	char2 := ord(caracter2);

	IF (char1 = char2) THEN
		compararCaracteres := 0 {0 para cuando son iguales los caracteres}
	ELSE IF (char1 < char2) THEN
		compararCaracteres := 1 {1 para cuando el primer caracter va antes}
	ELSE
		compararCaracteres := 2; {2 para cuando el primer caracter va despues}
END; {compararCaracteres}

FUNCTION compararTutores (tutor1, tutor2: tTutor) : integer;
VAR
	tutor1nombre, tutor2nombre: string;
	longitud, longitud1, longitud2, i, resultado, comparacion: integer;
	iguales: boolean;
BEGIN
	i := 1;
	iguales := TRUE;
	tutor1nombre := tutor1.nombre;
	tutor2nombre := tutor2.nombre;

	longitud1 := length(tutor1nombre);
	longitud2 := length(tutor2nombre);
	longitud := longitud1;

	IF (longitud > longitud2) THEN
		longitud := longitud2; {porque queremos que compare hasta la longitud mas corta}

	WHILE iguales AND (i < longitud) DO BEGIN
		comparacion := compararCaracteres(tutor1nombre[i], tutor2nombre[i]);
		IF (comparacion = 1) THEN BEGIN
			resultado := 1;
			iguales := FALSE;
		END
		ELSE IF (comparacion = 2) THEN BEGIN
			resultado := 2;
			iguales := FALSE;
		END;
		i := i + 1;
	END;

	IF iguales THEN BEGIN
		IF (longitud1 < longitud2) THEN
			resultado := 1
		ELSE
			resultado := 2;
	END;
	compararTutores := resultado;
END; {compararTutores}

PROCEDURE ordenarTutores (VAR tutores : tTutores);
VAR
	i, j, tope: integer;
	menorPosicion : integer;
	tutorOrdenado: tTutor;
BEGIN
	tope := tutores.tope;
	FOR i := 1 TO tope DO BEGIN
		tutorOrdenado := tutores.listadoTutores[i];
		menorPosicion := i;
		FOR j := (i + 1) TO tope DO
			IF (compararTutores(tutores.listadoTutores[j], tutorOrdenado) = 1) THEN BEGIN
				tutorOrdenado := tutores.listadoTutores[j];
				menorPosicion := j;
			END; {IF}

		IF menorPosicion <> i THEN BEGIN
			tutores.listadoTutores[menorPosicion] := tutores.listadoTutores[i];
			tutores.listadoTutores[i] := tutorOrdenado;
		END; {IF}
	END; {FOR}
END; {ordenarTutores}

PROCEDURE guardarTutoresTxt (VAR archivoTutores: text; tutores: tTutores);
VAR
	i,j:integer;
	tutoresOrdenados: tTutores;
	opcion1: char;
BEGIN
	REPEAT
		writeln('Desea guardar el nombre y especialidad de los tutores en un archivo de texto? (s/n)');;
		readln(opcion1);
		IF (opcion1 <> 's') AND (opcion1 <> 'S') AND (opcion1 <> 'N') AND (opcion1 <> 'n') THEN
			writeln('La opcion introducida no es valida');
	UNTIL (opcion1 = 's') OR (opcion1 = 'S') OR (opcion1 = 'N') OR (opcion1 = 'n');

	IF (opcion1 = 's') OR (opcion1 = 'S') THEN BEGIN
		tutoresOrdenados := tutores;
		ordenarTutores(tutoresOrdenados);
		j := tutoresOrdenados.tope;
		rewrite(archivoTutores);
		FOR i := 1 TO j DO BEGIN
	    	write(archivoTutores, tutoresOrdenados.listadoTutores[i].nombre, ' ');
	       	writeln(archivoTutores, tutoresOrdenados.listadoTutores[i].especialidad);
		END;
	  	writeln('Los tutores se han guardado en el fichero de texto con exito.');
	   	close(archivoTutores);
	END;
END; {guardarTutoresTxt}

{SUBPROGRAMAS CORRESPONDIENTES A ALUMNOS}

FUNCTION matricularAlumno (VAR alumnoNuevo: tAlumno; matricula: integer): integer;
VAR
	nombre, apellidos, telefono: string;
	anno, edad: integer;

BEGIN
	alumnoNuevo.numMatricula := matricula;

	writeln('Introduce un nombre');
	readln(nombre);
	alumnoNuevo.nombre := nombre;

	writeln('Introduce los apellidos');
	readln(apellidos);
	alumnoNuevo.apellidos := apellidos;

	REPEAT
		writeln('Introduce el telefono');
		readln(telefono);
	UNTIL (length(telefono) = 9);
	alumnoNuevo.telefonoContacto := telefono;

	writeln('Introduce el anno de nacimiento');
	readln(anno);
	alumnoNuevo.annoNacimiento := anno;

	edad := 2022 - anno;
		IF (edad > EDADMAXIMA) OR (edad < EDADMINIMA) THEN
		BEGIN
			writeln;
			writeln('No cumple con los criterios de edad para ser matriculado')
		END
		ELSE
		BEGIN
			writeln;
			writeln('Datos del alumno recogidos con exito');
		END;

	matricularAlumno := edad;
END; {matricularAlumno}

FUNCTION asignarAula (VAR colegio: tColegio; VAR matricula: integer) : boolean;
VAR
	edad: integer;
	alumno: tAlumno;
	asignado: boolean;
BEGIN
	asignado := FALSE;
	edad := matricularAlumno(alumno, matricula+1);
	IF (edad >= EDADMINIMA) AND (edad <= EDADMAXIMA) THEN BEGIN
		IF (colegio.aulas[edad-2].numeroAlumnos < colegio.aulas[edad-2].capacidadMaxima) THEN BEGIN
			colegio.aulas[edad-2].numeroAlumnos := colegio.aulas[edad-2].numeroAlumnos + 1;
			colegio.aulas[edad-2].alumnos[colegio.aulas[edad-2].numeroAlumnos] := alumno;
			matricula := matricula + 1;
			asignado := TRUE;
			IF colegio.aulas[edad-2].numeroAlumnos <= 1 THEN
				colegio.aulasAbiertas := colegio.aulasAbiertas + 1;
		END
		ELSE
		BEGIN
			writeln;
			writeln('No se ha podido matricular al alumno porque el aula esta llena');
		END;

	END;
	asignarAula := asignado;
END; {asignarAula}

PROCEDURE buscaAlumno(VAR colegio: tColegio; matricula: integer; VAR numeroAula, posicionAlumno: integer);
VAR
    encontrado: boolean;
    aulas, numAulas, alumnos, numAlumnos: integer;
BEGIN
    encontrado := FALSE;
    aulas:= colegio.aulasAbiertas;
    numAulas := 1;
    alumnos:= colegio.aulas[numAulas].numeroAlumnos;
    numAlumnos:= 0;
	WHILE (NOT encontrado) AND (numAulas <= aulas) DO
	BEGIN
		WHILE (NOT encontrado) AND (numAlumnos <= colegio.aulas[numAulas].numeroAlumnos) DO
		BEGIN
			IF (colegio.aulas[numAulas].alumnos[numAlumnos].numMatricula = matricula) THEN
			BEGIN
				encontrado := TRUE;
				numeroAula:= numAulas;
				posicionAlumno:= numAlumnos;
			END {IF}
			ELSE
				numAlumnos:= numAlumnos + 1;
		END; {WHILE}
		numAlumnos:= 1;
		numAulas:= numAulas + 1;
	END; {WHILE}
END; {buscaAlumno}

PROCEDURE mostrarColegio(colegio : tColegio);
VAR
	j, i : integer;
	cabecera: boolean;
BEGIN
		cabecera:= FALSE;
		FOR j := 1 TO EDADMAXIMA - 2 DO
		BEGIN
			IF colegio.aulas[j].numeroAlumnos <> 0 THEN
			BEGIN
				FOR i := 1 TO colegio.aulas[j].numeroAlumnos DO
				BEGIN
					IF NOT cabecera THEN BEGIN
						writeln('Los alumnos que hay en el colegio son:');
						writeln;
						writeln('NOMBRE	      APELLIDOS               NUM MATRICULA          TELEFONO           ANNO NACIMIENTO');
						cabecera:= TRUE;
					END;
					writeln(colegio.aulas[j].alumnos[i].nombre,'	',colegio.aulas[j].alumnos[i].apellidos:15,'	',colegio.aulas[j].alumnos[i].numMatricula:23,'	',colegio.aulas[j].alumnos[i].telefonoContacto:21,'	',colegio.aulas[j].alumnos[i].annoNacimiento:20);
				END;
			END;
		END; {for}
		IF NOT cabecera  THEN
			writeln('No hay alumnos en el colegio');
END; {mostrarColegio}

PROCEDURE mostrarNombreAlumnos(colegio : tColegio);
VAR
	j, i : integer;
BEGIN
	writeln('Los alumnos que hay en el colegio son:');
	writeln;
	writeln('NOMBRE	   	 APELLIDOS               NUM MATRICULA');
	FOR j := 1 TO EDADMAXIMA - 2 DO
	BEGIN
		IF colegio.aulas[j].numeroAlumnos <> 0 THEN
		BEGIN
			FOR i := 1 TO colegio.aulas[j].numeroAlumnos DO
			BEGIN
				writeln(colegio.aulas[j].alumnos[i].nombre,'	',colegio.aulas[j].alumnos[i].apellidos:15,'	',colegio.aulas[j].alumnos[i].numMatricula:23);
			END;
		END;
	END; {for}
END; {mostrarNombreAlumnos}

PROCEDURE anularMatricula (VAR colegio: tColegio);
VAR
	matricula, posicionAlumno, numeroAula, i: integer;
	borrar: char;
BEGIN
	posicionAlumno:=0;
	numeroAula:=0;
	mostrarNombreAlumnos(colegio);
	REPEAT
		writeln;
		writeln('Introduzca la matricula del alumno que desea anular');
		readln(matricula);
		IF matricula <= 0 THEN
			writeln('La matricula introducida es erronea');
	UNTIL matricula > 0;
	buscaAlumno(colegio, matricula, numeroAula, posicionAlumno);
	IF posicionAlumno <> 0 THEN
	BEGIN
		WITH colegio.aulas[numeroAula] DO
		BEGIN
			writeln;
			writeln('El alumno que sera borrado es:');
			writeln(alumnos[posicionAlumno].nombre);
			REPEAT
				writeln('Desea borrar este alumno? (s/n)');
				readln(borrar);
					IF (borrar <> 's') AND (borrar <> 'n') THEN
						writeln('Debe introducir una s si quiere o una n si no quiere eliminarlo');
			UNTIL (borrar = 's') OR (borrar = 'n');
			IF borrar = 's' THEN
			BEGIN
				FOR i:= posicionAlumno TO numeroAlumnos DO
				BEGIN
					alumnos[i].nombre:= alumnos[i + 1].nombre;
					alumnos[i].apellidos:= alumnos[i + 1].apellidos;
					alumnos[i].numMatricula:= alumnos[i + 1].numMatricula;
					alumnos[i].telefonoContacto:= alumnos [i + 1].telefonoContacto;
					alumnos[i].annoNacimiento:= alumnos[i + 1].annoNacimiento;
				END; {FOR}
				numeroAlumnos:= numeroAlumnos - 1;
				writeln;
				writeln('El alumno ha sido borrado con exito');

			END {IF}
			ELSE
				writeln('El alumno no ha sido borrado');
		END; {WITH}
	END {IF}
	ELSE
		writeln('No existe ningun alumno con esa matricula');
END; {anularMatricula}

PROCEDURE mostrarAula(edad: integer; colegio: tColegio);
VAR
	top, i, j: integer;
BEGIN
	j := edad-2;
	top := colegio.aulas[j].numeroAlumnos;
	IF top <> 0 THEN
	BEGIN
		writeln;
		writeln('NOMBRE	      APELLIDOS			  NUM MATRICULA	    TELEFONO		ANNO NACIMIENTO');
		FOR i := 1 TO top DO
		BEGIN
			writeln(colegio.aulas[j].alumnos[i].nombre,'	',colegio.aulas[j].alumnos[i].apellidos:15,'	',colegio.aulas[j].alumnos[i].numMatricula:23,'	',colegio.aulas[j].alumnos[i].telefonoContacto:21,'	',colegio.aulas[j].alumnos[i].annoNacimiento:20);
		END;
	END
	ELSE
	BEGIN
		writeln('Todavia no se han introducido alumnos en esta clase');
	END; {ELSE}
END; {mostrarAula}

FUNCTION buscarAlumno(colegio : tColegio; numMat, matricula : integer) : integer;
VAR
	posicion, top, i, j, contador : integer;
BEGIN
	top := matricula;
	posicion := 0;
	contador := 1;
	IF top <> 0 THEN
	BEGIN
		WHILE (posicion = 0) AND (contador <= top) DO
				BEGIN
					FOR j := EDADMINIMA - 2 TO EDADMAXIMA - 2 DO
					BEGIN
						IF colegio.aulas[j].alumnos[contador].numMatricula = numMat THEN
						BEGIN
							posicion := contador;
							writeln('NOMBRE		APELLIDOS		NUM MATRICULA		TELEFONO		ANNO NACIMIENTO');
							writeln('', colegio.aulas[j].alumnos[contador].nombre,' ',colegio.aulas[j].alumnos[contador].apellidos:15,'	',colegio.aulas[j].alumnos[contador].numMatricula:23,' ',colegio.aulas[j].alumnos[contador].telefonoContacto:21,' ',colegio.aulas[j].alumnos[contador].annoNacimiento:20);
							writeln;
							writeln('********************  Datos del aula ******************** ');
							writeln;
							IF (colegio.aulas[j].tutor.nombre = '') THEN
								writeln('Este aula no tiene asignado un tutor')
							ELSE
								writeln('El tutor es ' , colegio.aulas[j].tutor.nombre);
							writeln('Los aulumnos de este aula tienen ' , colegio.aulas[j].edad , ' annos');
							writeln('El numero de alumnos en este aula es ' , colegio.aulas[j].numeroAlumnos);
							writeln('La capacidad maxima de alumnos es de ' , MAXALUMNOS);
						END;
					END;
					contador := contador + 1;
			END;
	END;
	BuscarAlumno := posicion;
END; {buscarAlumno}

PROCEDURE guardarInformacionColegio (VAR ficheroColegioOut: tArchivoColegio; VAR colegio: tColegio);
VAR
	opcion: char;
BEGIN
	colegio.nombreColegio := 'COLEGIO ADA LOVELACE';
	REPEAT
		writeln('Desea grabar los datos del colegio? (s/n)');
		readln(opcion);
		IF (opcion <> 's') AND (opcion <> 'S') AND (opcion <> 'n') AND (opcion <> 'N') THEN
			writeln('Debe introducir una s si quiere o una n si no quiere grabarlo');
	UNTIL (opcion = 's') OR (opcion <> 'S') OR (opcion = 'n') OR (opcion <> 'N');
	IF (opcion = 's') OR (opcion <> 'S') THEN
	BEGIN
		rewrite(ficheroColegioOut);
		write(ficheroColegio, colegio);
		writeln;
	  	writeln('Los datos se han guardado en el fichero binario con exito');
	  	writeln;
	   	close(ficheroColegio);
	END {IF}
	ELSE
		writeln('Los datos no se han pasado al fichero');
END; {guardarInformacionColegio}

FUNCTION buscarNumMatricula (VAR colegio : tColegio): integer;
VAR
	i, j, mayorValor : integer;
BEGIN
	mayorValor:= 1;
	FOR i := 1 TO colegio.aulasAbiertas DO
	BEGIN
		FOR j := 1 TO colegio.aulas[i].numeroAlumnos DO
		BEGIN
			IF colegio.aulas[i].alumnos[j].numMatricula > mayorValor THEN
			BEGIN
				mayorValor := colegio.aulas[i].alumnos[j].numMatricula;
			END; {IF}
		END;
	END;
	buscarNumMatricula := mayorValor;
END;

PROCEDURE leerInformacionColegio (VAR ficheroColegioIn: tArchivoColegio; VAR colegio: tColegio; VAR matricula: integer);
VAR
	existe: boolean;
	opcion: char;
	matriculados: integer;
BEGIN
	REPEAT
		writeln('Desea cargar los datos del colegio? (s/n)');
		readln(opcion);
		IF (opcion <> 's') AND (opcion <> 'S') AND (opcion <> 'n') AND (opcion <> 'N') THEN
			writeln('Debe introducir una s si quiere o una n si no quiere cargarlo');
	UNTIL (opcion = 's') OR (opcion = 'S') OR (opcion = 'n') OR (opcion = 'N');
	IF (opcion = 's') OR (opcion = 'S') THEN
	BEGIN
		{$I-} {se desactiva para controlar la apertura para lectura}
		reset(ficheroColegioIn);
		{$I+}  {se activa para que detecte otros posibles errores que nosotros no vamos a controlar}
		existe := (IOResult= 0);
	  	IF existe THEN
		BEGIN
			WHILE NOT EOF(ficheroColegioIn)  DO BEGIN
				read(ficheroColegio,colegio);
			END; {WHILE}
			writeln;
			writeln('El fichero se ha cargado con exito');
			close(ficheroColegioIn);
			matricula:= buscarNumMatricula(colegio);
		END {IF}
		ELSE
			writeln('No existe el fichero Colegio');
	END
	ELSE
	BEGIN
		writeln;
		writeln('Los datos no se han cargado');
	END;
	writeln;
END; {leerInformacionColegio}

BEGIN {programa principal}
	assign(ficheroTutores, {'C:\EclipseComplete-win64\EclipseComplete\PracGrupal4\tutores.dat'} {'C:\Users\ramir\tutores.dat');} 'R:\tutores.dat');
	assign(archivoGuardarTutoresTexto,{'C:\EclipseComplete-win64\EclipseComplete\PracGrupal4\tutoresTexto.txt'} {'C:\Users\ramir\tutores.dat');} 'R:\tutoresTexto.txt');
	assign(ficheroColegio, {'C:\Users\ramir\colegio.dat');} 'R:\colegio.dat');

	numMatriculas := 0;
	tutores.tope := 0;
	colegio.aulasAbiertas := 0;

FOR i := 1 TO MAXAULAS DO BEGIN
	colegio.aulas[i].edad := i+2;
	colegio.aulas[i].capacidadMaxima := MAXALUMNOS;
	colegio.aulas[i].numeroAlumnos := 0;
END;

writeln('****************************************');
writeln('   Autores: Veronica, Silvia y Loreto');
writeln('****************************************');
writeln;
cargarTutoresPrograma;
leerInformacionColegio(ficheroColegio, colegio, numMatriculas);
	REPEAT
		menu1;
		readln(opcionMenu1);
		CASE opcionMenu1 OF
			'1':BEGIN
					writeln('Ha seleccionado la opcion 1');
					writeln;
					writeln('********** TUTORES **********');
					writeln;
					REPEAT
						menu2;
						readln(opcionMenu2);
						CASE opcionMenu2 OF
							'a','A':BEGIN
										writeln('Ha seleccionado la opcion A');
										writeln;
										writeln('********** Alta tutor **********');
										writeln;
										pedirDatosTutor(tutor);
										IF (insertarTutor(tutor, tutores) = TRUE) THEN
										BEGIN
											writeln;
											writeln('Tutor insertado con exito')
										END;
							END; {BEGIN A}
							'b','B':BEGIN
										writeln('Ha seleccionado la opcion B');
										writeln;
										writeln('******* Baja tutor *******');
										writeln;
										mostrarTutores(tutores);
										writeln();
										writeln('Escribe el nombre del tutor que quieres eliminar');
										readln(nombre);
										IF (bajaTutor(nombre, tutores, colegio) = TRUE) THEN
										BEGIN
											writeln;
											writeln ('El tutor ha sido eliminado con exito')
										END
										ELSE
										BEGIN
											writeln;
											writeln('No ha sido posible eliminar al tutor');
										END;
							END; {BEGIN B}
							'c','C':BEGIN
										writeln('Ha seleccionado la opcion C');
										writeln;
										writeln('********** Asignar tutor a un aula **********');
										writeln;
										mostrarTutores(tutores);
										asignarTutor(aula, colegio, tutores);
							END; {BEGIN C}
							'd','D':BEGIN
										writeln('Ha seleccionado la opcion D');
										writeln;
										writeln('****** Desasignar tutor a un aula ******');
										writeln;
										mostrarTutores(tutores);
										desasignarTutor (colegio, tutores);
							END; {BEGIN D}
							'e','E':BEGIN
										writeln('Ha seleccionado la opcion E');
										writeln;
										writeln('****** Guardar tutores ******');
										writeln;
										guardarTutoresBin(ficheroTutores, tutores);
							END; {BEGIN E}
							'f','F':BEGIN
										writeln('Ha seleccionado la opcion F');
										writeln;
										writeln('********** Cargar tutores **********');
										writeln;
										cargarTutoresPrograma;
							END; {BEGIN F}
							'g','G': BEGIN
										writeln('Ha seleccionado la opcion G');
										writeln;
										writeln('********** Guardar nombres de tutores **********');
										writeln;
										guardarTutoresTxt(archivoGuardarTutoresTexto, tutores);
							END; {BEGIN F}
							'h','H': writeln('Volver al menu principal')
							ELSE
							BEGIN
								writeln;
								writeln('Opcion incorrecta');
							END; {ELSE}
						END; {CASE}
					UNTIL (opcionMenu2 = 'h') OR (opcionMenu2 = 'H');

			END; {BEGIN A}
			'2':BEGIN
					writeln('Ha seleccionado la opcion 2');
					writeln();
					writeln('********** ALUMNOS *********');
					writeln;
					REPEAT
						menu3;
						readln(opcionMenu3);
						CASE opcionMenu3 OF
							'a','A':BEGIN
										writeln('Ha seleccionado la opcion A');
										writeln;
										writeln('******* Matricular a un alumno ******');
										writeln;
										IF (asignarAula(colegio, numMatriculas) = TRUE) THEN
										BEGIN
											writeln;
											writeln ('El alumno ha sido asignado a un aula con exito')
										END
										ELSE
											writeln('No se ha podido asignar el alumno a un aula');
									END; {BEGIN A}
							'b','B':BEGIN
										writeln('Ha seleccionado la opcion B');
										writeln;
										writeln('********** Anular matricula de un alumno **********');
										writeln;
										anularMatricula(colegio);
							END; {BEGIN B}
							'c','C':BEGIN
										writeln('Ha seleccionado la opcion C');
										writeln;
										writeln('********** Mostrar alumnos de un aula **********');
										writeln;
										REPEAT
											writeln('Introduce la edad del aula que quiere ver');
											readln(edad);
										UNTIL (edad >= EDADMINIMA) AND (edad <= EDADMAXIMA);
										mostrarAula(edad, colegio);

							END; {BEGIN C}
							'd','D':BEGIN
										writeln('Ha seleccionado la opcion D');
										writeln;
										writeln('****** Mostrar todos los alumnos del colegio ******');
										writeln;
										writeln(colegio.nombreColegio);
										mostrarColegio(colegio);
							END; {BEGIN D}
							'e','E':BEGIN
										writeln('Ha seleccionado la opcion E');
										writeln;
										writeln('****** Buscar alumno ******');
										writeln;
										mostrarNombreAlumnos (colegio);
										REPEAT
											writeln;
											writeln('Introduce el numero de matricula del alumno que desea buscar');
											readln(num);
										UNTIL (num >= 1);
										encontrado := buscarAlumno(colegio, num, numMatriculas);
										IF encontrado = 0 THEN
											writeln('El alumno buscado no existe');
							END; {BEGIN E}
							'f','F':BEGIN
										writeln('Ha seleccionado la opcion F');
										writeln;
										writeln('********** Guardar informacion del colegio **********');
										writeln;
										guardarInformacionColegio(ficheroColegio, colegio);
							END; {BEGIN F}
							'g','G': BEGIN
										writeln('Ha seleccionado la opcion G');
										writeln;
										writeln('********** Cargar informacion del colegio **********');
										leerInformacionColegio(ficheroColegio, colegio, numMatriculas);
							END; {BEGIN F}
							'h','H': writeln('Volver al menu principal')
							ELSE
							BEGIN
								writeln;
								writeln('Opcion incorrecta');
							END; {ELSE}
						END; {CASE}
					UNTIL (opcionMenu3 = 'h') OR (opcionMenu3 = 'H');
			END; {BEGIN B}
			'3':
				BEGIN
					guardarTutoresBin(ficheroTutores,tutores);
					guardarInformacionColegio(ficheroColegio, colegio);
					writeln('Presione cualquier tecla para salir del programa');
				END;
			ELSE
			BEGIN
				writeln;
				writeln('Opcion incorrecta');
			END; {ELSE}
		END; {CASE}
	UNTIL (opcionMenu1 = '3');
readln;
END. {programa principal}
