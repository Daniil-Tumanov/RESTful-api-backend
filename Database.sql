-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               5.6.41 - MySQL Community Server (GPL)
-- Операционная система:         Win32
-- HeidiSQL Версия:              9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Дамп структуры для таблица rest.dishes
CREATE TABLE IF NOT EXISTS `dishes` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `datatime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `description` varchar(500) NOT NULL,
  `composition` varchar(500) NOT NULL,
  `cost` int(11) NOT NULL,
  `tags` varchar(200) DEFAULT NULL,
  `img` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы rest.dishes: ~6 rows (приблизительно)
/*!40000 ALTER TABLE `dishes` DISABLE KEYS */;
INSERT INTO `dishes` (`ID`, `title`, `datatime`, `description`, `composition`, `cost`, `tags`, `img`) VALUES
	(1, 'Carbonara', '2020-09-24 22:32:37', 'Spaghetti Carbonara is the most famous traditional Italian pasta in the world. Carbonara is a delicate cheese and egg sauce that envelops the pasta, mixed with juicy, toasted bacon. All this is sprinkled with parmesan cheese and black pepper', 'spaghetti, bacon, cream, parmesan cheese,\negg yolk', 230, 'spaghetti, pasta, carbonara, makarons, italy, hot dish', 'carbonara.jpg'),
	(2, 'Caesar', '2020-09-24 22:52:58', 'Caesar is a vegetable salad. A popular American dish.', 'Green salad, Tomatoes, Chicken fillet, White bread, Sauce, Butter, Garlic, Parmesan cheese', 170, 'caesar, salad, vegetable, america, chicken', 'caesar.jpg'),
	(3, 'Borsch', '2020-09-24 23:03:43', 'Borsch is a traditional East Slavic dish prepared with beets, which gives it its characteristic rich color.', 'Pork, beef, Carrots, Beets, White cabbage, Sour cream', 180, 'borsch, soup, beet, Russia', 'borsch.jpg'),
	(4, 'Cream soup', '2020-09-24 23:27:51', 'Cream soup is a delicious first course with a pleasant texture. When properly cooked, it has a rich, creamy flavor and a silky smooth texture.', 'Processed cheese, Potatoes, Onions, Carrots, Cream, Butter, Hard cheese (Dutch)', 209, 'cream, soup, cheese, vegetable', 'cream-soup.jpg'),
	(5, 'Mashed potatoes with a cutlet', '2020-09-25 00:00:19', 'Mashed potatoes. A common way of cooking potatoes all over the world.', 'potatoes, beef, pork, white bread, milk', 150, 'potatoes, cutlet, Russia, hot dish', 'chop.jpg');
/*!40000 ALTER TABLE `dishes` ENABLE KEYS */;

-- Дамп структуры базы данных rest
CREATE DATABASE IF NOT EXISTS `rest` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `rest`;

-- Дамп структуры для таблица rest.comments
CREATE TABLE IF NOT EXISTS `comments` (
  `ID_comment` int(11) NOT NULL AUTO_INCREMENT,
  `datatime` datetime DEFAULT CURRENT_TIMESTAMP,
  `author` varchar(50) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `id` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_comment`),
  KEY `FK_comments_dishes` (`id`),
  CONSTRAINT `FK_comments_dishes` FOREIGN KEY (`id`) REFERENCES `dishes` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы rest.comments: ~6 rows (приблизительно)
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` (`ID_comment`, `datatime`, `author`, `comment`, `id`) VALUES
	(1, '2020-09-30 14:01:59', 'Daniil Tumanov', 'Norm', 1),
	(2, '2020-09-30 14:02:30', 'Mikhail Solyanoy', 'Cool', 1),
	(3, '2020-09-30 14:05:25', 'Islam Kuvandykov', 'Это вкусно, но не то чтобы по вкусу вкусно, но по сути вкусно', 3),
	(4, '2020-09-30 14:05:51', 'Daniil Tumanov', 'Very tasty', 3),
	(5, '2020-09-30 14:14:35', 'Ivan Ivanovich', 'The most common mashed potatoes with a cutlet, nothing unusual', 5),
	(6, '2020-09-30 14:16:05', 'Mizrobhon', 'Норм, но плов лучше', 5);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
