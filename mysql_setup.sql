-- sudo mysql -u root -p < mysql_setup.sql
-- prompt for root password : <puth the root password for server>



-- =============================================================
-- MySQL Setup Script for Key-Value Store
-- =============================================================


-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS kvdb;

-- Create a dedicated user 'kvuser' with password 'kvpass'
CREATE USER IF NOT EXISTS 'kvuser'@'localhost' IDENTIFIED BY 'kvpass';

-- Grant all privileges on the kvdb database to this user
GRANT ALL PRIVILEGES ON kvdb.* TO 'kvuser'@'localhost';

-- Apply privilege changes immediately
FLUSH PRIVILEGES;

-- Use the kvdb database
USE kvdb;

-- Create the table structure used by the C++ server
CREATE TABLE IF NOT EXISTS kv (k VARCHAR(255) PRIMARY KEY, v TEXT );

-- Done
SELECT 'kvdb setup complete' AS status;
