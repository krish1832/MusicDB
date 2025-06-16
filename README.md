# MusicDB 🎵

A relational database project for a music streaming platform, featuring user management, playlists, songs, premium subscriptions, payments, and business logic encapsulated through SQL.

## Features

- **User Management**: Store user profiles with emails, credentials, and date of birth
- **Premium Plans**: Multiple subscription tiers with durations and pricing
- **Payment System**: Logs subscription payments with timestamps and amounts
- **Songs & Playlists**: Users can create playlists and organize songs
- **Stored Procedures**: Encapsulate subscription and playlist logic
- **User-Defined Functions (UDFs)**: Calculate age, plan expiry, playlist duration, and active-plan status
- **ACID Transactions**: Ensures data integrity and consistency
- **Indexes**: Improved performance with primary keys, foreign keys, and selective B-tree indexes

## Project Structure
/MusicDB/
| File Name                   | Description                                  |
|-----------------------------|----------------------------------------------|
| `01_ER_DIAGRAM.jpg`         | Visual ER diagram of the database schema     |
| `02_ddl_statements.sql`     | CREATE TABLE statements for all entities     |
| `03_indexes.sql`            | Index definitions for query optimization     |
| `04_stored_procedure.sql`   | Stored procedures for subscriptions/playlists|
| `05_Userdefined_functions.sql` | Custom SQL functions (age, expiry, etc.)   |
| `06_Transaction.sql`        | Sample transaction blocks                    |
| `07_SQL_queries.sql`        | Application-level SQL queries                |
| `README.md`                 | Project documentation                        |




## Technologies Used

- **RDBMS**: MySQL/PostgreSQL compatible
- **SQL Features**:
  - Primary & Foreign Keys
  - Query optimization via indexing
  - Stored Procedures & Functions
  - Transactional integrity

## Author

**Krish Bhingradiya**  
GitHub
