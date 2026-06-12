# Production Deployment Audit

## Current architecture

- Frontend: React 18 deployed as a static site on Vercel.
- Backend: Spring Boot 3.2.3 running on Java 21.
- Database access: Spring Data JPA/Hibernate with MySQL Connector/J.
- Optional cache: Redis. The application must remain functional without Redis.
- Authentication: stateless JWT bearer tokens with BCrypt password hashing.

Vercel only hosts the React build. The Spring Boot API must be deployed to a
Java/Docker-capable service. Production also requires a managed MySQL database.

## Database model

- `roles` has many `users`.
- `restaurant` and `category` are many-to-many through
  `restaurant_category`.
- `food` belongs to one `restaurant` and one `category`.
- `orders` belongs to one `users` record and one `restaurant`.
- `order_item` joins `orders` and `food`.
- `promotion`, `rating_food`, and `rating_restaurant` store marketplace
  metadata.

## Production gaps found

- The Vercel project has no environment variables configured.
- The React API fallback is `http://localhost:8080`.
- No public Spring Boot deployment is connected to the frontend.
- The backend datasource falls back to local MySQL credentials.
- The current seed contains only 15 restaurants and approximately 60 foods.
- The frontend-only curated fallback contains five restaurants per category
  and four foods per restaurant.
- CORS allows local development only unless explicitly overridden.
- Database schema creation currently depends on Hibernate `ddl-auto=update`
  instead of a versioned SQL schema.

## Target production topology

1. Vercel hosts the React frontend.
2. Railway hosts the Spring Boot Docker service.
3. Railway MySQL stores persistent production data.
4. Vercel receives `REACT_APP_API_BASE` with the Railway API URL.
5. Railway receives JDBC database credentials, JWT secret, and the allowed
   Vercel origin through environment variables.

No database password, JWT key, or provider token belongs in Git.
