
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

INSERT INTO personas(dni, apyn, email, telefono) VALUES --tengo que especificar los campos, sino me va a querer agregar tambien los campos AutoIncrementales.
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
//--puedo agregar una condicion para solo ver el de una persona en especifico por ejemplo:
SELECT facturas.cod_facturas, facturas.total, clientes.n_tarjeta, clientes.id_personas, personas.apyn FROM facturas 
INNER JOIN clientes 
ON facturas.id_cliente = clientes.id_cliente
INNER JOIN personas
ON clientes.id_personas = personas.id_personas
WHERE persona.apyn=susana gimenez;

--LEFT--
SELECT clientes.n_tarjeta, personas.apyn FROM clientes 
LEFT JOIN personas 
ON clientes.id_personas = personas.id_personas;

--RIGHT--
SELECT clientes.n_tarjeta, personas.apyn FROM personas 
RIGHT JOIN clientes 
ON clientes.id_personas = personas.id_personas;


//------------ Usuario  -----------------------------------------------------
la idea es primero entrar con el usuario root, para crear los demas usuarios, y con estos usuario si trabajar con las tablas
--crear usuario:
CREATE USER 'clase'@'localhost' IDENTIFIED BY '123456';
//--puede ser que nos pida una contraseña dificl
//--significa en donde va a esta, en este caso en}n localhost. O por ejemplo @gmail, significa que está dominio de Gmail
--para editar la contraseña:
ALTER USER 'clases'@'localhost' INDENTIFIED BY 'Admin123456';





-- Ingresar a la shell
mysql -u clases1 -p
--Password:
Admin123456

//--Conceder permisos al usuario:
--? GRANT ALL ON sqljava.* TO 'clases1'@'localhost';
GRANT ALL PRIVILEGES ON db_tinelli.* TO 'tinelli'@'localhost';--db_tinelli.*  -> con el '.*' le digo que le doy acceso a todas las tablas. Si quisiera pudiera especificar a q tabla puede tener acceso
--GRANT SELECT, DROP PRIVILEGES...


CREATE TABLE IF NOT EXISTS tb_hq (
    id_hq int  NOT NULL auto_increment,
    nom varchar(40),
    dni int,
    email int,
    PRIMARY KEY (id_hq)
);
CREATE TABLE IF NOT EXISTS tb_estudio1 (
    id_estudio1 int  NOT NULL auto_increment,
    categoria varchar(20),
    sueldo int,
    id_hq int NOT NULL,
    PRIMARY KEY (id_estudio1),
    FOREIGN KEY (id_hq) REFERENCES tb_hq(id_hq) 
    ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS tb_estudio2 (
    id_estudio2 int  NOT NULL auto_increment,
    categoria varchar(20),
    sueldo int,
    id_hq int NOT NULL,
    PRIMARY KEY (id_estudio2),
    FOREIGN KEY (id_hq) REFERENCES tb_hq(id_hq) 
);
--ON DELETE CASCADE -> al momentode eliminar un registro de tb_hq, con este comando elimino tmbien el elemento relacionado en en estudio1/2.

INSERT INTO tb_hq (dni, nom, email) VALUES
    (40111333, 'susana gimenez', 'susana@hotmail.com'),
    (40111444, 'liliana calabro', 'liliana@hotmail.com'),
    (40111555, 'dipy papá', 'dipy@hotmail.com'),
    (40111666, 'pablo lezcano', 'pablo@hotmail.com'),
    (40111777, 'raul alfonsin', 'raul@hotmail.com'),
    (40111888, 'alex caniggia', 'alex@hotmail.com'),
    (40111999, 'enana feudale', 'feudale@hotmail.com'),
    (40111212, 'alacran X', 'X@hotmail.com')
    ;

INSERT INTO tb_estudio1 (id_hq, categoria, sueldo) VALUES
    (2, 'reidor',  200),
    (4, 'esclavo', 250),
    (6, 'bailarin',450),
    (8, 'reidor',  270)
    ;

INSERT INTO tb_estudio2 (id_hq, categoria, sueldo) VALUES
    (1, 'esclavo',  230),
    (3, 'reidor',   250),
    (5, 'bailarin', 500),
    (7, 'bailarin', 470)
    ; 

    INSERT INTO tb_hq (dni, nom, email) VALUES
    (40111753, 'Fernando de laRua', 'fercho@hotmail.com');

INSERT INTO tb_estudio2 (categoria, sueldo, id_hq) VALUES
('invitado',  10, 9);

SELECT sueldo FROM tb_hq INNER JOIN tb_estudio2 ON tb_estudio2.id_hq = tb_hq.id_hq WHERE tb_hq.id_hq = 9;

GmailUnir 2 tablas:
SELECT tb_hq.nom, tb_estudio1.sueldo, tb_estudio2.sueldo FROM tb_hq INNER JOIN tb_estudio2 ON tb_hq.id_hq = tb_estudio2.id_hq INNER JOIN tb_estudio1 ON tb_hq.id_hq = tb_estudio1.id_hq;

----------------------------------------------------------------------------------------------------
----  ALMACEN  ----------
CREATE TABLE IF NOT EXISTS  (
    codigo_art varchar NOT NULL,
    nombre varchar(20),
    marca varchar(20),
    precio int,
    cuit_prov int NOT NULL,
    CONSTRAINT pk_articulos PRIMARY KEY (codigo_art) -->Usamos constraint para indicar como vamos a llamar a la primaryKey, esta sentencia sirce como para poner "apodos". y "PK_" es de Primary Key 
    ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tb_Art_Proveedores(
    codigo_art VARCHAR(20),
    cuit_prov VARCHAR(20),
    CONSTRAINT pk_artprov PRIMARY KEY (cod_art, cuit_prov)-->En este caso nuestra clave es compuesta, posee 2 codigos para ser indentifiada
    FOREIGN KEY (cod_art) REFERENCES tb_Art_limpieza(pk_articulos) 
    FOREIGN KEY (cuit_prov) REFERENCES tb_Art_Proveedores(pk_prov) 
);



