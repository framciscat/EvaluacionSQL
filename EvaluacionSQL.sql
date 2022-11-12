CREATE SCHEMA IF NOT EXISTS `negocio`;
USE `negocio` ;

#Crear tabla categoria o tipo de producto
CREATE TABLE IF NOT EXISTS `negocio`.`categoria` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_categoria`));

#Crear tabla productos
CREATE TABLE IF NOT EXISTS `negocio`.`productos` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `precio` INT NOT NULL,
  `categoria_id_categoria` INT NOT NULL,
  PRIMARY KEY (`id_producto`),
  INDEX `fk_productos_categoria1_idx` (`categoria_id_categoria` ASC) VISIBLE,
  CONSTRAINT `fk_productos_categoria1`
    FOREIGN KEY (`categoria_id_categoria`)
    REFERENCES `negocio`.`categoria` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

#crear tabla proveedores
CREATE TABLE IF NOT EXISTS `negocio`.`proveedores` (
  `id_proveedores` INT NOT NULL AUTO_INCREMENT,
  `telefono` INT NOT NULL,
  `nombre` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_proveedores`));

#Crear tabla ventas
CREATE TABLE IF NOT EXISTS `negocio`.`ventas` (
  `id_ventas` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `productos_id_producto` INT NOT NULL,
  PRIMARY KEY (`id_ventas`),
  INDEX `fk_ventas_productos1_idx` (`productos_id_producto` ASC) VISIBLE,
  CONSTRAINT `fk_ventas_productos1`
    FOREIGN KEY (`productos_id_producto`)
    REFERENCES `negocio`.`productos` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

#Crear tabla stock
CREATE TABLE IF NOT EXISTS `negocio`.`stock` (
  `id_stock` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NOT NULL,
  `proveedores_id_proveedores` INT NOT NULL,
  `productos_id_producto` INT NOT NULL,
  PRIMARY KEY (`id_stock`),
  INDEX `fk_stock_proveedores1_idx` (`proveedores_id_proveedores` ASC) VISIBLE,
  INDEX `fk_stock_productos1_idx` (`productos_id_producto` ASC) VISIBLE,
  CONSTRAINT `fk_stock_proveedores1`
    FOREIGN KEY (`proveedores_id_proveedores`)
    REFERENCES `negocio`.`proveedores` (`id_proveedores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_stock_productos1`
    FOREIGN KEY (`productos_id_producto`)
    REFERENCES `negocio`.`productos` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


use `negocio`;
select * from productos;
select * from proveedores;
select * from ventas;
select * from stock;
select * from categoria;


# Agregando elementos a categoria
INSERT INTO `negocio`.`categoria` (`id_categoria`, `tipo`) VALUES ('1', 'Lacteos');
INSERT INTO `negocio`.`categoria` (`id_categoria`, `tipo`) VALUES ('2', 'Frutas');
INSERT INTO `negocio`.`categoria` (`id_categoria`, `tipo`) VALUES ('3', 'Abarrotes');
INSERT INTO `negocio`.`categoria` (`id_categoria`, `tipo`) VALUES ('4', 'Limpieza');
INSERT INTO `negocio`.`categoria` (`id_categoria`, `tipo`) VALUES ('5', 'Aseo personal');


#Agregando datos a proveedores
INSERT INTO `negocio`.`proveedores` (`id_proveedores`, `telefono`, `nombre`) VALUES ('1', '982345673', 'surlat');
INSERT INTO `negocio`.`proveedores` (`id_proveedores`, `telefono`, `nombre`) VALUES ('2', '98676534', 'la veguita');
INSERT INTO `negocio`.`proveedores` (`id_proveedores`, `telefono`, `nombre`) VALUES ('3', '98675674', 'belmont');
INSERT INTO `negocio`.`proveedores` (`id_proveedores`, `telefono`, `nombre`) VALUES ('4', '98767867', 'clorox');
INSERT INTO `negocio`.`proveedores` (`id_proveedores`, `telefono`, `nombre`) VALUES ('5', '97876434', 'familand');

#Agregando productos
INSERT INTO `negocio`.`productos` (`id_producto`, `nombre`, `precio`, `categoria_id_categoria`) VALUES ('1', 'leche sin lactosa', '1000', '1');
INSERT INTO `negocio`.`productos` (`id_producto`, `nombre`, `precio`, `categoria_id_categoria`) VALUES ('2', 'platanos', '1500', '2');
INSERT INTO `negocio`.`productos` (`id_producto`, `nombre`, `precio`, `categoria_id_categoria`) VALUES ('3', 'aceite', '4000', '3');
INSERT INTO `negocio`.`productos` (`id_producto`, `nombre`, `precio`, `categoria_id_categoria`) VALUES ('4', 'cloro', '1600', '4');
INSERT INTO `negocio`.`productos` (`id_producto`, `nombre`, `precio`, `categoria_id_categoria`) VALUES ('5', 'shampoo', '2000', '5');

#Agregando ventas
INSERT INTO `negocio`.`ventas` (`id_ventas`, `fecha`, `productos_id_producto`) VALUES ('1', '2021-01-10', '5');
INSERT INTO `negocio`.`ventas` (`id_ventas`, `fecha`, `productos_id_producto`) VALUES ('2', '2021-10-18', '4');
INSERT INTO `negocio`.`ventas` (`id_ventas`, `fecha`, `productos_id_producto`) VALUES ('3', '2021-07-14', '3');
INSERT INTO `negocio`.`ventas` (`id_ventas`, `fecha`, `productos_id_producto`) VALUES ('4', '2021-05-06', '1');

#Agregando stock
INSERT INTO `negocio`.`stock` (`id_stock`, `cantidad`, `proveedores_id_proveedores`, `productos_id_producto`) VALUES ('1', '20', '1', '1');
INSERT INTO `negocio`.`stock` (`id_stock`, `cantidad`, `proveedores_id_proveedores`, `productos_id_producto`) VALUES ('2', '15', '2', '2');
INSERT INTO `negocio`.`stock` (`id_stock`, `cantidad`, `proveedores_id_proveedores`, `productos_id_producto`) VALUES ('3', '25', '3', '3');
INSERT INTO `negocio`.`stock` (`id_stock`, `cantidad`, `proveedores_id_proveedores`, `productos_id_producto`) VALUES ('4', '30', '4', '4');
INSERT INTO `negocio`.`stock` (`id_stock`, `cantidad`, `proveedores_id_proveedores`, `productos_id_producto`) VALUES ('5', '20', '5', '5');


# Ver ganancias del año
SELECT sum(precio)
FROM negocio.ventas
INNER JOIN negocio.productos on negocio.ventas.id_ventas = negocio.productos.id_producto
WHERE ventas.fecha BETWEEN '2021-01-01' AND '2021-12-01';

# Revisar stock de productos
SELECT stock.cantidad, productos.nombre
FROM negocio.stock
INNER JOIN negocio.productos on negocio.stock.id_stock = negocio.productos.id_producto;

