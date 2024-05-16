-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: sistema_coude
-- ------------------------------------------------------
-- Server version	5.5.5-10.1.38-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cursos`
--

DROP TABLE IF EXISTS `cursos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cursos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `situacao` enum('ATIVO','INATIVO') DEFAULT 'ATIVO',
  `visibilidade` tinyint(1) DEFAULT '1',
  `data_criacao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_edicao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cursos`
--

LOCK TABLES `cursos` WRITE;
/*!40000 ALTER TABLE `cursos` DISABLE KEYS */;
/*!40000 ALTER TABLE `cursos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fk_usuarios_polos`
--

DROP TABLE IF EXISTS `fk_usuarios_polos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fk_usuarios_polos` (
  `id_usuario` int(11) DEFAULT NULL,
  `id_polo` int(11) DEFAULT NULL,
  KEY `id_usuario` (`id_usuario`),
  KEY `id_polo` (`id_polo`),
  CONSTRAINT `fk_usuarios_polos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_usuarios_polos_ibfk_2` FOREIGN KEY (`id_polo`) REFERENCES `polos` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fk_usuarios_polos`
--

LOCK TABLES `fk_usuarios_polos` WRITE;
/*!40000 ALTER TABLE `fk_usuarios_polos` DISABLE KEYS */;
/*!40000 ALTER TABLE `fk_usuarios_polos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fk_usuarios_tipos_usuarios`
--

DROP TABLE IF EXISTS `fk_usuarios_tipos_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fk_usuarios_tipos_usuarios` (
  `id_usuario` int(11) DEFAULT NULL,
  `id_tipos_usuarios` int(11) DEFAULT NULL,
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `fk_usuarios_tipos_usuarios_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_usuarios_tipos_usuarios_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fk_usuarios_tipos_usuarios`
--

LOCK TABLES `fk_usuarios_tipos_usuarios` WRITE;
/*!40000 ALTER TABLE `fk_usuarios_tipos_usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `fk_usuarios_tipos_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fk_usuarios_turmas`
--

DROP TABLE IF EXISTS `fk_usuarios_turmas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fk_usuarios_turmas` (
  `id_turma` int(11) DEFAULT NULL,
  `id_professor` int(11) DEFAULT NULL,
  `id_monitor` int(11) DEFAULT NULL,
  `id_aluno` int(11) DEFAULT NULL,
  KEY `id_turma` (`id_turma`),
  KEY `id_professor` (`id_professor`),
  KEY `id_monitor` (`id_monitor`),
  KEY `id_aluno` (`id_aluno`),
  CONSTRAINT `fk_usuarios_turmas_ibfk_1` FOREIGN KEY (`id_turma`) REFERENCES `turmas` (`id`),
  CONSTRAINT `fk_usuarios_turmas_ibfk_2` FOREIGN KEY (`id_professor`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `fk_usuarios_turmas_ibfk_3` FOREIGN KEY (`id_monitor`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `fk_usuarios_turmas_ibfk_4` FOREIGN KEY (`id_aluno`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fk_usuarios_turmas`
--

LOCK TABLES `fk_usuarios_turmas` WRITE;
/*!40000 ALTER TABLE `fk_usuarios_turmas` DISABLE KEYS */;
/*!40000 ALTER TABLE `fk_usuarios_turmas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fk_usuarios_unidades`
--

DROP TABLE IF EXISTS `fk_usuarios_unidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fk_usuarios_unidades` (
  `id_usuario` int(11) DEFAULT NULL,
  `id_unidades` int(11) DEFAULT NULL,
  KEY `id_usuario` (`id_usuario`),
  KEY `id_unidades` (`id_unidades`),
  CONSTRAINT `fk_usuarios_unidades_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_usuarios_unidades_ibfk_2` FOREIGN KEY (`id_unidades`) REFERENCES `unidades` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fk_usuarios_unidades`
--

LOCK TABLES `fk_usuarios_unidades` WRITE;
/*!40000 ALTER TABLE `fk_usuarios_unidades` DISABLE KEYS */;
/*!40000 ALTER TABLE `fk_usuarios_unidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `polos`
--

DROP TABLE IF EXISTS `polos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `polos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `situacao` enum('ATIVO','INATIVO') DEFAULT 'ATIVO',
  `visibilidade` tinyint(1) DEFAULT '1',
  `data_criacao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_edicao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `polos`
--

LOCK TABLES `polos` WRITE;
/*!40000 ALTER TABLE `polos` DISABLE KEYS */;
/*!40000 ALTER TABLE `polos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salas`
--

DROP TABLE IF EXISTS `salas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `id_unidade` int(11) DEFAULT NULL,
  `situacao` enum('ATIVO','INATIVO') DEFAULT 'ATIVO',
  `visibilidade` tinyint(1) DEFAULT '1',
  `data_criacao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_edicao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_unidade` (`id_unidade`),
  CONSTRAINT `salas_ibfk_1` FOREIGN KEY (`id_unidade`) REFERENCES `unidades` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salas`
--

LOCK TABLES `salas` WRITE;
/*!40000 ALTER TABLE `salas` DISABLE KEYS */;
/*!40000 ALTER TABLE `salas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_usuarios`
--

DROP TABLE IF EXISTS `tipos_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` enum('USER_MASTER','MASTER_POLO','ADM_POLO','MASTER_UNIDADE','ADM_UNIDADE','PROFESSOR','MODERADOR','ALUNO') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_usuarios`
--

LOCK TABLES `tipos_usuarios` WRITE;
/*!40000 ALTER TABLE `tipos_usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipos_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turmas`
--

DROP TABLE IF EXISTS `turmas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turmas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `id_sala` int(11) DEFAULT NULL,
  `id_curso` int(11) DEFAULT NULL,
  `situacao` enum('ATIVO','INATIVO') DEFAULT 'ATIVO',
  `visibilidade` tinyint(1) DEFAULT '1',
  `data_criacao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_edicao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_sala` (`id_sala`),
  KEY `id_curso` (`id_curso`),
  CONSTRAINT `turmas_ibfk_1` FOREIGN KEY (`id_sala`) REFERENCES `salas` (`id`),
  CONSTRAINT `turmas_ibfk_2` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turmas`
--

LOCK TABLES `turmas` WRITE;
/*!40000 ALTER TABLE `turmas` DISABLE KEYS */;
/*!40000 ALTER TABLE `turmas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidades`
--

DROP TABLE IF EXISTS `unidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unidades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `endereco` varchar(255) DEFAULT NULL,
  `id_polo` int(11) DEFAULT NULL,
  `situacao` enum('ATIVO','INATIVO') DEFAULT 'ATIVO',
  `visibilidade` tinyint(1) DEFAULT '1',
  `data_criacao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_edicao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_polo` (`id_polo`),
  CONSTRAINT `unidades_ibfk_1` FOREIGN KEY (`id_polo`) REFERENCES `polos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidades`
--

LOCK TABLES `unidades` WRITE;
/*!40000 ALTER TABLE `unidades` DISABLE KEYS */;
/*!40000 ALTER TABLE `unidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `cpf` varchar(20) NOT NULL,
  `endereço` varchar(255) DEFAULT NULL,
  `situacao` enum('ATIVO','INATIVO') DEFAULT 'ATIVO',
  `visibilidade` tinyint(1) DEFAULT '1',
  `data_criacao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_edicao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `cpf` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'nome','teste','123','',NULL,'ATIVO',1,'2024-05-16 17:08:08','2024-05-16 17:08:08');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-16 14:20:07
