drop database if exists mer2;

create database mer2;

use mer2;

create or replace table BECARIO(
	DNI CHAR (9) primary key,
	NUSS INT (13) unique not null,
	F_NACIMIENTO VARCHAR (10) not null,
	NOMBRE VARCHAR (20) not null,
	APELLIDOS VARCHAR (40) not null, 
	DNI_BECARIO_SUPLENTE CHAR (9) not null,
	foreign key (DNI_BECARIO_SUPLENTE)
		references BECARIO(DNI)
			on delete restrict
			on update cascade	
);

create or replace table LABORATORIO(
	CODIGO INT (12) primary key,
	N_PLANTA INT (3) not null,
	DNI_SUPERVISOR CHAR (9) not null,
	foreign key (DNI_SUPERVISOR)
		references BECARIO (DNI)
			on delete restrict
			on update cascade
);

create or replace table ORDENADOR (
	IP VARCHAR (15) primary key,
	FECHA_COMPRA DATE not null,
	CODIGO_LABORATORIO INT (12) not null,
	foreign key (CODIGO_LABORATORIO)
		references LABORATORIO (CODIGO)
			on delete restrict
			on update cascade
);

create or replace table FABRICANTE (
	CODIGO INT (12) primary key,
	WEB VARCHAR (50) unique,
	NOMBRE VARCHAR (30) not null,
	TELF1 INT (9) not null,
	TELF2 INT (9) null
);

create or replace table COMPONENTE (
	CODIGO INT (12) primary key,
	DESCRIPCION VARCHAR (100) not null,
	CODIGO_FABRICANTE INT (12) not null,
	foreign key (CODIGO_FABRICANTE)
		references FABRICANTE (CODIGO)
			on delete restrict
			on update cascade
);

create or replace table ORDENADOR_COMPONENTE (
	IP_ORDENADOR VARCHAR (15),
	CODIGO_COMPONENTE INT (12),
	primary key (IP_ORDENADOR, CODIGO_COMPONENTE),
	foreign key (IP_ORDENADOR)
		references ORDENADOR (IP)
			on delete cascade
			on update cascade,
	foreign key (CODIGO_COMPONENTE)
		references COMPONENTE (CODIGO)
			on delete restrict
			on update cascade
);