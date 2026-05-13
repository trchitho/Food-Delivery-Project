# FoodHub - Online Food Delivery Marketplace

A full-stack online food delivery platform built with **Spring Boot** (backend) and **React** (frontend). The project demonstrates RESTful API design, JWT-based authentication, role-based access control, and a responsive UI with Tailwind CSS.

---

## Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Database Schema](#database-schema)
- [API Endpoints](#api-endpoints)
- [Getting Started](#getting-started)
- [Environment Configuration](#environment-configuration)
- [Screenshots](#screenshots)

---

## Features

### Authentication & Authorization
- User registration and login with **BCrypt** password hashing
- **JWT (JSON Web Token)** stateless authentication
- Role-based access control: `ADMIN` and `USER` roles
- Protected routes — API endpoints secured by Spring Security filter chain

### Marketplace
- Browse restaurants with details (name, address, free-ship status, promotions)
- Explore food items grouped by category
- Restaurant detail page with full menu listing
- Order placement and order history tracking

### Admin Dashboard
- Manage users: create, view, update roles
- Full CRUD for restaurants, menus, and categories
- View all orders across the platform

### Performance
- **Redis caching** for category data to reduce database load (optional, gracefully disabled if Redis is unavailable)
- File upload support for restaurant and food images (up to 10MB)

---

## Tech Stack

### Backend
| Technology | Version | Purpose |
|---|---|---|
| Java | 21 | Runtime |
| Spring Boot | 3.2.3 | Application framework |
| Spring Security | 6.x | Authentication & authorization |
| Spring Data JPA | 3.x | ORM / database access |
| Spring Data Redis | 3.x | Caching layer |
| MySQL Connector/J | latest | Database driver |
| JJWT | 0.12.5 | JWT generation & validation |
| Lettuce | 6.3.1 | Redis client |
| Gson | 2.10.1 | JSON serialization for cache |
| Maven | 3.x | Build tool |

### Frontend
| Technology | Version | Purpose |
|---|---|---|
| React | 18.2 | UI framework |
| React Router DOM | 6.x | Client-side routing |
| Axios | 1.x | HTTP client |
| Tailwind CSS | 3.x | Utility-first styling |
| Headless UI | 1.x | Accessible UI components |
| Heroicons | 2.x | Icon library |

### Database
| Technology | Purpose |
|---|---|
| MySQL 8+ | Primary relational database |
| Redis (optional) | Category data caching |

---

## Project Structure

```
Food-Delivery-Project/
├── src/main/java/com/maxnguyen/fooddelivery/
│   ├── config/
│   │   └── RedisConfig.java              # Redis connection configuration
│   ├── controller/
│   │   ├── LoginController.java          # POST /client/login, /client/signup
│   │   ├── RestaurantController.java     # GET/POST/PUT/DELETE /restaurant
│   │   ├── MenuController.java           # GET/POST/PUT/DELETE /menu
│   │   ├── CategoryController.java       # GET /category
│   │   ├── OrderController.java          # GET/POST /order
│   │   └── UserController.java           # GET/POST/PUT /user (admin)
│   ├── dto/                              # Data Transfer Objects (API response shapes)
│   ├── entity/                           # JPA entities mapped to DB tables
│   │   ├── Users.java
│   │   ├── Roles.java
│   │   ├── Restaurant.java
│   │   ├── Food.java
│   │   ├── Category.java
│   │   ├── Orders.java
│   │   ├── OrderItem.java
│   │   ├── Promotion.java
│   │   ├── RatingFood.java
│   │   ├── RatingRestaurant.java
│   │   └── RestaurantCategory.java
│   ├── payload/
│   │   ├── ResponseData.java             # Unified API response wrapper
│   │   └── request/                      # Request body POJOs
│   ├── repository/                       # Spring Data JPA repositories
│   ├── security/
│   │   ├── CustomFilterSecurity.java     # Security filter chain config
│   │   ├── CustomJwtFilter.java          # JWT validation per-request filter
│   │   └── CustomUserDetailsService.java # UserDetailsService implementation
│   ├── service/                          # Business logic layer
│   └── utils/
│       └── JwtUtilsHelper.java           # JWT generation & parsing
│
├── client/                               # React frontend
│   ├── public/
│   │   └── index.html
│   └── src/
│       ├── Feature/
│       │   ├── AdminPage/                # Admin dashboard & user management
│       │   ├── Components/               # Shared components (Navbar)
│       │   ├── Homepage/                 # Homepage, restaurant & food listings
│       │   ├── Login/                    # Login & signup pages
│       │   └── Restaurants/              # Restaurant detail page
│       ├── Services/
│       │   └── RestaurantService.js      # Axios service layer
│       ├── App.js                        # Route definitions
│       └── index.js
│
├── demo/                                 # Screenshots
├── pom.xml                               # Maven dependencies
└── seed_data.sql                         # Sample database data
```

---

## Database Schema

The schema uses a normalized relational design with the following core tables:

| Table | Description |
|---|---|
| `roles` | User roles: ADMIN, USER |
| `users` | User accounts with hashed passwords |
| `restaurant` | Restaurant listings |
| `category` | Food categories (e.g. Rice, Noodles, Drinks) |
| `restaurant_category` | Many-to-many: restaurant ↔ category |
| `food` | Menu items linked to a restaurant and category |
| `orders` | Customer orders linked to a user and restaurant |
| `order_item` | Line items within an order (order ↔ food) |
| `promotion` | Discount promotions per restaurant |
| `rating_food` | User ratings for food items |
| `rating_restaurant` | User ratings for restaurants |

![Database Schema](demo/Database%20Schema.png)

---

## API Endpoints

All protected endpoints require the header:
```
Authorization: Bearer <JWT_TOKEN>
```

### Auth — `/client`
| Method | Endpoint | Auth | Description |
|---|---|---|---|
| POST | `/client/login` | Public | Login, returns JWT token |
| POST | `/client/signup` | Public | Register new user |

### Restaurants — `/restaurant`
| Method | Endpoint | Auth | Description |
|---|---|---|---|
| GET | `/restaurant` | Required | List all restaurants |
| GET | `/restaurant/detail/{id}` | Public | Get restaurant details |
| GET | `/restaurant/file/{filename}` | Public | Serve restaurant image |
| POST | `/restaurant` | Required | Create restaurant |
| PUT | `/restaurant/{id}` | Required | Update restaurant |
| DELETE | `/restaurant/{id}` | Required | Delete restaurant |

### Menu — `/menu`
| Method | Endpoint | Auth | Description |
|---|---|---|---|
| GET | `/menu/file/{filename}` | Public | Serve food image |
| POST | `/menu` | Required | Create food item |
| PUT | `/menu/{id}` | Required | Update food item |
| DELETE | `/menu/{id}` | Required | Delete food item |

### Categories — `/category`
| Method | Endpoint | Auth | Description |
|---|---|---|---|
| GET | `/category` | Required | List categories with top food items (Redis cached) |

### Orders — `/order`
| Method | Endpoint | Auth | Description |
|---|---|---|---|
| GET | `/order` | Required | List orders |
| POST | `/order` | Required | Place new order |

### Users — `/user`
| Method | Endpoint | Auth | Description |
|---|---|---|---|
| GET | `/user` | Public | List all users |
| POST | `/user` | Required | Create user (admin) |

---

## Getting Started

### Prerequisites

- **Java 21** — [Download](https://www.oracle.com/java/technologies/downloads/#java21)
- **MySQL 8+** — running on `localhost:3306`
- **Node.js 18+** and **npm**
- **Redis** *(optional)* — if available, runs on port `6380`

### 1. Clone the repository

```bash
git clone https://github.com/your-username/Food-Delivery-Project.git
cd Food-Delivery-Project
```

### 2. Set up the database

```sql
CREATE DATABASE fooddelivery;
```

Then import sample data:

```bash
mysql -u root -p fooddelivery < seed_data.sql
```

### 3. Configure the backend

Edit `src/main/resources/application.properties`:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/fooddelivery
spring.datasource.username=root
spring.datasource.password=YOUR_PASSWORD

fileUpload.rootPath=C:/uploads
```

### 4. Run the backend

```bash
# Windows
.\mvnw.cmd spring-boot:run

# macOS / Linux
./mvnw spring-boot:run
```

Backend starts on **http://localhost:8080**

> **Note:** If `JAVA_HOME` points to a JDK older than 21, set it explicitly:
> ```powershell
> $env:JAVA_HOME = "C:\Program Files\Java\jdk-21.0.10"
> .\mvnw.cmd spring-boot:run
> ```

### 5. Run the frontend

```bash
cd client
npm install
npm start
```

Frontend starts on **http://localhost:3000**

### 6. Default accounts

| Username | Password | Role |
|---|---|---|
| `admin` | `123456` | ADMIN |
| `nguyenvana` | `123456` | USER |
| `tranthib` | `123456` | USER |

---

## Environment Configuration

| Property | Default | Description |
|---|---|---|
| `spring.datasource.url` | `jdbc:mysql://localhost:3306/fooddelivery` | MySQL connection URL |
| `spring.datasource.username` | `root` | MySQL username |
| `spring.datasource.password` | *(set yours)* | MySQL password |
| `jwt.privateKey` | *(base64 secret)* | Secret key for JWT signing |
| `fileUpload.rootPath` | `C:/uploads` | Directory for uploaded images |
| `spring.servlet.multipart.max-file-size` | `10MB` | Max upload file size |
| `MYSQL_HOST` | `localhost` | Override MySQL host via env var |

---

## Screenshots

### Client Side
![Client Homepage](demo/Client%20side%2001.png)
![Client Restaurant](demo/Client%20side%2002.png)

### Admin Dashboard
![Admin Panel](demo/Admin%20side.png)

### Database Schema
![Database Schema](demo/Database%20Schema.png)

---

## Architecture Overview

```
Browser (React)
     │
     │  HTTP / REST (JSON)
     ▼
Spring Boot (port 8080)
     │
     ├── Spring Security ──► JWT Filter ──► Validate token per request
     │
     ├── Controllers ──► Services ──► Repositories
     │                                    │
     │                               MySQL (JPA/Hibernate)
     │
     └── Redis Cache (optional) ──► Category data
```

---

## Author

**Max Nguyen** — Backend & Full-stack Developer  
Built as an internship project to demonstrate Spring Boot, REST API design, and React development skills.
