SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET FOREIGN_KEY_CHECKS = 1;

-- Roles and demo users. Existing production users are never overwritten.
INSERT INTO roles (id, role_name, description) VALUES
  (1, 'ADMIN', 'Quản trị viên hệ thống'),
  (2, 'USER', 'Khách hàng FoodHub')
ON DUPLICATE KEY UPDATE description = VALUES(description);

INSERT IGNORE INTO users (id, user_name, password, fullname, create_date, role_id) VALUES
  (1, 'admin', '$2b$10$WS.aEAGnXkZm96.FS9RMkOMTj2kQOzP74EPWAjmOatU1FlgCRkU9i', 'Admin System', NOW(), 1),
  (2, 'nguyenvana', '$2b$10$WS.aEAGnXkZm96.FS9RMkOMTj2kQOzP74EPWAjmOatU1FlgCRkU9i', 'Nguyễn Văn A', NOW(), 2);

INSERT INTO category (id, category_name, create_date) VALUES (1, 'Cơm', NOW())
ON DUPLICATE KEY UPDATE category_name = VALUES(category_name);

INSERT INTO category (id, category_name, create_date) VALUES (2, 'Bún - Phở', NOW())
ON DUPLICATE KEY UPDATE category_name = VALUES(category_name);

INSERT INTO category (id, category_name, create_date) VALUES (3, 'Bánh mì', NOW())
ON DUPLICATE KEY UPDATE category_name = VALUES(category_name);

INSERT INTO category (id, category_name, create_date) VALUES (4, 'Đồ uống', NOW())
ON DUPLICATE KEY UPDATE category_name = VALUES(category_name);

INSERT INTO category (id, category_name, create_date) VALUES (5, 'Gà rán', NOW())
ON DUPLICATE KEY UPDATE category_name = VALUES(category_name);

INSERT INTO category (id, category_name, create_date) VALUES (6, 'Pizza', NOW())
ON DUPLICATE KEY UPDATE category_name = VALUES(category_name);

INSERT INTO category (id, category_name, create_date) VALUES (7, 'Lẩu', NOW())
ON DUPLICATE KEY UPDATE category_name = VALUES(category_name);

INSERT INTO category (id, category_name, create_date) VALUES (8, 'Chay', NOW())
ON DUPLICATE KEY UPDATE category_name = VALUES(category_name);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1001, 'Cơm Tấm Sài Gòn', 'Cơm tấm truyền thống', 'Cơm tấm truyền thống. Chuyên phục vụ cơm với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10011.jpg', 1, '18 Đường FoodHub, Quận 1, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (1, 1001, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100101, 'Cơm tấm sườn bì chả', 'Sườn nướng, bì heo, chả trứng và cơm tấm dẻo. Món được chuẩn bị mới tại Cơm Tấm Sài Gòn.', '/images/foods/10011.jpg', '20-30 phút', 35000, 1, 1, 1001)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100102, 'Cơm gà xối mỡ', 'Đùi gà da giòn ăn cùng cơm chiên tỏi. Món được chuẩn bị mới tại Cơm Tấm Sài Gòn.', '/images/foods/10012.jpg', '20-30 phút', 40000, 1, 1, 1001)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100103, 'Cơm thịt kho trứng', 'Thịt ba chỉ kho mềm, trứng và rau luộc. Món được chuẩn bị mới tại Cơm Tấm Sài Gòn.', '/images/foods/10013.jpg', '20-30 phút', 45000, 1, 1, 1001)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100104, 'Cơm sườn nướng mật ong', 'Sườn cốt lết nướng mật ong thơm đậm. Món được chuẩn bị mới tại Cơm Tấm Sài Gòn.', '/images/foods/10014.jpg', '20-30 phút', 50000, 1, 1, 1001)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100105, 'Cơm bò lúc lắc', 'Bò áp chảo, ớt chuông và khoai tây. Món được chuẩn bị mới tại Cơm Tấm Sài Gòn.', '/images/foods/10021.jpg', '20-30 phút', 55000, 1, 1, 1001)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100106, 'Cơm cá kho tộ', 'Cá kho tiêu trong niêu đất, vị mặn ngọt. Món được chuẩn bị mới tại Cơm Tấm Sài Gòn.', '/images/foods/10022.jpg', '20-30 phút', 60000, 1, 1, 1001)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100107, 'Cơm gà rô ti', 'Gà rô ti mềm, sốt ngũ vị và dưa chua. Món được chuẩn bị mới tại Cơm Tấm Sài Gòn.', '/images/foods/10023.jpg', '20-30 phút', 65000, 1, 1, 1001)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100108, 'Cơm chiên hải sản', 'Cơm chiên tơi với tôm, mực và rau củ. Món được chuẩn bị mới tại Cơm Tấm Sài Gòn.', '/images/foods/10024.jpg', '20-30 phút', 70000, 1, 1, 1001)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100109, 'Cơm niêu sườn rim', 'Sườn non rim mặn ngọt dùng với cơm niêu. Món được chuẩn bị mới tại Cơm Tấm Sài Gòn.', '/images/foods/10031.jpg', '20-30 phút', 75000, 1, 1, 1001)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100110, 'Cơm phần đặc biệt', 'Phần cơm đầy đủ món mặn, rau và canh. Món được chuẩn bị mới tại Cơm Tấm Sài Gòn.', '/images/foods/10032.jpg', '20-30 phút', 80000, 1, 1, 1001)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1002, 'Bếp Mẹ Ơi', 'Cơm nhà đúng vị', 'Cơm nhà đúng vị. Chuyên phục vụ cơm với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10012.jpg', 0, '29 Đường FoodHub, Quận 2, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (1, 1002, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100201, 'Cơm tấm sườn bì chả - Bếp Mẹ Ơi', 'Sườn nướng, bì heo, chả trứng và cơm tấm dẻo. Món được chuẩn bị mới tại Bếp Mẹ Ơi.', '/images/foods/10011.jpg', '20-30 phút', 35000, 0, 1, 1002)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100202, 'Cơm gà xối mỡ - Bếp Mẹ Ơi', 'Đùi gà da giòn ăn cùng cơm chiên tỏi. Món được chuẩn bị mới tại Bếp Mẹ Ơi.', '/images/foods/10012.jpg', '20-30 phút', 40000, 0, 1, 1002)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100203, 'Cơm thịt kho trứng - Bếp Mẹ Ơi', 'Thịt ba chỉ kho mềm, trứng và rau luộc. Món được chuẩn bị mới tại Bếp Mẹ Ơi.', '/images/foods/10013.jpg', '20-30 phút', 45000, 0, 1, 1002)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100204, 'Cơm sườn nướng mật ong - Bếp Mẹ Ơi', 'Sườn cốt lết nướng mật ong thơm đậm. Món được chuẩn bị mới tại Bếp Mẹ Ơi.', '/images/foods/10014.jpg', '20-30 phút', 50000, 0, 1, 1002)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100205, 'Cơm bò lúc lắc - Bếp Mẹ Ơi', 'Bò áp chảo, ớt chuông và khoai tây. Món được chuẩn bị mới tại Bếp Mẹ Ơi.', '/images/foods/10021.jpg', '20-30 phút', 55000, 0, 1, 1002)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100206, 'Cơm cá kho tộ - Bếp Mẹ Ơi', 'Cá kho tiêu trong niêu đất, vị mặn ngọt. Món được chuẩn bị mới tại Bếp Mẹ Ơi.', '/images/foods/10022.jpg', '20-30 phút', 60000, 0, 1, 1002)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100207, 'Cơm gà rô ti - Bếp Mẹ Ơi', 'Gà rô ti mềm, sốt ngũ vị và dưa chua. Món được chuẩn bị mới tại Bếp Mẹ Ơi.', '/images/foods/10023.jpg', '20-30 phút', 65000, 0, 1, 1002)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100208, 'Cơm chiên hải sản - Bếp Mẹ Ơi', 'Cơm chiên tơi với tôm, mực và rau củ. Món được chuẩn bị mới tại Bếp Mẹ Ơi.', '/images/foods/10024.jpg', '20-30 phút', 70000, 0, 1, 1002)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100209, 'Cơm niêu sườn rim - Bếp Mẹ Ơi', 'Sườn non rim mặn ngọt dùng với cơm niêu. Món được chuẩn bị mới tại Bếp Mẹ Ơi.', '/images/foods/10031.jpg', '20-30 phút', 75000, 0, 1, 1002)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100210, 'Cơm phần đặc biệt - Bếp Mẹ Ơi', 'Phần cơm đầy đủ món mặn, rau và canh. Món được chuẩn bị mới tại Bếp Mẹ Ơi.', '/images/foods/10032.jpg', '20-30 phút', 80000, 0, 1, 1002)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1003, 'Cơm Niêu Thiên Phúc', 'Cơm niêu gia đình', 'Cơm niêu gia đình. Chuyên phục vụ cơm với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10013.jpg', 0, '40 Đường FoodHub, Quận 3, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (1, 1003, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100301, 'Cơm tấm sườn bì chả - Cơm Niêu Thiên Phúc', 'Sườn nướng, bì heo, chả trứng và cơm tấm dẻo. Món được chuẩn bị mới tại Cơm Niêu Thiên Phúc.', '/images/foods/10011.jpg', '20-30 phút', 35000, 0, 1, 1003)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100302, 'Cơm gà xối mỡ - Cơm Niêu Thiên Phúc', 'Đùi gà da giòn ăn cùng cơm chiên tỏi. Món được chuẩn bị mới tại Cơm Niêu Thiên Phúc.', '/images/foods/10012.jpg', '20-30 phút', 40000, 0, 1, 1003)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100303, 'Cơm thịt kho trứng - Cơm Niêu Thiên Phúc', 'Thịt ba chỉ kho mềm, trứng và rau luộc. Món được chuẩn bị mới tại Cơm Niêu Thiên Phúc.', '/images/foods/10013.jpg', '20-30 phút', 45000, 0, 1, 1003)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100304, 'Cơm sườn nướng mật ong - Cơm Niêu Thiên Phúc', 'Sườn cốt lết nướng mật ong thơm đậm. Món được chuẩn bị mới tại Cơm Niêu Thiên Phúc.', '/images/foods/10014.jpg', '20-30 phút', 50000, 0, 1, 1003)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100305, 'Cơm bò lúc lắc - Cơm Niêu Thiên Phúc', 'Bò áp chảo, ớt chuông và khoai tây. Món được chuẩn bị mới tại Cơm Niêu Thiên Phúc.', '/images/foods/10021.jpg', '20-30 phút', 55000, 0, 1, 1003)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100306, 'Cơm cá kho tộ - Cơm Niêu Thiên Phúc', 'Cá kho tiêu trong niêu đất, vị mặn ngọt. Món được chuẩn bị mới tại Cơm Niêu Thiên Phúc.', '/images/foods/10022.jpg', '20-30 phút', 60000, 0, 1, 1003)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100307, 'Cơm gà rô ti - Cơm Niêu Thiên Phúc', 'Gà rô ti mềm, sốt ngũ vị và dưa chua. Món được chuẩn bị mới tại Cơm Niêu Thiên Phúc.', '/images/foods/10023.jpg', '20-30 phút', 65000, 0, 1, 1003)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100308, 'Cơm chiên hải sản - Cơm Niêu Thiên Phúc', 'Cơm chiên tơi với tôm, mực và rau củ. Món được chuẩn bị mới tại Cơm Niêu Thiên Phúc.', '/images/foods/10024.jpg', '20-30 phút', 70000, 0, 1, 1003)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100309, 'Cơm niêu sườn rim - Cơm Niêu Thiên Phúc', 'Sườn non rim mặn ngọt dùng với cơm niêu. Món được chuẩn bị mới tại Cơm Niêu Thiên Phúc.', '/images/foods/10031.jpg', '20-30 phút', 75000, 0, 1, 1003)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100310, 'Cơm phần đặc biệt - Cơm Niêu Thiên Phúc', 'Phần cơm đầy đủ món mặn, rau và canh. Món được chuẩn bị mới tại Cơm Niêu Thiên Phúc.', '/images/foods/10032.jpg', '20-30 phút', 80000, 0, 1, 1003)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1004, 'Cơm Gà Hội An', 'Cơm gà miền Trung', 'Cơm gà miền Trung. Chuyên phục vụ cơm với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10014.jpg', 1, '51 Đường FoodHub, Quận 4, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (1, 1004, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100401, 'Cơm tấm sườn bì chả - Cơm Gà Hội An', 'Sườn nướng, bì heo, chả trứng và cơm tấm dẻo. Món được chuẩn bị mới tại Cơm Gà Hội An.', '/images/foods/10011.jpg', '20-30 phút', 35000, 1, 1, 1004)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100402, 'Cơm gà xối mỡ - Cơm Gà Hội An', 'Đùi gà da giòn ăn cùng cơm chiên tỏi. Món được chuẩn bị mới tại Cơm Gà Hội An.', '/images/foods/10012.jpg', '20-30 phút', 40000, 1, 1, 1004)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100403, 'Cơm thịt kho trứng - Cơm Gà Hội An', 'Thịt ba chỉ kho mềm, trứng và rau luộc. Món được chuẩn bị mới tại Cơm Gà Hội An.', '/images/foods/10013.jpg', '20-30 phút', 45000, 1, 1, 1004)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100404, 'Cơm sườn nướng mật ong - Cơm Gà Hội An', 'Sườn cốt lết nướng mật ong thơm đậm. Món được chuẩn bị mới tại Cơm Gà Hội An.', '/images/foods/10014.jpg', '20-30 phút', 50000, 1, 1, 1004)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100405, 'Cơm bò lúc lắc - Cơm Gà Hội An', 'Bò áp chảo, ớt chuông và khoai tây. Món được chuẩn bị mới tại Cơm Gà Hội An.', '/images/foods/10021.jpg', '20-30 phút', 55000, 1, 1, 1004)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100406, 'Cơm cá kho tộ - Cơm Gà Hội An', 'Cá kho tiêu trong niêu đất, vị mặn ngọt. Món được chuẩn bị mới tại Cơm Gà Hội An.', '/images/foods/10022.jpg', '20-30 phút', 60000, 1, 1, 1004)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100407, 'Cơm gà rô ti - Cơm Gà Hội An', 'Gà rô ti mềm, sốt ngũ vị và dưa chua. Món được chuẩn bị mới tại Cơm Gà Hội An.', '/images/foods/10023.jpg', '20-30 phút', 65000, 1, 1, 1004)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100408, 'Cơm chiên hải sản - Cơm Gà Hội An', 'Cơm chiên tơi với tôm, mực và rau củ. Món được chuẩn bị mới tại Cơm Gà Hội An.', '/images/foods/10024.jpg', '20-30 phút', 70000, 1, 1, 1004)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100409, 'Cơm niêu sườn rim - Cơm Gà Hội An', 'Sườn non rim mặn ngọt dùng với cơm niêu. Món được chuẩn bị mới tại Cơm Gà Hội An.', '/images/foods/10031.jpg', '20-30 phút', 75000, 1, 1, 1004)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100410, 'Cơm phần đặc biệt - Cơm Gà Hội An', 'Phần cơm đầy đủ món mặn, rau và canh. Món được chuẩn bị mới tại Cơm Gà Hội An.', '/images/foods/10032.jpg', '20-30 phút', 80000, 1, 1, 1004)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1005, 'Cơm Gà Xối Mỡ A Mập', 'Cơm gà giòn nóng', 'Cơm gà giòn nóng. Chuyên phục vụ cơm với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10021.jpg', 0, '62 Đường FoodHub, Quận 5, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (1, 1005, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100501, 'Cơm tấm sườn bì chả - Cơm Gà Xối Mỡ A Mập', 'Sườn nướng, bì heo, chả trứng và cơm tấm dẻo. Món được chuẩn bị mới tại Cơm Gà Xối Mỡ A Mập.', '/images/foods/10011.jpg', '20-30 phút', 35000, 0, 1, 1005)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100502, 'Cơm gà xối mỡ - Cơm Gà Xối Mỡ A Mập', 'Đùi gà da giòn ăn cùng cơm chiên tỏi. Món được chuẩn bị mới tại Cơm Gà Xối Mỡ A Mập.', '/images/foods/10012.jpg', '20-30 phút', 40000, 0, 1, 1005)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100503, 'Cơm thịt kho trứng - Cơm Gà Xối Mỡ A Mập', 'Thịt ba chỉ kho mềm, trứng và rau luộc. Món được chuẩn bị mới tại Cơm Gà Xối Mỡ A Mập.', '/images/foods/10013.jpg', '20-30 phút', 45000, 0, 1, 1005)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100504, 'Cơm sườn nướng mật ong - Cơm Gà Xối Mỡ A Mập', 'Sườn cốt lết nướng mật ong thơm đậm. Món được chuẩn bị mới tại Cơm Gà Xối Mỡ A Mập.', '/images/foods/10014.jpg', '20-30 phút', 50000, 0, 1, 1005)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100505, 'Cơm bò lúc lắc - Cơm Gà Xối Mỡ A Mập', 'Bò áp chảo, ớt chuông và khoai tây. Món được chuẩn bị mới tại Cơm Gà Xối Mỡ A Mập.', '/images/foods/10021.jpg', '20-30 phút', 55000, 0, 1, 1005)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100506, 'Cơm cá kho tộ - Cơm Gà Xối Mỡ A Mập', 'Cá kho tiêu trong niêu đất, vị mặn ngọt. Món được chuẩn bị mới tại Cơm Gà Xối Mỡ A Mập.', '/images/foods/10022.jpg', '20-30 phút', 60000, 0, 1, 1005)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100507, 'Cơm gà rô ti - Cơm Gà Xối Mỡ A Mập', 'Gà rô ti mềm, sốt ngũ vị và dưa chua. Món được chuẩn bị mới tại Cơm Gà Xối Mỡ A Mập.', '/images/foods/10023.jpg', '20-30 phút', 65000, 0, 1, 1005)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100508, 'Cơm chiên hải sản - Cơm Gà Xối Mỡ A Mập', 'Cơm chiên tơi với tôm, mực và rau củ. Món được chuẩn bị mới tại Cơm Gà Xối Mỡ A Mập.', '/images/foods/10024.jpg', '20-30 phút', 70000, 0, 1, 1005)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100509, 'Cơm niêu sườn rim - Cơm Gà Xối Mỡ A Mập', 'Sườn non rim mặn ngọt dùng với cơm niêu. Món được chuẩn bị mới tại Cơm Gà Xối Mỡ A Mập.', '/images/foods/10031.jpg', '20-30 phút', 75000, 0, 1, 1005)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100510, 'Cơm phần đặc biệt - Cơm Gà Xối Mỡ A Mập', 'Phần cơm đầy đủ món mặn, rau và canh. Món được chuẩn bị mới tại Cơm Gà Xối Mỡ A Mập.', '/images/foods/10032.jpg', '20-30 phút', 80000, 0, 1, 1005)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1006, 'Cơm Văn Phòng An Nhiên', 'Bữa trưa đủ chất', 'Bữa trưa đủ chất. Chuyên phục vụ cơm với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10022.jpg', 0, '73 Đường FoodHub, Quận 6, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (1, 1006, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100601, 'Cơm tấm sườn bì chả - Cơm Văn Phòng An Nhiên', 'Sườn nướng, bì heo, chả trứng và cơm tấm dẻo. Món được chuẩn bị mới tại Cơm Văn Phòng An Nhiên.', '/images/foods/10011.jpg', '20-30 phút', 35000, 0, 1, 1006)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100602, 'Cơm gà xối mỡ - Cơm Văn Phòng An Nhiên', 'Đùi gà da giòn ăn cùng cơm chiên tỏi. Món được chuẩn bị mới tại Cơm Văn Phòng An Nhiên.', '/images/foods/10012.jpg', '20-30 phút', 40000, 0, 1, 1006)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100603, 'Cơm thịt kho trứng - Cơm Văn Phòng An Nhiên', 'Thịt ba chỉ kho mềm, trứng và rau luộc. Món được chuẩn bị mới tại Cơm Văn Phòng An Nhiên.', '/images/foods/10013.jpg', '20-30 phút', 45000, 0, 1, 1006)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100604, 'Cơm sườn nướng mật ong - Cơm Văn Phòng An Nhiên', 'Sườn cốt lết nướng mật ong thơm đậm. Món được chuẩn bị mới tại Cơm Văn Phòng An Nhiên.', '/images/foods/10014.jpg', '20-30 phút', 50000, 0, 1, 1006)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100605, 'Cơm bò lúc lắc - Cơm Văn Phòng An Nhiên', 'Bò áp chảo, ớt chuông và khoai tây. Món được chuẩn bị mới tại Cơm Văn Phòng An Nhiên.', '/images/foods/10021.jpg', '20-30 phút', 55000, 0, 1, 1006)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100606, 'Cơm cá kho tộ - Cơm Văn Phòng An Nhiên', 'Cá kho tiêu trong niêu đất, vị mặn ngọt. Món được chuẩn bị mới tại Cơm Văn Phòng An Nhiên.', '/images/foods/10022.jpg', '20-30 phút', 60000, 0, 1, 1006)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100607, 'Cơm gà rô ti - Cơm Văn Phòng An Nhiên', 'Gà rô ti mềm, sốt ngũ vị và dưa chua. Món được chuẩn bị mới tại Cơm Văn Phòng An Nhiên.', '/images/foods/10023.jpg', '20-30 phút', 65000, 0, 1, 1006)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100608, 'Cơm chiên hải sản - Cơm Văn Phòng An Nhiên', 'Cơm chiên tơi với tôm, mực và rau củ. Món được chuẩn bị mới tại Cơm Văn Phòng An Nhiên.', '/images/foods/10024.jpg', '20-30 phút', 70000, 0, 1, 1006)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100609, 'Cơm niêu sườn rim - Cơm Văn Phòng An Nhiên', 'Sườn non rim mặn ngọt dùng với cơm niêu. Món được chuẩn bị mới tại Cơm Văn Phòng An Nhiên.', '/images/foods/10031.jpg', '20-30 phút', 75000, 0, 1, 1006)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100610, 'Cơm phần đặc biệt - Cơm Văn Phòng An Nhiên', 'Phần cơm đầy đủ món mặn, rau và canh. Món được chuẩn bị mới tại Cơm Văn Phòng An Nhiên.', '/images/foods/10032.jpg', '20-30 phút', 80000, 0, 1, 1006)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1007, 'Phở Hà Nội 1946', 'Phở bò truyền thống', 'Phở bò truyền thống. Chuyên phục vụ bún - phở với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10061.jpg', 1, '18 Đường FoodHub, Quận 7, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (2, 1007, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100701, 'Phở bò tái', 'Bò tái mềm, bánh phở và nước dùng hầm xương. Món được chuẩn bị mới tại Phở Hà Nội 1946.', '/images/foods/10061.jpg', '20-30 phút', 35000, 1, 2, 1007)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100702, 'Phở bò tái nạm', 'Bò tái, nạm mềm và hành thơm. Món được chuẩn bị mới tại Phở Hà Nội 1946.', '/images/foods/10062.jpg', '20-30 phút', 41000, 1, 2, 1007)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100703, 'Phở gà ta', 'Gà ta xé, nước dùng trong và lá chanh. Món được chuẩn bị mới tại Phở Hà Nội 1946.', '/images/foods/10063.jpg', '20-30 phút', 47000, 1, 2, 1007)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100704, 'Bún bò Huế đặc biệt', 'Bò, giò heo, chả cua và nước dùng sả ớt. Món được chuẩn bị mới tại Phở Hà Nội 1946.', '/images/foods/10064.jpg', '20-30 phút', 53000, 1, 2, 1007)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100705, 'Bún riêu cua', 'Riêu cua đồng, đậu hũ, cà chua và mắm tôm. Món được chuẩn bị mới tại Phở Hà Nội 1946.', '/images/foods/10071.jpg', '20-30 phút', 59000, 1, 2, 1007)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100706, 'Bún chả Hà Nội', 'Thịt nướng than hoa, chả viên và nước mắm. Món được chuẩn bị mới tại Phở Hà Nội 1946.', '/images/foods/10072.jpg', '20-30 phút', 65000, 1, 2, 1007)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100707, 'Bún thịt nướng', 'Thịt nướng sả, đồ chua, rau và đậu phộng. Món được chuẩn bị mới tại Phở Hà Nội 1946.', '/images/foods/10073.jpg', '20-30 phút', 71000, 1, 2, 1007)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100708, 'Bún mọc', 'Mọc thịt, sườn non và nước dùng thanh. Món được chuẩn bị mới tại Phở Hà Nội 1946.', '/images/foods/10074.jpg', '20-30 phút', 77000, 1, 2, 1007)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100709, 'Bún cá', 'Cá chiên giòn, bún tươi và rau cần. Món được chuẩn bị mới tại Phở Hà Nội 1946.', '/images/foods/10081.jpg', '20-30 phút', 83000, 1, 2, 1007)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100710, 'Phở đặc biệt', 'Tái, nạm, gân, bò viên trong tô lớn. Món được chuẩn bị mới tại Phở Hà Nội 1946.', '/images/foods/10082.jpg', '20-30 phút', 89000, 1, 2, 1007)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1008, 'Bún Bò Huế Mụ Rơi', 'Bún bò Huế chuẩn vị', 'Bún bò Huế chuẩn vị. Chuyên phục vụ bún - phở với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10062.jpg', 0, '29 Đường FoodHub, Quận 8, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (2, 1008, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100801, 'Phở bò tái - Bún Bò Huế Mụ Rơi', 'Bò tái mềm, bánh phở và nước dùng hầm xương. Món được chuẩn bị mới tại Bún Bò Huế Mụ Rơi.', '/images/foods/10061.jpg', '20-30 phút', 35000, 0, 2, 1008)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100802, 'Phở bò tái nạm - Bún Bò Huế Mụ Rơi', 'Bò tái, nạm mềm và hành thơm. Món được chuẩn bị mới tại Bún Bò Huế Mụ Rơi.', '/images/foods/10062.jpg', '20-30 phút', 41000, 0, 2, 1008)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100803, 'Phở gà ta - Bún Bò Huế Mụ Rơi', 'Gà ta xé, nước dùng trong và lá chanh. Món được chuẩn bị mới tại Bún Bò Huế Mụ Rơi.', '/images/foods/10063.jpg', '20-30 phút', 47000, 0, 2, 1008)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100804, 'Bún bò Huế đặc biệt - Bún Bò Huế Mụ Rơi', 'Bò, giò heo, chả cua và nước dùng sả ớt. Món được chuẩn bị mới tại Bún Bò Huế Mụ Rơi.', '/images/foods/10064.jpg', '20-30 phút', 53000, 0, 2, 1008)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100805, 'Bún riêu cua - Bún Bò Huế Mụ Rơi', 'Riêu cua đồng, đậu hũ, cà chua và mắm tôm. Món được chuẩn bị mới tại Bún Bò Huế Mụ Rơi.', '/images/foods/10071.jpg', '20-30 phút', 59000, 0, 2, 1008)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100806, 'Bún chả Hà Nội - Bún Bò Huế Mụ Rơi', 'Thịt nướng than hoa, chả viên và nước mắm. Món được chuẩn bị mới tại Bún Bò Huế Mụ Rơi.', '/images/foods/10072.jpg', '20-30 phút', 65000, 0, 2, 1008)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100807, 'Bún thịt nướng - Bún Bò Huế Mụ Rơi', 'Thịt nướng sả, đồ chua, rau và đậu phộng. Món được chuẩn bị mới tại Bún Bò Huế Mụ Rơi.', '/images/foods/10073.jpg', '20-30 phút', 71000, 0, 2, 1008)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100808, 'Bún mọc - Bún Bò Huế Mụ Rơi', 'Mọc thịt, sườn non và nước dùng thanh. Món được chuẩn bị mới tại Bún Bò Huế Mụ Rơi.', '/images/foods/10074.jpg', '20-30 phút', 77000, 0, 2, 1008)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100809, 'Bún cá - Bún Bò Huế Mụ Rơi', 'Cá chiên giòn, bún tươi và rau cần. Món được chuẩn bị mới tại Bún Bò Huế Mụ Rơi.', '/images/foods/10081.jpg', '20-30 phút', 83000, 0, 2, 1008)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100810, 'Phở đặc biệt - Bún Bò Huế Mụ Rơi', 'Tái, nạm, gân, bò viên trong tô lớn. Món được chuẩn bị mới tại Bún Bò Huế Mụ Rơi.', '/images/foods/10082.jpg', '20-30 phút', 89000, 0, 2, 1008)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1009, 'Phở Thìn Lò Đúc', 'Phở bò tái lăn', 'Phở bò tái lăn. Chuyên phục vụ bún - phở với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10063.jpg', 0, '40 Đường FoodHub, Quận 9, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (2, 1009, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100901, 'Phở bò tái - Phở Thìn Lò Đúc', 'Bò tái mềm, bánh phở và nước dùng hầm xương. Món được chuẩn bị mới tại Phở Thìn Lò Đúc.', '/images/foods/10061.jpg', '20-30 phút', 35000, 0, 2, 1009)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100902, 'Phở bò tái nạm - Phở Thìn Lò Đúc', 'Bò tái, nạm mềm và hành thơm. Món được chuẩn bị mới tại Phở Thìn Lò Đúc.', '/images/foods/10062.jpg', '20-30 phút', 41000, 0, 2, 1009)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100903, 'Phở gà ta - Phở Thìn Lò Đúc', 'Gà ta xé, nước dùng trong và lá chanh. Món được chuẩn bị mới tại Phở Thìn Lò Đúc.', '/images/foods/10063.jpg', '20-30 phút', 47000, 0, 2, 1009)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100904, 'Bún bò Huế đặc biệt - Phở Thìn Lò Đúc', 'Bò, giò heo, chả cua và nước dùng sả ớt. Món được chuẩn bị mới tại Phở Thìn Lò Đúc.', '/images/foods/10064.jpg', '20-30 phút', 53000, 0, 2, 1009)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100905, 'Bún riêu cua - Phở Thìn Lò Đúc', 'Riêu cua đồng, đậu hũ, cà chua và mắm tôm. Món được chuẩn bị mới tại Phở Thìn Lò Đúc.', '/images/foods/10071.jpg', '20-30 phút', 59000, 0, 2, 1009)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100906, 'Bún chả Hà Nội - Phở Thìn Lò Đúc', 'Thịt nướng than hoa, chả viên và nước mắm. Món được chuẩn bị mới tại Phở Thìn Lò Đúc.', '/images/foods/10072.jpg', '20-30 phút', 65000, 0, 2, 1009)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100907, 'Bún thịt nướng - Phở Thìn Lò Đúc', 'Thịt nướng sả, đồ chua, rau và đậu phộng. Món được chuẩn bị mới tại Phở Thìn Lò Đúc.', '/images/foods/10073.jpg', '20-30 phút', 71000, 0, 2, 1009)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100908, 'Bún mọc - Phở Thìn Lò Đúc', 'Mọc thịt, sườn non và nước dùng thanh. Món được chuẩn bị mới tại Phở Thìn Lò Đúc.', '/images/foods/10074.jpg', '20-30 phút', 77000, 0, 2, 1009)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100909, 'Bún cá - Phở Thìn Lò Đúc', 'Cá chiên giòn, bún tươi và rau cần. Món được chuẩn bị mới tại Phở Thìn Lò Đúc.', '/images/foods/10081.jpg', '20-30 phút', 83000, 0, 2, 1009)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (100910, 'Phở đặc biệt - Phở Thìn Lò Đúc', 'Tái, nạm, gân, bò viên trong tô lớn. Món được chuẩn bị mới tại Phở Thìn Lò Đúc.', '/images/foods/10082.jpg', '20-30 phút', 89000, 0, 2, 1009)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1010, 'Bún Riêu Cô Ba', 'Bún riêu cua đồng', 'Bún riêu cua đồng. Chuyên phục vụ bún - phở với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10064.jpg', 1, '51 Đường FoodHub, Quận 10, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (2, 1010, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101001, 'Phở bò tái - Bún Riêu Cô Ba', 'Bò tái mềm, bánh phở và nước dùng hầm xương. Món được chuẩn bị mới tại Bún Riêu Cô Ba.', '/images/foods/10061.jpg', '20-30 phút', 35000, 1, 2, 1010)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101002, 'Phở bò tái nạm - Bún Riêu Cô Ba', 'Bò tái, nạm mềm và hành thơm. Món được chuẩn bị mới tại Bún Riêu Cô Ba.', '/images/foods/10062.jpg', '20-30 phút', 41000, 1, 2, 1010)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101003, 'Phở gà ta - Bún Riêu Cô Ba', 'Gà ta xé, nước dùng trong và lá chanh. Món được chuẩn bị mới tại Bún Riêu Cô Ba.', '/images/foods/10063.jpg', '20-30 phút', 47000, 1, 2, 1010)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101004, 'Bún bò Huế đặc biệt - Bún Riêu Cô Ba', 'Bò, giò heo, chả cua và nước dùng sả ớt. Món được chuẩn bị mới tại Bún Riêu Cô Ba.', '/images/foods/10064.jpg', '20-30 phút', 53000, 1, 2, 1010)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101005, 'Bún riêu cua - Bún Riêu Cô Ba', 'Riêu cua đồng, đậu hũ, cà chua và mắm tôm. Món được chuẩn bị mới tại Bún Riêu Cô Ba.', '/images/foods/10071.jpg', '20-30 phút', 59000, 1, 2, 1010)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101006, 'Bún chả Hà Nội - Bún Riêu Cô Ba', 'Thịt nướng than hoa, chả viên và nước mắm. Món được chuẩn bị mới tại Bún Riêu Cô Ba.', '/images/foods/10072.jpg', '20-30 phút', 65000, 1, 2, 1010)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101007, 'Bún thịt nướng - Bún Riêu Cô Ba', 'Thịt nướng sả, đồ chua, rau và đậu phộng. Món được chuẩn bị mới tại Bún Riêu Cô Ba.', '/images/foods/10073.jpg', '20-30 phút', 71000, 1, 2, 1010)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101008, 'Bún mọc - Bún Riêu Cô Ba', 'Mọc thịt, sườn non và nước dùng thanh. Món được chuẩn bị mới tại Bún Riêu Cô Ba.', '/images/foods/10074.jpg', '20-30 phút', 77000, 1, 2, 1010)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101009, 'Bún cá - Bún Riêu Cô Ba', 'Cá chiên giòn, bún tươi và rau cần. Món được chuẩn bị mới tại Bún Riêu Cô Ba.', '/images/foods/10081.jpg', '20-30 phút', 83000, 1, 2, 1010)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101010, 'Phở đặc biệt - Bún Riêu Cô Ba', 'Tái, nạm, gân, bò viên trong tô lớn. Món được chuẩn bị mới tại Bún Riêu Cô Ba.', '/images/foods/10082.jpg', '20-30 phút', 89000, 1, 2, 1010)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1011, 'Bún Chả Hà Nội', 'Bún chả than hoa', 'Bún chả than hoa. Chuyên phục vụ bún - phở với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10071.jpg', 0, '62 Đường FoodHub, Quận 11, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (2, 1011, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101101, 'Phở bò tái - Bún Chả Hà Nội', 'Bò tái mềm, bánh phở và nước dùng hầm xương. Món được chuẩn bị mới tại Bún Chả Hà Nội.', '/images/foods/10061.jpg', '20-30 phút', 35000, 0, 2, 1011)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101102, 'Phở bò tái nạm - Bún Chả Hà Nội', 'Bò tái, nạm mềm và hành thơm. Món được chuẩn bị mới tại Bún Chả Hà Nội.', '/images/foods/10062.jpg', '20-30 phút', 41000, 0, 2, 1011)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101103, 'Phở gà ta - Bún Chả Hà Nội', 'Gà ta xé, nước dùng trong và lá chanh. Món được chuẩn bị mới tại Bún Chả Hà Nội.', '/images/foods/10063.jpg', '20-30 phút', 47000, 0, 2, 1011)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101104, 'Bún bò Huế đặc biệt - Bún Chả Hà Nội', 'Bò, giò heo, chả cua và nước dùng sả ớt. Món được chuẩn bị mới tại Bún Chả Hà Nội.', '/images/foods/10064.jpg', '20-30 phút', 53000, 0, 2, 1011)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101105, 'Bún riêu cua - Bún Chả Hà Nội', 'Riêu cua đồng, đậu hũ, cà chua và mắm tôm. Món được chuẩn bị mới tại Bún Chả Hà Nội.', '/images/foods/10071.jpg', '20-30 phút', 59000, 0, 2, 1011)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101106, 'Bún chả Hà Nội - Bún Chả Hà Nội', 'Thịt nướng than hoa, chả viên và nước mắm. Món được chuẩn bị mới tại Bún Chả Hà Nội.', '/images/foods/10072.jpg', '20-30 phút', 65000, 0, 2, 1011)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101107, 'Bún thịt nướng - Bún Chả Hà Nội', 'Thịt nướng sả, đồ chua, rau và đậu phộng. Món được chuẩn bị mới tại Bún Chả Hà Nội.', '/images/foods/10073.jpg', '20-30 phút', 71000, 0, 2, 1011)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101108, 'Bún mọc - Bún Chả Hà Nội', 'Mọc thịt, sườn non và nước dùng thanh. Món được chuẩn bị mới tại Bún Chả Hà Nội.', '/images/foods/10074.jpg', '20-30 phút', 77000, 0, 2, 1011)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101109, 'Bún cá - Bún Chả Hà Nội', 'Cá chiên giòn, bún tươi và rau cần. Món được chuẩn bị mới tại Bún Chả Hà Nội.', '/images/foods/10081.jpg', '20-30 phút', 83000, 0, 2, 1011)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101110, 'Phở đặc biệt - Bún Chả Hà Nội', 'Tái, nạm, gân, bò viên trong tô lớn. Món được chuẩn bị mới tại Bún Chả Hà Nội.', '/images/foods/10082.jpg', '20-30 phút', 89000, 0, 2, 1011)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1012, 'Phở Gà Phố Cổ', 'Phở gà thanh ngọt', 'Phở gà thanh ngọt. Chuyên phục vụ bún - phở với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10072.jpg', 0, '73 Đường FoodHub, Quận 12, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (2, 1012, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101201, 'Phở bò tái - Phở Gà Phố Cổ', 'Bò tái mềm, bánh phở và nước dùng hầm xương. Món được chuẩn bị mới tại Phở Gà Phố Cổ.', '/images/foods/10061.jpg', '20-30 phút', 35000, 0, 2, 1012)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101202, 'Phở bò tái nạm - Phở Gà Phố Cổ', 'Bò tái, nạm mềm và hành thơm. Món được chuẩn bị mới tại Phở Gà Phố Cổ.', '/images/foods/10062.jpg', '20-30 phút', 41000, 0, 2, 1012)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101203, 'Phở gà ta - Phở Gà Phố Cổ', 'Gà ta xé, nước dùng trong và lá chanh. Món được chuẩn bị mới tại Phở Gà Phố Cổ.', '/images/foods/10063.jpg', '20-30 phút', 47000, 0, 2, 1012)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101204, 'Bún bò Huế đặc biệt - Phở Gà Phố Cổ', 'Bò, giò heo, chả cua và nước dùng sả ớt. Món được chuẩn bị mới tại Phở Gà Phố Cổ.', '/images/foods/10064.jpg', '20-30 phút', 53000, 0, 2, 1012)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101205, 'Bún riêu cua - Phở Gà Phố Cổ', 'Riêu cua đồng, đậu hũ, cà chua và mắm tôm. Món được chuẩn bị mới tại Phở Gà Phố Cổ.', '/images/foods/10071.jpg', '20-30 phút', 59000, 0, 2, 1012)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101206, 'Bún chả Hà Nội - Phở Gà Phố Cổ', 'Thịt nướng than hoa, chả viên và nước mắm. Món được chuẩn bị mới tại Phở Gà Phố Cổ.', '/images/foods/10072.jpg', '20-30 phút', 65000, 0, 2, 1012)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101207, 'Bún thịt nướng - Phở Gà Phố Cổ', 'Thịt nướng sả, đồ chua, rau và đậu phộng. Món được chuẩn bị mới tại Phở Gà Phố Cổ.', '/images/foods/10073.jpg', '20-30 phút', 71000, 0, 2, 1012)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101208, 'Bún mọc - Phở Gà Phố Cổ', 'Mọc thịt, sườn non và nước dùng thanh. Món được chuẩn bị mới tại Phở Gà Phố Cổ.', '/images/foods/10074.jpg', '20-30 phút', 77000, 0, 2, 1012)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101209, 'Bún cá - Phở Gà Phố Cổ', 'Cá chiên giòn, bún tươi và rau cần. Món được chuẩn bị mới tại Phở Gà Phố Cổ.', '/images/foods/10081.jpg', '20-30 phút', 83000, 0, 2, 1012)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101210, 'Phở đặc biệt - Phở Gà Phố Cổ', 'Tái, nạm, gân, bò viên trong tô lớn. Món được chuẩn bị mới tại Phở Gà Phố Cổ.', '/images/foods/10082.jpg', '20-30 phút', 89000, 0, 2, 1012)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1013, 'Bánh Mì Huỳnh Hoa', 'Bánh mì đầy đặn Sài Gòn', 'Bánh mì đầy đặn Sài Gòn. Chuyên phục vụ bánh mì với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10111.jpg', 1, '18 Đường FoodHub, Quận 1, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (3, 1013, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101301, 'Bánh mì đặc biệt', 'Pate, chả lụa, thịt nguội và rau thơm. Món được chuẩn bị mới tại Bánh Mì Huỳnh Hoa.', '/images/foods/10111.jpg', '20-30 phút', 18000, 1, 3, 1013)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101302, 'Bánh mì thịt nướng', 'Thịt nướng sả, đồ chua và sốt bơ. Món được chuẩn bị mới tại Bánh Mì Huỳnh Hoa.', '/images/foods/10112.jpg', '20-30 phút', 21000, 1, 3, 1013)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101303, 'Bánh mì heo quay', 'Heo quay da giòn, dưa leo và nước sốt. Món được chuẩn bị mới tại Bánh Mì Huỳnh Hoa.', '/images/foods/10113.jpg', '20-30 phút', 24000, 1, 3, 1013)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101304, 'Bánh mì xíu mại', 'Xíu mại mềm, sốt cà chua và hành ngò. Món được chuẩn bị mới tại Bánh Mì Huỳnh Hoa.', '/images/foods/10114.jpg', '20-30 phút', 27000, 1, 3, 1013)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101305, 'Bánh mì chả cá', 'Chả cá chiên nóng, rau răm và tương ớt. Món được chuẩn bị mới tại Bánh Mì Huỳnh Hoa.', '/images/foods/10121.jpg', '20-30 phút', 30000, 1, 3, 1013)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101306, 'Bánh mì gà xé', 'Gà xé, pate, sốt trứng và rau thơm. Món được chuẩn bị mới tại Bánh Mì Huỳnh Hoa.', '/images/foods/10122.jpg', '20-30 phút', 33000, 1, 3, 1013)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101307, 'Bánh mì bò nướng', 'Bò nướng tiêu đen, hành tây và xà lách. Món được chuẩn bị mới tại Bánh Mì Huỳnh Hoa.', '/images/foods/10123.jpg', '20-30 phút', 36000, 1, 3, 1013)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101308, 'Bánh mì pate trứng', 'Pate nhà làm và hai trứng ốp la. Món được chuẩn bị mới tại Bánh Mì Huỳnh Hoa.', '/images/foods/10124.jpg', '20-30 phút', 39000, 1, 3, 1013)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101309, 'Bánh mì chảo bò', 'Bò né, trứng, xíu mại kèm bánh mì. Món được chuẩn bị mới tại Bánh Mì Huỳnh Hoa.', '/images/foods/10131.jpg', '20-30 phút', 42000, 1, 3, 1013)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101310, 'Bánh mì que', 'Bánh mì que giòn với pate và chà bông. Món được chuẩn bị mới tại Bánh Mì Huỳnh Hoa.', '/images/foods/10132.jpg', '20-30 phút', 45000, 1, 3, 1013)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1014, 'Bánh Mì Phượng', 'Bánh mì Hội An', 'Bánh mì Hội An. Chuyên phục vụ bánh mì với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10112.jpg', 0, '29 Đường FoodHub, Quận 2, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (3, 1014, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101401, 'Bánh mì đặc biệt - Bánh Mì Phượng', 'Pate, chả lụa, thịt nguội và rau thơm. Món được chuẩn bị mới tại Bánh Mì Phượng.', '/images/foods/10111.jpg', '20-30 phút', 18000, 0, 3, 1014)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101402, 'Bánh mì thịt nướng - Bánh Mì Phượng', 'Thịt nướng sả, đồ chua và sốt bơ. Món được chuẩn bị mới tại Bánh Mì Phượng.', '/images/foods/10112.jpg', '20-30 phút', 21000, 0, 3, 1014)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101403, 'Bánh mì heo quay - Bánh Mì Phượng', 'Heo quay da giòn, dưa leo và nước sốt. Món được chuẩn bị mới tại Bánh Mì Phượng.', '/images/foods/10113.jpg', '20-30 phút', 24000, 0, 3, 1014)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101404, 'Bánh mì xíu mại - Bánh Mì Phượng', 'Xíu mại mềm, sốt cà chua và hành ngò. Món được chuẩn bị mới tại Bánh Mì Phượng.', '/images/foods/10114.jpg', '20-30 phút', 27000, 0, 3, 1014)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101405, 'Bánh mì chả cá - Bánh Mì Phượng', 'Chả cá chiên nóng, rau răm và tương ớt. Món được chuẩn bị mới tại Bánh Mì Phượng.', '/images/foods/10121.jpg', '20-30 phút', 30000, 0, 3, 1014)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101406, 'Bánh mì gà xé - Bánh Mì Phượng', 'Gà xé, pate, sốt trứng và rau thơm. Món được chuẩn bị mới tại Bánh Mì Phượng.', '/images/foods/10122.jpg', '20-30 phút', 33000, 0, 3, 1014)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101407, 'Bánh mì bò nướng - Bánh Mì Phượng', 'Bò nướng tiêu đen, hành tây và xà lách. Món được chuẩn bị mới tại Bánh Mì Phượng.', '/images/foods/10123.jpg', '20-30 phút', 36000, 0, 3, 1014)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101408, 'Bánh mì pate trứng - Bánh Mì Phượng', 'Pate nhà làm và hai trứng ốp la. Món được chuẩn bị mới tại Bánh Mì Phượng.', '/images/foods/10124.jpg', '20-30 phút', 39000, 0, 3, 1014)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101409, 'Bánh mì chảo bò - Bánh Mì Phượng', 'Bò né, trứng, xíu mại kèm bánh mì. Món được chuẩn bị mới tại Bánh Mì Phượng.', '/images/foods/10131.jpg', '20-30 phút', 42000, 0, 3, 1014)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101410, 'Bánh mì que - Bánh Mì Phượng', 'Bánh mì que giòn với pate và chà bông. Món được chuẩn bị mới tại Bánh Mì Phượng.', '/images/foods/10132.jpg', '20-30 phút', 45000, 0, 3, 1014)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1015, 'Bánh Mì Như Lan', 'Bánh mì lâu đời', 'Bánh mì lâu đời. Chuyên phục vụ bánh mì với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10113.jpg', 0, '40 Đường FoodHub, Quận 3, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (3, 1015, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101501, 'Bánh mì đặc biệt - Bánh Mì Như Lan', 'Pate, chả lụa, thịt nguội và rau thơm. Món được chuẩn bị mới tại Bánh Mì Như Lan.', '/images/foods/10111.jpg', '20-30 phút', 18000, 0, 3, 1015)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101502, 'Bánh mì thịt nướng - Bánh Mì Như Lan', 'Thịt nướng sả, đồ chua và sốt bơ. Món được chuẩn bị mới tại Bánh Mì Như Lan.', '/images/foods/10112.jpg', '20-30 phút', 21000, 0, 3, 1015)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101503, 'Bánh mì heo quay - Bánh Mì Như Lan', 'Heo quay da giòn, dưa leo và nước sốt. Món được chuẩn bị mới tại Bánh Mì Như Lan.', '/images/foods/10113.jpg', '20-30 phút', 24000, 0, 3, 1015)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101504, 'Bánh mì xíu mại - Bánh Mì Như Lan', 'Xíu mại mềm, sốt cà chua và hành ngò. Món được chuẩn bị mới tại Bánh Mì Như Lan.', '/images/foods/10114.jpg', '20-30 phút', 27000, 0, 3, 1015)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101505, 'Bánh mì chả cá - Bánh Mì Như Lan', 'Chả cá chiên nóng, rau răm và tương ớt. Món được chuẩn bị mới tại Bánh Mì Như Lan.', '/images/foods/10121.jpg', '20-30 phút', 30000, 0, 3, 1015)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101506, 'Bánh mì gà xé - Bánh Mì Như Lan', 'Gà xé, pate, sốt trứng và rau thơm. Món được chuẩn bị mới tại Bánh Mì Như Lan.', '/images/foods/10122.jpg', '20-30 phút', 33000, 0, 3, 1015)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101507, 'Bánh mì bò nướng - Bánh Mì Như Lan', 'Bò nướng tiêu đen, hành tây và xà lách. Món được chuẩn bị mới tại Bánh Mì Như Lan.', '/images/foods/10123.jpg', '20-30 phút', 36000, 0, 3, 1015)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101508, 'Bánh mì pate trứng - Bánh Mì Như Lan', 'Pate nhà làm và hai trứng ốp la. Món được chuẩn bị mới tại Bánh Mì Như Lan.', '/images/foods/10124.jpg', '20-30 phút', 39000, 0, 3, 1015)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101509, 'Bánh mì chảo bò - Bánh Mì Như Lan', 'Bò né, trứng, xíu mại kèm bánh mì. Món được chuẩn bị mới tại Bánh Mì Như Lan.', '/images/foods/10131.jpg', '20-30 phút', 42000, 0, 3, 1015)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101510, 'Bánh mì que - Bánh Mì Như Lan', 'Bánh mì que giòn với pate và chà bông. Món được chuẩn bị mới tại Bánh Mì Như Lan.', '/images/foods/10132.jpg', '20-30 phút', 45000, 0, 3, 1015)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1016, 'Bánh Mì Chảo Cô Ba', 'Bánh mì chảo nóng', 'Bánh mì chảo nóng. Chuyên phục vụ bánh mì với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10114.jpg', 1, '51 Đường FoodHub, Quận 4, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (3, 1016, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101601, 'Bánh mì đặc biệt - Bánh Mì Chảo Cô Ba', 'Pate, chả lụa, thịt nguội và rau thơm. Món được chuẩn bị mới tại Bánh Mì Chảo Cô Ba.', '/images/foods/10111.jpg', '20-30 phút', 18000, 1, 3, 1016)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101602, 'Bánh mì thịt nướng - Bánh Mì Chảo Cô Ba', 'Thịt nướng sả, đồ chua và sốt bơ. Món được chuẩn bị mới tại Bánh Mì Chảo Cô Ba.', '/images/foods/10112.jpg', '20-30 phút', 21000, 1, 3, 1016)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101603, 'Bánh mì heo quay - Bánh Mì Chảo Cô Ba', 'Heo quay da giòn, dưa leo và nước sốt. Món được chuẩn bị mới tại Bánh Mì Chảo Cô Ba.', '/images/foods/10113.jpg', '20-30 phút', 24000, 1, 3, 1016)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101604, 'Bánh mì xíu mại - Bánh Mì Chảo Cô Ba', 'Xíu mại mềm, sốt cà chua và hành ngò. Món được chuẩn bị mới tại Bánh Mì Chảo Cô Ba.', '/images/foods/10114.jpg', '20-30 phút', 27000, 1, 3, 1016)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101605, 'Bánh mì chả cá - Bánh Mì Chảo Cô Ba', 'Chả cá chiên nóng, rau răm và tương ớt. Món được chuẩn bị mới tại Bánh Mì Chảo Cô Ba.', '/images/foods/10121.jpg', '20-30 phút', 30000, 1, 3, 1016)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101606, 'Bánh mì gà xé - Bánh Mì Chảo Cô Ba', 'Gà xé, pate, sốt trứng và rau thơm. Món được chuẩn bị mới tại Bánh Mì Chảo Cô Ba.', '/images/foods/10122.jpg', '20-30 phút', 33000, 1, 3, 1016)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101607, 'Bánh mì bò nướng - Bánh Mì Chảo Cô Ba', 'Bò nướng tiêu đen, hành tây và xà lách. Món được chuẩn bị mới tại Bánh Mì Chảo Cô Ba.', '/images/foods/10123.jpg', '20-30 phút', 36000, 1, 3, 1016)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101608, 'Bánh mì pate trứng - Bánh Mì Chảo Cô Ba', 'Pate nhà làm và hai trứng ốp la. Món được chuẩn bị mới tại Bánh Mì Chảo Cô Ba.', '/images/foods/10124.jpg', '20-30 phút', 39000, 1, 3, 1016)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101609, 'Bánh mì chảo bò - Bánh Mì Chảo Cô Ba', 'Bò né, trứng, xíu mại kèm bánh mì. Món được chuẩn bị mới tại Bánh Mì Chảo Cô Ba.', '/images/foods/10131.jpg', '20-30 phút', 42000, 1, 3, 1016)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101610, 'Bánh mì que - Bánh Mì Chảo Cô Ba', 'Bánh mì que giòn với pate và chà bông. Món được chuẩn bị mới tại Bánh Mì Chảo Cô Ba.', '/images/foods/10132.jpg', '20-30 phút', 45000, 1, 3, 1016)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1017, 'Bánh Mì Pate Sài Gòn', 'Pate nhà làm', 'Pate nhà làm. Chuyên phục vụ bánh mì với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10121.jpg', 0, '62 Đường FoodHub, Quận 5, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (3, 1017, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101701, 'Bánh mì đặc biệt - Bánh Mì Pate Sài Gòn', 'Pate, chả lụa, thịt nguội và rau thơm. Món được chuẩn bị mới tại Bánh Mì Pate Sài Gòn.', '/images/foods/10111.jpg', '20-30 phút', 18000, 0, 3, 1017)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101702, 'Bánh mì thịt nướng - Bánh Mì Pate Sài Gòn', 'Thịt nướng sả, đồ chua và sốt bơ. Món được chuẩn bị mới tại Bánh Mì Pate Sài Gòn.', '/images/foods/10112.jpg', '20-30 phút', 21000, 0, 3, 1017)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101703, 'Bánh mì heo quay - Bánh Mì Pate Sài Gòn', 'Heo quay da giòn, dưa leo và nước sốt. Món được chuẩn bị mới tại Bánh Mì Pate Sài Gòn.', '/images/foods/10113.jpg', '20-30 phút', 24000, 0, 3, 1017)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101704, 'Bánh mì xíu mại - Bánh Mì Pate Sài Gòn', 'Xíu mại mềm, sốt cà chua và hành ngò. Món được chuẩn bị mới tại Bánh Mì Pate Sài Gòn.', '/images/foods/10114.jpg', '20-30 phút', 27000, 0, 3, 1017)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101705, 'Bánh mì chả cá - Bánh Mì Pate Sài Gòn', 'Chả cá chiên nóng, rau răm và tương ớt. Món được chuẩn bị mới tại Bánh Mì Pate Sài Gòn.', '/images/foods/10121.jpg', '20-30 phút', 30000, 0, 3, 1017)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101706, 'Bánh mì gà xé - Bánh Mì Pate Sài Gòn', 'Gà xé, pate, sốt trứng và rau thơm. Món được chuẩn bị mới tại Bánh Mì Pate Sài Gòn.', '/images/foods/10122.jpg', '20-30 phút', 33000, 0, 3, 1017)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101707, 'Bánh mì bò nướng - Bánh Mì Pate Sài Gòn', 'Bò nướng tiêu đen, hành tây và xà lách. Món được chuẩn bị mới tại Bánh Mì Pate Sài Gòn.', '/images/foods/10123.jpg', '20-30 phút', 36000, 0, 3, 1017)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101708, 'Bánh mì pate trứng - Bánh Mì Pate Sài Gòn', 'Pate nhà làm và hai trứng ốp la. Món được chuẩn bị mới tại Bánh Mì Pate Sài Gòn.', '/images/foods/10124.jpg', '20-30 phút', 39000, 0, 3, 1017)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101709, 'Bánh mì chảo bò - Bánh Mì Pate Sài Gòn', 'Bò né, trứng, xíu mại kèm bánh mì. Món được chuẩn bị mới tại Bánh Mì Pate Sài Gòn.', '/images/foods/10131.jpg', '20-30 phút', 42000, 0, 3, 1017)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101710, 'Bánh mì que - Bánh Mì Pate Sài Gòn', 'Bánh mì que giòn với pate và chà bông. Món được chuẩn bị mới tại Bánh Mì Pate Sài Gòn.', '/images/foods/10132.jpg', '20-30 phút', 45000, 0, 3, 1017)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1018, 'Bánh Mì Ốp La 24H', 'Bánh mì nóng cả ngày', 'Bánh mì nóng cả ngày. Chuyên phục vụ bánh mì với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10122.jpg', 0, '73 Đường FoodHub, Quận 6, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (3, 1018, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101801, 'Bánh mì đặc biệt - Bánh Mì Ốp La 24H', 'Pate, chả lụa, thịt nguội và rau thơm. Món được chuẩn bị mới tại Bánh Mì Ốp La 24H.', '/images/foods/10111.jpg', '20-30 phút', 18000, 0, 3, 1018)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101802, 'Bánh mì thịt nướng - Bánh Mì Ốp La 24H', 'Thịt nướng sả, đồ chua và sốt bơ. Món được chuẩn bị mới tại Bánh Mì Ốp La 24H.', '/images/foods/10112.jpg', '20-30 phút', 21000, 0, 3, 1018)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101803, 'Bánh mì heo quay - Bánh Mì Ốp La 24H', 'Heo quay da giòn, dưa leo và nước sốt. Món được chuẩn bị mới tại Bánh Mì Ốp La 24H.', '/images/foods/10113.jpg', '20-30 phút', 24000, 0, 3, 1018)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101804, 'Bánh mì xíu mại - Bánh Mì Ốp La 24H', 'Xíu mại mềm, sốt cà chua và hành ngò. Món được chuẩn bị mới tại Bánh Mì Ốp La 24H.', '/images/foods/10114.jpg', '20-30 phút', 27000, 0, 3, 1018)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101805, 'Bánh mì chả cá - Bánh Mì Ốp La 24H', 'Chả cá chiên nóng, rau răm và tương ớt. Món được chuẩn bị mới tại Bánh Mì Ốp La 24H.', '/images/foods/10121.jpg', '20-30 phút', 30000, 0, 3, 1018)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101806, 'Bánh mì gà xé - Bánh Mì Ốp La 24H', 'Gà xé, pate, sốt trứng và rau thơm. Món được chuẩn bị mới tại Bánh Mì Ốp La 24H.', '/images/foods/10122.jpg', '20-30 phút', 33000, 0, 3, 1018)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101807, 'Bánh mì bò nướng - Bánh Mì Ốp La 24H', 'Bò nướng tiêu đen, hành tây và xà lách. Món được chuẩn bị mới tại Bánh Mì Ốp La 24H.', '/images/foods/10123.jpg', '20-30 phút', 36000, 0, 3, 1018)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101808, 'Bánh mì pate trứng - Bánh Mì Ốp La 24H', 'Pate nhà làm và hai trứng ốp la. Món được chuẩn bị mới tại Bánh Mì Ốp La 24H.', '/images/foods/10124.jpg', '20-30 phút', 39000, 0, 3, 1018)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101809, 'Bánh mì chảo bò - Bánh Mì Ốp La 24H', 'Bò né, trứng, xíu mại kèm bánh mì. Món được chuẩn bị mới tại Bánh Mì Ốp La 24H.', '/images/foods/10131.jpg', '20-30 phút', 42000, 0, 3, 1018)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101810, 'Bánh mì que - Bánh Mì Ốp La 24H', 'Bánh mì que giòn với pate và chà bông. Món được chuẩn bị mới tại Bánh Mì Ốp La 24H.', '/images/foods/10132.jpg', '20-30 phút', 45000, 0, 3, 1018)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1019, 'Trà Sữa Gong Cha', 'Trà sữa Đài Loan', 'Trà sữa Đài Loan. Chuyên phục vụ đồ uống với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10161.jpg', 1, '18 Đường FoodHub, Quận 7, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (4, 1019, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101901, 'Trà sữa trân châu đen', 'Trà sữa thơm, trân châu đen dẻo. Món được chuẩn bị mới tại Trà Sữa Gong Cha.', '/images/foods/10161.jpg', '20-30 phút', 18000, 1, 4, 1019)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101902, 'Sữa tươi trân châu đường đen', 'Sữa tươi và đường nâu caramel. Món được chuẩn bị mới tại Trà Sữa Gong Cha.', '/images/foods/10162.jpg', '20-30 phút', 23000, 1, 4, 1019)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101903, 'Trà đào cam sả', 'Trà đào, cam vàng và sả tươi. Món được chuẩn bị mới tại Trà Sữa Gong Cha.', '/images/foods/10163.jpg', '20-30 phút', 28000, 1, 4, 1019)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101904, 'Matcha latte', 'Matcha Nhật Bản hòa cùng sữa tươi. Món được chuẩn bị mới tại Trà Sữa Gong Cha.', '/images/foods/10164.jpg', '20-30 phút', 33000, 1, 4, 1019)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101905, 'Trà ô long kem cheese', 'Ô long rang và lớp kem cheese mặn nhẹ. Món được chuẩn bị mới tại Trà Sữa Gong Cha.', '/images/foods/10171.jpg', '20-30 phút', 38000, 1, 4, 1019)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101906, 'Cà phê sữa đá', 'Cà phê rang đậm pha cùng sữa đặc. Món được chuẩn bị mới tại Trà Sữa Gong Cha.', '/images/foods/10172.jpg', '20-30 phút', 43000, 1, 4, 1019)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101907, 'Cold brew cam vàng', 'Cold brew dịu nhẹ với cam vàng. Món được chuẩn bị mới tại Trà Sữa Gong Cha.', '/images/foods/10173.jpg', '20-30 phút', 48000, 1, 4, 1019)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101908, 'Hồng trà macchiato', 'Hồng trà thơm cùng kem macchiato. Món được chuẩn bị mới tại Trà Sữa Gong Cha.', '/images/foods/10174.jpg', '20-30 phút', 53000, 1, 4, 1019)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101909, 'Chocolate đá xay', 'Chocolate, sữa và kem tươi. Món được chuẩn bị mới tại Trà Sữa Gong Cha.', '/images/foods/10181.jpg', '20-30 phút', 58000, 1, 4, 1019)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (101910, 'Trà vải nha đam', 'Trà thanh mát, vải và nha đam giòn. Món được chuẩn bị mới tại Trà Sữa Gong Cha.', '/images/foods/10182.jpg', '20-30 phút', 63000, 1, 4, 1019)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1020, 'KOI Thé', 'Trà sữa kem macchiato', 'Trà sữa kem macchiato. Chuyên phục vụ đồ uống với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10162.jpg', 0, '29 Đường FoodHub, Quận 8, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (4, 1020, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102001, 'Trà sữa trân châu đen - KOI Thé', 'Trà sữa thơm, trân châu đen dẻo. Món được chuẩn bị mới tại KOI Thé.', '/images/foods/10161.jpg', '20-30 phút', 18000, 0, 4, 1020)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102002, 'Sữa tươi trân châu đường đen - KOI Thé', 'Sữa tươi và đường nâu caramel. Món được chuẩn bị mới tại KOI Thé.', '/images/foods/10162.jpg', '20-30 phút', 23000, 0, 4, 1020)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102003, 'Trà đào cam sả - KOI Thé', 'Trà đào, cam vàng và sả tươi. Món được chuẩn bị mới tại KOI Thé.', '/images/foods/10163.jpg', '20-30 phút', 28000, 0, 4, 1020)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102004, 'Matcha latte - KOI Thé', 'Matcha Nhật Bản hòa cùng sữa tươi. Món được chuẩn bị mới tại KOI Thé.', '/images/foods/10164.jpg', '20-30 phút', 33000, 0, 4, 1020)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102005, 'Trà ô long kem cheese - KOI Thé', 'Ô long rang và lớp kem cheese mặn nhẹ. Món được chuẩn bị mới tại KOI Thé.', '/images/foods/10171.jpg', '20-30 phút', 38000, 0, 4, 1020)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102006, 'Cà phê sữa đá - KOI Thé', 'Cà phê rang đậm pha cùng sữa đặc. Món được chuẩn bị mới tại KOI Thé.', '/images/foods/10172.jpg', '20-30 phút', 43000, 0, 4, 1020)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102007, 'Cold brew cam vàng - KOI Thé', 'Cold brew dịu nhẹ với cam vàng. Món được chuẩn bị mới tại KOI Thé.', '/images/foods/10173.jpg', '20-30 phút', 48000, 0, 4, 1020)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102008, 'Hồng trà macchiato - KOI Thé', 'Hồng trà thơm cùng kem macchiato. Món được chuẩn bị mới tại KOI Thé.', '/images/foods/10174.jpg', '20-30 phút', 53000, 0, 4, 1020)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102009, 'Chocolate đá xay - KOI Thé', 'Chocolate, sữa và kem tươi. Món được chuẩn bị mới tại KOI Thé.', '/images/foods/10181.jpg', '20-30 phút', 58000, 0, 4, 1020)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102010, 'Trà vải nha đam - KOI Thé', 'Trà thanh mát, vải và nha đam giòn. Món được chuẩn bị mới tại KOI Thé.', '/images/foods/10182.jpg', '20-30 phút', 63000, 0, 4, 1020)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1021, 'TocoToco Bubble Tea', 'Trà sữa topping đa dạng', 'Trà sữa topping đa dạng. Chuyên phục vụ đồ uống với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10163.jpg', 0, '40 Đường FoodHub, Quận 9, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (4, 1021, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102101, 'Trà sữa trân châu đen - TocoToco Bubble Tea', 'Trà sữa thơm, trân châu đen dẻo. Món được chuẩn bị mới tại TocoToco Bubble Tea.', '/images/foods/10161.jpg', '20-30 phút', 18000, 0, 4, 1021)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102102, 'Sữa tươi trân châu đường đen - TocoToco Bubble Tea', 'Sữa tươi và đường nâu caramel. Món được chuẩn bị mới tại TocoToco Bubble Tea.', '/images/foods/10162.jpg', '20-30 phút', 23000, 0, 4, 1021)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102103, 'Trà đào cam sả - TocoToco Bubble Tea', 'Trà đào, cam vàng và sả tươi. Món được chuẩn bị mới tại TocoToco Bubble Tea.', '/images/foods/10163.jpg', '20-30 phút', 28000, 0, 4, 1021)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102104, 'Matcha latte - TocoToco Bubble Tea', 'Matcha Nhật Bản hòa cùng sữa tươi. Món được chuẩn bị mới tại TocoToco Bubble Tea.', '/images/foods/10164.jpg', '20-30 phút', 33000, 0, 4, 1021)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102105, 'Trà ô long kem cheese - TocoToco Bubble Tea', 'Ô long rang và lớp kem cheese mặn nhẹ. Món được chuẩn bị mới tại TocoToco Bubble Tea.', '/images/foods/10171.jpg', '20-30 phút', 38000, 0, 4, 1021)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102106, 'Cà phê sữa đá - TocoToco Bubble Tea', 'Cà phê rang đậm pha cùng sữa đặc. Món được chuẩn bị mới tại TocoToco Bubble Tea.', '/images/foods/10172.jpg', '20-30 phút', 43000, 0, 4, 1021)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102107, 'Cold brew cam vàng - TocoToco Bubble Tea', 'Cold brew dịu nhẹ với cam vàng. Món được chuẩn bị mới tại TocoToco Bubble Tea.', '/images/foods/10173.jpg', '20-30 phút', 48000, 0, 4, 1021)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102108, 'Hồng trà macchiato - TocoToco Bubble Tea', 'Hồng trà thơm cùng kem macchiato. Món được chuẩn bị mới tại TocoToco Bubble Tea.', '/images/foods/10174.jpg', '20-30 phút', 53000, 0, 4, 1021)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102109, 'Chocolate đá xay - TocoToco Bubble Tea', 'Chocolate, sữa và kem tươi. Món được chuẩn bị mới tại TocoToco Bubble Tea.', '/images/foods/10181.jpg', '20-30 phút', 58000, 0, 4, 1021)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102110, 'Trà vải nha đam - TocoToco Bubble Tea', 'Trà thanh mát, vải và nha đam giòn. Món được chuẩn bị mới tại TocoToco Bubble Tea.', '/images/foods/10182.jpg', '20-30 phút', 63000, 0, 4, 1021)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1022, 'Phúc Long Coffee & Tea', 'Trà và cà phê Việt', 'Trà và cà phê Việt. Chuyên phục vụ đồ uống với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10164.jpg', 1, '51 Đường FoodHub, Quận 10, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (4, 1022, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102201, 'Trà sữa trân châu đen - Phúc Long Coffee & Tea', 'Trà sữa thơm, trân châu đen dẻo. Món được chuẩn bị mới tại Phúc Long Coffee & Tea.', '/images/foods/10161.jpg', '20-30 phút', 18000, 1, 4, 1022)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102202, 'Sữa tươi trân châu đường đen - Phúc Long Coffee & Tea', 'Sữa tươi và đường nâu caramel. Món được chuẩn bị mới tại Phúc Long Coffee & Tea.', '/images/foods/10162.jpg', '20-30 phút', 23000, 1, 4, 1022)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102203, 'Trà đào cam sả - Phúc Long Coffee & Tea', 'Trà đào, cam vàng và sả tươi. Món được chuẩn bị mới tại Phúc Long Coffee & Tea.', '/images/foods/10163.jpg', '20-30 phút', 28000, 1, 4, 1022)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102204, 'Matcha latte - Phúc Long Coffee & Tea', 'Matcha Nhật Bản hòa cùng sữa tươi. Món được chuẩn bị mới tại Phúc Long Coffee & Tea.', '/images/foods/10164.jpg', '20-30 phút', 33000, 1, 4, 1022)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102205, 'Trà ô long kem cheese - Phúc Long Coffee & Tea', 'Ô long rang và lớp kem cheese mặn nhẹ. Món được chuẩn bị mới tại Phúc Long Coffee & Tea.', '/images/foods/10171.jpg', '20-30 phút', 38000, 1, 4, 1022)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102206, 'Cà phê sữa đá - Phúc Long Coffee & Tea', 'Cà phê rang đậm pha cùng sữa đặc. Món được chuẩn bị mới tại Phúc Long Coffee & Tea.', '/images/foods/10172.jpg', '20-30 phút', 43000, 1, 4, 1022)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102207, 'Cold brew cam vàng - Phúc Long Coffee & Tea', 'Cold brew dịu nhẹ với cam vàng. Món được chuẩn bị mới tại Phúc Long Coffee & Tea.', '/images/foods/10173.jpg', '20-30 phút', 48000, 1, 4, 1022)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102208, 'Hồng trà macchiato - Phúc Long Coffee & Tea', 'Hồng trà thơm cùng kem macchiato. Món được chuẩn bị mới tại Phúc Long Coffee & Tea.', '/images/foods/10174.jpg', '20-30 phút', 53000, 1, 4, 1022)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102209, 'Chocolate đá xay - Phúc Long Coffee & Tea', 'Chocolate, sữa và kem tươi. Món được chuẩn bị mới tại Phúc Long Coffee & Tea.', '/images/foods/10181.jpg', '20-30 phút', 58000, 1, 4, 1022)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102210, 'Trà vải nha đam - Phúc Long Coffee & Tea', 'Trà thanh mát, vải và nha đam giòn. Món được chuẩn bị mới tại Phúc Long Coffee & Tea.', '/images/foods/10182.jpg', '20-30 phút', 63000, 1, 4, 1022)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1023, 'The Alley Việt Nam', 'Sữa tươi đường nâu', 'Sữa tươi đường nâu. Chuyên phục vụ đồ uống với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10171.jpg', 0, '62 Đường FoodHub, Quận 11, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (4, 1023, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102301, 'Trà sữa trân châu đen - The Alley Việt Nam', 'Trà sữa thơm, trân châu đen dẻo. Món được chuẩn bị mới tại The Alley Việt Nam.', '/images/foods/10161.jpg', '20-30 phút', 18000, 0, 4, 1023)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102302, 'Sữa tươi trân châu đường đen - The Alley Việt Nam', 'Sữa tươi và đường nâu caramel. Món được chuẩn bị mới tại The Alley Việt Nam.', '/images/foods/10162.jpg', '20-30 phút', 23000, 0, 4, 1023)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102303, 'Trà đào cam sả - The Alley Việt Nam', 'Trà đào, cam vàng và sả tươi. Món được chuẩn bị mới tại The Alley Việt Nam.', '/images/foods/10163.jpg', '20-30 phút', 28000, 0, 4, 1023)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102304, 'Matcha latte - The Alley Việt Nam', 'Matcha Nhật Bản hòa cùng sữa tươi. Món được chuẩn bị mới tại The Alley Việt Nam.', '/images/foods/10164.jpg', '20-30 phút', 33000, 0, 4, 1023)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102305, 'Trà ô long kem cheese - The Alley Việt Nam', 'Ô long rang và lớp kem cheese mặn nhẹ. Món được chuẩn bị mới tại The Alley Việt Nam.', '/images/foods/10171.jpg', '20-30 phút', 38000, 0, 4, 1023)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102306, 'Cà phê sữa đá - The Alley Việt Nam', 'Cà phê rang đậm pha cùng sữa đặc. Món được chuẩn bị mới tại The Alley Việt Nam.', '/images/foods/10172.jpg', '20-30 phút', 43000, 0, 4, 1023)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102307, 'Cold brew cam vàng - The Alley Việt Nam', 'Cold brew dịu nhẹ với cam vàng. Món được chuẩn bị mới tại The Alley Việt Nam.', '/images/foods/10173.jpg', '20-30 phút', 48000, 0, 4, 1023)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102308, 'Hồng trà macchiato - The Alley Việt Nam', 'Hồng trà thơm cùng kem macchiato. Món được chuẩn bị mới tại The Alley Việt Nam.', '/images/foods/10174.jpg', '20-30 phút', 53000, 0, 4, 1023)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102309, 'Chocolate đá xay - The Alley Việt Nam', 'Chocolate, sữa và kem tươi. Món được chuẩn bị mới tại The Alley Việt Nam.', '/images/foods/10181.jpg', '20-30 phút', 58000, 0, 4, 1023)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102310, 'Trà vải nha đam - The Alley Việt Nam', 'Trà thanh mát, vải và nha đam giòn. Món được chuẩn bị mới tại The Alley Việt Nam.', '/images/foods/10182.jpg', '20-30 phút', 63000, 0, 4, 1023)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1024, 'Highlands Coffee Express', 'Cà phê Việt hiện đại', 'Cà phê Việt hiện đại. Chuyên phục vụ đồ uống với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10172.jpg', 0, '73 Đường FoodHub, Quận 12, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (4, 1024, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102401, 'Trà sữa trân châu đen - Highlands Coffee Express', 'Trà sữa thơm, trân châu đen dẻo. Món được chuẩn bị mới tại Highlands Coffee Express.', '/images/foods/10161.jpg', '20-30 phút', 18000, 0, 4, 1024)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102402, 'Sữa tươi trân châu đường đen - Highlands Coffee Express', 'Sữa tươi và đường nâu caramel. Món được chuẩn bị mới tại Highlands Coffee Express.', '/images/foods/10162.jpg', '20-30 phút', 23000, 0, 4, 1024)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102403, 'Trà đào cam sả - Highlands Coffee Express', 'Trà đào, cam vàng và sả tươi. Món được chuẩn bị mới tại Highlands Coffee Express.', '/images/foods/10163.jpg', '20-30 phút', 28000, 0, 4, 1024)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102404, 'Matcha latte - Highlands Coffee Express', 'Matcha Nhật Bản hòa cùng sữa tươi. Món được chuẩn bị mới tại Highlands Coffee Express.', '/images/foods/10164.jpg', '20-30 phút', 33000, 0, 4, 1024)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102405, 'Trà ô long kem cheese - Highlands Coffee Express', 'Ô long rang và lớp kem cheese mặn nhẹ. Món được chuẩn bị mới tại Highlands Coffee Express.', '/images/foods/10171.jpg', '20-30 phút', 38000, 0, 4, 1024)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102406, 'Cà phê sữa đá - Highlands Coffee Express', 'Cà phê rang đậm pha cùng sữa đặc. Món được chuẩn bị mới tại Highlands Coffee Express.', '/images/foods/10172.jpg', '20-30 phút', 43000, 0, 4, 1024)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102407, 'Cold brew cam vàng - Highlands Coffee Express', 'Cold brew dịu nhẹ với cam vàng. Món được chuẩn bị mới tại Highlands Coffee Express.', '/images/foods/10173.jpg', '20-30 phút', 48000, 0, 4, 1024)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102408, 'Hồng trà macchiato - Highlands Coffee Express', 'Hồng trà thơm cùng kem macchiato. Món được chuẩn bị mới tại Highlands Coffee Express.', '/images/foods/10174.jpg', '20-30 phút', 53000, 0, 4, 1024)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102409, 'Chocolate đá xay - Highlands Coffee Express', 'Chocolate, sữa và kem tươi. Món được chuẩn bị mới tại Highlands Coffee Express.', '/images/foods/10181.jpg', '20-30 phút', 58000, 0, 4, 1024)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102410, 'Trà vải nha đam - Highlands Coffee Express', 'Trà thanh mát, vải và nha đam giòn. Món được chuẩn bị mới tại Highlands Coffee Express.', '/images/foods/10182.jpg', '20-30 phút', 63000, 0, 4, 1024)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1025, 'KFC Việt Nam', 'Gà rán giòn tan', 'Gà rán giòn tan. Chuyên phục vụ gà rán với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10211.jpg', 1, '18 Đường FoodHub, Quận 1, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (5, 1025, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102501, 'Gà rán truyền thống', 'Hai miếng gà giòn theo công thức riêng. Món được chuẩn bị mới tại KFC Việt Nam.', '/images/foods/10211.jpg', '20-30 phút', 35000, 1, 5, 1025)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102502, 'Gà rán cay', 'Gà giòn phủ gia vị cay thơm. Món được chuẩn bị mới tại KFC Việt Nam.', '/images/foods/10212.jpg', '20-30 phút', 51000, 1, 5, 1025)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102503, 'Gà sốt tương tỏi', 'Gà rán phủ sốt tương tỏi Hàn Quốc. Món được chuẩn bị mới tại KFC Việt Nam.', '/images/foods/10213.jpg', '20-30 phút', 67000, 1, 5, 1025)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102504, 'Gà sốt mật ong', 'Gà không xương sốt mật ong ngọt dịu. Món được chuẩn bị mới tại KFC Việt Nam.', '/images/foods/10214.jpg', '20-30 phút', 83000, 1, 5, 1025)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102505, 'Cánh gà chiên nước mắm', 'Cánh gà giòn áo sốt nước mắm. Món được chuẩn bị mới tại KFC Việt Nam.', '/images/foods/10221.jpg', '20-30 phút', 99000, 1, 5, 1025)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102506, 'Burger gà giòn', 'Gà giòn, xà lách và sốt mayo. Món được chuẩn bị mới tại KFC Việt Nam.', '/images/foods/10222.jpg', '20-30 phút', 115000, 1, 5, 1025)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102507, 'Gà popcorn', 'Viên gà nhỏ giòn, tiện dùng. Món được chuẩn bị mới tại KFC Việt Nam.', '/images/foods/10223.jpg', '20-30 phút', 131000, 1, 5, 1025)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102508, 'Combo gà cá nhân', 'Hai miếng gà, khoai tây và nước. Món được chuẩn bị mới tại KFC Việt Nam.', '/images/foods/10224.jpg', '20-30 phút', 147000, 1, 5, 1025)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102509, 'Combo gà gia đình', 'Sáu miếng gà, khoai và salad. Món được chuẩn bị mới tại KFC Việt Nam.', '/images/foods/10231.jpg', '20-30 phút', 163000, 1, 5, 1025)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102510, 'Khoai tây chiên', 'Khoai tây vàng giòn rắc muối. Món được chuẩn bị mới tại KFC Việt Nam.', '/images/foods/10232.jpg', '20-30 phút', 179000, 1, 5, 1025)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1026, 'Texas Chicken', 'Gà rán vị Texas', 'Gà rán vị Texas. Chuyên phục vụ gà rán với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10212.jpg', 0, '29 Đường FoodHub, Quận 2, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (5, 1026, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102601, 'Gà rán truyền thống - Texas Chicken', 'Hai miếng gà giòn theo công thức riêng. Món được chuẩn bị mới tại Texas Chicken.', '/images/foods/10211.jpg', '20-30 phút', 35000, 0, 5, 1026)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102602, 'Gà rán cay - Texas Chicken', 'Gà giòn phủ gia vị cay thơm. Món được chuẩn bị mới tại Texas Chicken.', '/images/foods/10212.jpg', '20-30 phút', 51000, 0, 5, 1026)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102603, 'Gà sốt tương tỏi - Texas Chicken', 'Gà rán phủ sốt tương tỏi Hàn Quốc. Món được chuẩn bị mới tại Texas Chicken.', '/images/foods/10213.jpg', '20-30 phút', 67000, 0, 5, 1026)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102604, 'Gà sốt mật ong - Texas Chicken', 'Gà không xương sốt mật ong ngọt dịu. Món được chuẩn bị mới tại Texas Chicken.', '/images/foods/10214.jpg', '20-30 phút', 83000, 0, 5, 1026)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102605, 'Cánh gà chiên nước mắm - Texas Chicken', 'Cánh gà giòn áo sốt nước mắm. Món được chuẩn bị mới tại Texas Chicken.', '/images/foods/10221.jpg', '20-30 phút', 99000, 0, 5, 1026)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102606, 'Burger gà giòn - Texas Chicken', 'Gà giòn, xà lách và sốt mayo. Món được chuẩn bị mới tại Texas Chicken.', '/images/foods/10222.jpg', '20-30 phút', 115000, 0, 5, 1026)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102607, 'Gà popcorn - Texas Chicken', 'Viên gà nhỏ giòn, tiện dùng. Món được chuẩn bị mới tại Texas Chicken.', '/images/foods/10223.jpg', '20-30 phút', 131000, 0, 5, 1026)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102608, 'Combo gà cá nhân - Texas Chicken', 'Hai miếng gà, khoai tây và nước. Món được chuẩn bị mới tại Texas Chicken.', '/images/foods/10224.jpg', '20-30 phút', 147000, 0, 5, 1026)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102609, 'Combo gà gia đình - Texas Chicken', 'Sáu miếng gà, khoai và salad. Món được chuẩn bị mới tại Texas Chicken.', '/images/foods/10231.jpg', '20-30 phút', 163000, 0, 5, 1026)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102610, 'Khoai tây chiên - Texas Chicken', 'Khoai tây vàng giòn rắc muối. Món được chuẩn bị mới tại Texas Chicken.', '/images/foods/10232.jpg', '20-30 phút', 179000, 0, 5, 1026)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1027, 'Popeyes Louisiana Kitchen', 'Gà rán Louisiana', 'Gà rán Louisiana. Chuyên phục vụ gà rán với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10213.jpg', 0, '40 Đường FoodHub, Quận 3, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (5, 1027, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102701, 'Gà rán truyền thống - Popeyes Louisiana Kitchen', 'Hai miếng gà giòn theo công thức riêng. Món được chuẩn bị mới tại Popeyes Louisiana Kitchen.', '/images/foods/10211.jpg', '20-30 phút', 35000, 0, 5, 1027)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102702, 'Gà rán cay - Popeyes Louisiana Kitchen', 'Gà giòn phủ gia vị cay thơm. Món được chuẩn bị mới tại Popeyes Louisiana Kitchen.', '/images/foods/10212.jpg', '20-30 phút', 51000, 0, 5, 1027)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102703, 'Gà sốt tương tỏi - Popeyes Louisiana Kitchen', 'Gà rán phủ sốt tương tỏi Hàn Quốc. Món được chuẩn bị mới tại Popeyes Louisiana Kitchen.', '/images/foods/10213.jpg', '20-30 phút', 67000, 0, 5, 1027)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102704, 'Gà sốt mật ong - Popeyes Louisiana Kitchen', 'Gà không xương sốt mật ong ngọt dịu. Món được chuẩn bị mới tại Popeyes Louisiana Kitchen.', '/images/foods/10214.jpg', '20-30 phút', 83000, 0, 5, 1027)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102705, 'Cánh gà chiên nước mắm - Popeyes Louisiana Kitchen', 'Cánh gà giòn áo sốt nước mắm. Món được chuẩn bị mới tại Popeyes Louisiana Kitchen.', '/images/foods/10221.jpg', '20-30 phút', 99000, 0, 5, 1027)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102706, 'Burger gà giòn - Popeyes Louisiana Kitchen', 'Gà giòn, xà lách và sốt mayo. Món được chuẩn bị mới tại Popeyes Louisiana Kitchen.', '/images/foods/10222.jpg', '20-30 phút', 115000, 0, 5, 1027)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102707, 'Gà popcorn - Popeyes Louisiana Kitchen', 'Viên gà nhỏ giòn, tiện dùng. Món được chuẩn bị mới tại Popeyes Louisiana Kitchen.', '/images/foods/10223.jpg', '20-30 phút', 131000, 0, 5, 1027)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102708, 'Combo gà cá nhân - Popeyes Louisiana Kitchen', 'Hai miếng gà, khoai tây và nước. Món được chuẩn bị mới tại Popeyes Louisiana Kitchen.', '/images/foods/10224.jpg', '20-30 phút', 147000, 0, 5, 1027)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102709, 'Combo gà gia đình - Popeyes Louisiana Kitchen', 'Sáu miếng gà, khoai và salad. Món được chuẩn bị mới tại Popeyes Louisiana Kitchen.', '/images/foods/10231.jpg', '20-30 phút', 163000, 0, 5, 1027)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102710, 'Khoai tây chiên - Popeyes Louisiana Kitchen', 'Khoai tây vàng giòn rắc muối. Món được chuẩn bị mới tại Popeyes Louisiana Kitchen.', '/images/foods/10232.jpg', '20-30 phút', 179000, 0, 5, 1027)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1028, 'Lotteria Chicken', 'Gà rán Hàn Quốc', 'Gà rán Hàn Quốc. Chuyên phục vụ gà rán với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10214.jpg', 1, '51 Đường FoodHub, Quận 4, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (5, 1028, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102801, 'Gà rán truyền thống - Lotteria Chicken', 'Hai miếng gà giòn theo công thức riêng. Món được chuẩn bị mới tại Lotteria Chicken.', '/images/foods/10211.jpg', '20-30 phút', 35000, 1, 5, 1028)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102802, 'Gà rán cay - Lotteria Chicken', 'Gà giòn phủ gia vị cay thơm. Món được chuẩn bị mới tại Lotteria Chicken.', '/images/foods/10212.jpg', '20-30 phút', 51000, 1, 5, 1028)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102803, 'Gà sốt tương tỏi - Lotteria Chicken', 'Gà rán phủ sốt tương tỏi Hàn Quốc. Món được chuẩn bị mới tại Lotteria Chicken.', '/images/foods/10213.jpg', '20-30 phút', 67000, 1, 5, 1028)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102804, 'Gà sốt mật ong - Lotteria Chicken', 'Gà không xương sốt mật ong ngọt dịu. Món được chuẩn bị mới tại Lotteria Chicken.', '/images/foods/10214.jpg', '20-30 phút', 83000, 1, 5, 1028)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102805, 'Cánh gà chiên nước mắm - Lotteria Chicken', 'Cánh gà giòn áo sốt nước mắm. Món được chuẩn bị mới tại Lotteria Chicken.', '/images/foods/10221.jpg', '20-30 phút', 99000, 1, 5, 1028)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102806, 'Burger gà giòn - Lotteria Chicken', 'Gà giòn, xà lách và sốt mayo. Món được chuẩn bị mới tại Lotteria Chicken.', '/images/foods/10222.jpg', '20-30 phút', 115000, 1, 5, 1028)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102807, 'Gà popcorn - Lotteria Chicken', 'Viên gà nhỏ giòn, tiện dùng. Món được chuẩn bị mới tại Lotteria Chicken.', '/images/foods/10223.jpg', '20-30 phút', 131000, 1, 5, 1028)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102808, 'Combo gà cá nhân - Lotteria Chicken', 'Hai miếng gà, khoai tây và nước. Món được chuẩn bị mới tại Lotteria Chicken.', '/images/foods/10224.jpg', '20-30 phút', 147000, 1, 5, 1028)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102809, 'Combo gà gia đình - Lotteria Chicken', 'Sáu miếng gà, khoai và salad. Món được chuẩn bị mới tại Lotteria Chicken.', '/images/foods/10231.jpg', '20-30 phút', 163000, 1, 5, 1028)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102810, 'Khoai tây chiên - Lotteria Chicken', 'Khoai tây vàng giòn rắc muối. Món được chuẩn bị mới tại Lotteria Chicken.', '/images/foods/10232.jpg', '20-30 phút', 179000, 1, 5, 1028)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1029, 'Gà Rán Seoul', 'Gà sốt Hàn Quốc', 'Gà sốt Hàn Quốc. Chuyên phục vụ gà rán với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10221.jpg', 0, '62 Đường FoodHub, Quận 5, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (5, 1029, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102901, 'Gà rán truyền thống - Gà Rán Seoul', 'Hai miếng gà giòn theo công thức riêng. Món được chuẩn bị mới tại Gà Rán Seoul.', '/images/foods/10211.jpg', '20-30 phút', 35000, 0, 5, 1029)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102902, 'Gà rán cay - Gà Rán Seoul', 'Gà giòn phủ gia vị cay thơm. Món được chuẩn bị mới tại Gà Rán Seoul.', '/images/foods/10212.jpg', '20-30 phút', 51000, 0, 5, 1029)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102903, 'Gà sốt tương tỏi - Gà Rán Seoul', 'Gà rán phủ sốt tương tỏi Hàn Quốc. Món được chuẩn bị mới tại Gà Rán Seoul.', '/images/foods/10213.jpg', '20-30 phút', 67000, 0, 5, 1029)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102904, 'Gà sốt mật ong - Gà Rán Seoul', 'Gà không xương sốt mật ong ngọt dịu. Món được chuẩn bị mới tại Gà Rán Seoul.', '/images/foods/10214.jpg', '20-30 phút', 83000, 0, 5, 1029)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102905, 'Cánh gà chiên nước mắm - Gà Rán Seoul', 'Cánh gà giòn áo sốt nước mắm. Món được chuẩn bị mới tại Gà Rán Seoul.', '/images/foods/10221.jpg', '20-30 phút', 99000, 0, 5, 1029)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102906, 'Burger gà giòn - Gà Rán Seoul', 'Gà giòn, xà lách và sốt mayo. Món được chuẩn bị mới tại Gà Rán Seoul.', '/images/foods/10222.jpg', '20-30 phút', 115000, 0, 5, 1029)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102907, 'Gà popcorn - Gà Rán Seoul', 'Viên gà nhỏ giòn, tiện dùng. Món được chuẩn bị mới tại Gà Rán Seoul.', '/images/foods/10223.jpg', '20-30 phút', 131000, 0, 5, 1029)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102908, 'Combo gà cá nhân - Gà Rán Seoul', 'Hai miếng gà, khoai tây và nước. Món được chuẩn bị mới tại Gà Rán Seoul.', '/images/foods/10224.jpg', '20-30 phút', 147000, 0, 5, 1029)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102909, 'Combo gà gia đình - Gà Rán Seoul', 'Sáu miếng gà, khoai và salad. Món được chuẩn bị mới tại Gà Rán Seoul.', '/images/foods/10231.jpg', '20-30 phút', 163000, 0, 5, 1029)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (102910, 'Khoai tây chiên - Gà Rán Seoul', 'Khoai tây vàng giòn rắc muối. Món được chuẩn bị mới tại Gà Rán Seoul.', '/images/foods/10232.jpg', '20-30 phút', 179000, 0, 5, 1029)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1030, 'Chicken Plus', 'Gà rán và sốt đặc biệt', 'Gà rán và sốt đặc biệt. Chuyên phục vụ gà rán với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10222.jpg', 0, '73 Đường FoodHub, Quận 6, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (5, 1030, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103001, 'Gà rán truyền thống - Chicken Plus', 'Hai miếng gà giòn theo công thức riêng. Món được chuẩn bị mới tại Chicken Plus.', '/images/foods/10211.jpg', '20-30 phút', 35000, 0, 5, 1030)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103002, 'Gà rán cay - Chicken Plus', 'Gà giòn phủ gia vị cay thơm. Món được chuẩn bị mới tại Chicken Plus.', '/images/foods/10212.jpg', '20-30 phút', 51000, 0, 5, 1030)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103003, 'Gà sốt tương tỏi - Chicken Plus', 'Gà rán phủ sốt tương tỏi Hàn Quốc. Món được chuẩn bị mới tại Chicken Plus.', '/images/foods/10213.jpg', '20-30 phút', 67000, 0, 5, 1030)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103004, 'Gà sốt mật ong - Chicken Plus', 'Gà không xương sốt mật ong ngọt dịu. Món được chuẩn bị mới tại Chicken Plus.', '/images/foods/10214.jpg', '20-30 phút', 83000, 0, 5, 1030)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103005, 'Cánh gà chiên nước mắm - Chicken Plus', 'Cánh gà giòn áo sốt nước mắm. Món được chuẩn bị mới tại Chicken Plus.', '/images/foods/10221.jpg', '20-30 phút', 99000, 0, 5, 1030)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103006, 'Burger gà giòn - Chicken Plus', 'Gà giòn, xà lách và sốt mayo. Món được chuẩn bị mới tại Chicken Plus.', '/images/foods/10222.jpg', '20-30 phút', 115000, 0, 5, 1030)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103007, 'Gà popcorn - Chicken Plus', 'Viên gà nhỏ giòn, tiện dùng. Món được chuẩn bị mới tại Chicken Plus.', '/images/foods/10223.jpg', '20-30 phút', 131000, 0, 5, 1030)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103008, 'Combo gà cá nhân - Chicken Plus', 'Hai miếng gà, khoai tây và nước. Món được chuẩn bị mới tại Chicken Plus.', '/images/foods/10224.jpg', '20-30 phút', 147000, 0, 5, 1030)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103009, 'Combo gà gia đình - Chicken Plus', 'Sáu miếng gà, khoai và salad. Món được chuẩn bị mới tại Chicken Plus.', '/images/foods/10231.jpg', '20-30 phút', 163000, 0, 5, 1030)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103010, 'Khoai tây chiên - Chicken Plus', 'Khoai tây vàng giòn rắc muối. Món được chuẩn bị mới tại Chicken Plus.', '/images/foods/10232.jpg', '20-30 phút', 179000, 0, 5, 1030)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1031, 'Pizza Hut', 'Pizza Ý phong phú', 'Pizza Ý phong phú. Chuyên phục vụ pizza với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10261.jpg', 1, '18 Đường FoodHub, Quận 7, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (6, 1031, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103101, 'Pizza Pepperoni', 'Pepperoni, mozzarella và sốt cà chua. Món được chuẩn bị mới tại Pizza Hut.', '/images/foods/10261.jpg', '30-45 phút', 79000, 1, 6, 1031)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103102, 'Pizza hải sản', 'Tôm, mực, thanh cua và sốt mayonnaise. Món được chuẩn bị mới tại Pizza Hut.', '/images/foods/10262.jpg', '30-45 phút', 103000, 1, 6, 1031)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103103, 'Pizza BBQ gà', 'Gà nướng BBQ, hành tây và ớt chuông. Món được chuẩn bị mới tại Pizza Hut.', '/images/foods/10263.jpg', '30-45 phút', 127000, 1, 6, 1031)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103104, 'Pizza bốn phô mai', 'Mozzarella, cheddar, parmesan và gouda. Món được chuẩn bị mới tại Pizza Hut.', '/images/foods/10264.jpg', '30-45 phút', 151000, 1, 6, 1031)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103105, 'Pizza Margherita', 'Cà chua, mozzarella và húng quế. Món được chuẩn bị mới tại Pizza Hut.', '/images/foods/10271.jpg', '30-45 phút', 175000, 1, 6, 1031)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103106, 'Pizza bò bằm', 'Bò bằm, nấm, hành tây và phô mai. Món được chuẩn bị mới tại Pizza Hut.', '/images/foods/10272.jpg', '30-45 phút', 199000, 1, 6, 1031)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103107, 'Pizza Hawaiian', 'Thịt nguội, dứa và mozzarella. Món được chuẩn bị mới tại Pizza Hut.', '/images/foods/10273.jpg', '30-45 phút', 223000, 1, 6, 1031)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103108, 'Pizza xúc xích Ý', 'Xúc xích Ý, olive và ớt chuông. Món được chuẩn bị mới tại Pizza Hut.', '/images/foods/10274.jpg', '30-45 phút', 247000, 1, 6, 1031)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103109, 'Pizza nấm truffle', 'Nấm hỗn hợp, dầu truffle và phô mai. Món được chuẩn bị mới tại Pizza Hut.', '/images/foods/10281.jpg', '30-45 phút', 271000, 1, 6, 1031)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103110, 'Pizza rau củ nướng', 'Bí ngòi, cà tím, ớt chuông và nấm. Món được chuẩn bị mới tại Pizza Hut.', '/images/foods/10282.jpg', '30-45 phút', 295000, 1, 6, 1031)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1032, 'Domino''s Pizza', 'Pizza giao nhanh', 'Pizza giao nhanh. Chuyên phục vụ pizza với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10262.jpg', 0, '29 Đường FoodHub, Quận 8, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (6, 1032, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103201, 'Pizza Pepperoni - Domino''s Pizza', 'Pepperoni, mozzarella và sốt cà chua. Món được chuẩn bị mới tại Domino''s Pizza.', '/images/foods/10261.jpg', '30-45 phút', 79000, 0, 6, 1032)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103202, 'Pizza hải sản - Domino''s Pizza', 'Tôm, mực, thanh cua và sốt mayonnaise. Món được chuẩn bị mới tại Domino''s Pizza.', '/images/foods/10262.jpg', '30-45 phút', 103000, 0, 6, 1032)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103203, 'Pizza BBQ gà - Domino''s Pizza', 'Gà nướng BBQ, hành tây và ớt chuông. Món được chuẩn bị mới tại Domino''s Pizza.', '/images/foods/10263.jpg', '30-45 phút', 127000, 0, 6, 1032)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103204, 'Pizza bốn phô mai - Domino''s Pizza', 'Mozzarella, cheddar, parmesan và gouda. Món được chuẩn bị mới tại Domino''s Pizza.', '/images/foods/10264.jpg', '30-45 phút', 151000, 0, 6, 1032)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103205, 'Pizza Margherita - Domino''s Pizza', 'Cà chua, mozzarella và húng quế. Món được chuẩn bị mới tại Domino''s Pizza.', '/images/foods/10271.jpg', '30-45 phút', 175000, 0, 6, 1032)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103206, 'Pizza bò bằm - Domino''s Pizza', 'Bò bằm, nấm, hành tây và phô mai. Món được chuẩn bị mới tại Domino''s Pizza.', '/images/foods/10272.jpg', '30-45 phút', 199000, 0, 6, 1032)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103207, 'Pizza Hawaiian - Domino''s Pizza', 'Thịt nguội, dứa và mozzarella. Món được chuẩn bị mới tại Domino''s Pizza.', '/images/foods/10273.jpg', '30-45 phút', 223000, 0, 6, 1032)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103208, 'Pizza xúc xích Ý - Domino''s Pizza', 'Xúc xích Ý, olive và ớt chuông. Món được chuẩn bị mới tại Domino''s Pizza.', '/images/foods/10274.jpg', '30-45 phút', 247000, 0, 6, 1032)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103209, 'Pizza nấm truffle - Domino''s Pizza', 'Nấm hỗn hợp, dầu truffle và phô mai. Món được chuẩn bị mới tại Domino''s Pizza.', '/images/foods/10281.jpg', '30-45 phút', 271000, 0, 6, 1032)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103210, 'Pizza rau củ nướng - Domino''s Pizza', 'Bí ngòi, cà tím, ớt chuông và nấm. Món được chuẩn bị mới tại Domino''s Pizza.', '/images/foods/10282.jpg', '30-45 phút', 295000, 0, 6, 1032)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1033, 'Pizza 4P''s', 'Pizza phô mai thủ công', 'Pizza phô mai thủ công. Chuyên phục vụ pizza với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10263.jpg', 0, '40 Đường FoodHub, Quận 9, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (6, 1033, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103301, 'Pizza Pepperoni - Pizza 4P''s', 'Pepperoni, mozzarella và sốt cà chua. Món được chuẩn bị mới tại Pizza 4P''s.', '/images/foods/10261.jpg', '30-45 phút', 79000, 0, 6, 1033)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103302, 'Pizza hải sản - Pizza 4P''s', 'Tôm, mực, thanh cua và sốt mayonnaise. Món được chuẩn bị mới tại Pizza 4P''s.', '/images/foods/10262.jpg', '30-45 phút', 103000, 0, 6, 1033)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103303, 'Pizza BBQ gà - Pizza 4P''s', 'Gà nướng BBQ, hành tây và ớt chuông. Món được chuẩn bị mới tại Pizza 4P''s.', '/images/foods/10263.jpg', '30-45 phút', 127000, 0, 6, 1033)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103304, 'Pizza bốn phô mai - Pizza 4P''s', 'Mozzarella, cheddar, parmesan và gouda. Món được chuẩn bị mới tại Pizza 4P''s.', '/images/foods/10264.jpg', '30-45 phút', 151000, 0, 6, 1033)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103305, 'Pizza Margherita - Pizza 4P''s', 'Cà chua, mozzarella và húng quế. Món được chuẩn bị mới tại Pizza 4P''s.', '/images/foods/10271.jpg', '30-45 phút', 175000, 0, 6, 1033)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103306, 'Pizza bò bằm - Pizza 4P''s', 'Bò bằm, nấm, hành tây và phô mai. Món được chuẩn bị mới tại Pizza 4P''s.', '/images/foods/10272.jpg', '30-45 phút', 199000, 0, 6, 1033)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103307, 'Pizza Hawaiian - Pizza 4P''s', 'Thịt nguội, dứa và mozzarella. Món được chuẩn bị mới tại Pizza 4P''s.', '/images/foods/10273.jpg', '30-45 phút', 223000, 0, 6, 1033)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103308, 'Pizza xúc xích Ý - Pizza 4P''s', 'Xúc xích Ý, olive và ớt chuông. Món được chuẩn bị mới tại Pizza 4P''s.', '/images/foods/10274.jpg', '30-45 phút', 247000, 0, 6, 1033)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103309, 'Pizza nấm truffle - Pizza 4P''s', 'Nấm hỗn hợp, dầu truffle và phô mai. Món được chuẩn bị mới tại Pizza 4P''s.', '/images/foods/10281.jpg', '30-45 phút', 271000, 0, 6, 1033)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103310, 'Pizza rau củ nướng - Pizza 4P''s', 'Bí ngòi, cà tím, ớt chuông và nấm. Món được chuẩn bị mới tại Pizza 4P''s.', '/images/foods/10282.jpg', '30-45 phút', 295000, 0, 6, 1033)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1034, 'The Pizza Company', 'Pizza đa topping', 'Pizza đa topping. Chuyên phục vụ pizza với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10264.jpg', 1, '51 Đường FoodHub, Quận 10, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (6, 1034, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103401, 'Pizza Pepperoni - The Pizza Company', 'Pepperoni, mozzarella và sốt cà chua. Món được chuẩn bị mới tại The Pizza Company.', '/images/foods/10261.jpg', '30-45 phút', 79000, 1, 6, 1034)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103402, 'Pizza hải sản - The Pizza Company', 'Tôm, mực, thanh cua và sốt mayonnaise. Món được chuẩn bị mới tại The Pizza Company.', '/images/foods/10262.jpg', '30-45 phút', 103000, 1, 6, 1034)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103403, 'Pizza BBQ gà - The Pizza Company', 'Gà nướng BBQ, hành tây và ớt chuông. Món được chuẩn bị mới tại The Pizza Company.', '/images/foods/10263.jpg', '30-45 phút', 127000, 1, 6, 1034)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103404, 'Pizza bốn phô mai - The Pizza Company', 'Mozzarella, cheddar, parmesan và gouda. Món được chuẩn bị mới tại The Pizza Company.', '/images/foods/10264.jpg', '30-45 phút', 151000, 1, 6, 1034)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103405, 'Pizza Margherita - The Pizza Company', 'Cà chua, mozzarella và húng quế. Món được chuẩn bị mới tại The Pizza Company.', '/images/foods/10271.jpg', '30-45 phút', 175000, 1, 6, 1034)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103406, 'Pizza bò bằm - The Pizza Company', 'Bò bằm, nấm, hành tây và phô mai. Món được chuẩn bị mới tại The Pizza Company.', '/images/foods/10272.jpg', '30-45 phút', 199000, 1, 6, 1034)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103407, 'Pizza Hawaiian - The Pizza Company', 'Thịt nguội, dứa và mozzarella. Món được chuẩn bị mới tại The Pizza Company.', '/images/foods/10273.jpg', '30-45 phút', 223000, 1, 6, 1034)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103408, 'Pizza xúc xích Ý - The Pizza Company', 'Xúc xích Ý, olive và ớt chuông. Món được chuẩn bị mới tại The Pizza Company.', '/images/foods/10274.jpg', '30-45 phút', 247000, 1, 6, 1034)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103409, 'Pizza nấm truffle - The Pizza Company', 'Nấm hỗn hợp, dầu truffle và phô mai. Món được chuẩn bị mới tại The Pizza Company.', '/images/foods/10281.jpg', '30-45 phút', 271000, 1, 6, 1034)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103410, 'Pizza rau củ nướng - The Pizza Company', 'Bí ngòi, cà tím, ớt chuông và nấm. Món được chuẩn bị mới tại The Pizza Company.', '/images/foods/10282.jpg', '30-45 phút', 295000, 1, 6, 1034)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1035, 'Pizza Roma', 'Pizza đế mỏng Roma', 'Pizza đế mỏng Roma. Chuyên phục vụ pizza với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10271.jpg', 0, '62 Đường FoodHub, Quận 11, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (6, 1035, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103501, 'Pizza Pepperoni - Pizza Roma', 'Pepperoni, mozzarella và sốt cà chua. Món được chuẩn bị mới tại Pizza Roma.', '/images/foods/10261.jpg', '30-45 phút', 79000, 0, 6, 1035)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103502, 'Pizza hải sản - Pizza Roma', 'Tôm, mực, thanh cua và sốt mayonnaise. Món được chuẩn bị mới tại Pizza Roma.', '/images/foods/10262.jpg', '30-45 phút', 103000, 0, 6, 1035)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103503, 'Pizza BBQ gà - Pizza Roma', 'Gà nướng BBQ, hành tây và ớt chuông. Món được chuẩn bị mới tại Pizza Roma.', '/images/foods/10263.jpg', '30-45 phút', 127000, 0, 6, 1035)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103504, 'Pizza bốn phô mai - Pizza Roma', 'Mozzarella, cheddar, parmesan và gouda. Món được chuẩn bị mới tại Pizza Roma.', '/images/foods/10264.jpg', '30-45 phút', 151000, 0, 6, 1035)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103505, 'Pizza Margherita - Pizza Roma', 'Cà chua, mozzarella và húng quế. Món được chuẩn bị mới tại Pizza Roma.', '/images/foods/10271.jpg', '30-45 phút', 175000, 0, 6, 1035)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103506, 'Pizza bò bằm - Pizza Roma', 'Bò bằm, nấm, hành tây và phô mai. Món được chuẩn bị mới tại Pizza Roma.', '/images/foods/10272.jpg', '30-45 phút', 199000, 0, 6, 1035)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103507, 'Pizza Hawaiian - Pizza Roma', 'Thịt nguội, dứa và mozzarella. Món được chuẩn bị mới tại Pizza Roma.', '/images/foods/10273.jpg', '30-45 phút', 223000, 0, 6, 1035)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103508, 'Pizza xúc xích Ý - Pizza Roma', 'Xúc xích Ý, olive và ớt chuông. Món được chuẩn bị mới tại Pizza Roma.', '/images/foods/10274.jpg', '30-45 phút', 247000, 0, 6, 1035)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103509, 'Pizza nấm truffle - Pizza Roma', 'Nấm hỗn hợp, dầu truffle và phô mai. Món được chuẩn bị mới tại Pizza Roma.', '/images/foods/10281.jpg', '30-45 phút', 271000, 0, 6, 1035)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103510, 'Pizza rau củ nướng - Pizza Roma', 'Bí ngòi, cà tím, ớt chuông và nấm. Món được chuẩn bị mới tại Pizza Roma.', '/images/foods/10282.jpg', '30-45 phút', 295000, 0, 6, 1035)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1036, 'Pizza Home', 'Pizza nóng tại nhà', 'Pizza nóng tại nhà. Chuyên phục vụ pizza với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10272.jpg', 0, '73 Đường FoodHub, Quận 12, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (6, 1036, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103601, 'Pizza Pepperoni - Pizza Home', 'Pepperoni, mozzarella và sốt cà chua. Món được chuẩn bị mới tại Pizza Home.', '/images/foods/10261.jpg', '30-45 phút', 79000, 0, 6, 1036)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103602, 'Pizza hải sản - Pizza Home', 'Tôm, mực, thanh cua và sốt mayonnaise. Món được chuẩn bị mới tại Pizza Home.', '/images/foods/10262.jpg', '30-45 phút', 103000, 0, 6, 1036)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103603, 'Pizza BBQ gà - Pizza Home', 'Gà nướng BBQ, hành tây và ớt chuông. Món được chuẩn bị mới tại Pizza Home.', '/images/foods/10263.jpg', '30-45 phút', 127000, 0, 6, 1036)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103604, 'Pizza bốn phô mai - Pizza Home', 'Mozzarella, cheddar, parmesan và gouda. Món được chuẩn bị mới tại Pizza Home.', '/images/foods/10264.jpg', '30-45 phút', 151000, 0, 6, 1036)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103605, 'Pizza Margherita - Pizza Home', 'Cà chua, mozzarella và húng quế. Món được chuẩn bị mới tại Pizza Home.', '/images/foods/10271.jpg', '30-45 phút', 175000, 0, 6, 1036)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103606, 'Pizza bò bằm - Pizza Home', 'Bò bằm, nấm, hành tây và phô mai. Món được chuẩn bị mới tại Pizza Home.', '/images/foods/10272.jpg', '30-45 phút', 199000, 0, 6, 1036)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103607, 'Pizza Hawaiian - Pizza Home', 'Thịt nguội, dứa và mozzarella. Món được chuẩn bị mới tại Pizza Home.', '/images/foods/10273.jpg', '30-45 phút', 223000, 0, 6, 1036)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103608, 'Pizza xúc xích Ý - Pizza Home', 'Xúc xích Ý, olive và ớt chuông. Món được chuẩn bị mới tại Pizza Home.', '/images/foods/10274.jpg', '30-45 phút', 247000, 0, 6, 1036)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103609, 'Pizza nấm truffle - Pizza Home', 'Nấm hỗn hợp, dầu truffle và phô mai. Món được chuẩn bị mới tại Pizza Home.', '/images/foods/10281.jpg', '30-45 phút', 271000, 0, 6, 1036)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103610, 'Pizza rau củ nướng - Pizza Home', 'Bí ngòi, cà tím, ớt chuông và nấm. Món được chuẩn bị mới tại Pizza Home.', '/images/foods/10282.jpg', '30-45 phút', 295000, 0, 6, 1036)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1037, 'Lẩu Thái Mama', 'Lẩu Thái cay nồng', 'Lẩu Thái cay nồng. Chuyên phục vụ lẩu với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10311.jpg', 1, '18 Đường FoodHub, Quận 1, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (7, 1037, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103701, 'Lẩu Thái hải sản', 'Tôm, mực, nghêu và nước lẩu chua cay. Món được chuẩn bị mới tại Lẩu Thái Mama.', '/images/foods/10311.jpg', '30-45 phút', 159000, 1, 7, 1037)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103702, 'Lẩu bò Mỹ', 'Ba chỉ bò Mỹ, nấm và rau theo mùa. Món được chuẩn bị mới tại Lẩu Thái Mama.', '/images/foods/10312.jpg', '30-45 phút', 196000, 1, 7, 1037)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103703, 'Lẩu gà lá é', 'Gà ta, lá é, măng và ớt xiêm xanh. Món được chuẩn bị mới tại Lẩu Thái Mama.', '/images/foods/10313.jpg', '30-45 phút', 233000, 1, 7, 1037)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103704, 'Lẩu nấm', 'Nhiều loại nấm, rau củ và nước dùng thanh. Món được chuẩn bị mới tại Lẩu Thái Mama.', '/images/foods/10314.jpg', '30-45 phút', 270000, 1, 7, 1037)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103705, 'Lẩu mala Đài Loan', 'Nước lẩu mala cay tê cùng thịt bò. Món được chuẩn bị mới tại Lẩu Thái Mama.', '/images/foods/10321.jpg', '30-45 phút', 307000, 1, 7, 1037)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103706, 'Lẩu kim chi', 'Kim chi Hàn Quốc, ba chỉ heo và đậu hũ. Món được chuẩn bị mới tại Lẩu Thái Mama.', '/images/foods/10322.jpg', '30-45 phút', 344000, 1, 7, 1037)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103707, 'Lẩu riêu cua bắp bò', 'Riêu cua, bắp bò, đậu hũ và rau. Món được chuẩn bị mới tại Lẩu Thái Mama.', '/images/foods/10323.jpg', '30-45 phút', 381000, 1, 7, 1037)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103708, 'Lẩu cá kèo', 'Cá kèo tươi, lá giang và rau đắng. Món được chuẩn bị mới tại Lẩu Thái Mama.', '/images/foods/10324.jpg', '30-45 phút', 418000, 1, 7, 1037)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103709, 'Lẩu bò nhúng giấm', 'Bò mềm nhúng nước giấm dừa thanh. Món được chuẩn bị mới tại Lẩu Thái Mama.', '/images/foods/10331.jpg', '30-45 phút', 455000, 1, 7, 1037)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103710, 'Combo lẩu đặc biệt', 'Thịt, hải sản, viên thả lẩu và rau. Món được chuẩn bị mới tại Lẩu Thái Mama.', '/images/foods/10332.jpg', '30-45 phút', 492000, 1, 7, 1037)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1038, 'Hotpot Story', 'Lẩu nhiều vị', 'Lẩu nhiều vị. Chuyên phục vụ lẩu với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10312.jpg', 0, '29 Đường FoodHub, Quận 2, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (7, 1038, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103801, 'Lẩu Thái hải sản - Hotpot Story', 'Tôm, mực, nghêu và nước lẩu chua cay. Món được chuẩn bị mới tại Hotpot Story.', '/images/foods/10311.jpg', '30-45 phút', 159000, 0, 7, 1038)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103802, 'Lẩu bò Mỹ - Hotpot Story', 'Ba chỉ bò Mỹ, nấm và rau theo mùa. Món được chuẩn bị mới tại Hotpot Story.', '/images/foods/10312.jpg', '30-45 phút', 196000, 0, 7, 1038)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103803, 'Lẩu gà lá é - Hotpot Story', 'Gà ta, lá é, măng và ớt xiêm xanh. Món được chuẩn bị mới tại Hotpot Story.', '/images/foods/10313.jpg', '30-45 phút', 233000, 0, 7, 1038)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103804, 'Lẩu nấm - Hotpot Story', 'Nhiều loại nấm, rau củ và nước dùng thanh. Món được chuẩn bị mới tại Hotpot Story.', '/images/foods/10314.jpg', '30-45 phút', 270000, 0, 7, 1038)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103805, 'Lẩu mala Đài Loan - Hotpot Story', 'Nước lẩu mala cay tê cùng thịt bò. Món được chuẩn bị mới tại Hotpot Story.', '/images/foods/10321.jpg', '30-45 phút', 307000, 0, 7, 1038)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103806, 'Lẩu kim chi - Hotpot Story', 'Kim chi Hàn Quốc, ba chỉ heo và đậu hũ. Món được chuẩn bị mới tại Hotpot Story.', '/images/foods/10322.jpg', '30-45 phút', 344000, 0, 7, 1038)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103807, 'Lẩu riêu cua bắp bò - Hotpot Story', 'Riêu cua, bắp bò, đậu hũ và rau. Món được chuẩn bị mới tại Hotpot Story.', '/images/foods/10323.jpg', '30-45 phút', 381000, 0, 7, 1038)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103808, 'Lẩu cá kèo - Hotpot Story', 'Cá kèo tươi, lá giang và rau đắng. Món được chuẩn bị mới tại Hotpot Story.', '/images/foods/10324.jpg', '30-45 phút', 418000, 0, 7, 1038)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103809, 'Lẩu bò nhúng giấm - Hotpot Story', 'Bò mềm nhúng nước giấm dừa thanh. Món được chuẩn bị mới tại Hotpot Story.', '/images/foods/10331.jpg', '30-45 phút', 455000, 0, 7, 1038)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103810, 'Combo lẩu đặc biệt - Hotpot Story', 'Thịt, hải sản, viên thả lẩu và rau. Món được chuẩn bị mới tại Hotpot Story.', '/images/foods/10332.jpg', '30-45 phút', 492000, 0, 7, 1038)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1039, 'Manwah Taiwanese Hotpot', 'Lẩu Đài Loan', 'Lẩu Đài Loan. Chuyên phục vụ lẩu với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10313.jpg', 0, '40 Đường FoodHub, Quận 3, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (7, 1039, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103901, 'Lẩu Thái hải sản - Manwah Taiwanese Hotpot', 'Tôm, mực, nghêu và nước lẩu chua cay. Món được chuẩn bị mới tại Manwah Taiwanese Hotpot.', '/images/foods/10311.jpg', '30-45 phút', 159000, 0, 7, 1039)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103902, 'Lẩu bò Mỹ - Manwah Taiwanese Hotpot', 'Ba chỉ bò Mỹ, nấm và rau theo mùa. Món được chuẩn bị mới tại Manwah Taiwanese Hotpot.', '/images/foods/10312.jpg', '30-45 phút', 196000, 0, 7, 1039)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103903, 'Lẩu gà lá é - Manwah Taiwanese Hotpot', 'Gà ta, lá é, măng và ớt xiêm xanh. Món được chuẩn bị mới tại Manwah Taiwanese Hotpot.', '/images/foods/10313.jpg', '30-45 phút', 233000, 0, 7, 1039)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103904, 'Lẩu nấm - Manwah Taiwanese Hotpot', 'Nhiều loại nấm, rau củ và nước dùng thanh. Món được chuẩn bị mới tại Manwah Taiwanese Hotpot.', '/images/foods/10314.jpg', '30-45 phút', 270000, 0, 7, 1039)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103905, 'Lẩu mala Đài Loan - Manwah Taiwanese Hotpot', 'Nước lẩu mala cay tê cùng thịt bò. Món được chuẩn bị mới tại Manwah Taiwanese Hotpot.', '/images/foods/10321.jpg', '30-45 phút', 307000, 0, 7, 1039)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103906, 'Lẩu kim chi - Manwah Taiwanese Hotpot', 'Kim chi Hàn Quốc, ba chỉ heo và đậu hũ. Món được chuẩn bị mới tại Manwah Taiwanese Hotpot.', '/images/foods/10322.jpg', '30-45 phút', 344000, 0, 7, 1039)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103907, 'Lẩu riêu cua bắp bò - Manwah Taiwanese Hotpot', 'Riêu cua, bắp bò, đậu hũ và rau. Món được chuẩn bị mới tại Manwah Taiwanese Hotpot.', '/images/foods/10323.jpg', '30-45 phút', 381000, 0, 7, 1039)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103908, 'Lẩu cá kèo - Manwah Taiwanese Hotpot', 'Cá kèo tươi, lá giang và rau đắng. Món được chuẩn bị mới tại Manwah Taiwanese Hotpot.', '/images/foods/10324.jpg', '30-45 phút', 418000, 0, 7, 1039)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103909, 'Lẩu bò nhúng giấm - Manwah Taiwanese Hotpot', 'Bò mềm nhúng nước giấm dừa thanh. Món được chuẩn bị mới tại Manwah Taiwanese Hotpot.', '/images/foods/10331.jpg', '30-45 phút', 455000, 0, 7, 1039)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (103910, 'Combo lẩu đặc biệt - Manwah Taiwanese Hotpot', 'Thịt, hải sản, viên thả lẩu và rau. Món được chuẩn bị mới tại Manwah Taiwanese Hotpot.', '/images/foods/10332.jpg', '30-45 phút', 492000, 0, 7, 1039)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1040, 'Lẩu Gà Lá É Đà Lạt', 'Lẩu gà lá é', 'Lẩu gà lá é. Chuyên phục vụ lẩu với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10314.jpg', 1, '51 Đường FoodHub, Quận 4, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (7, 1040, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104001, 'Lẩu Thái hải sản - Lẩu Gà Lá É Đà Lạt', 'Tôm, mực, nghêu và nước lẩu chua cay. Món được chuẩn bị mới tại Lẩu Gà Lá É Đà Lạt.', '/images/foods/10311.jpg', '30-45 phút', 159000, 1, 7, 1040)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104002, 'Lẩu bò Mỹ - Lẩu Gà Lá É Đà Lạt', 'Ba chỉ bò Mỹ, nấm và rau theo mùa. Món được chuẩn bị mới tại Lẩu Gà Lá É Đà Lạt.', '/images/foods/10312.jpg', '30-45 phút', 196000, 1, 7, 1040)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104003, 'Lẩu gà lá é - Lẩu Gà Lá É Đà Lạt', 'Gà ta, lá é, măng và ớt xiêm xanh. Món được chuẩn bị mới tại Lẩu Gà Lá É Đà Lạt.', '/images/foods/10313.jpg', '30-45 phút', 233000, 1, 7, 1040)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104004, 'Lẩu nấm - Lẩu Gà Lá É Đà Lạt', 'Nhiều loại nấm, rau củ và nước dùng thanh. Món được chuẩn bị mới tại Lẩu Gà Lá É Đà Lạt.', '/images/foods/10314.jpg', '30-45 phút', 270000, 1, 7, 1040)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104005, 'Lẩu mala Đài Loan - Lẩu Gà Lá É Đà Lạt', 'Nước lẩu mala cay tê cùng thịt bò. Món được chuẩn bị mới tại Lẩu Gà Lá É Đà Lạt.', '/images/foods/10321.jpg', '30-45 phút', 307000, 1, 7, 1040)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104006, 'Lẩu kim chi - Lẩu Gà Lá É Đà Lạt', 'Kim chi Hàn Quốc, ba chỉ heo và đậu hũ. Món được chuẩn bị mới tại Lẩu Gà Lá É Đà Lạt.', '/images/foods/10322.jpg', '30-45 phút', 344000, 1, 7, 1040)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104007, 'Lẩu riêu cua bắp bò - Lẩu Gà Lá É Đà Lạt', 'Riêu cua, bắp bò, đậu hũ và rau. Món được chuẩn bị mới tại Lẩu Gà Lá É Đà Lạt.', '/images/foods/10323.jpg', '30-45 phút', 381000, 1, 7, 1040)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104008, 'Lẩu cá kèo - Lẩu Gà Lá É Đà Lạt', 'Cá kèo tươi, lá giang và rau đắng. Món được chuẩn bị mới tại Lẩu Gà Lá É Đà Lạt.', '/images/foods/10324.jpg', '30-45 phút', 418000, 1, 7, 1040)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104009, 'Lẩu bò nhúng giấm - Lẩu Gà Lá É Đà Lạt', 'Bò mềm nhúng nước giấm dừa thanh. Món được chuẩn bị mới tại Lẩu Gà Lá É Đà Lạt.', '/images/foods/10331.jpg', '30-45 phút', 455000, 1, 7, 1040)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104010, 'Combo lẩu đặc biệt - Lẩu Gà Lá É Đà Lạt', 'Thịt, hải sản, viên thả lẩu và rau. Món được chuẩn bị mới tại Lẩu Gà Lá É Đà Lạt.', '/images/foods/10332.jpg', '30-45 phút', 492000, 1, 7, 1040)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1041, 'Lẩu Bò Sài Gòn', 'Lẩu bò nóng hổi', 'Lẩu bò nóng hổi. Chuyên phục vụ lẩu với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10321.jpg', 0, '62 Đường FoodHub, Quận 5, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (7, 1041, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104101, 'Lẩu Thái hải sản - Lẩu Bò Sài Gòn', 'Tôm, mực, nghêu và nước lẩu chua cay. Món được chuẩn bị mới tại Lẩu Bò Sài Gòn.', '/images/foods/10311.jpg', '30-45 phút', 159000, 0, 7, 1041)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104102, 'Lẩu bò Mỹ - Lẩu Bò Sài Gòn', 'Ba chỉ bò Mỹ, nấm và rau theo mùa. Món được chuẩn bị mới tại Lẩu Bò Sài Gòn.', '/images/foods/10312.jpg', '30-45 phút', 196000, 0, 7, 1041)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104103, 'Lẩu gà lá é - Lẩu Bò Sài Gòn', 'Gà ta, lá é, măng và ớt xiêm xanh. Món được chuẩn bị mới tại Lẩu Bò Sài Gòn.', '/images/foods/10313.jpg', '30-45 phút', 233000, 0, 7, 1041)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104104, 'Lẩu nấm - Lẩu Bò Sài Gòn', 'Nhiều loại nấm, rau củ và nước dùng thanh. Món được chuẩn bị mới tại Lẩu Bò Sài Gòn.', '/images/foods/10314.jpg', '30-45 phút', 270000, 0, 7, 1041)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104105, 'Lẩu mala Đài Loan - Lẩu Bò Sài Gòn', 'Nước lẩu mala cay tê cùng thịt bò. Món được chuẩn bị mới tại Lẩu Bò Sài Gòn.', '/images/foods/10321.jpg', '30-45 phút', 307000, 0, 7, 1041)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104106, 'Lẩu kim chi - Lẩu Bò Sài Gòn', 'Kim chi Hàn Quốc, ba chỉ heo và đậu hũ. Món được chuẩn bị mới tại Lẩu Bò Sài Gòn.', '/images/foods/10322.jpg', '30-45 phút', 344000, 0, 7, 1041)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104107, 'Lẩu riêu cua bắp bò - Lẩu Bò Sài Gòn', 'Riêu cua, bắp bò, đậu hũ và rau. Món được chuẩn bị mới tại Lẩu Bò Sài Gòn.', '/images/foods/10323.jpg', '30-45 phút', 381000, 0, 7, 1041)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104108, 'Lẩu cá kèo - Lẩu Bò Sài Gòn', 'Cá kèo tươi, lá giang và rau đắng. Món được chuẩn bị mới tại Lẩu Bò Sài Gòn.', '/images/foods/10324.jpg', '30-45 phút', 418000, 0, 7, 1041)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104109, 'Lẩu bò nhúng giấm - Lẩu Bò Sài Gòn', 'Bò mềm nhúng nước giấm dừa thanh. Món được chuẩn bị mới tại Lẩu Bò Sài Gòn.', '/images/foods/10331.jpg', '30-45 phút', 455000, 0, 7, 1041)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104110, 'Combo lẩu đặc biệt - Lẩu Bò Sài Gòn', 'Thịt, hải sản, viên thả lẩu và rau. Món được chuẩn bị mới tại Lẩu Bò Sài Gòn.', '/images/foods/10332.jpg', '30-45 phút', 492000, 0, 7, 1041)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1042, 'Kichi Hotpot', 'Lẩu băng chuyền tại nhà', 'Lẩu băng chuyền tại nhà. Chuyên phục vụ lẩu với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10322.jpg', 0, '73 Đường FoodHub, Quận 6, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (7, 1042, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104201, 'Lẩu Thái hải sản - Kichi Hotpot', 'Tôm, mực, nghêu và nước lẩu chua cay. Món được chuẩn bị mới tại Kichi Hotpot.', '/images/foods/10311.jpg', '30-45 phút', 159000, 0, 7, 1042)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104202, 'Lẩu bò Mỹ - Kichi Hotpot', 'Ba chỉ bò Mỹ, nấm và rau theo mùa. Món được chuẩn bị mới tại Kichi Hotpot.', '/images/foods/10312.jpg', '30-45 phút', 196000, 0, 7, 1042)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104203, 'Lẩu gà lá é - Kichi Hotpot', 'Gà ta, lá é, măng và ớt xiêm xanh. Món được chuẩn bị mới tại Kichi Hotpot.', '/images/foods/10313.jpg', '30-45 phút', 233000, 0, 7, 1042)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104204, 'Lẩu nấm - Kichi Hotpot', 'Nhiều loại nấm, rau củ và nước dùng thanh. Món được chuẩn bị mới tại Kichi Hotpot.', '/images/foods/10314.jpg', '30-45 phút', 270000, 0, 7, 1042)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104205, 'Lẩu mala Đài Loan - Kichi Hotpot', 'Nước lẩu mala cay tê cùng thịt bò. Món được chuẩn bị mới tại Kichi Hotpot.', '/images/foods/10321.jpg', '30-45 phút', 307000, 0, 7, 1042)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104206, 'Lẩu kim chi - Kichi Hotpot', 'Kim chi Hàn Quốc, ba chỉ heo và đậu hũ. Món được chuẩn bị mới tại Kichi Hotpot.', '/images/foods/10322.jpg', '30-45 phút', 344000, 0, 7, 1042)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104207, 'Lẩu riêu cua bắp bò - Kichi Hotpot', 'Riêu cua, bắp bò, đậu hũ và rau. Món được chuẩn bị mới tại Kichi Hotpot.', '/images/foods/10323.jpg', '30-45 phút', 381000, 0, 7, 1042)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104208, 'Lẩu cá kèo - Kichi Hotpot', 'Cá kèo tươi, lá giang và rau đắng. Món được chuẩn bị mới tại Kichi Hotpot.', '/images/foods/10324.jpg', '30-45 phút', 418000, 0, 7, 1042)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104209, 'Lẩu bò nhúng giấm - Kichi Hotpot', 'Bò mềm nhúng nước giấm dừa thanh. Món được chuẩn bị mới tại Kichi Hotpot.', '/images/foods/10331.jpg', '30-45 phút', 455000, 0, 7, 1042)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104210, 'Combo lẩu đặc biệt - Kichi Hotpot', 'Thịt, hải sản, viên thả lẩu và rau. Món được chuẩn bị mới tại Kichi Hotpot.', '/images/foods/10332.jpg', '30-45 phút', 492000, 0, 7, 1042)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1043, 'Cơm Chay Thiên Lý', 'Ẩm thực chay thanh tịnh', 'Ẩm thực chay thanh tịnh. Chuyên phục vụ chay với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10361.jpg', 1, '18 Đường FoodHub, Quận 7, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (8, 1043, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104301, 'Cơm chay thập cẩm', 'Cơm, đậu hũ, nấm và rau củ theo ngày. Món được chuẩn bị mới tại Cơm Chay Thiên Lý.', '/images/foods/10361.jpg', '20-30 phút', 35000, 1, 8, 1043)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104302, 'Bún Huế chay', 'Bún, đậu hũ, nấm và nước dùng sả. Món được chuẩn bị mới tại Cơm Chay Thiên Lý.', '/images/foods/10362.jpg', '20-30 phút', 44000, 1, 8, 1043)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104303, 'Phở chay', 'Phở, nấm, tàu hũ ky và rau thơm. Món được chuẩn bị mới tại Cơm Chay Thiên Lý.', '/images/foods/10363.jpg', '20-30 phút', 53000, 1, 8, 1043)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104304, 'Cơm gạo lứt', 'Gạo lứt, rau củ, hạt và sốt mè. Món được chuẩn bị mới tại Cơm Chay Thiên Lý.', '/images/foods/10364.jpg', '20-30 phút', 62000, 1, 8, 1043)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104305, 'Đậu hũ kho nấm', 'Đậu hũ non kho nấm đông cô đậm vị. Món được chuẩn bị mới tại Cơm Chay Thiên Lý.', '/images/foods/10371.jpg', '20-30 phút', 71000, 1, 8, 1043)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104306, 'Gỏi cuốn chay', 'Rau, bún, đậu hũ cuốn bánh tráng. Món được chuẩn bị mới tại Cơm Chay Thiên Lý.', '/images/foods/10372.jpg', '20-30 phút', 80000, 1, 8, 1043)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104307, 'Mì xào rau củ', 'Mì xào nấm và rau củ theo mùa. Món được chuẩn bị mới tại Cơm Chay Thiên Lý.', '/images/foods/10373.jpg', '20-30 phút', 89000, 1, 8, 1043)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104308, 'Cà ri chay', 'Khoai, đậu hũ và nước cốt dừa. Món được chuẩn bị mới tại Cơm Chay Thiên Lý.', '/images/foods/10374.jpg', '20-30 phút', 98000, 1, 8, 1043)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104309, 'Lẩu nấm chay', 'Nấm tươi, đậu hũ và rau xanh. Món được chuẩn bị mới tại Cơm Chay Thiên Lý.', '/images/foods/10381.jpg', '20-30 phút', 107000, 1, 8, 1043)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104310, 'Salad đậu hũ', 'Đậu hũ áp chảo, rau xanh và sốt mè. Món được chuẩn bị mới tại Cơm Chay Thiên Lý.', '/images/foods/10382.jpg', '20-30 phút', 116000, 1, 8, 1043)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1044, 'Hum Vegetarian', 'Chay cao cấp', 'Chay cao cấp. Chuyên phục vụ chay với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10362.jpg', 0, '29 Đường FoodHub, Quận 8, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (8, 1044, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104401, 'Cơm chay thập cẩm - Hum Vegetarian', 'Cơm, đậu hũ, nấm và rau củ theo ngày. Món được chuẩn bị mới tại Hum Vegetarian.', '/images/foods/10361.jpg', '20-30 phút', 35000, 0, 8, 1044)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104402, 'Bún Huế chay - Hum Vegetarian', 'Bún, đậu hũ, nấm và nước dùng sả. Món được chuẩn bị mới tại Hum Vegetarian.', '/images/foods/10362.jpg', '20-30 phút', 44000, 0, 8, 1044)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104403, 'Phở chay - Hum Vegetarian', 'Phở, nấm, tàu hũ ky và rau thơm. Món được chuẩn bị mới tại Hum Vegetarian.', '/images/foods/10363.jpg', '20-30 phút', 53000, 0, 8, 1044)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104404, 'Cơm gạo lứt - Hum Vegetarian', 'Gạo lứt, rau củ, hạt và sốt mè. Món được chuẩn bị mới tại Hum Vegetarian.', '/images/foods/10364.jpg', '20-30 phút', 62000, 0, 8, 1044)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104405, 'Đậu hũ kho nấm - Hum Vegetarian', 'Đậu hũ non kho nấm đông cô đậm vị. Món được chuẩn bị mới tại Hum Vegetarian.', '/images/foods/10371.jpg', '20-30 phút', 71000, 0, 8, 1044)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104406, 'Gỏi cuốn chay - Hum Vegetarian', 'Rau, bún, đậu hũ cuốn bánh tráng. Món được chuẩn bị mới tại Hum Vegetarian.', '/images/foods/10372.jpg', '20-30 phút', 80000, 0, 8, 1044)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104407, 'Mì xào rau củ - Hum Vegetarian', 'Mì xào nấm và rau củ theo mùa. Món được chuẩn bị mới tại Hum Vegetarian.', '/images/foods/10373.jpg', '20-30 phút', 89000, 0, 8, 1044)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104408, 'Cà ri chay - Hum Vegetarian', 'Khoai, đậu hũ và nước cốt dừa. Món được chuẩn bị mới tại Hum Vegetarian.', '/images/foods/10374.jpg', '20-30 phút', 98000, 0, 8, 1044)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104409, 'Lẩu nấm chay - Hum Vegetarian', 'Nấm tươi, đậu hũ và rau xanh. Món được chuẩn bị mới tại Hum Vegetarian.', '/images/foods/10381.jpg', '20-30 phút', 107000, 0, 8, 1044)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104410, 'Salad đậu hũ - Hum Vegetarian', 'Đậu hũ áp chảo, rau xanh và sốt mè. Món được chuẩn bị mới tại Hum Vegetarian.', '/images/foods/10382.jpg', '20-30 phút', 116000, 0, 8, 1044)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1045, 'Chay Garden', 'Vườn chay xanh', 'Vườn chay xanh. Chuyên phục vụ chay với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10363.jpg', 0, '40 Đường FoodHub, Quận 9, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (8, 1045, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104501, 'Cơm chay thập cẩm - Chay Garden', 'Cơm, đậu hũ, nấm và rau củ theo ngày. Món được chuẩn bị mới tại Chay Garden.', '/images/foods/10361.jpg', '20-30 phút', 35000, 0, 8, 1045)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104502, 'Bún Huế chay - Chay Garden', 'Bún, đậu hũ, nấm và nước dùng sả. Món được chuẩn bị mới tại Chay Garden.', '/images/foods/10362.jpg', '20-30 phút', 44000, 0, 8, 1045)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104503, 'Phở chay - Chay Garden', 'Phở, nấm, tàu hũ ky và rau thơm. Món được chuẩn bị mới tại Chay Garden.', '/images/foods/10363.jpg', '20-30 phút', 53000, 0, 8, 1045)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104504, 'Cơm gạo lứt - Chay Garden', 'Gạo lứt, rau củ, hạt và sốt mè. Món được chuẩn bị mới tại Chay Garden.', '/images/foods/10364.jpg', '20-30 phút', 62000, 0, 8, 1045)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104505, 'Đậu hũ kho nấm - Chay Garden', 'Đậu hũ non kho nấm đông cô đậm vị. Món được chuẩn bị mới tại Chay Garden.', '/images/foods/10371.jpg', '20-30 phút', 71000, 0, 8, 1045)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104506, 'Gỏi cuốn chay - Chay Garden', 'Rau, bún, đậu hũ cuốn bánh tráng. Món được chuẩn bị mới tại Chay Garden.', '/images/foods/10372.jpg', '20-30 phút', 80000, 0, 8, 1045)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104507, 'Mì xào rau củ - Chay Garden', 'Mì xào nấm và rau củ theo mùa. Món được chuẩn bị mới tại Chay Garden.', '/images/foods/10373.jpg', '20-30 phút', 89000, 0, 8, 1045)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104508, 'Cà ri chay - Chay Garden', 'Khoai, đậu hũ và nước cốt dừa. Món được chuẩn bị mới tại Chay Garden.', '/images/foods/10374.jpg', '20-30 phút', 98000, 0, 8, 1045)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104509, 'Lẩu nấm chay - Chay Garden', 'Nấm tươi, đậu hũ và rau xanh. Món được chuẩn bị mới tại Chay Garden.', '/images/foods/10381.jpg', '20-30 phút', 107000, 0, 8, 1045)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104510, 'Salad đậu hũ - Chay Garden', 'Đậu hũ áp chảo, rau xanh và sốt mè. Món được chuẩn bị mới tại Chay Garden.', '/images/foods/10382.jpg', '20-30 phút', 116000, 0, 8, 1045)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1046, 'Bông Súng Vegetarian', 'Món chay Việt', 'Món chay Việt. Chuyên phục vụ chay với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10364.jpg', 1, '51 Đường FoodHub, Quận 10, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (8, 1046, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104601, 'Cơm chay thập cẩm - Bông Súng Vegetarian', 'Cơm, đậu hũ, nấm và rau củ theo ngày. Món được chuẩn bị mới tại Bông Súng Vegetarian.', '/images/foods/10361.jpg', '20-30 phút', 35000, 1, 8, 1046)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104602, 'Bún Huế chay - Bông Súng Vegetarian', 'Bún, đậu hũ, nấm và nước dùng sả. Món được chuẩn bị mới tại Bông Súng Vegetarian.', '/images/foods/10362.jpg', '20-30 phút', 44000, 1, 8, 1046)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104603, 'Phở chay - Bông Súng Vegetarian', 'Phở, nấm, tàu hũ ky và rau thơm. Món được chuẩn bị mới tại Bông Súng Vegetarian.', '/images/foods/10363.jpg', '20-30 phút', 53000, 1, 8, 1046)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104604, 'Cơm gạo lứt - Bông Súng Vegetarian', 'Gạo lứt, rau củ, hạt và sốt mè. Món được chuẩn bị mới tại Bông Súng Vegetarian.', '/images/foods/10364.jpg', '20-30 phút', 62000, 1, 8, 1046)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104605, 'Đậu hũ kho nấm - Bông Súng Vegetarian', 'Đậu hũ non kho nấm đông cô đậm vị. Món được chuẩn bị mới tại Bông Súng Vegetarian.', '/images/foods/10371.jpg', '20-30 phút', 71000, 1, 8, 1046)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104606, 'Gỏi cuốn chay - Bông Súng Vegetarian', 'Rau, bún, đậu hũ cuốn bánh tráng. Món được chuẩn bị mới tại Bông Súng Vegetarian.', '/images/foods/10372.jpg', '20-30 phút', 80000, 1, 8, 1046)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104607, 'Mì xào rau củ - Bông Súng Vegetarian', 'Mì xào nấm và rau củ theo mùa. Món được chuẩn bị mới tại Bông Súng Vegetarian.', '/images/foods/10373.jpg', '20-30 phút', 89000, 1, 8, 1046)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104608, 'Cà ri chay - Bông Súng Vegetarian', 'Khoai, đậu hũ và nước cốt dừa. Món được chuẩn bị mới tại Bông Súng Vegetarian.', '/images/foods/10374.jpg', '20-30 phút', 98000, 1, 8, 1046)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104609, 'Lẩu nấm chay - Bông Súng Vegetarian', 'Nấm tươi, đậu hũ và rau xanh. Món được chuẩn bị mới tại Bông Súng Vegetarian.', '/images/foods/10381.jpg', '20-30 phút', 107000, 1, 8, 1046)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104610, 'Salad đậu hũ - Bông Súng Vegetarian', 'Đậu hũ áp chảo, rau xanh và sốt mè. Món được chuẩn bị mới tại Bông Súng Vegetarian.', '/images/foods/10382.jpg', '20-30 phút', 116000, 1, 8, 1046)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1047, 'Nhà Hàng Chay An Lạc', 'Chay gia đình', 'Chay gia đình. Chuyên phục vụ chay với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10371.jpg', 0, '62 Đường FoodHub, Quận 11, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (8, 1047, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104701, 'Cơm chay thập cẩm - Nhà Hàng Chay An Lạc', 'Cơm, đậu hũ, nấm và rau củ theo ngày. Món được chuẩn bị mới tại Nhà Hàng Chay An Lạc.', '/images/foods/10361.jpg', '20-30 phút', 35000, 0, 8, 1047)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104702, 'Bún Huế chay - Nhà Hàng Chay An Lạc', 'Bún, đậu hũ, nấm và nước dùng sả. Món được chuẩn bị mới tại Nhà Hàng Chay An Lạc.', '/images/foods/10362.jpg', '20-30 phút', 44000, 0, 8, 1047)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104703, 'Phở chay - Nhà Hàng Chay An Lạc', 'Phở, nấm, tàu hũ ky và rau thơm. Món được chuẩn bị mới tại Nhà Hàng Chay An Lạc.', '/images/foods/10363.jpg', '20-30 phút', 53000, 0, 8, 1047)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104704, 'Cơm gạo lứt - Nhà Hàng Chay An Lạc', 'Gạo lứt, rau củ, hạt và sốt mè. Món được chuẩn bị mới tại Nhà Hàng Chay An Lạc.', '/images/foods/10364.jpg', '20-30 phút', 62000, 0, 8, 1047)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104705, 'Đậu hũ kho nấm - Nhà Hàng Chay An Lạc', 'Đậu hũ non kho nấm đông cô đậm vị. Món được chuẩn bị mới tại Nhà Hàng Chay An Lạc.', '/images/foods/10371.jpg', '20-30 phút', 71000, 0, 8, 1047)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104706, 'Gỏi cuốn chay - Nhà Hàng Chay An Lạc', 'Rau, bún, đậu hũ cuốn bánh tráng. Món được chuẩn bị mới tại Nhà Hàng Chay An Lạc.', '/images/foods/10372.jpg', '20-30 phút', 80000, 0, 8, 1047)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104707, 'Mì xào rau củ - Nhà Hàng Chay An Lạc', 'Mì xào nấm và rau củ theo mùa. Món được chuẩn bị mới tại Nhà Hàng Chay An Lạc.', '/images/foods/10373.jpg', '20-30 phút', 89000, 0, 8, 1047)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104708, 'Cà ri chay - Nhà Hàng Chay An Lạc', 'Khoai, đậu hũ và nước cốt dừa. Món được chuẩn bị mới tại Nhà Hàng Chay An Lạc.', '/images/foods/10374.jpg', '20-30 phút', 98000, 0, 8, 1047)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104709, 'Lẩu nấm chay - Nhà Hàng Chay An Lạc', 'Nấm tươi, đậu hũ và rau xanh. Món được chuẩn bị mới tại Nhà Hàng Chay An Lạc.', '/images/foods/10381.jpg', '20-30 phút', 107000, 0, 8, 1047)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104710, 'Salad đậu hũ - Nhà Hàng Chay An Lạc', 'Đậu hũ áp chảo, rau xanh và sốt mè. Món được chuẩn bị mới tại Nhà Hàng Chay An Lạc.', '/images/foods/10382.jpg', '20-30 phút', 116000, 0, 8, 1047)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO restaurant (id, title, subtitle, description, image, is_freeship, address, open_date)
VALUES (1048, 'Lá Bồ Đề Vegan', 'Món chay thuần thực vật', 'Món chay thuần thực vật. Chuyên phục vụ chay với nguyên liệu chọn lọc, chế biến trong ngày và đóng gói phù hợp giao tận nơi.', '/images/foods/10372.jpg', 0, '73 Đường FoodHub, Quận 12, TP.HCM', NOW())
ON DUPLICATE KEY UPDATE
  subtitle = VALUES(subtitle),
  description = VALUES(description),
  image = VALUES(image),
  is_freeship = VALUES(is_freeship),
  address = VALUES(address);
INSERT INTO restaurant_category (cate_id, res_id, create_date)
VALUES (8, 1048, NOW())
ON DUPLICATE KEY UPDATE create_date = VALUES(create_date);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104801, 'Cơm chay thập cẩm - Lá Bồ Đề Vegan', 'Cơm, đậu hũ, nấm và rau củ theo ngày. Món được chuẩn bị mới tại Lá Bồ Đề Vegan.', '/images/foods/10361.jpg', '20-30 phút', 35000, 0, 8, 1048)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104802, 'Bún Huế chay - Lá Bồ Đề Vegan', 'Bún, đậu hũ, nấm và nước dùng sả. Món được chuẩn bị mới tại Lá Bồ Đề Vegan.', '/images/foods/10362.jpg', '20-30 phút', 44000, 0, 8, 1048)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104803, 'Phở chay - Lá Bồ Đề Vegan', 'Phở, nấm, tàu hũ ky và rau thơm. Món được chuẩn bị mới tại Lá Bồ Đề Vegan.', '/images/foods/10363.jpg', '20-30 phút', 53000, 0, 8, 1048)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104804, 'Cơm gạo lứt - Lá Bồ Đề Vegan', 'Gạo lứt, rau củ, hạt và sốt mè. Món được chuẩn bị mới tại Lá Bồ Đề Vegan.', '/images/foods/10364.jpg', '20-30 phút', 62000, 0, 8, 1048)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104805, 'Đậu hũ kho nấm - Lá Bồ Đề Vegan', 'Đậu hũ non kho nấm đông cô đậm vị. Món được chuẩn bị mới tại Lá Bồ Đề Vegan.', '/images/foods/10371.jpg', '20-30 phút', 71000, 0, 8, 1048)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104806, 'Gỏi cuốn chay - Lá Bồ Đề Vegan', 'Rau, bún, đậu hũ cuốn bánh tráng. Món được chuẩn bị mới tại Lá Bồ Đề Vegan.', '/images/foods/10372.jpg', '20-30 phút', 80000, 0, 8, 1048)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104807, 'Mì xào rau củ - Lá Bồ Đề Vegan', 'Mì xào nấm và rau củ theo mùa. Món được chuẩn bị mới tại Lá Bồ Đề Vegan.', '/images/foods/10373.jpg', '20-30 phút', 89000, 0, 8, 1048)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104808, 'Cà ri chay - Lá Bồ Đề Vegan', 'Khoai, đậu hũ và nước cốt dừa. Món được chuẩn bị mới tại Lá Bồ Đề Vegan.', '/images/foods/10374.jpg', '20-30 phút', 98000, 0, 8, 1048)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104809, 'Lẩu nấm chay - Lá Bồ Đề Vegan', 'Nấm tươi, đậu hũ và rau xanh. Món được chuẩn bị mới tại Lá Bồ Đề Vegan.', '/images/foods/10381.jpg', '20-30 phút', 107000, 0, 8, 1048)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

INSERT INTO food (id, title, description, image, time_ship, price, is_freeship, cate_id, res_id)
VALUES (104810, 'Salad đậu hũ - Lá Bồ Đề Vegan', 'Đậu hũ áp chảo, rau xanh và sốt mè. Món được chuẩn bị mới tại Lá Bồ Đề Vegan.', '/images/foods/10382.jpg', '20-30 phút', 116000, 0, 8, 1048)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  image = VALUES(image),
  time_ship = VALUES(time_ship),
  price = VALUES(price),
  is_freeship = VALUES(is_freeship),
  cate_id = VALUES(cate_id),
  res_id = VALUES(res_id);

-- Seed summary: 8 categories, 48 restaurants, 480 foods.
SELECT 8 AS seeded_categories, 48 AS seeded_restaurants, 480 AS seeded_foods;
