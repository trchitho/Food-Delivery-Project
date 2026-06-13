SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS roles (
    id INT NOT NULL AUTO_INCREMENT,
    role_name VARCHAR(50) NOT NULL,
    description VARCHAR(255) NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_roles_name (role_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL AUTO_INCREMENT,
    create_date DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    status VARCHAR(32) NOT NULL DEFAULT 'PENDING',
    payment_status VARCHAR(32) NOT NULL DEFAULT 'UNPAID',
    fullname VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    user_name VARCHAR(150) NOT NULL,
    role_id INT NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_users_username (user_name),
    KEY idx_users_role (role_id),
    CONSTRAINT fk_users_role FOREIGN KEY (role_id) REFERENCES roles (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS category (
    id INT NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL,
    create_date DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    PRIMARY KEY (id),
    UNIQUE KEY uk_category_name (category_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS restaurant (
    id INT NOT NULL AUTO_INCREMENT,
    address VARCHAR(255) NOT NULL,
    description VARCHAR(500) NOT NULL,
    image VARCHAR(500) NULL,
    is_freeship BIT(1) NOT NULL DEFAULT b'0',
    open_date DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    subtitle VARCHAR(255) NOT NULL,
    title VARCHAR(150) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_restaurant_title (title),
    KEY idx_restaurant_title (title)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS restaurant_category (
    cate_id INT NOT NULL,
    res_id INT NOT NULL,
    create_date DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    PRIMARY KEY (cate_id, res_id),
    KEY idx_restaurant_category_restaurant (res_id),
    CONSTRAINT fk_restaurant_category_category FOREIGN KEY (cate_id) REFERENCES category (id),
    CONSTRAINT fk_restaurant_category_restaurant FOREIGN KEY (res_id) REFERENCES restaurant (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS food (
    id INT NOT NULL AUTO_INCREMENT,
    description VARCHAR(500) NOT NULL,
    image VARCHAR(500) NULL,
    is_freeship BIT(1) NOT NULL DEFAULT b'0',
    price DECIMAL(12,2) NOT NULL,
    time_ship VARCHAR(50) NOT NULL,
    title VARCHAR(150) NOT NULL,
    cate_id INT NOT NULL,
    res_id INT NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_food_restaurant_title (res_id, title),
    KEY idx_food_category (cate_id),
    KEY idx_food_restaurant (res_id),
    KEY idx_food_category_restaurant (cate_id, res_id),
    CONSTRAINT fk_food_category FOREIGN KEY (cate_id) REFERENCES category (id),
    CONSTRAINT fk_food_restaurant FOREIGN KEY (res_id) REFERENCES restaurant (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS orders (
    id INT NOT NULL AUTO_INCREMENT,
    create_date DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    res_id INT NOT NULL,
    user_id INT NOT NULL,
    PRIMARY KEY (id),
    KEY idx_orders_restaurant (res_id),
    KEY idx_orders_user (user_id),
    KEY idx_orders_created (create_date),
    CONSTRAINT fk_orders_restaurant FOREIGN KEY (res_id) REFERENCES restaurant (id),
    CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES users (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS order_item (
    food_id INT NOT NULL,
    order_id INT NOT NULL,
    create_date DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    PRIMARY KEY (food_id, order_id),
    KEY idx_order_item_order (order_id),
    CONSTRAINT fk_order_item_food FOREIGN KEY (food_id) REFERENCES food (id),
    CONSTRAINT fk_order_item_order FOREIGN KEY (order_id) REFERENCES orders (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS promotion (
    id INT NOT NULL AUTO_INCREMENT,
    end_date DATETIME(6) NOT NULL,
    percent INT NOT NULL,
    start_date DATETIME(6) NOT NULL,
    res_id INT NOT NULL,
    PRIMARY KEY (id),
    KEY idx_promotion_restaurant (res_id),
    KEY idx_promotion_dates (start_date, end_date),
    CONSTRAINT fk_promotion_restaurant FOREIGN KEY (res_id) REFERENCES restaurant (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS rating_food (
    id INT NOT NULL AUTO_INCREMENT,
    content VARCHAR(500) NULL,
    rating_point INT NOT NULL,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    food_id INT NOT NULL,
    user_id INT NOT NULL,
    PRIMARY KEY (id),
    KEY idx_rating_food_food (food_id),
    KEY idx_rating_food_user (user_id),
    UNIQUE KEY uk_rating_food_user_food (user_id, food_id),
    CONSTRAINT chk_rating_food_point CHECK (rating_point BETWEEN 1 AND 5),
    CONSTRAINT fk_rating_food_food FOREIGN KEY (food_id) REFERENCES food (id),
    CONSTRAINT fk_rating_food_user FOREIGN KEY (user_id) REFERENCES users (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS rating_restaurant (
    id INT NOT NULL AUTO_INCREMENT,
    content VARCHAR(500) NULL,
    rating_point INT NOT NULL,
    res_id INT NOT NULL,
    user_id INT NOT NULL,
    PRIMARY KEY (id),
    KEY idx_rating_restaurant_restaurant (res_id),
    KEY idx_rating_restaurant_user (user_id),
    CONSTRAINT fk_rating_restaurant_restaurant FOREIGN KEY (res_id) REFERENCES restaurant (id),
    CONSTRAINT fk_rating_restaurant_user FOREIGN KEY (user_id) REFERENCES users (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
