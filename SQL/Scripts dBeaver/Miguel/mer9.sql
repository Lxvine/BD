drop database if exists mer9;

create database mer9;

use mer9;

create or replace table CLIENTES (
	DNI_CLIENTE int (9),
	TELF_CLIENTE int (9) not null unique,
	NOMBRE_CLIENTE varchar (20) not null,
	DIRECCION_CLIENTE varchar (20) not null,
	primary key (DNI_CLIENTE)
);

create or replace table AGENTES(
	DNI_AGENTE int (9),
	TELF_AGENTE int (9) not null unique,
	NOMBRE_AGENTE varchar (20) not null,
	DIRECCION_AGENTE varchar (100) not null,
	primary key (DNI_AGENTE)
);

create or replace table SEGUROS(
	ID_SEGURO int auto_increment,
	PRIMA int (3) not null,
	TIPO_SEGURO enum ('hogar', 'vida', 'automovil') not null,
	CLIENTE int (9) not null,
	AGENTE int (9) not null, 
	primary key (ID_SEGURO),
	foreign key CLIENTE
		references CLIENTES (DNI_CLIENTE)
			on delete restrict
			on update cascade,
	foreign key (AGENTE)
		references AGENTES (DNI_AGENTE)
			on delete restrict
			on update cascade 
);