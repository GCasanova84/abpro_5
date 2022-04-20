/* Ejercicios ABPro AE5 */
/* Grupo 5 - Militza, Gregory, Jose */

/* Parte 1: Crear entorno de trabajo */
/* - Crear una base de datos */
create database abpro5_grup character set utf8;

/* - Crear un usuario con todos los privilegios para trabajar con la base de datos recién creada. */
create user user_utc@'localhost' identified by '1234';

grant all on abpro5_grup.* to 'user_utc'@'localhost';

use abpro5_grup;

/* Parte 2: Crear dos tablas. */
/* - La primera almacena a los usuarios de la aplicación (id_usuario, nombre, apellido,
contraseña, zona horaria (por defecto UTC-3), género y teléfono de contacto).
*/
CREATE TABLE `abpro5_grup`.`usuarios` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT COMMENT 'numerico autogenarado para id',
  `nombre` VARCHAR(20) NULL COMMENT 'varchar maximo 20 para nombres',
  `apellido` VARCHAR(20) NULL COMMENT 'varchar maximo 20 para apellidos',
  `contrasena` VARCHAR(20) NULL COMMENT 'varchar maximo 20 para contraseña robusta',
  `zona_horaria` VARCHAR(6) NULL DEFAULT 'UTC-3' COMMENT 'varchar zon horaria Por defecto UTC-3',
  `genero` VARCHAR(10) NULL COMMENT 'varchar texto Masculino o Femenino',
  `telefono` VARCHAR(12) NULL COMMENT 'varchar para el formato +56999999999',
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

/*- La segunda tabla almacena información relacionada a la fecha-hora de ingreso de los
usuarios a la plataforma (id_ingreso, id_usuario y la fecha-hora de ingreso (por defecto la
fecha-hora actual)).
*/
CREATE TABLE `abpro5_grup`.`ingresos` (
  `id_ingreso` INT NOT NULL AUTO_INCREMENT COMMENT 'Campo id numerico autoincremental clave primaria',
  `id_usuario` INT NULL COMMENT 'campo id de usuario. por ser clave foranea de la tabla usuarios, debe tener el mismo tipo de datos que la tabla padre (INT)',
  `fecha_hora` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Datetime para almacenar fecha y hora de ingreso del usuario',  
  PRIMARY KEY (`id_ingreso`),  
  CONSTRAINT `id_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `abpro5_grup`.`usuarios` (`id_usuario`)
    ON UPDATE CASCADE
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

/* Parte 3: Modificación de la tabla */
/*- Modifique el UTC por defecto.Desde UTC-3 a UTC-2. */
ALTER TABLE `abpro5_grup`.`usuarios` 
CHANGE COLUMN `zona_horaria` `zona_horaria` VARCHAR(6) NULL DEFAULT 'UTC-2' COMMENT 'Por defecto UTC-2' ;

/* Parte 4: Creación de registros. */
/* - Para cada tabla crea 8 registros. */
/* tabla usuarios */
INSERT INTO `abpro5_grup`.`usuarios`(`nombre`, `apellido`, `contrasena`, `genero`, `telefono`)
VALUES('Milizta', 'Ortega', 'Pwd1234', 'Femenino','+56955544478'),
('Nicole', 'Contreras', 'Pwd4321', 'Femenino','+5699554478'),
('Gregory', 'Casanova', 'Pwd3333', 'Masculino','+56967854928'),
('Jose', 'Toloza', 'Pwd7777', 'Masculino','+56997576458'),
('Andrea', 'Perez', 'Pwd4444', 'Femenino','+56955556789'),
('Ines', 'Fernandez', 'Pwd2222', 'Femenino','+5644461558'),
('Roberto', 'Guzman', 'Pwd1111', 'Masculino','+56999899851'),
('Enrique', 'Pena', 'Pwd8877', 'Masculino','+56945678912');

/* tabla ingresos */
INSERT INTO `abpro5_grup`.`ingresos`(`id_usuario`)
VALUES(1),(1),(2),(3),(4),(5),(6),(8);

/*Parte 5: Justifique cada tipo de dato utilizado. ¿Es el óptimo en cada caso? */
/* RESPUESTA: cada dato esta comentado con la justificacion de cada tipo de dato utilizado */

/* Parte 6: Creen una nueva tabla llamada Contactos (id_contacto, id_usuario, numero de telefono, 
correo electronico).
*/
CREATE TABLE `abpro5_grup`.`contactos` (
  `id_contacto` INT NOT NULL AUTO_INCREMENT COMMENT 'numerico autoincremental para id',
  `id_usuario` INT NULL COMMENT 'identificador del usuario registrado en el contacto. numerico porque debe tener el mismo tipo de datos de id_usuario de la tabla usuarios',
  `num_telefono` VARCHAR(12) NULL COMMENT 'varchar para el formato +56999999999',
  `correo_electronico` VARCHAR(25) NULL COMMENT 'varchar para correo electroico del contacto',
  PRIMARY KEY (`id_contacto`),  
  CONSTRAINT `id_usuario_contacto`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `abpro5_grup`.`usuarios` (`id_usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

/*
Parte 7: Modifique la columna teléfono de contacto, para crear un vínculo entre la tabla Usuarios y la
tabla Contactos.
*/
ALTER TABLE `abpro5_grup`.`ingresos`
DROP FOREIGN KEY `id_usuario`; 

ALTER TABLE `abpro5_grup`.`usuarios`
MODIFY `id_usuario` INT NOT NULL COMMENT 'numerico para id', 
DROP PRIMARY KEY,
ADD PRIMARY KEY (`telefono`);

ALTER TABLE `abpro5_grup`.`contactos`
DROP FOREIGN KEY `id_usuario_contacto`; 

ALTER TABLE `abpro5_grup`.`contactos`  
ADD CONSTRAINT `telefono_contacto` 
    FOREIGN KEY (`num_telefono`) 
    REFERENCES `abpro5_grup`.`usuarios` (`telefono`) 
    ON DELETE CASCADE
    ON UPDATE CASCADE; 

/*
El ejercicio debe ser subido a github y al Nodo Virtual.
*/
