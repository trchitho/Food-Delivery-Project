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
├── src/main/java/com/thotran/fooddelivery/
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
├── scripts/                              # MySQL migration and seed tools
├── src/schema.sql                        # Idempotent MySQL schema
├── src/seed_data.sql                     # Production catalog seed
├── .env.example                          # Backend/DB environment template
└── pom.xml                               # Maven dependencies
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

### 2. Configure the environment

Copy `.env.example` to `.env` and provide local credentials. Never commit the
real `.env` file.

```env
DATABASE_URL=jdbc:mysql://localhost:3306/fooddelivery?useUnicode=true&characterEncoding=utf8&characterSetResults=utf8mb4&connectionCollation=utf8mb4_unicode_ci&useSSL=false&allowPublicKeyRetrieval=true
DATABASE_USERNAME=root
DATABASE_PASSWORD=your_local_password
JWT_PRIVATE_KEY=your_base64_secret
CORS_ALLOWED_ORIGINS=http://localhost:3000
```

### 3. Create and seed the database

```bash
npm install
npm run db:migrate
npm run db:seed
```

Useful database commands:

| Command | Purpose |
|---|---|
| `npm run seed:generate` | Regenerate the deterministic catalog SQL |
| `npm run db:migrate` | Apply `src/schema.sql` |
| `npm run db:seed` | Apply schema and idempotent seed data |
| `npm run db:reset` | Destructive local reset; requires `ALLOW_DB_RESET=true` |

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

---

## Environment Configuration

| Variable | Default | Description |
|---|---|---|
| `DATABASE_URL` | local JDBC URL | JDBC MySQL connection URL |
| `DATABASE_USERNAME` | `root` | MySQL username |
| `DATABASE_PASSWORD` | empty | MySQL password |
| `DB_SSL` | `false` | Enable TLS when using split `DB_*` variables |
| `DDL_AUTO` | `update` | Hibernate schema mode |
| `DB_INIT_MODE` | `never` | Set to `always` only for the initial production seed |
| `JWT_PRIVATE_KEY` | required | Base64 secret used to sign JWTs |
| `JWT_EXPIRATION_MS` | `86400000` | Token lifetime |
| `CORS_ALLOWED_ORIGINS` | `http://localhost:3000` | Comma-separated frontend origins |
| `FILE_UPLOAD_ROOT` | `./uploads` | Writable upload directory |
| `REACT_APP_API_BASE` | localhost in development | Public backend URL for React |

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

**Tho Tran** — Backend & Full-stack Developer  
Built as an internship project to demonstrate Spring Boot, REST API design, and React development skills.

---

## Deployment Notes

### Frontend on Vercel

The repository includes `vercel.json` for deploying the React app from the `client` folder.

Required Vercel environment variable:

```env
REACT_APP_API_BASE=https://your-public-backend-url
```

### Backend and Database on Railway

The production topology is:

```text
Vercel React frontend -> Railway Spring Boot API -> Railway MySQL
```

Create a Railway MySQL service and reference its variables from the backend
service. The root `Dockerfile` builds the Spring Boot API with Java 21.

Required backend environment variables:

```env
DATABASE_URL=jdbc:mysql://${{MySQL.MYSQLHOST}}:${{MySQL.MYSQLPORT}}/${{MySQL.MYSQLDATABASE}}?useUnicode=true&characterEncoding=utf8&characterSetResults=utf8mb4&connectionCollation=utf8mb4_unicode_ci&useSSL=false&allowPublicKeyRetrieval=true
DATABASE_USERNAME=${{MySQL.MYSQLUSER}}
DATABASE_PASSWORD=${{MySQL.MYSQLPASSWORD}}
JWT_PRIVATE_KEY=replace-with-base64-secret
CORS_ALLOWED_ORIGINS=https://your-vercel-app.vercel.app,http://localhost:3000
NODE_ENV=production
DDL_AUTO=update
FILE_UPLOAD_ROOT=/tmp/uploads
```

For the first deployment only, set `DB_INIT_MODE=always`. The packaged
`schema.sql` and `seed_data.sql` create 8 categories, 48 restaurants and 480
menu items without deleting existing users. After the first successful startup,
change `DB_INIT_MODE` back to `never` and redeploy.

Generate a Railway public domain for the backend, then set the Vercel Production
environment:

```env
REACT_APP_API_BASE=https://your-backend.up.railway.app
```

Redeploy Vercel after changing this build-time React variable.
