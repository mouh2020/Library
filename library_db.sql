-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 27, 2025 at 08:45 PM
-- Server version: 8.0.40-0ubuntu0.24.04.1
-- PHP Version: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `library_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `Admin`
--

CREATE TABLE `Admin` (
  `id` int NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Admin`
--

INSERT INTO `Admin` (`id`, `email`, `password`) VALUES
(1, 'admin1@example.com', 'admin1'),
(2, 'admin2@example.com', 'admin2');

-- --------------------------------------------------------

--
-- Table structure for table `Book`
--

CREATE TABLE `Book` (
  `id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `studentId` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Book`
--

INSERT INTO `Book` (`id`, `title`, `description`, `studentId`) VALUES
(7, 'Souna El Imam Ahmed', NULL, 0),
(13, 'Ibn Zamanine', 'Earlier scolar', 0),
(17, 'Ahmed Ibn Hanbel', 'Kitab E sou,a', 0),
(21, 'El Imane for Abou Oubaid El Kacem', 'El Imane', 0),
(22, 'El Mousnad Al Aouzai', 'Mousnad El Imam Ahmed', 0),
(23, 'The Silent Ocean', 'A gripping tale of adventure and mystery set on the high seas.', 0),
(24, 'Echoes of the Past', 'A historical drama unraveling secrets buried for decades.', 0),
(25, 'Starlight Chronicles', 'A fantasy epic of heroes, magic, and a battle for a kingdom.', 0),
(26, 'The Lost Expedition', 'An account of an ill-fated journey through the Amazon rainforest.', 0),
(27, 'Whispers in the Dark', 'A psychological thriller about a woman uncovering dark family secrets.', 0),
(28, 'Beneath the Ice', 'A chilling story of survival and discovery in Antarctica.', 0),
(29, 'Threads of Fate', 'A romantic drama that spans generations and continents.', 0),
(30, 'Shadows of the Empire', 'A political thriller exploring power, betrayal, and loyalty.', 0),
(31, 'Garden of the Moon', 'A lyrical exploration of love, loss, and redemption.', 0),
(32, 'The Last Horizon', 'A sci-fi adventure set in a distant galaxy.', 0),
(33, 'River of Dreams', 'A coming-of-age story about friendship and following your passion.', 0),
(34, 'The Forgotten Tower', 'An eerie mystery surrounding a strange and abandoned tower.', 0),
(35, 'Winds of Change', 'A story of resilience and hope in the face of adversity.', 0),
(36, 'The Crimson Crown', 'A tale of betrayal and war in a medieval kingdom.', 0),
(37, 'Secrets of the Forest', 'An enchanting story of magical creatures hidden in the woods.', 0),
(38, 'The Clockmaker’s Daughter', 'A historical fiction novel about time, love, and legacy.', 0),
(39, 'Dancing with Shadows', 'A gripping noir mystery in the underbelly of a bustling city.', 0),
(40, 'The Infinite Loop', 'A mind-bending thriller about time travel and consequences.', 0),
(41, 'City of Glass', 'A dystopian story of survival in a fractured urban landscape.', 0),
(42, 'The Phoenix Reborn', 'An inspirational story of rebuilding after personal tragedy.', 0),
(43, 'The Seventh Seal', 'A dark fantasy novel of prophecy and destiny.', 0),
(44, 'Silent Watchers', 'A mystery about strange occurrences in a remote mountain town.', 0),
(45, 'The Paper Swan', 'A poignant romance about love found in unexpected places.', 0),
(46, 'Across the Stars', 'A space opera about exploring the unknown and finding oneself.', 0),
(47, 'The Wolf’s Call', 'A gripping fantasy about loyalty and the bonds of a pack.', 0),
(48, 'Tides of War', 'An epic historical novel set during a devastating conflict.', 0),
(49, 'The Midnight Library', 'A heartwarming tale of second chances and alternate lives.', 0),
(50, 'Rise of the Fallen', 'A fantasy story of rebellion and the fight for freedom.', 0),
(51, 'Echo Valley', 'A mystery that unravels in a small, tight-knit community.', 0),
(52, 'The Ivory Key', 'An adventure to uncover an ancient artifact with immense power.', 0),
(53, 'The Golden Compass', 'A journey through magical lands with unexpected allies.', 0),
(54, 'Voices from the Ashes', 'A post-apocalyptic story of hope and rebuilding.', 0),
(55, 'The Alchemist’s Secret', 'A thrilling tale of mystery and alchemy in medieval times.', 0),
(56, 'The Fire Within', 'An inspiring story of overcoming obstacles and finding inner strength.', 0),
(57, 'Chasing the Sun', 'A romance about rediscovering love while traveling the world.', 0),
(58, 'The Enchanted Lake', 'A magical tale about courage and the quest for truth.', 0),
(59, 'The Broken Kingdom', 'A fantasy epic of a fractured realm seeking unity.', 0),
(60, 'The Lighthouse Keeper', 'A haunting story of solitude and the mysteries of the sea.', 0),
(61, 'The Starborn Legacy', 'A sci-fi novel of intergalactic politics and personal ambition.', 0),
(62, 'The Glass Butterfly', 'A poignant drama about the fragility of life and love.', 0),
(63, 'Journey to the Edge', 'An adventure novel exploring the limits of human endurance.', 0),
(64, 'The Emerald Throne', 'A fantasy story about the fight for a legendary seat of power.', 0),
(65, 'The Winter Rose', 'A historical romance set against a backdrop of war and peace.', 0),
(66, 'The Dreamer’s Quest', 'A whimsical story about chasing one’s dreams.', 0),
(67, 'A Song for the Lost', 'A heart-wrenching tale of love and loss.', 0),
(68, 'The Forgotten Heir', 'A mystery about a missing royal descendant and hidden truths.', 0),
(69, 'The Iron Path', 'A story of revolution and the strength of the human spirit.', 0),
(70, 'Moonlit Shadows', 'A paranormal romance with secrets lurking in the night.', 0),
(71, 'The Wanderer’s Tale', 'A novel about self-discovery and the meaning of home.', 0);

-- --------------------------------------------------------

--
-- Table structure for table `Student`
--

CREATE TABLE `Student` (
  `id` int NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Student`
--

INSERT INTO `Student` (`id`, `email`, `password`) VALUES
(22, 'admin1@example.com', 'admin1'),
(28, 'admin2@example.com', 'Q6Spf0gaf50'),
(30, 'admin3@example.com', 'admin1'),
(31, 'admin4@example.com', 'admin1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Admin`
--
ALTER TABLE `Admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Book`
--
ALTER TABLE `Book`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Student`
--
ALTER TABLE `Student`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Admin`
--
ALTER TABLE `Admin`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Book`
--
ALTER TABLE `Book`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `Student`
--
ALTER TABLE `Student`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
