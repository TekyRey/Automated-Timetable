-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 22, 2021 at 03:23 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mmustable`
--

-- --------------------------------------------------------

--
-- Table structure for table `Course`
--

CREATE TABLE `Course` (
  `courseId` int(11) NOT NULL,
  `groupSize` int(11) NOT NULL,
  `moduleIds` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Course`
--

INSERT INTO `Course` (`courseId`, `groupSize`, `moduleIds`) VALUES
(1, 70, 1),
(1, 70, 3),
(1, 70, 4),
(2, 300, 2),
(2, 300, 3),
(2, 300, 5),
(3, 150, 3),
(3, 150, 4),
(3, 150, 5),
(4, 100, 1),
(4, 100, 4),
(5, 50, 2),
(5, 50, 3),
(5, 50, 5),
(6, 75, 1),
(6, 75, 4),
(6, 75, 5),
(7, 86, 1),
(7, 86, 3),
(8, 43, 2),
(8, 43, 5),
(9, 35, 1),
(9, 35, 5),
(10, 63, 3),
(10, 63, 4);

-- --------------------------------------------------------

--
-- Table structure for table `Module`
--

CREATE TABLE `Module` (
  `moduleId` int(11) NOT NULL,
  `moduleCode` varchar(255) NOT NULL,
  `module` varchar(255) NOT NULL,
  `professorIds` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Module`
--

INSERT INTO `Module` (`moduleId`, `moduleCode`, `module`, `professorIds`) VALUES
(1, 'BIT213', 'Database Administration', 1),
(1, 'BIT213', 'Database Administration', 4),
(2, 'BIT312', 'Java Programming', 4),
(2, 'BIT312', 'Java Programming', 5),
(3, 'BIT324', 'Digital Electronics', 2),
(3, 'BIT324', 'Digital Electronics', 4),
(4, 'BCS323', 'Computer Security', 1),
(4, 'BCS323', 'Computer Security', 2),
(4, 'BCS323', 'Computer Security', 5),
(5, 'BCS322', 'Linear Programming', 1),
(5, 'BCS322', 'Linear Programming', 2),
(5, 'BCS322', 'Linear Programming', 3),
(6, 'BIT320', 'System Administration', 6),
(6, 'BIT320', 'System Administration', 7),
(6, 'BIT320', 'System Administration', 9),
(7, 'BIT321', 'Data Warehousing', 6),
(7, 'BIT321', 'Data Warehousing', 7),
(7, 'BIT321', 'Data Warehousing', 8),
(8, 'BIT330', 'Multimedia Technologies', 7),
(8, 'BIT330', 'Multimedia Technologies', 9),
(8, 'BIT330', 'Multimedia Technologies', 10),
(9, 'BIT328', 'Integrative Programming', 1),
(9, 'BIT328', 'Integrative Programming', 10);

-- --------------------------------------------------------

--
-- Table structure for table `Professor`
--

CREATE TABLE `Professor` (
  `professorId` int(11) NOT NULL,
  `professorName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Professor`
--

INSERT INTO `Professor` (`professorId`, `professorName`) VALUES
(1, 'Mr Matoke'),
(2, 'Dr Ondulo'),
(3, 'Dr Odoyo'),
(4, 'Dr Angulu'),
(5, 'Dr Rambim'),
(6, 'Mr Kadima'),
(7, 'Mr Charles'),
(8, 'Mrs Rono'),
(9, 'Dr Kiget'),
(10, 'Mr Tobias');

-- --------------------------------------------------------

--
-- Table structure for table `Room`
--

CREATE TABLE `Room` (
  `roomId` int(11) NOT NULL,
  `roomNumber` varchar(255) NOT NULL,
  `capacity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Room`
--

INSERT INTO `Room` (`roomId`, `roomNumber`, `capacity`) VALUES
(1, 'MPH', 450),
(2, 'ECA004', 70),
(4, 'MEA', 100),
(5, 'SPD', 100),
(6, 'ECA Basement', 300),
(7, 'ECA101', 60),
(8, 'ECA003', 70),
(9, 'ECA202', 70),
(10, 'MED003', 70);

-- --------------------------------------------------------

--
-- Table structure for table `Timeslot`
--

CREATE TABLE `Timeslot` (
  `timeslotId` int(11) NOT NULL,
  `timestlot` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Timeslot`
--

INSERT INTO `Timeslot` (`timeslotId`, `timestlot`) VALUES
(1, 'Mon 8:00 - 11:00'),
(3, 'Mon 11:00 - 13:00'),
(4, 'Mon 13:00 - 15:00'),
(5, 'Tue 9:00 - 11:00'),
(6, 'Tue 11:00 - 13:00'),
(7, 'Tue 13:00 - 15:00'),
(8, 'Wed 9:00 - 11:00'),
(9, 'Wed 11:00 - 13:00'),
(10, 'Wed 13:00 - 15:00'),
(11, 'Thur 9:00 - 11:00'),
(12, 'Thur 11:00 - 13:00'),
(13, 'Thur 13:00 - 15:00'),
(14, 'Fri 9:00 - 11:00'),
(15, 'Fri 11:00 - 13:00'),
(16, 'Fri 13:00 - 15:00');

-- --------------------------------------------------------

--
-- Table structure for table `Timetabel`
--

CREATE TABLE `Timetabel` (
  `timetableId` int(11) NOT NULL,
  `courseId` int(11) NOT NULL,
  `moduleId` int(11) NOT NULL,
  `professorId` int(11) NOT NULL,
  `timeslotId` int(11) NOT NULL,
  `roomId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Course`
--
ALTER TABLE `Course`
  ADD PRIMARY KEY (`courseId`,`moduleIds`),
  ADD KEY `moduleIds` (`moduleIds`);

--
-- Indexes for table `Module`
--
ALTER TABLE `Module`
  ADD PRIMARY KEY (`moduleId`,`professorIds`),
  ADD KEY `professorIds` (`professorIds`);

--
-- Indexes for table `Professor`
--
ALTER TABLE `Professor`
  ADD PRIMARY KEY (`professorId`);

--
-- Indexes for table `Room`
--
ALTER TABLE `Room`
  ADD PRIMARY KEY (`roomId`);

--
-- Indexes for table `Timeslot`
--
ALTER TABLE `Timeslot`
  ADD PRIMARY KEY (`timeslotId`);

--
-- Indexes for table `Timetabel`
--
ALTER TABLE `Timetabel`
  ADD PRIMARY KEY (`timetableId`),
  ADD KEY `Timetabel_ibfk_1` (`courseId`),
  ADD KEY `moduleId` (`moduleId`),
  ADD KEY `professorId` (`professorId`),
  ADD KEY `roomId` (`roomId`),
  ADD KEY `timeslotId` (`timeslotId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Professor`
--
ALTER TABLE `Professor`
  MODIFY `professorId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `Timeslot`
--
ALTER TABLE `Timeslot`
  MODIFY `timeslotId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `Timetabel`
--
ALTER TABLE `Timetabel`
  MODIFY `timetableId` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Course`
--
ALTER TABLE `Course`
  ADD CONSTRAINT `Course_ibfk_1` FOREIGN KEY (`moduleIds`) REFERENCES `Module` (`moduleId`) ON UPDATE CASCADE;

--
-- Constraints for table `Module`
--
ALTER TABLE `Module`
  ADD CONSTRAINT `Module_ibfk_1` FOREIGN KEY (`professorIds`) REFERENCES `Professor` (`professorId`) ON UPDATE CASCADE;

--
-- Constraints for table `Timetabel`
--
ALTER TABLE `Timetabel`
  ADD CONSTRAINT `Timetabel_ibfk_1` FOREIGN KEY (`courseId`) REFERENCES `Course` (`courseId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Timetabel_ibfk_2` FOREIGN KEY (`moduleId`) REFERENCES `Module` (`moduleId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Timetabel_ibfk_3` FOREIGN KEY (`professorId`) REFERENCES `Professor` (`professorId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Timetabel_ibfk_4` FOREIGN KEY (`roomId`) REFERENCES `Room` (`roomId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Timetabel_ibfk_5` FOREIGN KEY (`timeslotId`) REFERENCES `Timeslot` (`timeslotId`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
