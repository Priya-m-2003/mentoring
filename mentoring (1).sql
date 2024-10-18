-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 11, 2024 at 09:21 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mentoring`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `adminid` varchar(200) NOT NULL,
  `name` varchar(200) NOT NULL,
  `password` varchar(400) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`adminid`, `name`, `password`) VALUES
('01', 'Akhila', 'mit@123'),
('02', 'Priya', 'mit@123');

-- --------------------------------------------------------

--
-- Table structure for table `hod`
--

CREATE TABLE `hod` (
  `HOD_ID` bigint(100) NOT NULL,
  `NAME` varchar(250) NOT NULL,
  `PASSWORD` varchar(290) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hod`
--

INSERT INTO `hod` (`HOD_ID`, `NAME`, `PASSWORD`) VALUES
(2, 'sharathkumar', '123');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `usn` varchar(100) NOT NULL,
  `name` varchar(109) NOT NULL,
  `address` varchar(300) NOT NULL,
  `branch` varchar(167) NOT NULL,
  `semester` varchar(123) NOT NULL,
  `teacher_id` varchar(400) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`usn`, `name`, `address`, `branch`, `semester`, `teacher_id`) VALUES
('4mh21is001', 'priya m', 'mysore', 'IS', '5', '01'),
('4mh21is067', 'raghva', 'hassan', 'is', '5', '03'),
('4mh21is095', 'shree', '', 'IS', '2', '01'),
('4mh21is098', 'aishu', 'mysore', 'is', '5', '04'),
('4MH21MC011', 'CHANDRA R', 'MYSORE', 'IS', '2', '01');

-- --------------------------------------------------------

--
-- Table structure for table `student_data`
--

CREATE TABLE `student_data` (
  `usn` varchar(400) NOT NULL,
  `IA_marks1` bigint(20) NOT NULL,
  `IA_marks2` bigint(20) NOT NULL,
  `IA_marks3` bigint(20) NOT NULL,
  `semester_percentage` float NOT NULL,
  `cocurricular_activity` varchar(400) NOT NULL,
  `sugesstion` varchar(400) NOT NULL,
  `total_marks` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_data`
--

INSERT INTO `student_data` (`usn`, `IA_marks1`, `IA_marks2`, `IA_marks3`, `semester_percentage`, `cocurricular_activity`, `sugesstion`, `total_marks`) VALUES
('4mh21is095', 32, 232, 232, 32, 'dfd', 'ff', 496),
('4MH21MC011', 11, 232, 232, 39, 'DSFSF', 'DSFFDSDF', 475),
('4mh21is001', 11, 232, 232, 39, 'sdfg', 'erfg', 475),
('4mh21is067', 10, 9, 8, 60, 'sports', 'ntg', 27),
('4mh21is098', 9, 7, 6, 65, 'sports', 'ntg', 22);

--
-- Triggers `student_data`
--
DELIMITER $$
CREATE TRIGGER `calculate_total_marks` BEFORE INSERT ON `student_data` FOR EACH ROW BEGIN
    
    SET NEW.total_marks = NEW.IA_marks1 + NEW.IA_marks2 + NEW.IA_marks3;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE `teacher` (
  `teacher_id` varchar(400) NOT NULL,
  `teacher_name` varchar(400) NOT NULL,
  `teacher_gender` varchar(400) NOT NULL,
  `password` varchar(400) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`teacher_id`, `teacher_name`, `teacher_gender`, `password`) VALUES
('01', 'nids', 'female', '123'),
('03', 'vijay', 'male', 'mit@123'),
('04', 'racha', 'female', '123'),
('2', 'sujay', 'male', 'mit@123');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`adminid`);

--
-- Indexes for table `hod`
--
ALTER TABLE `hod`
  ADD PRIMARY KEY (`HOD_ID`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`usn`),
  ADD KEY `teacher` (`teacher_id`);

--
-- Indexes for table `student_data`
--
ALTER TABLE `student_data`
  ADD KEY `usn` (`usn`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`teacher_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `hod`
--
ALTER TABLE `hod`
  MODIFY `HOD_ID` bigint(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`teacher_id`);

--
-- Constraints for table `student_data`
--
ALTER TABLE `student_data`
  ADD CONSTRAINT `student_data_ibfk_1` FOREIGN KEY (`usn`) REFERENCES `student` (`usn`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
DELIMITER $$
CREATE TRIGGER `check_semester_percentage`
BEFORE INSERT ON `student_data`
FOR EACH ROW
BEGIN
    IF NEW.semester_percentage > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Semester percentage cannot exceed 100';
    END IF;
END $$
DELIMITER ;
