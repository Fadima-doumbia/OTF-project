-- MySQL Script generated by MySQL Workbench
-- Sat Jun 26 15:09:05 2021
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
-- Table `mydb`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `prenom` VARCHAR(245) GENERATED ALWAYS AS () VIRTUAL,
  `nom` VARCHAR(245) NOT NULL,
  `telephone` INT NOT NULL,
  `email` VARCHAR(145) NOT NULL,
  `password` VARCHAR(145) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`roles_has_User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`roles_has_User` (
  `roles_id` INT NOT NULL,
  `User_id` INT NOT NULL,
  PRIMARY KEY (`roles_id`, `User_id`),
  CONSTRAINT `fk_roles_has_User_roles`
    FOREIGN KEY (`roles_id`)
    REFERENCES `mydb`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_roles_has_User_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `mydb`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_roles_has_User_User1_idx` ON `mydb`.`roles_has_User` (`User_id` ASC) VISIBLE;

CREATE INDEX `fk_roles_has_User_roles_idx` ON `mydb`.`roles_has_User` (`roles_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`profil_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`profil_user` (
  `idprofil_user` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(145) NOT NULL,
  PRIMARY KEY (`idprofil_user`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`role` (
  `roles` ENUM("admin", "utilisateur") NOT NULL,
  PRIMARY KEY (`roles`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `iduser` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(100) NOT NULL,
  `prenom` VARCHAR(145) NOT NULL,
  `email` VARCHAR(145) NOT NULL,
  `telephone` VARCHAR(145) NOT NULL,
  `mot-de-passe` VARCHAR(245) NOT NULL,
  `profil_user_idprofil_user` INT NOT NULL,
  `role_roles` ENUM("admin", "utilisateur") NOT NULL,
  `civilites` ENUM("mr", "mme", "autre") NOT NULL,
  `pays` VARCHAR(55) NOT NULL,
  PRIMARY KEY (`iduser`, `role_roles`),
  CONSTRAINT `fk_user_profil_user1`
    FOREIGN KEY (`profil_user_idprofil_user`)
    REFERENCES `mydb`.`profil_user` (`idprofil_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_role1`
    FOREIGN KEY (`role_roles`)
    REFERENCES `mydb`.`role` (`roles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_user_profil_user1_idx` ON `mydb`.`user` (`profil_user_idprofil_user` ASC) VISIBLE;

CREATE INDEX `fk_user_role1_idx` ON `mydb`.`user` (`role_roles` ASC) VISIBLE;

CREATE UNIQUE INDEX `role_roles_UNIQUE` ON `mydb`.`user` (`role_roles` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`medias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`medias` (
  `idmedias` INT NOT NULL AUTO_INCREMENT,
  `chemin` VARCHAR(255) NOT NULL,
  `types` ENUM("image", "video") NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`idmedias`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`historique`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`historique` (
  `idhistorique` INT NOT NULL AUTO_INCREMENT,
  `status` ENUM("Terminé", "Abandonné") NOT NULL,
  `date` DATETIME NOT NULL,
  PRIMARY KEY (`idhistorique`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`projet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`projet` (
  `idprojet` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(145) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `date_debut` DATETIME NOT NULL,
  `user_iduser` INT NOT NULL,
  `historique_idhistorique` INT NOT NULL,
  PRIMARY KEY (`idprojet`),
  CONSTRAINT `fk_projet_user1`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `mydb`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projet_historique1`
    FOREIGN KEY (`historique_idhistorique`)
    REFERENCES `mydb`.`historique` (`idhistorique`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_projet_user1_idx` ON `mydb`.`projet` (`user_iduser` ASC) VISIBLE;

CREATE INDEX `fk_projet_historique1_idx` ON `mydb`.`projet` (`historique_idhistorique` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`secteur_activite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`secteur_activite` (
  `idsecteur_activité` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(245) NOT NULL,
  PRIMARY KEY (`idsecteur_activité`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`follow`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`follow` (
  `idfollow` INT NOT NULL AUTO_INCREMENT,
  `nom_suivi` VARCHAR(45) NOT NULL,
  `nom_suiveur` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idfollow`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user_medias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user_medias` (
  `user_iduser` INT NOT NULL,
  `medias_idmedias` INT NOT NULL,
  PRIMARY KEY (`user_iduser`, `medias_idmedias`),
  CONSTRAINT `fk_user_has_medias_user1`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `mydb`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_medias_medias1`
    FOREIGN KEY (`medias_idmedias`)
    REFERENCES `mydb`.`medias` (`idmedias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_user_has_medias_medias1_idx` ON `mydb`.`user_medias` (`medias_idmedias` ASC) VISIBLE;

CREATE INDEX `fk_user_has_medias_user1_idx` ON `mydb`.`user_medias` (`user_iduser` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`projet_secteur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`projet_secteur` (
  `projet_idprojet` INT NOT NULL,
  `secteur_activité_idsecteur_activité` INT NOT NULL,
  PRIMARY KEY (`projet_idprojet`, `secteur_activité_idsecteur_activité`),
  CONSTRAINT `fk_projet_has_secteur_activité_projet1`
    FOREIGN KEY (`projet_idprojet`)
    REFERENCES `mydb`.`projet` (`idprojet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projet_has_secteur_activité_secteur_activité1`
    FOREIGN KEY (`secteur_activité_idsecteur_activité`)
    REFERENCES `mydb`.`secteur_activite` (`idsecteur_activité`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_projet_has_secteur_activité_secteur_activité1_idx` ON `mydb`.`projet_secteur` (`secteur_activité_idsecteur_activité` ASC) VISIBLE;

CREATE INDEX `fk_projet_has_secteur_activité_projet1_idx` ON `mydb`.`projet_secteur` (`projet_idprojet` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`user_follow`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user_follow` (
  `user_iduser` INT NOT NULL,
  `follow_idfollow` INT NOT NULL,
  PRIMARY KEY (`user_iduser`, `follow_idfollow`),
  CONSTRAINT `fk_user_has_follow_user1`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `mydb`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_follow_follow1`
    FOREIGN KEY (`follow_idfollow`)
    REFERENCES `mydb`.`follow` (`idfollow`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_user_has_follow_follow1_idx` ON `mydb`.`user_follow` (`follow_idfollow` ASC) VISIBLE;

CREATE INDEX `fk_user_has_follow_user1_idx` ON `mydb`.`user_follow` (`user_iduser` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`post` (
  `idpost` INT NOT NULL AUTO_INCREMENT,
  `contenu` LONGTEXT NULL,
  `user_iduser` INT NOT NULL,
  PRIMARY KEY (`idpost`, `user_iduser`),
  CONSTRAINT `fk_post_user1`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `mydb`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_post_user1_idx` ON `mydb`.`post` (`user_iduser` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`medias_post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`medias_post` (
  `medias_idmedias` INT NOT NULL,
  `post_idpost` INT NOT NULL,
  PRIMARY KEY (`medias_idmedias`, `post_idpost`),
  CONSTRAINT `fk_medias_has_post_medias1`
    FOREIGN KEY (`medias_idmedias`)
    REFERENCES `mydb`.`medias` (`idmedias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medias_has_post_post1`
    FOREIGN KEY (`post_idpost`)
    REFERENCES `mydb`.`post` (`idpost`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_medias_has_post_post1_idx` ON `mydb`.`medias_post` (`post_idpost` ASC) VISIBLE;

CREATE INDEX `fk_medias_has_post_medias1_idx` ON `mydb`.`medias_post` (`medias_idmedias` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`commentaire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`commentaire` (
  `idcommentaire` INT NOT NULL AUTO_INCREMENT,
  `contenu` MEDIUMTEXT NOT NULL,
  `pseudo` VARCHAR(45) NOT NULL,
  `date` DATETIME NOT NULL,
  `post_idpost` INT NOT NULL,
  `post_user_iduser` INT NOT NULL,
  `user_iduser` INT NOT NULL,
  PRIMARY KEY (`idcommentaire`, `post_idpost`, `post_user_iduser`, `user_iduser`),
  CONSTRAINT `fk_commentaire_post1`
    FOREIGN KEY (`post_idpost` , `post_user_iduser`)
    REFERENCES `mydb`.`post` (`idpost` , `user_iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_commentaire_user1`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `mydb`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_commentaire_post1_idx` ON `mydb`.`commentaire` (`post_idpost` ASC, `post_user_iduser` ASC) VISIBLE;

CREATE INDEX `fk_commentaire_user1_idx` ON `mydb`.`commentaire` (`user_iduser` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`message` (
  `idmessage` INT NOT NULL AUTO_INCREMENT,
  `contenu` LONGTEXT NOT NULL,
  `pseudo` VARCHAR(145) NOT NULL,
  `date` DATETIME NOT NULL,
  `user_iduser` INT NOT NULL,
  PRIMARY KEY (`idmessage`, `user_iduser`),
  CONSTRAINT `fk_message_user1`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `mydb`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
