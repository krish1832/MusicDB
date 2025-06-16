# 🎵 MusicDB

A relational database project for a music streaming platform — complete with user management, playlists, songs, premium subscriptions, payments, and business logic encapsulated through SQL.

---

## 📈 Features

- **User Management**: Store user profiles with emails, credentials, and date of birth  
- **Premium Plans**: Multiple subscription tiers with durations and pricing  
- **Payment System**: Logs subscription payments with timestamps and amounts  
- **Songs & Playlists**: Users can create playlists and organize songs  
- **Stored Procedures**: Encapsulate subscription and playlist logic  
- **User-Defined Functions (UDFs)**: Calculate age, plan expiry, playlist duration, and active-plan status  
- **ACID Transactions**: Ensures data integrity and consistency  
- **Indexes**: Improved performance with primary keys, foreign keys, and selective B-tree indexes

---

## 📂 Project Structure

/MusicDB/
|-- 01_ER_DIAGRAM.jpg             # Visual ER diagram of the entire database schema  
|-- 02_ddl_statements.sql         # CREATE TABLE statements for all entities and relationships  
|-- 03_indexes.sql                # Index definitions for query performance optimization  
|-- 04_stored_procedure.sql       # Stored procedures for tasks like subscribing and playlist management  
|-- 05_Userdefined_functions.sql  # Custom SQL functions (UDFs) for calculations like age, expiry, etc.  
|-- 06_Transaction.sql            # Sample transaction blocks ensuring ACID properties  
|-- 07_SQL_queries.sql            # Application-level SQL queries (INSERTs, SELECTs, JOINs, etc.)  
|-- README.md                     # Project overview, setup, and documentation  


---

## 📊 Technologies Used

- **RDBMS**: MySQL / PostgreSQL compatible  
- **SQL Features**:  
  - Primary & Foreign Keys  
  - Indexing for optimization  
  - Stored Procedures & Functions  
  - Transactional Integrity

---

## 👨‍💻 Author

**Krish Bhingradiya**  
🔗 [GitHub Profile](https://github.com/krish1832)  
📧 krish1832kb@gmail.com
---
