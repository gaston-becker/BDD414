
CREATE DATABASE IF NOT EXISTS empresa;

USE empresa;

CREATE DATABASE IF NOT EXISTS empresa;

USE empresa;

//---------- CREAR TABLAS  ---------------------
CREATE TABLE IF NOT EXISTS personas (
    id_personas int NOT NULL auto_increment,
    dni int NOT NULL,
    apyn varchar(20),
    email varchar(20),
    telefono int,
    PRIMARY KEY (id_personas)
);

CREATE TABLE IF NOT EXISTS clientes (
    id_cliente int  NOT NULL auto_increment,
    n_tarjeta int,
    credito int,
    id_personas int,
    PRIMARY KEY (id_cliente),
    FOREIGN KEY (id_personas) REFERENCES personas(id_personas)
);

CREATE TABLE IF NOT EXISTS empleados (
    id_empleado int  NOT NULL auto_increment,
    categoria varchar(20),
    sueldo int,
    id_personas int NOT NULL,
    PRIMARY KEY (id_empleado),
    FOREIGN KEY (id_personas) REFERENCES personas(id_personas)
);
CREATE TABLE IF NOT EXISTS facturas (
    id_facturas int  NOT NULL auto_increment,
    cod_facturas varchar(20),
    total int,
    id_cliente int,
    PRIMARY KEY (id_facturas),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE productos (
    id_producto int,
    precio int,
    stock int
);

//----------------  AGREGAR LLAVES  ------------------------------------------------

ALTER TABLE personas ADD CONSTRAINT dni PRIMARY KEY (dni);
ALTER TABLE clientes ADD CONSTRAINT id_cliente PRIMARY KEY (id_cliente);
ALTER TABLE empleados ADD CONSTRAINT id_empleado PRIMARY KEY (id_empleado);
ALTER TABLE facturas ADD CONSTRAINT n_factura PRIMARY KEY (n_factura);
ALTER TABLE productos ADD CONSTRAINT id_producto PRIMARY KEY (id_producto);
//es importante crear primero la llave primeria antes que la foranea sino devuelve error
ALTER TABLE clientes ADD CONSTRAINT dni FOREIGN KEY (dni) REFERENCES personas(dni);
ALTER TABLE empleados ADD CONSTRAINT dni FOREIGN KEY (dni) REFERENCES personas(dni);
ALTER TABLE facturas ADD CONSTRAINT id_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente);

//-- TAMBIEN SE PUEDE HACER EN UNA LINEA:
// ALTER TABLE clientes ADD CONSTRAINT id_cliente PRIMARY KEY (id_cliente), ADD CONSTRAINT dni FOREIGN KEY (dni) REFERENCES personas(dni);
//





//--------------------------------------------------------------------------------------------------------
//------------  OTROS  ---------------
//--------------------------------------------------------------------------------------------------------

ALTER TABLE facturas CHANGE COLUMN dni TO id_cliente varchar(20);
ALTER TABLE facturas DROP COLUMN dni;
ALTER TABLE facturas ADD COLUMN id_cliente int;
//--eliminar data base
DROP DATABASE empresa;
//--actualizar un dato de la tabla
UPDATE personas SET dni=40444444 WHERE id_personas=3; //--si no agrego el where me modificaria todos los dni
//--limpiar shell
system cls

SELECT * FROM personas;



//------------  INGRESAR REGISTROS  ---------------
INSERT INTO personas(dni, apyn, email, telefono) VALUES
(40111111, 'pepe sanches', 'pepe@hotmail.com', 1132165498),
(40222222, 'susana sanches', 'susana@hotmail.com', 1165984752),
(40333333, 'juan tinelli', 'juan@hotmail.com', 1132165498);

INSERT INTO clientes (tarjeta, credito, id_personas) VALUES (6547987498561234, 4321, 3);

INSERT INTO personas(dni, apyn, email, telefono) VALUES
(40555555, 'ricardo ford', 'ricardo@hotmail.com', 1132165498),
(40666666, 'guillermo francella', 'guillermo@hotmail.com', 1165984752),
(40777777, 'mario pergolini', 'juan@hotmail.com', 1132165498),
(40888888, 'pepe biondi', 'pepe@hotmail.com', 1132165498),
(40999999, 'viviana canosa', 'susana@hotmail.com', 1165984752),
(40111222, 'chunia villafania', 'juan@hotmail.com', 1132165498);

INSERT INTO personas(dni, apyn, email, telefono) VALUES
(40111333, 'mirtha legrand', 'mirtha@hotmail.com', 11258369);
