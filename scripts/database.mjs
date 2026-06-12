import fs from 'node:fs/promises'
import path from 'node:path'
import process from 'node:process'
import dotenv from 'dotenv'
import mysql from 'mysql2/promise'

dotenv.config()

const command = process.argv[2]
const supportedCommands = new Set(['migrate', 'seed', 'reset'])

if (!supportedCommands.has(command)) {
  console.error('Usage: node scripts/database.mjs <migrate|seed|reset>')
  process.exit(1)
}

function parseDatabaseUrl(value) {
  if (!value) return null
  const normalized = value.startsWith('jdbc:') ? value.slice(5) : value
  if (!normalized.startsWith('mysql://')) {
    throw new Error('DATABASE_URL must use mysql:// or jdbc:mysql:// format.')
  }
  const parsed = new URL(normalized)
  return {
    host: parsed.hostname,
    port: Number(parsed.port || 3306),
    user: decodeURIComponent(parsed.username),
    password: decodeURIComponent(parsed.password),
    database: parsed.pathname.replace(/^\//, ''),
  }
}

function boolFromEnv(value, defaultValue = false) {
  if (value == null || value === '') return defaultValue
  return ['1', 'true', 'yes', 'on'].includes(String(value).toLowerCase())
}

function databaseConfig() {
  const urlConfig = parseDatabaseUrl(process.env.DATABASE_URL)
  const config = urlConfig || {
    host: process.env.DB_HOST || process.env.MYSQLHOST || 'localhost',
    port: Number(process.env.DB_PORT || process.env.MYSQLPORT || 3306),
    user: process.env.DATABASE_USERNAME || process.env.DB_USER || process.env.MYSQLUSER || 'root',
    password: process.env.DATABASE_PASSWORD || process.env.DB_PASSWORD || process.env.MYSQLPASSWORD || '',
    database: process.env.DB_NAME || process.env.MYSQLDATABASE || 'fooddelivery',
  }

  const sslEnabled = boolFromEnv(process.env.DB_SSL, process.env.NODE_ENV === 'production')
  return {
    ...config,
    waitForConnections: true,
    connectionLimit: Number(process.env.DB_SEED_POOL_SIZE || 3),
    connectTimeout: Number(process.env.DB_CONNECTION_TIMEOUT_MS || 30000),
    multipleStatements: true,
    charset: 'utf8mb4',
    ssl: sslEnabled ? { rejectUnauthorized: boolFromEnv(process.env.DB_SSL_REJECT_UNAUTHORIZED, true) } : undefined,
  }
}

async function readSql(fileName) {
  return fs.readFile(path.resolve('src', fileName), 'utf8')
}

async function runSql(pool, label, sql) {
  console.log(label)
  await pool.query(sql)
}

async function resetDatabase(pool) {
  if (process.env.ALLOW_DB_RESET !== 'true') {
    throw new Error('Database reset is blocked. Set ALLOW_DB_RESET=true only for an intentional reset.')
  }
  await runSql(
    pool,
    'Resetting database',
    `SET FOREIGN_KEY_CHECKS = 0;
     DROP TABLE IF EXISTS rating_food, rating_restaurant, promotion, order_item, orders, food, restaurant_category, restaurant, category, users, roles;
     SET FOREIGN_KEY_CHECKS = 1;`,
  )
}

const pool = mysql.createPool(databaseConfig())

try {
  const connection = await pool.getConnection()
  console.log('Connected to database')
  connection.release()

  if (command === 'reset') {
    await resetDatabase(pool)
  }

  const schema = await readSql('schema.sql')
  await runSql(pool, 'Running schema', schema)

  if (command === 'seed' || command === 'reset') {
    const seed = await readSql('seed_data.sql')
    await runSql(pool, 'Running seed', seed)
    console.log('Seed completed')
  } else {
    console.log('Migration completed')
  }
} catch (error) {
  console.error(`Database command failed: ${error.message}`)
  process.exitCode = 1
} finally {
  await pool.end()
}
