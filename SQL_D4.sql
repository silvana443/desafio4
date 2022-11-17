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
-- Table `mydb`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`persona` (
  `idpersona` INT NOT NULL,
  `DNI` INT(8) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `domicilio` VARCHAR(45) NOT NULL,
  `fecha_nac` DATE NOT NULL,
  `edad` TINYINT(3) NULL,
  `telefono1` VARCHAR(15) NOT NULL,
  `telefono2` VARCHAR(45) NULL,
  `img_foto` VARCHAR(200) NULL,
  PRIMARY KEY (`idpersona`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`domicilio` (
  `iddomicilio` INT NOT NULL,
  `Pais` VARCHAR(45) NULL,
  `provincia` VARCHAR(45) NULL,
  `departamento` VARCHAR(45) NULL,
  `calle` VARCHAR(45) NULL,
  `altura` SMALLINT(5) NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`iddomicilio`, `persona_idpersona`),
  INDEX `fk_domicilio_persona_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_domicilio_persona`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `mydb`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`educacion` (
  `ideducacion` INT NOT NULL,
  `Establecimiento` VARCHAR(45) NOT NULL,
  `nivel_educ` VARCHAR(45) NOT NULL,
  `fecha_ing` DATE NOT NULL,
  `fecha_eg` DATE NOT NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`ideducacion`, `persona_idpersona`),
  INDEX `fk_educacion_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_educacion_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `mydb`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Experiencia_Laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Experiencia_Laboral` (
  `idlaboral` INT NOT NULL,
  `Empresa` VARCHAR(45) NOT NULL,
  `fecha_ing` DATE NOT NULL,
  `fecha_eg` DATE NOT NULL,
  `Descripcion` VARCHAR(45) NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`idlaboral`, `persona_idpersona`),
  INDEX `fk_Experiencia_Laboral_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_Experiencia_Laboral_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `mydb`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuarios` (
  `idusuarios` INT NOT NULL,
  `usuario` VARCHAR(45) NULL,
  `contraseña` VARCHAR(45) NULL,
  `mail` VARCHAR(45) NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`idusuarios`, `persona_idpersona`),
  INDEX `fk_usuarios_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `mydb`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hard&Soft_Skills`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Hard&Soft_Skills` (
  `idHard&Soft_Skills` INT NOT NULL,
  `tecnologia` VARCHAR(45) NOT NULL,
  `Nivel` VARCHAR(45) NOT NULL,
  `img_logo` VARCHAR(200) NOT NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`idHard&Soft_Skills`, `persona_idpersona`),
  INDEX `fk_Hard&Soft_Skills_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_Hard&Soft_Skills_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `mydb`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Proyectos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Proyectos` (
  `idProyectos` INT NULL,
  `Nombre_Proyecto` VARCHAR(45) NOT NULL,
  `Version` VARCHAR(45) NULL,
  `Descripcion` LONGTEXT NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`persona_idpersona`),
  CONSTRAINT `fk_Proyectos_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `mydb`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Roles` (
  `idRoles` INT NOT NULL,
  `Rol` VARCHAR(45) NULL,
  PRIMARY KEY (`idRoles`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuarios_has_Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuarios_has_Roles` (
  `usuarios_idusuarios` INT NOT NULL,
  `usuarios_persona_idpersona` INT NOT NULL,
  `Roles_idRoles` INT NOT NULL,
  PRIMARY KEY (`usuarios_idusuarios`, `usuarios_persona_idpersona`, `Roles_idRoles`),
  INDEX `fk_usuarios_has_Roles_Roles1_idx` (`Roles_idRoles` ASC) VISIBLE,
  INDEX `fk_usuarios_has_Roles_usuarios1_idx` (`usuarios_idusuarios` ASC, `usuarios_persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_has_Roles_usuarios1`
    FOREIGN KEY (`usuarios_idusuarios` , `usuarios_persona_idpersona`)
    REFERENCES `mydb`.`usuarios` (`idusuarios` , `persona_idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_has_Roles_Roles1`
    FOREIGN KEY (`Roles_idRoles`)
    REFERENCES `mydb`.`Roles` (`idRoles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
