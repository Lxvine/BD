drop database if exists mer3;

create database mer3;

use mer3;

create or replace table DEPARTAMENTOS( 
	CODIGO INT (15),
	NOMBRE VARCHAR (20) unique not null,
	NRP_PROFESOR CHAR(15),
	primary key (CODIGO)
);

create or replace table PROFESORES(
	NRP CHAR(15),
	NOMBRE VARCHAR(20) not null,
	AREA_CONOCIMIENTO VARCHAR(20) not null,
	CATEGORIA VARCHAR(15) not null,
	CODIGO_DEPARTAMENTO INT not null default 0,
	primary key (NRP),
	foreign key(CODIGO_DEPARTAMENTO)
		references DEPARTAMENTOS (CODIGO)
			on delete restrict
			on update cascade
);

alter table DEPARTAMENTOS
add foreign key(NRP_PROFESOR)
		references PROFESORES (NRP)
			on delete cascade
			on update cascade;

create or replace table ASIGNATURAS(
	CODIGO INT (15),
	NOMBRE VARCHAR(20),
 	CREDITOS INT (3) not null,
	CARACTER ENUM ('troncal', 'obligatoria', 'optativa') not null,
	CURSO CHAR (2) not null,
	primary key(CODIGO, NOMBRE)
);

create or replace table GRUPOS( 
	NUMERO INT(10),
	CODIGO_ASIGNATURA INT(15), 
	MAX_ALUMNO INT(3) not null,
	TIPO VARCHAR(15) not null,
	primary key(NUMERO, CODIGO_ASIGNATURA),
	foreign key (CODIGO_ASIGNATURA)
		references ASIGNATURAS (CODIGO)
			on delete restrict
			on update cascade
);

create or replace table ALUMNOS(
	DNI CHAR(9),
	DIRECCION VARCHAR (30) not null, 
	F_NACIMIENTO DATE not null,
	BECA BOOL not null,
	NOMBRE VARCHAR(20) not null,
	primary key(DNI)
);


create or replace table MATRICULA(
	CONVOCATORIA VARCHAR(15),
	DNI CHAR(9),
	CODIGO INT(15),
	NOTA INT(2) not null,
	primary key(CONVOCATORIA, DNI, CODIGO),
	foreign key(DNI)
		references ALUMNOS (DNI)
			on delete cascade
			on update cascade,
	foreign key(CODIGO)
		references ASIGNATURAS (CODIGO)
			on delete restrict
			on update cascade
);

create or replace table PROFESORES_GRUPOS(
	NRP_PROFESOR CHAR(15),
	NUMERO_GRUPO INT(10),
	CODIGO_GRUPO INT(15),
	primary key(NRP_PROFESOR, NUMERO_GRUPO, CODIGO_GRUPO),
	foreign key(NRP_PROFESOR)
		references PROFESORES (NRP)
			on delete restrict
			on update cascade,
	foreign key(NUMERO_GRUPO, CODIGO_GRUPO)
		references GRUPOS (NUMERO, CODIGO_ASIGNATURA)
			on delete restrict
			on update cascade
);

create or replace table ALUMNOS_GRUPOS(
	DNI_ALUMNO CHAR(9),
	NUMERO_GRUPO INT(10),
	CODIGO_GRUPO INT(15),
	primary key(DNI_ALUMNO, NUMERO_GRUPO, CODIGO_GRUPO),
	foreign key(DNI_ALUMNO)
		references ALUMNOS (DNI)
			on delete restrict
			on update cascade,
	foreign key(NUMERO_GRUPO)
		references GRUPOS (NUMERO)
			on delete restrict
			on update cascade,
	foreign key(CODIGO_GRUPO)
		references GRUPOS (CODIGO_ASIGNATURA)
			on delete restrict
			on update cascade
);

create or replace table ALUMNOS_ASIGNATURAS(
	DNI_ALUMNO CHAR(9),
	CODIGO_ASIGNATURA INT(15),
	primary key (DNI_ALUMNO, CODIGO_ASIGNATURA),
	foreign key(DNI_ALUMNO)
		references ALUMNOS (DNI)
			on delete restrict 
			on update cascade,
	foreign key(CODIGO_ASIGNATURA)
		references ASIGNATURAS (CODIGO)
			on delete restrict
			on update cascade
);