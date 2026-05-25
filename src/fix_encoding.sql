USE fooddelivery;
SET NAMES utf8mb4 COLLATE utf8mb4_0900_ai_ci;

ALTER DATABASE fooddelivery CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
ALTER TABLE roles CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
ALTER TABLE users CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
ALTER TABLE category CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
ALTER TABLE restaurant CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
ALTER TABLE food CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
ALTER TABLE rating_restaurant CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
ALTER TABLE rating_food CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

-- Sửa dữ liệu tiếng Việt bị lưu dạng mojibake, ví dụ: Nguyß╗àn -> Nguyễn.
-- Collation phân biệt ký tự giúp tránh chuyển nhầm dữ liệu đã đúng như "Cơm".
UPDATE users SET fullname = CONVERT(CAST(CONVERT(fullname USING cp850) AS BINARY) USING utf8mb4)
WHERE fullname COLLATE utf8mb4_0900_as_cs REGEXP '[ß║╗├┼─]';

UPDATE roles SET description = CONVERT(CAST(CONVERT(description USING cp850) AS BINARY) USING utf8mb4)
WHERE description COLLATE utf8mb4_0900_as_cs REGEXP '[ß║╗├┼─]';

UPDATE category SET category_name = CONVERT(CAST(CONVERT(category_name USING cp850) AS BINARY) USING utf8mb4)
WHERE category_name COLLATE utf8mb4_0900_as_cs REGEXP '[ß║╗├┼─]';

UPDATE restaurant SET title = CONVERT(CAST(CONVERT(title USING cp850) AS BINARY) USING utf8mb4)
WHERE title COLLATE utf8mb4_0900_as_cs REGEXP '[ß║╗├┼─]';
UPDATE restaurant SET subtitle = CONVERT(CAST(CONVERT(subtitle USING cp850) AS BINARY) USING utf8mb4)
WHERE subtitle COLLATE utf8mb4_0900_as_cs REGEXP '[ß║╗├┼─]';
UPDATE restaurant SET description = CONVERT(CAST(CONVERT(description USING cp850) AS BINARY) USING utf8mb4)
WHERE description COLLATE utf8mb4_0900_as_cs REGEXP '[ß║╗├┼─]';
UPDATE restaurant SET address = CONVERT(CAST(CONVERT(address USING cp850) AS BINARY) USING utf8mb4)
WHERE address COLLATE utf8mb4_0900_as_cs REGEXP '[ß║╗├┼─]';

UPDATE food SET title = CONVERT(CAST(CONVERT(title USING cp850) AS BINARY) USING utf8mb4)
WHERE title COLLATE utf8mb4_0900_as_cs REGEXP '[ß║╗├┼─]';
UPDATE food SET description = CONVERT(CAST(CONVERT(description USING cp850) AS BINARY) USING utf8mb4)
WHERE description COLLATE utf8mb4_0900_as_cs REGEXP '[ß║╗├┼─]';
UPDATE food SET time_ship = CONVERT(CAST(CONVERT(time_ship USING cp850) AS BINARY) USING utf8mb4)
WHERE time_ship COLLATE utf8mb4_0900_as_cs REGEXP '[ß║╗├┼─]';

UPDATE rating_restaurant SET content = CONVERT(CAST(CONVERT(content USING cp850) AS BINARY) USING utf8mb4)
WHERE content COLLATE utf8mb4_0900_as_cs REGEXP '[ß║╗├┼─]';

UPDATE rating_food SET content = CONVERT(CAST(CONVERT(content USING cp850) AS BINARY) USING utf8mb4)
WHERE content COLLATE utf8mb4_0900_as_cs REGEXP '[ß║╗├┼─]';
