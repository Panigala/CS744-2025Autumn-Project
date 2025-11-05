# Multi-Tier KV HTTP System (C++)

## Overview
This project implements a **multi-tier HTTP key-value store** using:
- **cpp-httplib** for HTTP server/client
- **MySQL** for persistent storage
- **In-memory LRU cache** for fast access
- **Multi-threaded load generator** for benchmarking

## Files
- `server.cpp`: HTTP server with REST (PUT, GET, DELETE) endpoints that can handle multiple clients concurrently
- `client.cpp`: Load generator to simulate concurrent clients
- `mysql_setup.sql`: MySQL setup script
- `experiment.sh`: Automated load testing + CPU/disk utilization collection

## Setup Instructions
1. **Install dependencies**
   ```bash
   sudo apt update
   sudo apt install g++ make libmysqlclient-dev mysql-server mpstat sysstat iostat
   
   sudo apt install -y mysql-server mysql-client
   #put root password something remebering coz we need it later
   
   sudo systemctl enable mysql
   sudo systemctl start mysql
   ```

2. **Download httplib header**
   ```bash
   #if not already downloaded
   wget https://raw.githubusercontent.com/yhirose/cpp-httplib/master/httplib.h
   ```
   Place it in the same directory as `server.cpp` and `client.cpp`.

3. **Setup MySQL**
   ```bash
   sudo mysql -u root -p < mysql_setup.sql
   ```

4. **Compile**
   ```bash
   g++ -std=c++17 server.cpp -lmysqlclient -lpthread -o server
   g++ -std=c++17 client.cpp -lpthread -o client
   chmod +x experiment.sh
   ```

5. **Run**
   ```bash
   # put desired cpu core where this need to be run
   taskset -c 6,7 ./server &
   
   # put desired cpu core where this need to be run
   taskset -c 0-5 ./client 
   ```

