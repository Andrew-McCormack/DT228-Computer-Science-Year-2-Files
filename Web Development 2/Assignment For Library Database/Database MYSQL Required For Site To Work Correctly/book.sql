-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 31, 2015 at 02:46 AM
-- Server version: 5.6.20
-- PHP Version: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `book`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE IF NOT EXISTS `books` (
  `ISBN` varchar(15) NOT NULL DEFAULT '',
  `bookTitle` varchar(31) NOT NULL,
  `author` varchar(31) NOT NULL,
  `edition` int(2) NOT NULL,
  `year` int(4) NOT NULL,
  `category` int(3) NOT NULL,
  `reserved` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`ISBN`, `bookTitle`, `author`, `edition`, `year`, `category`, `reserved`) VALUES
('093-403992', 'Computers In Business', 'Alica O''Neill', 3, 1997, 3, 'N'),
('23472-8729', 'Exploring Peru', 'Stephanie Birchin', 4, 2005, 5, 'N'),
('237-34823', 'Business Strategy', 'Joe Peppard', 2, 2002, 2, 'N'),
('23u8-923849', 'A Guide To Nutrition', 'John Thorpe', 2, 1997, 1, 'N'),
('2914-487021', 'Ready to Run: Unlocking Your Po', 'Kelly Starrett', 1, 2014, 1, 'N'),
('2954-38938', 'Starting Strength', 'Mark Rippetoe ', 3, 2011, 1, 'N'),
('2983-3494', 'Cooking For Children', 'Anabelle Sharpe', 1, 2003, 7, 'N'),
('82n8-308', 'Computers For Idiots', 'Susan O''Neil', 5, 1998, 4, 'N'),
('9821-46829', 'Becoming a Supple Leopard', 'Kelly Starrett', 1, 2013, 1, 'N'),
('9823-23984', 'My Life In Pictures', 'Kevin Graham', 8, 2004, 1, 'N'),
('9823-2403-0', 'DaVinci Code', 'Dan Brown', 1, 2003, 8, 'N'),
('9823-98345', 'How To Cook Italian Food', 'Jamie Oliver', 2, 2005, 7, 'Y'),
('9823-98487', 'Optimising Your Business', 'Cleo Blair', 1, 2001, 1, 'N'),
('98234-02984', 'My Ranch In Texas', 'George Bush', 1, 2005, 1, 'Y'),
('988745-234', 'Tara Road', 'Maeve Binchy', 4, 2002, 8, 'N'),
('993-00-00', 'My Life In Bits', 'John Smith', 1, 2001, 1, 'N'),
('9942-6346782', 'Strength Training Anatomy', 'Frederic Delavier', 1, 2010, 1, 'N'),
('9983-52911', 'Aging Backwards', 'Miranda Esmonde-White', 1, 2014, 1, 'N'),
('9987-0039882', 'Shooting History', 'Jon Snow', 1, 2003, 1, 'N');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `CategoryId` int(3) NOT NULL,
  `CategoryDescription` varchar(31) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`CategoryId`, `CategoryDescription`) VALUES
(1, 'Health'),
(2, 'Business'),
(3, 'Biography'),
(4, 'Technology'),
(5, 'Travel'),
(6, 'Self-Help'),
(7, 'Cookery'),
(8, 'Fiction');

-- --------------------------------------------------------

--
-- Table structure for table `reservedbooks`
--

CREATE TABLE IF NOT EXISTS `reservedbooks` (
  `ISBN` varchar(15) NOT NULL,
  `userName` varchar(21) NOT NULL,
  `reservedDate` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reservedbooks`
--

INSERT INTO `reservedbooks` (`ISBN`, `userName`, `reservedDate`) VALUES
('9823-98345', 'tommy100', '24/11/2014'),
('98234-02984', 'joecrotty', '24/11/2014');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `userName` varchar(21) NOT NULL,
  `password` varchar(6) DEFAULT NULL,
  `firstName` varchar(11) NOT NULL,
  `surName` varchar(21) NOT NULL,
  `addressLine1` varchar(21) NOT NULL,
  `addressLine2` varchar(21) NOT NULL,
  `city` varchar(11) NOT NULL,
  `telephone` int(11) NOT NULL,
  `mobile` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userName`, `password`, `firstName`, `surName`, `addressLine1`, `addressLine2`, `city`, `telephone`, `mobile`) VALUES
('alanmckenna', 't1234s', 'Alan', 'McKenna', '38 Cranley Road', 'Fairview', 'Dublin', 9998377, 856625567),
('Andrew', 'Hitman', 'Andrew', 'McCormack', '45 Hillside', 'Greystones', 'Wicklow', 12876818, 863117458),
('joecrotty', 'kj7899', 'Joseph', 'Crotty', 'Apt. 5 Clyde Road', 'Donnybrook', 'Dublin', 8887889, 876654456),
('John', 'hello1', 'John', 'O''Shay', 'Greystones', 'Wicklow', 'Wicklow', 12367645, 864233576),
('tommy100', '123456', 'tom', 'behan', '14 hyde road', 'dalkey', 'dublin', 9983747, 876738782);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
 ADD PRIMARY KEY (`ISBN`), ADD KEY `category` (`category`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
 ADD PRIMARY KEY (`CategoryId`);

--
-- Indexes for table `reservedbooks`
--
ALTER TABLE `reservedbooks`
 ADD PRIMARY KEY (`ISBN`,`userName`), ADD KEY `fk_users_reservedBooks_userName` (`userName`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`userName`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `reservedbooks`
--
ALTER TABLE `reservedbooks`
ADD CONSTRAINT `fk_books_reservedBooks_ISBN` FOREIGN KEY (`ISBN`) REFERENCES `books` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_users_reservedBooks_userName` FOREIGN KEY (`userName`) REFERENCES `users` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
