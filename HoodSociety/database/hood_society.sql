-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 07 Wrz 2022, 18:52
-- Wersja serwera: 10.4.20-MariaDB
-- Wersja PHP: 8.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `hood_society`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `cart`
--

CREATE TABLE `cart` (
  `id_cart` int(11) NOT NULL,
  `name` varchar(150) COLLATE utf8_polish_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` float NOT NULL,
  `cart_user` varchar(25) COLLATE utf8_polish_ci NOT NULL,
  `status` varchar(6) COLLATE utf8_polish_ci NOT NULL,
  `id_order` int(11) DEFAULT NULL,
  `id_product` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `cart`
--

INSERT INTO `cart` (`id_cart`, `name`, `quantity`, `price`, `cart_user`, `status`, `id_order`, `id_product`) VALUES
(1, 'Koszulka z sercem', 1, 99, 'admin', 'closed', 1, 1),
(2, 'Czapka z misiem', 1, 99, 'user1', 'closed', 2, 24),
(3, 'Spodnie z czaszka', 1, 129, 'user1', 'closed', 2, 20),
(4, 'Bluza z symbolem kanji', 2, 498, 'admin', 'closed', 1, 10),


-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `orders`
--

CREATE TABLE `orders` (
  `id_order` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `address` varchar(500) COLLATE utf8_polish_ci NOT NULL,
  `email` varchar(45) COLLATE utf8_polish_ci NOT NULL,
  `phone` int(9) NOT NULL,
  `total` double NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `orders`
--

INSERT INTO `orders` (`id_order`, `date`, `address`, `email`, `phone`, `total`, `id_user`) VALUES
(1, '2022-09-07 10:55:35', 'Marek Markowski\r\nul. Brzozowa 23/3\r\n40-005 Katowice\r\nPolska', 'testowymail2@mail.pl', 421543654, 597, 1),
(2, '2022-09-08 13:22:22', 'Michał Michalski\r\nul. Polna 17/5\r\n50-031 Wrocław\r\nPolska', 'testowymail@mail.pl', 765765345, 228, 3),

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `product`
--

CREATE TABLE `product` (
  `id_product` int(11) NOT NULL,
  `name` varchar(150) COLLATE utf8_polish_ci NOT NULL,
  `category` varchar(25) COLLATE utf8_polish_ci NOT NULL,
  `description` varchar(1000) COLLATE utf8_polish_ci NOT NULL,
  `price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `product`
--

INSERT INTO `product` (`id_product`, `name`, `category`, `description`, `price`) VALUES

(1, 'Koszulka z sercem', 'koszulki', 'Koszulka z nadrukiem przedstawiajacym złamane serce.', 99),
(2, 'Koszulka z namiotem', 'koszulki', 'Koszulka z nadrukiem przedstawiajacym namiot symbolizujacy obozowisko.', 119),
(3, 'Koszulka z wedka', 'koszulki', 'Koszulka z nadrukiem przedstawiajacym niedzwiedzia z wedka symbolizujacego wedkowanie.', 119),
(4, 'Koszulka z wspinaczka', 'koszulki', 'Koszulka z nadrukiem przedstawiajacym buty gorskie symbolizujace wspinaczke .', 119),
(5, 'Bluza z flamingiem', 'bluzy', 'Bluza z nadrukiem przedstawiajacym nadruk flaminga.', 199),
(6, 'Bluza ze zlamanym sercem na niebieskim materiale', 'bluzy', 'Bluza z nadrukiem przedstawiajacym zlamane serce. Zostala wykonana na niebieskim nadruku w stylu tiedye.', 299),
(7, 'Bluza ze zlamanym sercem zwykla', 'bluzy', 'Bluza z nadrukiem przedstawiajacym zlamane serce .', 199),
(8, 'Bluza z fightclub', 'bluzy', 'Bluza z nadrukiem przedstawiajacym logo fight club zrealizowane w stylu looney tunes.', 249),
(9, 'Bluza z geisha', 'bluzy', 'Bluza z nadrukiem przedstawiajacym postac geishy.', 299),
(10, 'Bluza z symbolem kanji', 'bluzy', 'Bluza z nadrukiem przedstawiajacym japonski wzor typu kanji.', 249),
(11, 'Bluza z koi', 'bluzy', 'Bluza z nadrukiem przedstawiajacym ryby koi.', 299),
(12, 'Bluza z panda', 'bluzy', 'Bluza z nadrukiem przedstawiajacym pande.', 299),
(13, 'Bluza z postacia reaper', 'bluzy', 'Bluza z nadrukiem przedstawiajacym postac reaper w stylu cartoon.', 199),
(14, 'Bluza z usmiechnieta buzka', 'bluzy', 'Bluza z nadrukiem przedstawiajacym usmiechnieta buzke.', 199),
(15, 'Bluza z tygrysem', 'bluzy', 'Bluza z nadrukiem przedstawiajacym tygrysa.', 299),
(16, 'Bezrekawnik z flamingiem', 'bezrekawniki', 'Bezrekawnik z nadrukiem przedstawiajacym flaminga.', 99),
(17, 'Bezrekawnik z motywem filmu jaws', 'bezrekawniki', 'Bezrekawnik z nadrukiem przedstawiajacym motyw z filmu jaws.', 99),
(18, 'Bezrekawnik z postacia reaper', 'bezrekawniki', 'Bezrekawnik z nadrukiem przedstawiajacym postac reaper w stylu cartoon.', 99),
(19, 'Spodnie z usmiechnieta buzka', 'spodnie', 'Spodnie z nadrukiem przedstawiajacym symbol usmiechnietej buzki.', 119),
(20, 'Spodnie z czaszka', 'spodnie', 'Spodnie z nadrukiem przedstawiajacym symbol niebieskiej czaszki.', 129),
(21, 'Koszulka z dlugim rekawkiem z kotem', 'koszulki-longsleeve', 'Koszulka z dlugim rekawkiem z nadrukiem przedstawiajacym kota jedzacego sushi.', 159),
(22, 'Koszulka z dlugim rekawkiem z flamingiem', 'koszulki-longsleeve', 'Koszulka z dlugim rekawkiem z nadrukiem przedstawiajacym flaminga.', 139),
(23, 'Koszulka z dlugim rekawkiem z usmiechnieta buzka', 'koszulki-longsleeve', 'Koszulka z dlugim rekawkiem z nadrukiem przedstawiajacym usmiechnieta buzke.', 129),
(24, 'Czapka z misiem', 'czapki', 'Czapka z nadrukiem przedstawiajacym misia.', 99),
(25, 'Czapka z symbolem kanji', 'czapki', 'Czapka z nadrukiem przedstawiajacym japonski symbol typu kanji.', 89),


-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `login` varchar(25) COLLATE utf8_polish_ci NOT NULL,
  `pass` varchar(25) COLLATE utf8_polish_ci NOT NULL,
  `role` varchar(10) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `user`
--

INSERT INTO `user` (`id_user`, `login`, `pass`, `role`) VALUES
(1, 'admin', 'admin', 'admin'),
(3, 'user1', 'user1', 'user');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id_cart`);

--
-- Indeksy dla tabeli `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id_order`);

--
-- Indeksy dla tabeli `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id_product`);

--
-- Indeksy dla tabeli `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `cart`
--
ALTER TABLE `cart`
  MODIFY `id_cart` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT dla tabeli `orders`
--
ALTER TABLE `orders`
  MODIFY `id_order` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT dla tabeli `product`
--
ALTER TABLE `product`
  MODIFY `id_product` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT dla tabeli `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
