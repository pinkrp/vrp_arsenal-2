-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.3.16-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Copiando estrutura do banco de dados para creative
CREATE DATABASE IF NOT EXISTS `creative` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `creative`;

-- Copiando estrutura para tabela creative.skd_arsenal
CREATE TABLE IF NOT EXISTS `skd_arsenal` (
  `weapon` varchar(30) NOT NULL,
  `qtd` int(11) NOT NULL,
  `type` varchar(4) NOT NULL,
  `price` int(11) NOT NULL,
  UNIQUE KEY `WEAPON` (`weapon`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Copiando dados para a tabela creative.skd_arsenal: ~12 rows (aproximadamente)
/*!40000 ALTER TABLE `skd_arsenal` DISABLE KEYS */;
INSERT INTO `skd_arsenal` (`weapon`, `qtd`, `type`, `price`) VALUES
	('fiveseven', 20, 'SEMI', 10000),
	('m-fiveseven', 1250, 'AMMO', 2),
	('m-m416', 1000, 'AMMO', 5),
	('m-m4a1', 1000, 'AMMO', 5),
	('m-mp5', 1250, 'AMMO', 3),
	('m-sigsauer', 900, 'AMMO', 3),
	('m-spas12', 420, 'AMMO', 3),
	('m416', 10, 'AUTO', 50000),
	('m4a1', 10, 'AUTO', 50000),
	('mp5', 15, 'AUTO', 30000),
	('sigsauer', 5, 'AUTO', 30000),
	('spas12', 5, 'SEMI', 20000);
/*!40000 ALTER TABLE `skd_arsenal` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
