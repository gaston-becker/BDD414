
CREATE DATABASE IF NOT EXISTS empresa;

USE empresa;

CREATE DATABASE IF NOT EXISTS empresa;

USE empresa;

//---------- CREAR TABLAS  ---------------------
CREATE TABLE IF NOT EXISTS personas (
    id_personas int NOT NULL auto_increment,--El atributo id_persona es de valor entero/numero(int). NOT NULL->No puede ser nulo/vacio. auto_incremente-> a medida que se ingrese un registro este atributo va a tener un valor(+1) al anterior registro.
    dni int NOT NULL,
    apyn varchar(20),
    email varchar(20),
    telefono int,
    PRIMARY KEY (id_personas) --La Primary key es el valor unico de los registro que van a poseer para diferenciarse de otros atributos
);--en este caso, personas no va a poseer llave foranea ya que esta tabla es como una table padre

CREATE TABLE IF NOT EXISTS clientes (
    id_cliente int  NOT NULL auto_increment,
    n_tarjeta int,
    credito int,
    id_personas int,
    PRIMARY KEY (id_cliente),
    FOREIGN KEY (id_personas) REFERENCES personas(id_personas) --la llave fornaea de clientes es id_personas, ya que esta tabla esta relacionada con la tabla personas, es decir, la foreign_Key de una tabla es la llave Primary_key de la tabla con la que se realciona.
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
//--es importante crear primero la llave primeria antes que la foranea sino devuelve error
ALTER TABLE clientes ADD CONSTRAINT dni FOREIGN KEY (dni) REFERENCES personas(dni);
ALTER TABLE empleados ADD CONSTRAINT dni FOREIGN KEY (dni) REFERENCES personas(dni);
ALTER TABLE facturas ADD CONSTRAINT id_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente);

//-- TAMBIEN SE PUEDE HACER EN UNA LINEA:
//-- ALTER TABLE clientes ADD CONSTRAINT id_cliente PRIMARY KEY (id_cliente), ADD CONSTRAINT dni FOREIGN KEY (dni) REFERENCES personas(dni);
//





//--------------------------------------------------------------------------------------------------------
//------------  OTROS  
//--------------------------------------------------------------------------------------------------------

ALTER TABLE facturas CHANGE COLUMN dni TO id_cliente varchar(20);
ALTER TABLE facturas DROP COLUMN dni;
ALTER TABLE facturas ADD COLUMN id_cliente int;
//--eliminar data base
DROP DATABASE empresa;
//--actualizar un dato de la tabla
UPDATE personas SET dni=40444444 WHERE id_personas=3; //--si no agrego el where me modificaria todos los dni
UPDATE facturas SET total= 55005 WHERE id_facturas=6;
//--limpiar shell
system cls

SELECT * FROM personas;



//------------  INGRESAR REGISTROS  ------------------------------------------------------------------------

INSERT INTO personas(dni, apyn, email, telefono) VALUES
(40111333, 'susana gimenez', 'susana@hotmail.com', 1133355599),
(40111444, 'liliana calabro', 'liliana@hotmail.com', 1188884752),
(40111555, 'dipy papá', 'dipy@hotmail.com', 11951753),
(40111666, 'pablo lezcano', 'pablo@hotmail.com', 1132165498),
(40111777, 'raul alfonsin', 'raul@hotmail.com', 1165984752),
(40111888, 'alex caniggia', 'alex@hotmail.com', 1132165498);


INSERT INTO clientes (n_tarjeta, credito, id_personas) VALUES (6547987498561237, 3778, 4);

INSERT INTO facturas (cod_facturas, total, id_cliente) VALUES 
('fempn_123455', 50000, 4),
('fempn_123454', 100000, 4),
('fempn_123453', 50000, 1);



//------------ JOIN  -----------------------------------------------------------------------------------
--INNER--
SELECT clientes.n_tarjeta, personas.apyn FROM clientes 
INNER JOIN personas 
ON clientes.id_personas = personas.id_personas;


SELECT facturas.cod_facturas, facturas.total, facturas.id_cliente, clientes.n_tarjeta, clientes.id_personas FROM facturas 
INNER JOIN clientes 
ON facturas.id_cliente = clientes.id_cliente;
//--ya que al usar esta tabla solo me muestra datos de las facturas y de cliente, pero si tambien quiero saber datos de la persona:
SELECT facturas.cod_facturas, facturas.total, clientes.n_tarjeta, clientes.id_personas, personas.apyn FROM facturas 
INNER JOIN clientes 
ON facturas.id_cliente = clientes.id_cliente
INNER JOIN personas
ON clientes.id_personas = personas.id_personas;

--LEFT--
SELECT clientes.n_tarjeta, personas.apyn FROM clientes 
LEFT JOIN personas 
ON clientes.id_personas = personas.id_personas;

--RIGHT--
SELECT clientes.n_tarjeta, personas.apyn FROM personas 
RIGHT JOIN clientes 
ON clientes.id_personas = personas.id_personas;