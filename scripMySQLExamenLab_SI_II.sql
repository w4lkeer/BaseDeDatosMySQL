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
-- Table `mydb`.`Paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Paciente` (
  `idPaciente` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `Apellidos` VARCHAR(45) NULL,
  `Genero` VARCHAR(45) NULL,
  `Direccion` VARCHAR(45) NULL,
  `Correo` VARCHAR(45) NULL,
  `Celular` VARCHAR(45) NULL,
  `Medicamentos` VARCHAR(45) NULL,
  PRIMARY KEY (`idPaciente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Medico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medico` (
  `idMedico` INT NOT NULL,
  `Nombres` VARCHAR(45) NULL,
  `Apellidos` VARCHAR(45) NULL,
  `DNI` VARCHAR(45) NULL,
  `Genero` VARCHAR(45) NULL,
  `Direccion` VARCHAR(45) NULL,
  `Correo` VARCHAR(45) NULL,
  `Celular` VARCHAR(45) NULL,
  PRIMARY KEY (`idMedico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ESPECIALIDAD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ESPECIALIDAD` (
  `idESPECIALIDAD` INT NOT NULL,
  `Nombre_Especialidad` VARCHAR(45) NULL,
  PRIMARY KEY (`idESPECIALIDAD`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reservacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Reservacion` (
  `idReservacion` INT NOT NULL,
  `fecha` DATETIME NULL,
  `Paciente_idPaciente` INT NOT NULL,
  `Medico_idMedico` INT NOT NULL,
  `Nombre_Paciente` VARCHAR(45) NOT NULL,
  `Nombre_Especialdad` VARCHAR(45) NOT NULL,
  `Nombre_Medico` VARCHAR(45) NOT NULL,
  `Nombre_Clinica` VARCHAR(45) NULL,
  `ESPECIALIDAD_idESPECIALIDAD` INT NOT NULL,
  PRIMARY KEY (`idReservacion`, `Paciente_idPaciente`, `Medico_idMedico`, `Nombre_Paciente`, `Nombre_Especialdad`, `Nombre_Medico`, `ESPECIALIDAD_idESPECIALIDAD`),
  INDEX `fk_Reservacion_Paciente1_idx` (`Paciente_idPaciente` ASC) VISIBLE,
  INDEX `fk_Reservacion_Medico1_idx` (`Medico_idMedico` ASC) VISIBLE,
  INDEX `fk_Reservacion_ESPECIALIDAD1_idx` (`ESPECIALIDAD_idESPECIALIDAD` ASC) VISIBLE,
  CONSTRAINT `fk_Reservacion_Paciente1`
    FOREIGN KEY (`Paciente_idPaciente`)
    REFERENCES `mydb`.`Paciente` (`idPaciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservacion_Medico1`
    FOREIGN KEY (`Medico_idMedico`)
    REFERENCES `mydb`.`Medico` (`idMedico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservacion_ESPECIALIDAD1`
    FOREIGN KEY (`ESPECIALIDAD_idESPECIALIDAD`)
    REFERENCES `mydb`.`ESPECIALIDAD` (`idESPECIALIDAD`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ticket` (
  `idTicket` INT NOT NULL,
  `Paciente_idPaciente` INT NOT NULL,
  `Reservacion_idReservacion` INT NOT NULL,
  `Reservacion_Paciente_idPaciente` INT NOT NULL,
  `Reservacion_Medico_idMedico` INT NOT NULL,
  `Reservacion_Nombre_Paciente` VARCHAR(45) NOT NULL,
  `Reservacion_Nombre_Especialdad` VARCHAR(45) NOT NULL,
  `Reservacion_Nombre_Medico` VARCHAR(45) NOT NULL,
  `Fecha` DATETIME NULL,
  PRIMARY KEY (`idTicket`, `Paciente_idPaciente`, `Reservacion_idReservacion`, `Reservacion_Paciente_idPaciente`, `Reservacion_Medico_idMedico`, `Reservacion_Nombre_Paciente`, `Reservacion_Nombre_Especialdad`, `Reservacion_Nombre_Medico`),
  INDEX `fk_Ticket_Paciente_idx` (`Paciente_idPaciente` ASC) VISIBLE,
  INDEX `fk_Ticket_Reservacion1_idx` (`Reservacion_idReservacion` ASC, `Reservacion_Paciente_idPaciente` ASC, `Reservacion_Medico_idMedico` ASC, `Reservacion_Nombre_Paciente` ASC, `Reservacion_Nombre_Especialdad` ASC, `Reservacion_Nombre_Medico` ASC) VISIBLE,
  CONSTRAINT `fk_Ticket_Paciente`
    FOREIGN KEY (`Paciente_idPaciente`)
    REFERENCES `mydb`.`Paciente` (`idPaciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ticket_Reservacion1`
    FOREIGN KEY (`Reservacion_idReservacion` , `Reservacion_Paciente_idPaciente` , `Reservacion_Medico_idMedico` , `Reservacion_Nombre_Paciente` , `Reservacion_Nombre_Especialdad` , `Reservacion_Nombre_Medico`)
    REFERENCES `mydb`.`Reservacion` (`idReservacion` , `Paciente_idPaciente` , `Medico_idMedico` , `Nombre_Paciente` , `Nombre_Especialdad` , `Nombre_Medico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ESPECIALIDAD_has_Paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ESPECIALIDAD_has_Paciente` (
  `ESPECIALIDAD_idESPECIALIDAD` INT NOT NULL,
  `Paciente_idPaciente` INT NOT NULL,
  PRIMARY KEY (`ESPECIALIDAD_idESPECIALIDAD`, `Paciente_idPaciente`),
  INDEX `fk_ESPECIALIDAD_has_Paciente_Paciente1_idx` (`Paciente_idPaciente` ASC) VISIBLE,
  INDEX `fk_ESPECIALIDAD_has_Paciente_ESPECIALIDAD1_idx` (`ESPECIALIDAD_idESPECIALIDAD` ASC) VISIBLE,
  CONSTRAINT `fk_ESPECIALIDAD_has_Paciente_ESPECIALIDAD1`
    FOREIGN KEY (`ESPECIALIDAD_idESPECIALIDAD`)
    REFERENCES `mydb`.`ESPECIALIDAD` (`idESPECIALIDAD`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ESPECIALIDAD_has_Paciente_Paciente1`
    FOREIGN KEY (`Paciente_idPaciente`)
    REFERENCES `mydb`.`Paciente` (`idPaciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Medico_has_Paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medico_has_Paciente` (
  `Medico_idMedico` INT NOT NULL,
  `Paciente_idPaciente` INT NOT NULL,
  PRIMARY KEY (`Medico_idMedico`, `Paciente_idPaciente`),
  INDEX `fk_Medico_has_Paciente_Paciente1_idx` (`Paciente_idPaciente` ASC) VISIBLE,
  INDEX `fk_Medico_has_Paciente_Medico1_idx` (`Medico_idMedico` ASC) VISIBLE,
  CONSTRAINT `fk_Medico_has_Paciente_Medico1`
    FOREIGN KEY (`Medico_idMedico`)
    REFERENCES `mydb`.`Medico` (`idMedico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Medico_has_Paciente_Paciente1`
    FOREIGN KEY (`Paciente_idPaciente`)
    REFERENCES `mydb`.`Paciente` (`idPaciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
