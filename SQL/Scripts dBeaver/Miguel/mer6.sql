drop database if exists mer6;

create database mer6;

use mer6;

create or replace table PLANTAS(
	NUMERO_PLANTA int (2),
	SUPERFICIE int (5) not null,
	NUM_HABITACIONES int (4) not null,
	primary key (NUMERO_PLANTA)	
);

create or replace table HABITACIONES(
	ID_HABITACION int auto_increment,
	NUM_PLANTA int (2),
	TIPO_HABITACION varchar(20) not null,
	primary key (ID_HABITACION, NUM_PLANTA),
	foreign key (NUM_PLANTA)
		references PLANTAS (NUMERO_PLANTA)
			on delete restrict
			on update cascade	
);

create or replace table HABITACIONES_NEONATAL(
	ID_HABITACION int auto_increment,
	NUM_PLANTA int (2),
	MON_CARD bool not null,
	MON_RESP bool not null,
	primary key (ID_HABITACION, NUM_PLANTA),
	foreign key (ID_HABITACION, NUM_PLANTA)
		references HABITACIONES (ID_HABITACION, NUM_PLANTA)
);

create or replace table HABITACIONES_MATERNA(
	ID_HABITACION int auto_increment,
	NUM_PLANTA int (2),
	TELEFONO bool not null,
	BAÑO bool not null,
	primary key (ID_HABITACION, NUM_PLANTA),
	foreign key (ID_HABITACION, NUM_PLANTA)
		references HABITACIONES (ID_HABITACION, NUM_PLANTA)
);

create or replace table CAMAS(
	ID_CAMA int auto_increment,
	ID_HABITACION int,
	NUM_PLANTA int (2),
	F_COMPRA date,
	primary key (ID_CAMA),
	foreign key (ID_HABITACION, NUM_PLANTA)
		references HABITACIONES (ID_HABITACION, NUM_PLANTA)
			on delete restrict			
			on update cascade
);

create or replace table PACIENTES(
	NUM_HISTORIAL int auto_increment,
	DNI int(9) unique not null, 
	NUSS int(12) unique not null,
	NOMBRE varchar(25) not null,
	APELLIDOS varchar(50) not null,
	DIRECCION varchar(100) not null,
	F_NACIMIENTO date not null,
	primary key (NUM_HISTORIAL)
);

create or replace table TELEFONOS_PACIENTE(
	TELF1 int(9),
	TELF2 int(9),
	NUM_HISTORIAL int auto_increment,
	primary key (NUM_HISTORIAL, TELF1, TELF2),
	foreign key (NUM_HISTORIAL)
		references PACIENTES (NUM_HISTORIAL)
			on delete cascade
			on update cascade
	);
	
create or replace table PACIENTE_CAMAS(
	ID_CAMA int,
	NUM_HISTORIAL int,
	F_ENTRADA date not null,
	F_SALIDA date not null,
	primary key (ID_CAMA, NUM_HISTORIAL, F_ENTRADA)
);