create database clinica_veterinaria;
use clinica_veterinaria;
 

create table dueños(
id_dueño int primary key auto_increment,
username varchar(100),
nombre_dueño varchar(50) not null 
CHECK (CHAR_LENGTH(nombre_dueño) >= 3 AND nombre_dueño REGEXP '^[A-Za-z ]+$'),
rut varchar(14) not null unique,
direccion varchar(100) not null,
telefono int not null,
-- campos de auditoria
created_at datetime default current_timestamp,
updated_at datetime default current_timestamp 
on update current_timestamp,
created_by int,
updated_by int,
deleted boolean default false
);

create table mascotas(
id_mascota int primary key auto_increment,
nombre_mascota varchar(100) not null
CHECK (CHAR_LENGTH(nombre_mascota) >= 3 AND nombre_mascota REGEXP '^[A-Za-z ]+$'),
comportamiento varchar(300) not null,
fecha_nacimiento date not null,
genero varchar(50) not null,
id_dueño int,
foreign key (id_dueño) references dueños(id_dueño),
-- campos de auditoria
created_at datetime default current_timestamp,
updated_at datetime default current_timestamp 
on update current_timestamp,
created_by int,
updated_by int,
deleted boolean default false
);

create table tipo_mascotas(
id_tipo_mascota int primary key auto_increment,
especie varchar(100) not null,
descripcion_especie varchar(300) not null,
id_raza int,
foreign key (id_raza) references razas(id_raza),
-- campos de auditoria
created_at datetime default current_timestamp,
updated_at datetime default current_timestamp 
on update current_timestamp,
created_by int,
updated_by int,
deleted boolean default false
);

create table razas (
id_raza int primary key auto_increment,
raza varchar(100) not null,
-- campos de auditoria
created_at datetime default current_timestamp,
updated_at datetime default current_timestamp
on update current_timestamp,
created_by int,
updated_by int,
deleted boolean default false
);

CREATE TABLE usuarios (
id_usuario INT AUTO_INCREMENT PRIMARY KEY, 
nombre_usuario VARCHAR(100) NOT NULL, 
password varchar(13) not null,
correo VARCHAR(100) UNIQUE,
id_tipo_usuario INT,
foreign key(id_tipo_usuario) references tipo_usuarios(id_tipo_usuario),
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE 
);

CREATE TABLE tipo_usuarios (
id_tipo_usuario INT AUTO_INCREMENT PRIMARY KEY, 
nombre_tipo VARCHAR(100) NOT NULL 
check (nombre_tipo in ('veterinario', 'dueño', ' recepcionista')), 
descripcion_tipo varchar(300) not null,
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE 
);

create table consultas(
id_consulta int primary key auto_increment,
fecha_consulta date not null,
motivo varchar(100) not null,
id_diagnostico int,
foreign key (id_diagnostico) references diagnosticos(id_diagnostico),
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE
);

create table diagnosticos(
id_diagnostico int primary key auto_increment,
descripcion_diagnostico varchar(100) not null,
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE 
);


create table recetas(
id_receta int primary key auto_increment,
fecha_emision datetime not null,
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE 
);


create table evaluaciones_medicas(
id_evaluacion_medica int primary key auto_increment,
id_receta int not null,
id_diagnostico int not null, 
fecha_evaluacion datetime default current_timestamp,
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE 
);

alter table evaluaciones_medicas
add constraint fk_diagnosticos_evaluaciones_medicas
foreign key (id_diagnostico) references	diagnosticos(id_diagnostico);

alter table evaluaciones_medicas
add constraint fk_recetas_evaluaciones_medicas
foreign key (id_receta) references	recetas(id_receta); 


create table medicamentos(
id_medicamento int primary key auto_increment,
nombre_medicamento varchar(100) not null 
CHECK (CHAR_LENGTH(nombre_medicamento) >= 3 AND nombre_medicamento REGEXP '^[A-Za-z ]+$'),
principio_activo varchar(100) not null,
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE
);

alter table prescripciones
add constraint fk_recetas_prescripciones
foreign key (id_receta) references	recetas(id_receta);

alter table prescripciones
add constraint fk_medicamentos_prescripciones
foreign key (id_medicamento) references	medicamentos(id_medicamento);

create table prescripciones(
id_prescripcion int primary key auto_increment,
id_receta int not null,
id_medicamento int not null, 
dosis int not null,
frecuencia int not null,
duracion int not null,
fecha_analisis datetime default current_timestamp,
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE 
);
