-- crear la base de datos
CREATE database sistema_ventas_4E; 
-- seleccionar la base de datos para tabajar 
Use sistema_ventas_4E;
-- creamos la tabla tipo_usuario
CREATE TABLE tipo_usuarios (
id INT auto_increment PRIMARY KEY,
-- identificador unico 
nombre_tipo VARCHAR(50)NOT NULL,
-- tipo de usuario (admin, Cliente)
-- campos de auditoria
created_at datetime default CURRENT_TIMESTAMP,
-- fecha creacion
updated_at datetime default CURRENT_TIMESTAMP
ON update CURRENT_TIMESTAMP, -- Fecha modificacion 
	created_by int, -- Usuario que crea 
	UPDATED_BY int, -- Usuario que modifica
	deleted Boolean default false -- borrado logico 
);
CREATE TABLE usuarios (
id_tipo_usuario INT AUTO_INCREMENT PRIMARY KEY, -- Id único
nombre_tipo VARCHAR(100) NOT NULL, -- Nombre de usuario
correo VARCHAR(100) UNIQUE, -- Correo electrónico único
tipo_usuario_id INT, -- Relación a tipo_usuario
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
-- Fecha creación
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, -- Fecha modificación
created_by INT, -- Usuario que crea
updated_by INT, -- Usuario que modifica
deleted BOOLEAN DEFAULT FALSE -- Borrado lógico
);
alter table usuarios -- modificar tabla
-- agregar una relacion (FK) 
add constraint fk_usuario_tipo_usuario
-- añade referenceia 
foreign key (tipo_usuario_id) references
tipo_usuarios(id);	
create table productos (
id_producto int auto_increment primary key,
nombre_producto varchar(100) not null,
precio_producto float not null, 
stock int,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE
);

create table ventas(
id_V int auto_increment primary key,
User_id int, -- usuario que realizo la venta 
fecha datetime,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE
);

create table D_Productos(
id_detalle_producto int auto_increment primary key,
venta_id int,
producto_id int,
cantidad int,
precio_unitario float not null,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE
);

