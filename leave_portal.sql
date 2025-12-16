-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 16, 2025 at 08:32 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `leave_portal`
--

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `dept_id` int(11) NOT NULL,
  `dept_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`dept_id`, `dept_name`) VALUES
(1, 'Computer Science'),
(2, 'Mechanical'),
(3, 'Electrical'),
(4, 'Chemical');

-- --------------------------------------------------------

--
-- Table structure for table `leave_applications`
--

CREATE TABLE `leave_applications` (
  `application_id` int(11) NOT NULL,
  `u_id` int(11) NOT NULL,
  `l_id` int(11) NOT NULL,
  `no_of_days` int(11) DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `address_during_leave` text DEFAULT NULL,
  `mobile_no` varchar(20) DEFAULT NULL,
  `pdf_file` varchar(500) DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `submission_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `resolved_date` timestamp NULL DEFAULT NULL,
  `accepted_days` int(11) DEFAULT NULL,
  `accepted_from` date DEFAULT NULL,
  `accepted_to` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `leave_applications`
--

INSERT INTO `leave_applications` (`application_id`, `u_id`, `l_id`, `no_of_days`, `from_date`, `to_date`, `reason`, `address_during_leave`, `mobile_no`, `pdf_file`, `status`, `submission_date`, `resolved_date`, `accepted_days`, `accepted_from`, `accepted_to`) VALUES
(8, 3, 3, 2, '2025-12-19', '2025-12-20', 'Have a examination somewhere ', 'Kolkata', '789456123', NULL, 'approved', '2025-12-16 07:18:28', '2025-12-16 07:19:34', 2, '2025-12-19', '2025-12-20'),
(9, 3, 3, 2, '2025-12-26', '2025-12-27', 'sdfasdf', 'adfsdfsa', '789456123', NULL, 'pending', '2025-12-16 07:20:14', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `leave_nature`
--

CREATE TABLE `leave_nature` (
  `l_id` int(11) NOT NULL,
  `l_nature` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `leave_nature`
--

INSERT INTO `leave_nature` (`l_id`, `l_nature`) VALUES
(1, 'Casual Leave'),
(2, 'Medical Leave'),
(3, 'Academic Leave'),
(4, 'Emergency Leave');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `u_id` int(11) NOT NULL,
  `roll_no` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `dept_id` int(11) NOT NULL,
  `hostel_block` varchar(50) DEFAULT NULL,
  `room_number` varchar(50) DEFAULT NULL,
  `mobile_no` varchar(20) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('student','admin') NOT NULL DEFAULT 'student'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`u_id`, `roll_no`, `name`, `dept_id`, `hostel_block`, `room_number`, `mobile_no`, `email`, `password`, `role`) VALUES
(1, 'ADMIN001', 'Site Admin', 1, 'A', '101', '9999999999', 'admin@example.com', '$2b$10$s/8jIKCYAqfBuZ2O/USsSeAcypVJ49r/KHxZSvbs/uxvwv11sheiW', 'admin'),
(3, '123211003022', 'Aakash', 1, 'A', '109', '987654321', 'stu@aiims.edu.in', '$2b$10$6ZsM6ztpTUzLSrgi8e1ehOjHtJLG/kQTfiENTX9795PuRwIjAXP0e', 'student');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`dept_id`);

--
-- Indexes for table `leave_applications`
--
ALTER TABLE `leave_applications`
  ADD PRIMARY KEY (`application_id`),
  ADD KEY `fk_leave_user` (`u_id`),
  ADD KEY `fk_leave_nature` (`l_id`);

--
-- Indexes for table `leave_nature`
--
ALTER TABLE `leave_nature`
  ADD PRIMARY KEY (`l_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`u_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `fk_users_dept` (`dept_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `dept_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `leave_applications`
--
ALTER TABLE `leave_applications`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `leave_nature`
--
ALTER TABLE `leave_nature`
  MODIFY `l_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `u_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `leave_applications`
--
ALTER TABLE `leave_applications`
  ADD CONSTRAINT `fk_leave_nature` FOREIGN KEY (`l_id`) REFERENCES `leave_nature` (`l_id`),
  ADD CONSTRAINT `fk_leave_user` FOREIGN KEY (`u_id`) REFERENCES `users` (`u_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_dept` FOREIGN KEY (`dept_id`) REFERENCES `departments` (`dept_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
