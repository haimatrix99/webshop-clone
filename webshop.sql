-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th3 07, 2025 lúc 11:36 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.0.30
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */
;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */
;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */
;
/*!40101 SET NAMES utf8mb4 */
;
--
-- Cơ sở dữ liệu: `webshop`
--
-- --------------------------------------------------------
--
-- Cấu trúc bảng cho bảng `attendance`
--
CREATE TABLE IF NOT EXISTS `attendance` (
  `id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `checkin_time` datetime DEFAULT NULL,
  `checkout_time` datetime DEFAULT NULL,
  `date` date NOT NULL,
  `status` enum('Checked-in', 'Checked-out', 'Pending') DEFAULT 'Pending',
  `location` varchar(100) DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;
--
-- Đang đổ dữ liệu cho bảng `attendance`
--
INSERT INTO `attendance` (
    `id`,
    `employee_id`,
    `checkin_time`,
    `checkout_time`,
    `date`,
    `status`,
    `location`
  )
VALUES (
    13,
    19,
    '2025-03-07 15:33:45',
    '2025-03-07 15:41:27',
    '2025-03-07',
    'Checked-out',
    'Láng Thượng, Hanoi, Vietnam'
  ),
  (
    18,
    18,
    '2025-03-07 17:34:37',
    '2025-03-07 17:35:48',
    '2025-03-07',
    'Checked-out',
    'Hanoi, Hanoi, Vietnam'
  );
-- --------------------------------------------------------
--
-- Cấu trúc bảng cho bảng `bookings`
--
CREATE TABLE IF NOT EXISTS `bookings` (
  `id` int(11) NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `court_name` varchar(50) NOT NULL,
  `booking_date` date NOT NULL,
  `time_slot` varchar(20) NOT NULL,
  `client_id` int(11) DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;
--
-- Đang đổ dữ liệu cho bảng `bookings`
--
INSERT INTO `bookings` (
    `id`,
    `customer_name`,
    `phone`,
    `court_name`,
    `booking_date`,
    `time_slot`,
    `client_id`
  )
VALUES (
    1,
    'Lê Tất Tiến',
    '0777050506',
    'Sân 2',
    '2025-03-02',
    '08:00 - 10:00',
    NULL
  );
-- --------------------------------------------------------
--
-- Cấu trúc bảng cho bảng `cart`
--
CREATE TABLE IF NOT EXISTS `cart` (
  `cartID` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `feature` varchar(50) DEFAULT NULL,
  `client_clientID` int(11) NOT NULL,
  `product_productID` int(11) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;
--
-- Đang đổ dữ liệu cho bảng `cart`
--
INSERT INTO `cart` (
    `cartID`,
    `quantity`,
    `feature`,
    `client_clientID`,
    `product_productID`
  )
VALUES (77, 1, '', 19, 5);
-- --------------------------------------------------------
--
-- Cấu trúc bảng cho bảng `category`
--
CREATE TABLE IF NOT EXISTS `category` (
  `categoryID` int(11) NOT NULL,
  `nameCategory` varchar(45) DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;
--
-- Đang đổ dữ liệu cho bảng `category`
--
INSERT INTO `category` (`categoryID`, `nameCategory`)
VALUES (1, 'Quần áo'),
  (2, 'Bóng'),
  (3, 'Giày'),
  (4, 'Phụ kiện');
-- --------------------------------------------------------
--
-- Cấu trúc bảng cho bảng `client`
--
CREATE TABLE IF NOT EXISTS `client` (
  `clientID` int(11) NOT NULL,
  `user` varchar(50) DEFAULT NULL,
  `pass` varchar(50) DEFAULT NULL,
  `money` varchar(20) DEFAULT '1000000000',
  `fullname` varchar(50) DEFAULT NULL,
  `birthday` date DEFAULT '1990-01-01',
  `address` varchar(50) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `image` text DEFAULT NULL,
  `role` varchar(11) DEFAULT '0'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;
--
-- Đang đổ dữ liệu cho bảng `client`
--
INSERT INTO `client` (
    `clientID`,
    `user`,
    `pass`,
    `money`,
    `fullname`,
    `birthday`,
    `address`,
    `phone`,
    `image`,
    `role`
  )
VALUES (
    1,
    'test_1',
    '123456',
    '36268503',
    'Test 1',
    '2000-06-19',
    '122 Hoàng Thụ',
    '0799994566',
    '/DataImage/user/avatar_userID1.png',
    '0'
  ),
  (
    2,
    'test_2',
    '123456',
    '1000000000',
    'Test 2',
    '2003-10-13',
    '1 Le Duan',
    '0912345678',
    '/DataImage/user/avatar_userID1.png',
    '0'
  ),
  (
    18,
    'test_3',
    '123456',
    '1000000000',
    'Test 3',
    '1997-02-06',
    'Hà Nội',
    '0777050506',
    NULL,
    '1'
  ),
  (
    19,
    'test_4',
    '123456',
    '1000000000',
    'Test 4',
    '2025-03-05',
    'Tứ dân Khoái Châu Hưng Yên',
    '0899168889',
    NULL,
    '0'
  );
-- --------------------------------------------------------
--
-- Cấu trúc bảng cho bảng `product`
--
CREATE TABLE IF NOT EXISTS `product` (
  `productID` int(11) NOT NULL,
  `product` varchar(100) DEFAULT NULL,
  `priceO` varchar(20) DEFAULT NULL,
  `priceS` varchar(20) DEFAULT NULL,
  `img` varchar(200) DEFAULT NULL,
  `numsold` varchar(20) DEFAULT NULL,
  `shop_shopID` int(11) NOT NULL,
  `category_categoryID` int(11) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;
--
-- Đang đổ dữ liệu cho bảng `product`
--
INSERT INTO `product` (
    `productID`,
    `product`,
    `priceO`,
    `priceS`,
    `img`,
    `numsold`,
    `shop_shopID`,
    `category_categoryID`
  )
VALUES (
    1,
    'Lakers',
    '950000',
    '900000',
    'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lndo0oojsctp1f.webp',
    '1.4 k',
    1,
    1
  ),
  (
    5,
    'Lakers',
    '499999',
    '299999',
    'https://down-vn.img.susercontent.com/file/5b834a0c2432c2315f8d8250445be7d1.webp',
    NULL,
    1,
    1
  ),
  (
    6,
    'Lakers',
    '999999',
    '950000',
    'https://down-vn.img.susercontent.com/file/ec75c1eab3fcdb4a0cb7fb0344ec54ef.webp',
    NULL,
    1,
    1
  ),
  (
    7,
    'BROOKLYN',
    '1250000',
    '950000',
    'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lsl81q4xxg3o93.webp',
    NULL,
    1,
    1
  ),
  (
    8,
    'Giày',
    '23550000',
    '23550000',
    'https://down-vn.img.susercontent.com/file/sg-11134202-7rfi3-m30claff2z9340.webp',
    NULL,
    1,
    3
  ),
  (
    9,
    'Giày Duke',
    '5950000',
    '5950000',
    'https://down-vn.img.susercontent.com/file/vn-11134207-7ras8-m43c6udda0s0fd.webp',
    NULL,
    1,
    3
  ),
  (
    12,
    'Giày Nike',
    '190000',
    '125000',
    'https://down-vn.img.susercontent.com/file/sg-11134202-7rfh3-m30clg0ayewna3.webp',
    NULL,
    1,
    3
  ),
  (
    19,
    'Giày Adidas',
    '27950000',
    '27950000',
    'https://down-vn.img.susercontent.com/file/sg-11134201-7rfhd-m3bq6w6egns026.webp',
    NULL,
    1,
    3
  ),
  (
    20,
    'Bóng rổ',
    '950000',
    '750000',
    'https://down-vn.img.susercontent.com/file/vn-11134207-7ra0g-m684yqf01snrc5.webp',
    NULL,
    1,
    2
  ),
  (
    21,
    'Bóng rổ ABC',
    '950000',
    '850000',
    'https://down-vn.img.susercontent.com/file/vn-11134207-7ra0g-m684yqf00e3be6.webp',
    NULL,
    1,
    2
  ),
  (
    22,
    'Rổ',
    '650000',
    '550000',
    'https://down-vn.img.susercontent.com/file/b83f1e3d955a4e6a44c19d618d89815a.webp',
    NULL,
    1,
    4
  ),
  (
    33,
    'Rổ bóng',
    '27950000',
    '27950000',
    'https://down-vn.img.susercontent.com/file/0eff35fff1be9137d8dc5b08559e4c91.webp',
    NULL,
    1,
    4
  );
-- --------------------------------------------------------
--
-- Cấu trúc bảng cho bảng `shop`
--
CREATE TABLE IF NOT EXISTS `shop` (
  `shopID` int(11) NOT NULL,
  `user` varchar(50) NOT NULL,
  `pass` varchar(45) CHARACTER SET armscii8 COLLATE armscii8_general_ci NOT NULL,
  `nameShop` varchar(50) DEFAULT NULL,
  `numFollower` varchar(20) DEFAULT NULL,
  `urlAvatar` varchar(100) DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;
--
-- Đang đổ dữ liệu cho bảng `shop`
--
INSERT INTO `shop` (
    `shopID`,
    `user`,
    `pass`,
    `nameShop`,
    `numFollower`,
    `urlAvatar`
  )
VALUES (
    1,
    'camsport',
    '123456',
    'CAMSPORT',
    '14800',
    '/style/assets/images/logoShop/LOGO CAMSPORT.png'
  );
--
-- Cấu trúc bảng cho bảng `comment`
--
CREATE TABLE IF NOT EXISTS `comment` (
  `commentID` int(11) NOT NULL,
  `comment` varchar(50) NOT NULL,
  `date` datetime NOT NULL,
  `client_clientID` int(11) NOT NULL,
  `product_productID` int(11) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;
-- --------------------------------------------------------
--
-- Cấu trúc bảng cho bảng `orders`
--
CREATE TABLE IF NOT EXISTS `orders` (
  `orderID` int(11) NOT NULL,
  `fullName` VARCHAR(255) NOT NULL,
  `address` VARCHAR(500) NOT NULL,
  `phoneNumber` VARCHAR(20) NOT NULL,
  `client_clientID` int(11) NOT NULL,
  `totalAmount` BIGINT NOT NULL,
  `status` VARCHAR(50) DEFAULT 'pending',
  `orderDate` DATETIME NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `order_details` (
  `orderDetailID` int(11) NOT NULL AUTO_INCREMENT,
  `order_orderID` int(11) NOT NULL,
  `product_productID` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` BIGINT NOT NULL,
  PRIMARY KEY (`orderDetailID`),
  KEY `fk_order_details_orders_idx` (`order_orderID`),
  KEY `fk_order_details_product_idx` (`product_productID`),
  CONSTRAINT `fk_order_details_orders` FOREIGN KEY (`order_orderID`) REFERENCES `orders` (`orderID`) ON DELETE CASCADE,
  CONSTRAINT `fk_order_details_product` FOREIGN KEY (`product_productID`) REFERENCES `product` (`productID`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- Auto increment
ALTER TABLE `order_details` 
MODIFY `orderDetailID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;
--
-- Chỉ mục cho các bảng đã đổ
--
--
-- Chỉ mục cho bảng `attendance`
--
ALTER TABLE `attendance`
ADD PRIMARY KEY (`id`),
  ADD KEY `employee_id` (`employee_id`);
--
-- Chỉ mục cho bảng `bookings`
--
ALTER TABLE `bookings`
ADD PRIMARY KEY (`id`),
  ADD KEY `fk_bookings_client` (`client_id`);
--
-- Chỉ mục cho bảng `cart`
--
ALTER TABLE `cart`
ADD PRIMARY KEY (`cartID`, `client_clientID`, `product_productID`),
  ADD KEY `fk_cart_client_idx` (`client_clientID`),
  ADD KEY `fk_cart_product_idx` (`product_productID`);
--
-- Chỉ mục cho bảng `category`
--
ALTER TABLE `category`
ADD PRIMARY KEY (`categoryID`);
--
-- Chỉ mục cho bảng `client`
--
ALTER TABLE `client`
ADD PRIMARY KEY (`clientID`);
--
-- Chỉ mục cho bảng `product`
--
ALTER TABLE `product`
ADD PRIMARY KEY (
    `productID`,
    `shop_shopID`,
    `category_categoryID`
  ),
  ADD KEY `fk_product_shop1_idx` (`shop_shopID`),
  ADD KEY `fk_product_category_idx` (`category_categoryID`);
--
-- Chỉ mục cho bảng `shop`
--
ALTER TABLE `shop`
ADD PRIMARY KEY (`shopID`);
--
-- Chỉ mục cho bảng `comment`
--
ALTER TABLE `comment`
ADD PRIMARY KEY (`commentID`),
  ADD KEY `fk_comment_client_idx` (`client_clientID`),
  ADD KEY `fk_comment_product_idx` (`product_productID`);
--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
ADD PRIMARY KEY (`orderID`),
  ADD KEY `fk_orders_client_idx` (`client_clientID`);
--
-- AUTO_INCREMENT cho các bảng đã đổ
--
--
-- AUTO_INCREMENT cho bảng `attendance`
--
ALTER TABLE `attendance`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,
  AUTO_INCREMENT = 19;
--
-- AUTO_INCREMENT cho bảng `bookings`
--
ALTER TABLE `bookings`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,
  AUTO_INCREMENT = 10;
--
-- AUTO_INCREMENT cho bảng `cart`
--
ALTER TABLE `cart`
MODIFY `cartID` int(11) NOT NULL AUTO_INCREMENT,
  AUTO_INCREMENT = 78;
--
-- AUTO_INCREMENT cho bảng `category`
--
ALTER TABLE `category`
MODIFY `categoryID` int(11) NOT NULL AUTO_INCREMENT,
  AUTO_INCREMENT = 1002;
--
-- AUTO_INCREMENT cho bảng `client`
--
ALTER TABLE `client`
MODIFY `clientID` int(11) NOT NULL AUTO_INCREMENT,
  AUTO_INCREMENT = 20;
--
-- AUTO_INCREMENT cho bảng `product`
--
ALTER TABLE `product`
MODIFY `productID` int(11) NOT NULL AUTO_INCREMENT,
  AUTO_INCREMENT = 35;
--
-- AUTO_INCREMENT cho bảng `shop`
--
ALTER TABLE `shop`
MODIFY `shopID` int(11) NOT NULL AUTO_INCREMENT,
  AUTO_INCREMENT = 8;
--
-- AUTO_INCREMENT cho bảng `comment`
--
ALTER TABLE `comment`
MODIFY `commentID` int(11) NOT NULL AUTO_INCREMENT,
  AUTO_INCREMENT = 8;
--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
MODIFY `orderID` int(11) NOT NULL AUTO_INCREMENT,
  AUTO_INCREMENT = 8;
--
-- Các ràng buộc cho các bảng đã đổ
--
--
-- Các ràng buộc cho bảng `attendance`
--
ALTER TABLE `attendance`
ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `client` (`clientID`);
--
-- Các ràng buộc cho bảng `cart`
--
ALTER TABLE `cart`
ADD CONSTRAINT `fk_cart_client` FOREIGN KEY (`client_clientID`) REFERENCES `client` (`clientID`),
  ADD CONSTRAINT `fk_cart_product` FOREIGN KEY (`product_productID`) REFERENCES `product` (`productID`);
--
-- Các ràng buộc cho bảng `product`
--
ALTER TABLE `product`
ADD CONSTRAINT `fk_product_category` FOREIGN KEY (`category_categoryID`) REFERENCES `category` (`categoryID`),
  ADD CONSTRAINT `fk_product_shop1` FOREIGN KEY (`shop_shopID`) REFERENCES `shop` (`shopID`);
--
-- Các ràng buộc cho bảng `comment`
--
ALTER TABLE `comment`
ADD CONSTRAINT `fk_comment_client` FOREIGN KEY (`client_clientID`) REFERENCES `client` (`clientID`),
  ADD CONSTRAINT `fk_comment_product` FOREIGN KEY (`product_productID`) REFERENCES `product` (`productID`);
--
-- Các ràng buộc cho bảng `bookings`
--
ALTER TABLE `bookings`
ADD CONSTRAINT `fk_bookings_client` FOREIGN KEY (`client_id`) REFERENCES `client` (`clientID`);
COMMIT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */
;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */
;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */
;