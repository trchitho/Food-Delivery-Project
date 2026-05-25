USE fooddelivery;
SET NAMES utf8mb4 COLLATE utf8mb4_0900_ai_ci;

-- =============================================
-- ROLES
-- =============================================
INSERT INTO roles (role_name, description) VALUES
('ADMIN', 'Quản trị viên hệ thống'),
('USER', 'Người dùng thông thường');

-- =============================================
-- USERS (password = BCrypt của "123456")
-- =============================================
INSERT INTO users (user_name, password, fullname, create_date, role_id) VALUES
('admin',    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Admin System',     NOW(), 1),
('nguyenvana','$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Nguyễn Văn A',    NOW(), 2),
('tranthib',  '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Trần Thị B',      NOW(), 2),
('lehoancc',  '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Lê Hoàng C',      NOW(), 2),
('phamthid',  '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Phạm Thị D',      NOW(), 2),
('vuminhe',   '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Vũ Minh E',       NOW(), 2);

-- =============================================
-- CATEGORIES
-- =============================================
INSERT INTO category (category_name, create_date) VALUES
('Cơm',         NOW()),
('Bún - Phở',   NOW()),
('Bánh mì',     NOW()),
('Đồ uống',     NOW()),
('Gà rán',      NOW()),
('Pizza',       NOW()),
('Lẩu',         NOW()),
('Chay',        NOW());

-- =============================================
-- RESTAURANTS (15 nhà hàng)
-- =============================================
INSERT INTO restaurant (title, subtitle, description, image, is_freeship, address, open_date) VALUES
('Cơm Tấm Sài Gòn',      'Cơm tấm truyền thống',        'Cơm tấm sườn bì chả đặc trưng Sài Gòn, phục vụ từ sáng đến tối.',                NULL, 1, '12 Nguyễn Trãi, Q.1, TP.HCM',         NOW()),
('Phở Hà Nội 1946',       'Phở bò truyền thống',         'Phở bò nấu theo công thức gia truyền từ năm 1946, nước dùng trong vắt.',          NULL, 0, '45 Đinh Tiên Hoàng, Q.1, TP.HCM',     NOW()),
('Bánh Mì Huỳnh Hoa',     'Bánh mì nổi tiếng nhất SG',   'Bánh mì thịt nguội, pate, chả lụa nhân đầy ắp, xếp hàng mỗi ngày.',             NULL, 1, '26 Lê Thị Riêng, Q.1, TP.HCM',        NOW()),
('KFC Việt Nam',           'Gà rán giòn tan',             'Gà rán Kentucky truyền thống, combo gia đình và cá nhân đa dạng.',               NULL, 1, '78 Nguyễn Huệ, Q.1, TP.HCM',          NOW()),
('Pizza Hut',              'Pizza Ý chính hiệu',          'Pizza đế dày, đế mỏng, stuffed crust với hơn 20 loại topping.',                  NULL, 0, '15 Lê Lợi, Q.1, TP.HCM',             NOW()),
('Lẩu Thái Mama',          'Lẩu Thái cay nồng',           'Lẩu Thái chua cay đặc trưng, hải sản tươi sống, rau sạch.',                     NULL, 0, '88 Võ Văn Tần, Q.3, TP.HCM',          NOW()),
('Bún Bò Huế Mụ Rơi',     'Bún bò Huế chuẩn vị',         'Bún bò Huế nước dùng đậm đà, chả cua, giò heo, sả ớt thơm lừng.',              NULL, 1, '33 Trần Hưng Đạo, Q.5, TP.HCM',       NOW()),
('Cơm Chay Thiên Lý',     'Ẩm thực chay thanh tịnh',     'Cơm chay đa dạng, nguyên liệu hữu cơ, tốt cho sức khỏe.',                       NULL, 1, '55 Bà Huyện Thanh Quan, Q.3, TP.HCM', NOW()),
('Trà Sữa Gong Cha',      'Trà sữa Đài Loan',            'Trà sữa trân châu, matcha, taro với nhiều topping hấp dẫn.',                     NULL, 1, '102 Nguyễn Thị Minh Khai, Q.1, TP.HCM', NOW()),
('Burger King',            'Burger bò Mỹ',                'Whopper bò nướng lửa than, fries giòn, onion rings đặc biệt.',                   NULL, 1, '200 Lý Tự Trọng, Q.1, TP.HCM',        NOW()),
('Hải Sản Biển Đông',     'Hải sản tươi sống',           'Tôm hùm, cua, ghẹ, ốc tươi sống chế biến theo yêu cầu.',                        NULL, 0, '9 Trần Phú, Q.4, TP.HCM',             NOW()),
('Dimsum Palace',          'Dimsum Hồng Kông',            'Há cảo, xíu mại, bánh bao, chân gà hấp theo phong cách Hồng Kông.',             NULL, 1, '67 Châu Văn Liêm, Q.5, TP.HCM',       NOW()),
('Cháo Ếch Singapore',    'Cháo ếch đặc sản',            'Cháo ếch nấu kiểu Singapore, thịt ếch mềm, cháo sánh mịn.',                     NULL, 0, '14 Nguyễn Cư Trinh, Q.1, TP.HCM',     NOW()),
('Sushi Hokkaido',         'Sushi Nhật Bản',              'Sushi, sashimi, ramen chuẩn vị Nhật, nguyên liệu nhập khẩu.',                    NULL, 0, '38 Hai Bà Trưng, Q.1, TP.HCM',        NOW()),
('Bếp Mẹ Ơi',             'Cơm nhà đúng vị',             'Các món cơm nhà truyền thống: canh chua, cá kho, thịt kho tàu.',                 NULL, 1, '71 Đinh Bộ Lĩnh, Bình Thạnh, TP.HCM', NOW());

-- =============================================
-- RESTAURANT_CATEGORY (gán category cho nhà hàng)
-- =============================================
INSERT INTO restaurant_category (res_id, cate_id, create_date) VALUES
(1,1,NOW()), (1,3,NOW()),   -- Cơm Tấm: Cơm, Bánh mì
(2,2,NOW()),                -- Phở HN: Bún-Phở
(3,3,NOW()),                -- Bánh Mì HH: Bánh mì
(4,5,NOW()),                -- KFC: Gà rán
(5,6,NOW()),                -- Pizza Hut: Pizza
(6,7,NOW()),                -- Lẩu Thái: Lẩu
(7,2,NOW()),                -- Bún Bò: Bún-Phở
(8,8,NOW()),                -- Cơm Chay: Chay
(9,4,NOW()),                -- Gong Cha: Đồ uống
(10,5,NOW()),               -- Burger King: Gà rán
(11,7,NOW()),               -- Hải Sản: Lẩu
(12,1,NOW()),               -- Dimsum: Cơm
(13,2,NOW()),               -- Cháo Ếch: Bún-Phở
(14,1,NOW()),               -- Sushi: Cơm
(15,1,NOW()), (15,8,NOW()); -- Bếp Mẹ: Cơm, Chay

-- =============================================
-- FOOD (60+ món ăn)
-- =============================================
INSERT INTO food (title, description, image, time_ship, price, is_freeship, cate_id, res_id) VALUES
-- Cơm Tấm Sài Gòn (res_id=1)
('Cơm tấm sườn bì chả',    'Sườn nướng, bì, chả trứng, cơm tấm dẻo',  NULL, '20-30 phút', 45000, 1, 1, 1),
('Cơm tấm sườn nướng',     'Sườn cốt lết nướng than hoa thơm lừng',    NULL, '20-30 phút', 40000, 1, 1, 1),
('Cơm tấm bì chả',         'Bì heo, chả trứng, dưa leo, cà chua',      NULL, '15-25 phút', 35000, 1, 1, 1),
('Cơm tấm đặc biệt',       'Combo đầy đủ sườn + bì + chả + trứng ốp',  NULL, '25-35 phút', 55000, 1, 1, 1),

-- Phở Hà Nội 1946 (res_id=2)
('Phở bò tái',             'Thịt bò tái, nước dùng trong, bánh phở mềm', NULL, '20-30 phút', 65000, 0, 2, 2),
('Phở bò chín',            'Thịt bò chín mềm, gân, nước dùng đậm đà',   NULL, '20-30 phút', 65000, 0, 2, 2),
('Phở bò tái chín',        'Kết hợp tái và chín, đặc biệt thơm ngon',   NULL, '20-30 phút', 70000, 0, 2, 2),
('Phở gà',                 'Gà ta nấu nước dùng ngọt thanh, thịt mềm',  NULL, '20-30 phút', 60000, 0, 2, 2),

-- Bánh Mì Huỳnh Hoa (res_id=3)
('Bánh mì đặc biệt',       'Pate, chả lụa, thịt nguội, rau thơm đầy ắp', NULL, '10-15 phút', 35000, 1, 3, 3),
('Bánh mì thịt nướng',     'Thịt heo nướng sả ớt, dưa leo, hành lá',    NULL, '10-15 phút', 30000, 1, 3, 3),
('Bánh mì trứng',          'Trứng ốp la, pate, bơ, maggi thơm',          NULL, '10-15 phút', 25000, 1, 3, 3),
('Bánh mì chả cá',         'Chả cá thu, rau răm, ớt tươi',               NULL, '10-15 phút', 28000, 1, 3, 3),

-- KFC (res_id=4)
('Gà rán Original',        '2 miếng gà rán giòn tan theo công thức gốc', NULL, '15-25 phút', 79000, 1, 5, 4),
('Combo Gà Bucket',        '8 miếng gà rán, 2 khoai tây chiên lớn',      NULL, '20-30 phút', 259000, 1, 5, 4),
('Gà Zinger Burger',       'Burger gà giòn, rau xà lách, sốt mayo',      NULL, '15-25 phút', 69000, 1, 5, 4),
('Khoai tây chiên lớn',    'Khoai tây chiên vàng giòn, muối vừa',        NULL, '10-15 phút', 39000, 1, 5, 4),

-- Pizza Hut (res_id=5)
('Pizza Pepperoni',        'Pepperoni, phô mai mozzarella, sốt cà chua', NULL, '30-45 phút', 189000, 0, 6, 5),
('Pizza Hải Sản',          'Tôm, mực, cua, phô mai, sốt trắng',          NULL, '30-45 phút', 219000, 0, 6, 5),
('Pizza BBQ Gà',           'Gà nướng BBQ, hành tây, ớt chuông',          NULL, '30-45 phút', 199000, 0, 6, 5),
('Pizza 4 Phô Mai',        'Mozzarella, cheddar, parmesan, gouda',        NULL, '30-45 phút', 229000, 0, 6, 5),

-- Lẩu Thái Mama (res_id=6)
('Lẩu Thái hải sản',       'Tôm, mực, nghêu, nấm, rau đa dạng',         NULL, '30-40 phút', 350000, 0, 7, 6),
('Lẩu Thái gà',            'Gà ta, sả, lá chanh, ớt, nước dùng chua cay', NULL, '30-40 phút', 280000, 0, 7, 6),
('Lẩu Thái chay',          'Đậu hũ, nấm kim châm, rau củ, nước dùng chay', NULL, '30-40 phút', 220000, 0, 7, 6),

-- Bún Bò Huế (res_id=7)
('Bún bò Huế đặc biệt',    'Giò heo, chả cua, huyết, sả ớt đậm đà',    NULL, '20-30 phút', 75000, 1, 2, 7),
('Bún bò Huế thường',      'Thịt bò, chả, nước dùng chuẩn vị Huế',      NULL, '20-30 phút', 55000, 1, 2, 7),
('Bún bò chả cua',         'Chả cua đặc biệt, bún tươi, rau sống',       NULL, '20-30 phút', 65000, 1, 2, 7),

-- Cơm Chay Thiên Lý (res_id=8)
('Cơm chay đặc biệt',      'Đậu hũ chiên, nấm xào, rau củ luộc, canh',  NULL, '20-30 phút', 55000, 1, 8, 8),
('Bún chay',               'Bún tươi, đậu hũ, rau sống, nước lèo chay', NULL, '20-30 phút', 45000, 1, 8, 8),
('Cơm chay thập cẩm',      'Nhiều món chay phong phú, dinh dưỡng',       NULL, '20-30 phút', 65000, 1, 8, 8),

-- Gong Cha (res_id=9)
('Trà sữa trân châu đen',  'Trà sữa Assam, trân châu đen dẻo ngọt',     NULL, '10-15 phút', 55000, 1, 4, 9),
('Matcha latte trân châu', 'Matcha Nhật Bản, sữa tươi, trân châu',       NULL, '10-15 phút', 65000, 1, 4, 9),
('Taro milk tea',          'Khoai môn, sữa tươi, trân châu trắng',       NULL, '10-15 phút', 60000, 1, 4, 9),
('Brown sugar milk tea',   'Đường nâu, sữa tươi, trân châu tiger',       NULL, '10-15 phút', 65000, 1, 4, 9),

-- Burger King (res_id=10)
('Whopper',                'Bò nướng lửa than, rau tươi, sốt đặc biệt', NULL, '15-25 phút', 89000, 1, 5, 10),
('Double Whopper',         'Hai lớp bò nướng, phô mai, bacon',           NULL, '15-25 phút', 119000, 1, 5, 10),
('Chicken Royale',         'Gà giòn, xà lách, sốt mayo đặc biệt',       NULL, '15-25 phút', 79000, 1, 5, 10),
('Onion Rings',            'Hành tây tẩm bột chiên giòn, sốt BBQ',       NULL, '10-15 phút', 45000, 1, 5, 10),

-- Hải Sản Biển Đông (res_id=11)
('Tôm hùm nướng bơ tỏi',  'Tôm hùm 500g nướng bơ tỏi thơm lừng',      NULL, '30-45 phút', 650000, 0, 7, 11),
('Cua rang muối',          'Cua biển rang muối ớt, hành lá',             NULL, '30-45 phút', 450000, 0, 7, 11),
('Mực nướng sa tế',        'Mực ống tươi nướng sa tế cay thơm',          NULL, '25-35 phút', 180000, 0, 7, 11),
('Nghêu hấp sả',           'Nghêu tươi hấp sả gừng, nước chấm chua ngọt', NULL, '20-30 phút', 120000, 0, 7, 11),

-- Dimsum Palace (res_id=12)
('Há cảo tôm',             'Há cảo tôm tươi hấp, vỏ mỏng dai',          NULL, '20-30 phút', 75000, 1, 1, 12),
('Xíu mại heo',            'Xíu mại thịt heo, nấm, hấp mềm',            NULL, '20-30 phút', 70000, 1, 1, 12),
('Bánh bao xá xíu',        'Bánh bao nhân xá xíu ngọt thơm',             NULL, '20-30 phút', 45000, 1, 1, 12),
('Chân gà hấp đậu đen',    'Chân gà mềm, đậu đen, sốt oyster',          NULL, '25-35 phút', 85000, 1, 1, 12),

-- Cháo Ếch Singapore (res_id=13)
('Cháo ếch đặc biệt',      'Ếch tươi, cháo sánh, gừng, hành phi',       NULL, '25-35 phút', 95000, 0, 2, 13),
('Cháo ếch cay',           'Ếch tươi, ớt sa tế, cháo đặc kiểu Singapore', NULL, '25-35 phút', 100000, 0, 2, 13),
('Cháo ếch rau củ',        'Ếch, cà rốt, nấm, rau xanh bổ dưỡng',       NULL, '25-35 phút', 90000, 0, 2, 13),

-- Sushi Hokkaido (res_id=14)
('Sashimi cá hồi',         'Cá hồi Na Uy tươi, 8 lát, wasabi, gừng',    NULL, '20-30 phút', 185000, 0, 1, 14),
('Sushi cuộn California',  'Cua, bơ, dưa leo, trứng cá tobiko',          NULL, '20-30 phút', 145000, 0, 1, 14),
('Ramen tonkotsu',         'Nước dùng xương heo, chashu, trứng lòng đào', NULL, '25-35 phút', 165000, 0, 1, 14),
('Gyoza chiên',            'Há cảo Nhật chiên giòn, sốt ponzu',          NULL, '15-25 phút', 95000, 0, 1, 14),

-- Bếp Mẹ Ơi (res_id=15)
('Cơm canh chua cá lóc',   'Cá lóc đồng, canh chua me, cơm trắng',      NULL, '20-30 phút', 65000, 1, 1, 15),
('Cơm thịt kho tàu',       'Thịt ba chỉ kho trứng, cơm trắng, dưa cải', NULL, '20-30 phút', 60000, 1, 1, 15),
('Cơm gà kho gừng',        'Gà ta kho gừng đậm đà, cơm trắng',          NULL, '20-30 phút', 65000, 1, 1, 15),
('Cơm sườn ram mặn',       'Sườn non ram mặn ngọt, cơm trắng, rau luộc', NULL, '20-30 phút', 70000, 1, 1, 15);

-- =============================================
-- PROMOTIONS
-- =============================================
INSERT INTO promotion (percent, start_date, end_date, res_id) VALUES
(10, '2026-05-01', '2026-05-31', 1),
(15, '2026-05-01', '2026-05-31', 2),
(20, '2026-05-10', '2026-05-20', 4),
(10, '2026-05-01', '2026-06-30', 5),
(25, '2026-05-13', '2026-05-15', 9),
(15, '2026-05-01', '2026-05-31', 10),
(10, '2026-05-01', '2026-06-30', 15);

-- =============================================
-- ORDERS & ORDER ITEMS (sample)
-- =============================================
INSERT INTO orders (create_date, user_id, res_id) VALUES
(NOW(), 2, 1),
(NOW(), 3, 2),
(NOW(), 4, 4),
(NOW(), 2, 9),
(NOW(), 5, 5);

INSERT INTO order_item (order_id, food_id, create_date) VALUES
(1, 1, NOW()),
(1, 2, NOW()),
(2, 5, NOW()),
(3, 13, NOW()),
(3, 16, NOW()),
(4, 30, NOW()),
(4, 31, NOW()),
(5, 17, NOW());

-- =============================================
-- RATINGS
-- =============================================
INSERT INTO rating_restaurant (content, rating_point, user_id, res_id) VALUES
('Quán ngon, phục vụ nhanh!',       5, 2, 1),
('Phở rất đậm đà, sẽ quay lại',     5, 3, 2),
('Bánh mì nhân đầy, giá hợp lý',    4, 4, 3),
('Gà rán giòn, giao hàng nhanh',    4, 2, 4),
('Pizza ngon nhưng hơi đắt',        3, 5, 5),
('Lẩu Thái cay vừa, hải sản tươi',  5, 3, 6),
('Bún bò đúng vị Huế, thích lắm',   5, 4, 7),
('Đồ chay ngon, sạch sẽ',           4, 2, 8);

INSERT INTO rating_food (content, rating_point, user_id, food_id) VALUES
('Cơm tấm ngon tuyệt!',             5, 2, 1),
('Phở bò tái chuẩn vị',             5, 3, 5),
('Bánh mì nhân đầy ắp',             4, 4, 9),
('Gà rán giòn tan',                 4, 5, 13),
('Pizza pepperoni thơm ngon',       4, 2, 17),
('Trà sữa ngọt vừa, trân châu dẻo', 5, 3, 30);
