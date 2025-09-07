-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.37 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para agenda
CREATE DATABASE IF NOT EXISTS `agenda` /*!40100 DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `agenda`;

-- Volcando estructura para tabla agenda.auditoria
CREATE TABLE IF NOT EXISTS `auditoria` (
  `id_auditoria` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `accion` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `tabla_afectada` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `registro_afectado` int DEFAULT NULL,
  `descripcion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `realizado_el` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_auditoria`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `auditoria_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Volcando datos para la tabla agenda.auditoria: ~0 rows (aproximadamente)

-- Volcando estructura para tabla agenda.permisos
CREATE TABLE IF NOT EXISTS `permisos` (
  `id_permiso` int NOT NULL AUTO_INCREMENT,
  `nombre_permiso` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `creado_el` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_el` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_permiso`),
  UNIQUE KEY `nombre_permiso` (`nombre_permiso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Volcando datos para la tabla agenda.permisos: ~0 rows (aproximadamente)

-- Volcando estructura para tabla agenda.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `creado_el` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_el` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `nombre_rol` (`nombre_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Volcando datos para la tabla agenda.roles: ~0 rows (aproximadamente)

-- Volcando estructura para tabla agenda.rol_permiso
CREATE TABLE IF NOT EXISTS `rol_permiso` (
  `id_rol` int NOT NULL,
  `id_permiso` int NOT NULL,
  `asignado_el` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_rol`,`id_permiso`),
  KEY `id_permiso` (`id_permiso`),
  CONSTRAINT `rol_permiso_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`),
  CONSTRAINT `rol_permiso_ibfk_2` FOREIGN KEY (`id_permiso`) REFERENCES `permisos` (`id_permiso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Volcando datos para la tabla agenda.rol_permiso: ~0 rows (aproximadamente)

-- Volcando estructura para tabla agenda.sesiones
CREATE TABLE IF NOT EXISTS `sesiones` (
  `id_sesion` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `inicio` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fin` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_sesion`),
  UNIQUE KEY `token` (`token`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `sesiones_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Volcando datos para la tabla agenda.sesiones: ~3 rows (aproximadamente)
INSERT INTO `sesiones` (`id_sesion`, `id_usuario`, `token`, `ip_address`, `inicio`, `fin`) VALUES
	(7, 34, '5ef778b635f65814d12462390129323f71de93e5131329fe9b3d4e58b0533b78', NULL, '2025-07-23 00:10:21', NULL),
	(8, 35, '86fbd90c6cc5c316e2120f8a8fd7baaded4f8537b31aefe58a17965d799b3a63', NULL, '2025-07-23 01:22:03', NULL),
	(9, 34, '5994b857754779bd44ad1be4d0f25b1121b8f86a9d21e437e8eee782e03f7498', NULL, '2025-08-21 22:10:09', NULL);

-- Volcando estructura para tabla agenda.tareas
CREATE TABLE IF NOT EXISTS `tareas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(200) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `descripcion` varchar(200) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `prioridad` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Volcando datos para la tabla agenda.tareas: ~8 rows (aproximadamente)
INSERT INTO `tareas` (`id`, `titulo`, `descripcion`, `prioridad`) VALUES
	(3, 'Hacer ejercicio', 'Correr 5km en la mañana', 2),
	(4, 'Lavar el auto', 'Lavar y aspirar el auto los domingos', 2),
	(6, 'Lavar la motociceta', 'Lavar y aspirar la motociceta los viernes', 3),
	(7, 'Lavar la motociceta', 'Lavar y aspirar la motociceta los viernes', 3),
	(14, 'Lectura de libros de Programación', 'Avance en formación en Programación, C++', 2),
	(15, 'Grado Henry', 'Documentación', 1),
	(16, 'Maestría', 'Gestionar Grado', 1),
	(17, 'Grado', 'ADSO', 1);

-- Volcando estructura para tabla agenda.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `contrasena` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `creado_el` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_el` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Volcando datos para la tabla agenda.usuarios: ~2 rows (aproximadamente)
INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `email`, `contrasena`, `activo`, `creado_el`, `actualizado_el`) VALUES
	(34, 'Henry', 'hg@gmail.com', '$2y$10$uafnNvFD3sGZvAecT17qneI2RhNn2iSa7SFSvTnPtzi3lSlG5nJ5O', 1, '2025-07-23 00:10:03', '2025-07-23 00:10:03'),
	(35, 'euclides', 'euclides@gmail.com', '$2y$10$qswL1EWacOwXdV14cXnYi.xLqMmITW3e2SPk0hSoJlwYjKNariJiy', 1, '2025-07-23 01:21:11', '2025-07-23 01:21:11');

-- Volcando estructura para tabla agenda.usuario_rol
CREATE TABLE IF NOT EXISTS `usuario_rol` (
  `id_usuario` int NOT NULL,
  `id_rol` int NOT NULL,
  `asignado_el` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_usuario`,`id_rol`),
  KEY `id_rol` (`id_rol`),
  CONSTRAINT `usuario_rol_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `usuario_rol_ibfk_2` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Volcando datos para la tabla agenda.usuario_rol: ~0 rows (aproximadamente)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
