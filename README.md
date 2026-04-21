# README

# Employee Salary Insights API

A Ruby on Rails API to manage employees and provide salary insights with optimized queries and efficient data seeding.

* * * * *

📌 Tech Stack
-------------

-   Ruby 3.x
-   Rails 7.x
-   PostgreSQL

* * * * *

🚀 Features
-----------

### 1\. Employee Management

-   Create, update, delete, and fetch employees
-   Pagination support
-   Optimized queries (select only required fields)

### 2\. Salary Insights API

Provides insights based on country:

-   Minimum salary
-   Maximum salary
-   Average salary
-   Average salary by job title
-   Total employees
-   Median salary

* * * * *

📡 API Endpoints
----------------

### 🔹 Employees

| Method | Endpoint | Description |
| --- | --- | --- |
| GET | `/employees` | List employees (paginated) |
| POST | `/employees` | Create employee |
| GET | `/employees/:id` | Show employee |
| PATCH | `/employees/:id` | Update employee |
| DELETE | `/employees/:id` | Delete employee |

* * * * *

### 🔹 Insights

| Method | Endpoint | Description |
| --- | --- | --- |
| GET | `/insights?country=India` | Get salary insights |

Optional:

/insights?country=India&job_title=Engineer

* * * * *

⚙️ Setup Instructions
---------------------

### 1\. Clone repository

git clone <repo_url>\
cd project_name

### 2\. Install dependencies

bundle install

### 3\. Setup database

rails db:create db:migrate

* * * * *

🌱 Seeding Data (10,000 Employees)
----------------------------------

### Step 1: Generate name files

rails db:generate_names

This will create:

db/first_names.txt\
db/last_names.txt

* * * * *

### Step 2: Seed data

rails db:seed

* * * * *
## 📄 API Documentation (Swagger)

This project uses Swagger via the `rswag` gem for API documentation and testing.

## Setup Swagger

```bash
bundle install
rails generate rswag:install
rails db:migrate
```

- URL: `http://localhost:3000/api-docs`
- Built using `rswag`
- Specs are located in `spec/requests`

* * * * *

⚡ Seeding Approach
------------------

-   Generates **10,000 employees**
-   Uses names from `.txt` files
-   Uses **batch insert (`insert_all`)**
-   Batch size: **200**
-   Adds progress logs during execution

* * * * *

🚀 Performance Optimizations
----------------------------

-   Uses `insert_all`
-   Batch processing → memory efficient
-   Aggregation using database functions

* * * * *

🧪 Running Tests
----------------

bundle exec rspec

* * * * *

🧠 Design Decisions
-------------------

-   Used **PORO serializer** for clean JSON responses
-   Used **database aggregations** (`minimum`, `maximum`, `average`)
-   Used **grouping** for job title insights
-   Median calculated in Ruby
-   Batch insert used for seeding performance
