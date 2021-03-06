-- MySQL Script generated by MySQL Workbench
-- vie 13 nov 2020 11:57:38 WET
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Vivero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vivero` (
  `ubicación` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `horario_apertura` DATE NOT NULL,
  `horario_cierre` DATE NOT NULL,
  PRIMARY KEY (`ubicación`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Zona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Zona` (
  `Nombre` VARCHAR(45) NOT NULL,
  `num_zona` INT NULL,
  `Vivero_ubicación` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Nombre`),
  INDEX `fk_Zona_Vivero1_idx` (`Vivero_ubicación` ASC) VISIBLE,
  CONSTRAINT `fk_Zona_Vivero1`
    FOREIGN KEY (`Vivero_ubicación`)
    REFERENCES `mydb`.`Vivero` (`ubicación`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Producto` (
  `código_barras` INT NOT NULL,
  `caducidad` VARCHAR(20) NULL,
  `nombre` VARCHAR(45) NULL,
  `precio` FLOAT NULL,
  `tipo` VARCHAR(45) NULL,
  `stock` INT NULL,
  `nombre_zona` VARCHAR(45) NULL,
  `num_zona` INT NULL,
  `Zona_Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`código_barras`),
  UNIQUE INDEX `Zona_nombre_UNIQUE` () VISIBLE,
  INDEX `fk_Producto_Zona1_idx` (`Zona_Nombre` ASC) VISIBLE,
  CONSTRAINT `fk_Producto_Zona1`
    FOREIGN KEY (`Zona_Nombre`)
    REFERENCES `mydb`.`Zona` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Empleado` (
  `DNI` VARCHAR(20) NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellidos` VARCHAR(45) NULL,
  `contrato` VARCHAR(45) NULL,
  `código_SS` INT NULL,
  `Zona_Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`DNI`),
  INDEX `fk_Empleado_Zona1_idx` (`Zona_Nombre` ASC) VISIBLE,
  CONSTRAINT `fk_Empleado_Zona1`
    FOREIGN KEY (`Zona_Nombre`)
    REFERENCES `mydb`.`Zona` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `DNI` INT NOT NULL,
  `código_fidelización` INT NULL,
  `num_tarjeta` INT NULL,
  `bonificación` FLOAT NULL,
  `Gasto_mensual` FLOAT NULL,
  PRIMARY KEY (`DNI`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
  `num_pedido` INT NOT NULL,
  `fecha` DATE NULL,
  `Producto_código_barras` INT NOT NULL,
  `Empleado_DNI` VARCHAR(20) NOT NULL,
  `Cliente_DNI` INT NOT NULL,
  `Importe` FLOAT NULL,
  PRIMARY KEY (`num_pedido`),
  INDEX `fk_Pedido_Producto1_idx` (`Producto_código_barras` ASC) VISIBLE,
  INDEX `fk_Pedido_Empleado1_idx` (`Empleado_DNI` ASC) VISIBLE,
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_DNI` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Producto1`
    FOREIGN KEY (`Producto_código_barras`)
    REFERENCES `mydb`.`Producto` (`código_barras`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Empleado1`
    FOREIGN KEY (`Empleado_DNI`)
    REFERENCES `mydb`.`Empleado` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_DNI`)
    REFERENCES `mydb`.`Cliente` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
