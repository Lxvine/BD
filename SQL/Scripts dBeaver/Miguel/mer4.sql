drop database if exists mer4;

create database mer4;

use mer4;

create or replace table CLIENTES(
	CODIGO INT (15),
	NOMBRE VARCHAR (20) not null,
	TELEFONO CHAR (9) not null,
	DIRECCION VARCHAR (40) not null,
	DNI CHAR(9) not null,
	AVAL INT (15),
	primary key(CODIGO),
	foreign key (AVAL)
		references CLIENTES (CODIGO)
			on delete restrict
			on update cascade
);

create or replace table AGENCIAS(
	CODIGO int (10),
	DIRECCION varchar (30) not null,   
	LOCALIDAD varchar (10) not null,
	primary key(CODIGO)
);

create or replace table GARAJES(
	CODIGO int (10),
	NOM_PLAZAS varchar (20) not null,
	DIRECCION varchar (30) not null,
	primary key(CODIGO)
);

create or replace table RESERVAS(
	F_INICIO DATE,
	F_FIN DATE,
	CODIGO_CLIENTE int (15) not null,
	CODIGO_AGENCIA int (10) not null,
	PRECIO_TOTAL int (3) not null,
	primary key (F_INICIO, CODIGO_CLIENTE),
	foreign key (CODIGO_CLIENTE)
		references CLIENTES (CODIGO)
			on delete cascade
			on update cascade	
);

create or replace table COCHES(
	MATRICULA varchar (10),
	COLOR varchar (12) not null,
	PRECIO int (4) not null,
	MODELO varchar (15) not null,
	MARCA varchar (10) not null,
	CODIGO_GARAJE int (10) not null,
	INDICADOR bool,
	primary key (MATRICULA),
	foreign key (CODIGO_GARAJE)
		references GARAJES (CODIGO)
			on delete restrict
			on update cascade
);

create or replace table COCHES_RESERVAS(
	CODIGO_CLIENTE int (15),
	F_INICIO_RESERVAS date,
	MATRICULA_COCHES varchar (10),
	LITROS int (3) not null,
	primary key(CODIGO_CLIENTE, F_INICIO_RESERVAS, MATRICULA_COCHES),
	foreign key (CODIGO_CLIENTE, F_INICIO_RESERVAS)
		references RESERVAS (CODIGO_CLIENTE, F_INICIO)
			on delete cascade
			on update cascade,
	foreign key (MATRICULA_COCHES)
		references COCHES (MATRICULA)
			on delete cascade
			on update cascade
);