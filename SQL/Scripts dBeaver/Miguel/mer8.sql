drop database if exists mer8;

create database mer8;

use mer8;

create or replace table INVENTOR(
	DNI_INVENTOR int(9),
	NOMBRE_INVENTOR varchar(20) not null,
	DIRECCION_INVENTOR varchar(100) not null,
	TELEFONO_INVENTOR int(9) not null,
	CHECK (TELEFONO_INVENTOR  >= 0),
	primary key (DNI_INVENTOR)
);

create or replace table EMPRESA(
	ID_EMPRESA int(8) auto_increment,
	NOMBRE_EMPRESA varchar(20) not null,
	DIRECCION varchar(100) not null,
	primary key (ID_EMPRESA)
);

create or replace table PATENTES(
	NUMERO_PATENTE int(10) auto_increment,
	NOMBRE_PATENTE varchar(20) not null unique,
	FECHA_PATENTE date not null,
	FECHA_COMPRA date null,
	INVENTOR_PATENTE int(9) not null,
	EMPRESA_CLIENTE int (8) null,
	primary key (NUMERO_PATENTE),
	foreign key (INVENTOR_PATENTE)
		references INVENTOR (DNI_INVENTOR)
			on delete restrict 
			on update cascade,
	foreign key (EMPRESA_CLIENTE)
		references EMPRESA (ID_EMPRESA)
			on delete restrict 
			on update CASCADE
);

create or replace table AYUDANTE(
	DNI_AYUDANTE int(9),
	NOMBRE_AYUDANTE varchar(20) not null,
	DIRECCION_AYUDANTE varchar(100) not null,
	TELEFONO_AYUDANTE int(9) not null,
	INVENTOR_AYUDANTE int(9),
	primary key (DNI_AYUDANTE),
	foreign key (INVENTOR_AYUDANTE)
		references INVENTOR (DNI_INVENTOR)
			on delete restrict 
			on update cascade
);

create or replace table INVENTOR_PATENTE(
	DNI_INVENTOR int (9),
	NUMERO_PATENTE int (10),
	primary key (DNI_INVENTOR, NUMERO_PATENTE),
	foreign key (DNI_INVENTOR)
		references INVENTOR (DNI_INVENTOR)
			on delete restrict 
			on update cascade,
	foreign key (NUMERO_PATENTE)
		references PATENTES (NUMERO_PATENTE)
			on delete restrict 
			on update cascade
);

create or replace table EMPRESA_AYUDANTE(
	DNI_AYUDANTE int (9),
	ID_EMPRESA int (8),
	FECHA_CONTRATACION date not null,
	primary key (DNI_AYUDANTE, ID_EMPRESA),
	foreign key (DNI_AYUDANTE)
		references AYUDANTE (DNI_AYUDANTE)
			on delete restrict
			on update cascade,
	foreign key (ID_EMPRESA)
		references EMPRESA (ID_EMPRESA)
			on delete restrict
			on update cascade
);

create or replace table EMPRESA_INVENTOR(
	DNI_INVENTOR int (9),
	ID_EMPRESA int (8),
	FECHA_CONTRATACION date not null,
	primary key (DNI_INVENTOR, ID_EMPRESA),
	foreign key (DNI_INVENTOR)
		references INVENTOR (DNI_INVENTOR)
			on delete restrict
			on update cascade,
	foreign key (ID_EMPRESA)
		references EMPRESA (ID_EMPRESA)
			on delete restrict
			on update cascade
);

create or replace table TELEFONO_EMPRESA(
	TELEFONO_EMPRESA int(9),
	ID_EMPRESA int(8),
	primary key (TELEFONO_EMPRESA, ID_EMPRESA),
	foreign key (ID_EMPRESA)
		references EMPRESA (ID_EMPRESA)
			on delete restrict 
			on update cascade
);
