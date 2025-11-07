# Multi-Tier Key-Value HTTP System (C++)

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
- `client_test_server.cpp`: for testing all server request responses

## Setup Instructions
1. **Install dependencies**
   ```bash
   sudo apt update
   sudo apt install wget curl
   sudo apt install g++ make libmysqlclient-dev mysql-server mpstat sysstat iostat
   
   sudo apt install -y mysql-server mysql-client
   #put root password something remebering coz we need it later
   
   sudo systemctl enable mysql
   sudo systemctl start mysql
   ```

2. **Download httplib header**
   ```bash
   #if not already then only  downloaded
   wget https://raw.githubusercontent.com/yhirose/cpp-httplib/master/httplib.h
   ```
   Place it in the same directory as `server.cpp` and `client.cpp`.

3. **Setup MySQL**
   ```bash
   sudo mysql -u root -p < mysql_setup.sql
   ```
4. **Compile**
   ```bash
   #compile server and the actual multithreaded-client(load generator)
   g++ -std=c++17 server.cpp -lmysqlclient -lpthread -o server
   g++ -std=c++17 client.cpp -lpthread -o client
   ```

5. **Testing**
   ```bash
   #just to test server response for request etc...
   g++ -std=c++17 client_test_server.cpp -o test_server -lpthread
   taskset -c 0,1 ./server &
   taskset -c 2-7 ./test_server
   ```


6. **Run**
   ```bash
   #--------Requests supported but server--------------
   # GET , PUT/POST , DELETE , popular , stats , health
   
   # put desired cpu core where this need to be run then the arguments are
   # number of threads, time to run, GET%, POST%, DELETE%, popular%    where all % should add to 100
   # eg : taskset -c 0-7 ./client 6000 10 0 10 90 0
   taskset -c 0-5 ./client 
   ```





