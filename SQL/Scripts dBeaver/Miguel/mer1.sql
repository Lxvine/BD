drop database if exists mer1;

create database mer1;

use mer1;

create or replace table APLICACIONES(
	NOMBRE VARCHAR(40) primary key,
	DESCRIPCION TEXT not NULL
);

create or replace table PROGRAMADORES(
	DNI char(10) primary key,
	NUSS char(12) not null unique,
	NOMBRE varchar(50) not null,
	EMAIL varchar(100) not null unique
);

create or replace table VERSIONES(
	ID_VERSION varchar(10),
	NOMBRE_APP varchar(40),
	primary key (NOMBRE_APP, ID_VERSION),
	foreign key (NOMBRE_APP)
		references APLICACIONES (NOMBRE)
			on delete cascade
			on update cascade
);

create or replace table INCIDENCIAS(
	CODIGO int primary key auto_increment,
	F_INICIO DATE not null,
	F_FINAL DATE not null, 
	DNI_PROGRAMADOR char(10) not null, 
	NOMBRE_APP varchar(40) not null, 
	foreign key (DNI_PROGRAMADOR) 
		references PROGRAMADORES (DNI)
			on delete cascade
			on update cascade,
	foreign key (NOMBRE_APP) 
		references APLICACIONES (NOMBRE)
			on delete cascade
			on update cascade
);

create or replace table PROGRAMADOR_INCIDENCIA(
	CODIGO_INCIDENCIA int,
	DNI_PROGRAMADOR CHAR(10),
	TIEMPO TIME not null,
	primary key (CODIGO_INCIDENCIA, DNI_PROGRAMADOR),
	foreign key (DNI_PROGRAMADOR) 
		references PROGRAMADORES (DNI)
			on delete cascade
			on update cascade,
	foreign key (CODIGO_INCIDENCIA) 
		references INCIDENCIAS (CODIGO)
			on delete cascade
			on update cascade	
);