drop database if exists mer5;

create database mer5;

use mer5;

create or replace table CLIENTES(
	CODIGO_CLIENTE int(8) auto_increment,
	NOMBRE varchar(15) not null,
	APELLIDOS varchar(30) not null,
	DIRECCION varchar(30) not null,
	TELEFONO int(9) not null,
	primary key (CODIGO_CLIENTE)
);

create or replace table HOTELES(
	CODIGO_HOTEL int(8) auto_increment,
	NOMBRE varchar(15) not null,
	DIRECCION varchar(100) not null,
	CIUDAD varchar(20) not null,
	TELEFONO int(9),
	PLAZAS_DISPONIBLES int(4) not null,
	primary key (CODIGO_HOTEL)
);

create or replace table CLIENTES_HOTELES(
	REGIMEN enum ('Sólo alojamiento', 'alojamiento y desayuno', 'media pensión', 'pensión completa', 'todo incluido'),
	F_LLEGADA date not null,
	F_SALIDA date not null,
	HOTEL int(8),
	CLIENTE int(8),
	primary key (REGIMEN, HOTEL, CLIENTE),
	foreign key (HOTEL) 
		references HOTELES (CODIGO_HOTEL)
			on delete cascade
			on update cascade,	
	foreign key (CLIENTE) 
		references CLIENTES (CODIGO_CLIENTE)
			on delete cascade
			on update cascade	
);

create or replace table VUELOS(
	NUMERO_VUELO int(9), 
	ORIGEN varchar(20) not null,
	DESTINO varchar (20) not null,
	FECHA date not null,
	HORA time not null,	
	PLAZAS_TOTALES int(8) not null,
	PLAZAS_TURISTAS int(8) not null,
	primary key (NUMERO_VUELO)
);

create or replace table CLIENTES_VUELOS(
	CLASE varchar(10) not null,
	CODIGO_CLIENTE int(8),
	NUMERO_VUELO int(9),
	primary key (CODIGO_CLIENTE, NUMERO_VUELO),
	foreign key (CODIGO_CLIENTE)
		references CLIENTES (CODIGO_CLIENTE)
			on delete cascade
			on update cascade,
	foreign key (NUMERO_VUELO)
		references VUELOS (NUMERO_VUELO)
			on delete cascade
			on update cascade
);

create or replace table AGENCIAS(
	CODIGO int auto_increment,
	DIRECCION varchar(100) not null,
	TELEFONO varchar(9),
	primary key (CODIGO)
);

create or replace table AGENCIAS_CLIENTES(
	CODIGO_AGENCIA int, 
	CODIGO_CLIENTE int(8),
	primary key (CODIGO_AGENCIA, CODIGO_CLIENTE),
	foreign key (CODIGO_AGENCIA)
		references AGENCIAS (CODIGO)
			on delete cascade
			on update cascade,
	foreign key (CODIGO_CLIENTE)
		references CLIENTES (CODIGO_CLIENTE)
			on delete cascade
			on update cascade
);
