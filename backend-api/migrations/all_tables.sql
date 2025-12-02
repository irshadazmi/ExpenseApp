--- This table stores information about roles, such as their name and description.
CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL UNIQUE, 
    description VARCHAR(255)
);

-- This table stores information about users, such as their name, contact details, and employment status.
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    role_id INTEGER NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES roles (id)
);

INSERT INTO users (full_name, email, password, phone, role_id, is_active)
VALUES
    ('Irshad Ahmad', 'irshad_ahmad@hotmail.com', 'password123', '9090909090', 1, TRUE),
    ('Umair Ahmed', 'umair_ahmed@hotmail.com', 'password123', '8989898989', 2, TRUE),
    ('Rifa Ahmed', 'rifa_ahmed@hotmail.com', 'password123', '8888888888', 2, TRUE),
    ('John Doe', 'john.doe@example.com', 'password123', '1234567890', 1, TRUE),
    ('Jane Doe', 'jane.doe@example.com', 'password123', '1234567891', 2, TRUE),
    ('Bob Smith', 'bob.smith@example.com', 'password123', '1234567892', 3, TRUE),
    ('Alice Johnson', 'alice.johnson@example.com', 'password123', '1234567893', 1, TRUE),
    ('Charlie Brown', 'charlie.brown@example.com', 'password123', '1234567894', 2, TRUE),
    ('David Jones', 'david.jones@example.com', 'password123', '1234567895', 3, TRUE),
    ('Emily Williams', 'emily.williams@example.com', 'password123', '1234567896', 1, TRUE),
    ('Frank Lee', 'frank.lee@example.com', 'password123', '1234567897', 2, TRUE),
    ('George Miller', 'george.miller@example.com', 'password123', '1234567898', 3, TRUE),
    ('Harry White', 'harry.white@example.com', 'password123', '1234567899', 1, TRUE),
    ('Karen Johnson', 'karen.johnson@example.com', 'password123', '1234567900', 2, TRUE),
    ('Lisa Brown', 'lisa.brown@example.com', 'password123', '1234567901', 3, TRUE),
    ('Mike Davis', 'mike.davis@example.com', 'password123', '1234567902', 1, TRUE),
    ('Nancy Smith', 'nancy.smith@example.com', 'password123', '1234567903', 2, TRUE),
    ('Oliver Jones', 'oliver.jones@example.com', 'password123', '1234567904', 3, TRUE),
    ('Peter Johnson', 'peter.johnson@example.com', 'password123', '1234567905', 1, TRUE),
    ('Sarah Lee', 'sarah.lee@example.com', 'password123', '1234567906', 2, TRUE),
    ('Thomas Brown', 'thomas.brown@example.com', 'password123', '1234567907', 3, TRUE),
    ('Victoria Smith', 'victoria.smith@example.com', 'password123', '1234567908', 1, TRUE),
    ('William Jones', 'william.jones@example.com', 'password123', '1234567909', 2, TRUE),
    ('Zachary White', 'zachary.white@example.com', 'password123', '1234567910', 3, TRUE),
    ('Amy Johnson', 'amy.johnson@example.com', 'password123', '1234567911', 1, TRUE),
    ('Brian Brown', 'brian.brown@example.com', 'password123', '1234567912', 2, TRUE),
    ('Carol Jones', 'carol.jones@example.com', 'password123', '1234567913', 3, TRUE),
    ('Daniel Smith', 'daniel.smith@example.com', 'password123', '1234567914', 1, TRUE),
    ('Elizabeth Lee', 'elizabeth.lee@example.com', 'password123', '1234567915', 2, TRUE),
    ('Franklin Jones', 'franklin.jones@example.com', 'password123', '1234567916', 3, TRUE),
    ('George Williams', 'george.williams@example.com', 'password123', '1234567917', 1, TRUE),
    ('Helen Brown', 'helen.brown@example.com', 'password123', '1234567918', 2, TRUE),
    ('Isaac Johnson', 'isaac.johnson@example.com', 'password123', '1234567919', 3, TRUE),
    ('James Smith', 'james.smith@example.com', 'password123', '1234567920', 1, TRUE),
    ('Julie Jones', 'julie.jones@example.com', 'password123', '1234567921', 2, TRUE),
    ('Katherine Lee', 'katherine.lee@example.com', 'password123', '1234567922', 3, TRUE),
    ('Linda Johnson', 'linda.johnson@example.com', 'password123', '1234567923', 1, TRUE),
    ('Margaret Brown', 'margaret.brown@example.com', 'password123', '1234567924', 2, TRUE),
    ('Matthew Smith', 'matthew.smith@example.com', 'password123', '1234567925', 3, TRUE),
    ('Nicholas Jones', 'nicholas.jones@example.com', 'password123', '1234567926', 1, TRUE),
    ('Olivia Lee', 'olivia.lee@example.com', 'password123', '1234567927', 2, TRUE),
    ('Patrick Johnson', 'patrick.johnson@example.com', 'password123', '1234567928', 3, TRUE),
    ('Rachel Smith', 'rachel.smith@example.com', 'password123', '1234567929', 1, TRUE),
    ('Robert Jones', 'robert.jones@example.com', 'password123', '1234567930', 2, TRUE),
    ('Samuel Brown', 'samuel.brown@example.com', 'password123', '1234567931', 3, TRUE),
    ('Sophia Johnson', 'sophia.johnson@example.com', 'password123', '1234567932', 1, TRUE),
    ('Thomas Smith', 'thomas.smith@example.com', 'password123', '1234567933', 2, TRUE),
    ('Victoria Jones', 'victoria.jones@example.com', 'password123', '1234567934', 3, TRUE),
    ('William Brown', 'william.brown@example.com', 'password123', '1234567935', 1, TRUE),
    ('Zachary Johnson', 'zachary.johnson@example.com', 'password123', '1234567936', 2, TRUE);

--- This table stores information about categories, such as their name and description.
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    description VARCHAR(255),   
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TRUNCATE TABLE categories RESTART IDENTITY;

INSERT INTO categories (name, description) VALUES
('Food & Dining', 'Meals, groceries, cafes, restaurants, and takeout orders'),
('Transportation', 'Fuel, public transit, ride-hailing, parking, and vehicle expenses'),
('Housing', 'Rent, mortgage payments, property maintenance, and household utilities'),
('Healthcare', 'Doctor visits, pharmacy purchases, medical insurance, and hospital bills'),
('Entertainment', 'Movies, streaming subscriptions, concerts, gaming, and leisure activities'),
('Travel', 'Flights, hotels, vacation packages, and related travel costs'),
('Shopping', 'Clothing, electronics, household goods, and personal purchases'),
('Education', 'Tuition fees, online courses, books, and professional training'),
('Bills & Utilities', 'Recurring service bills like internet, phone, cable, and electricity'),
('Miscellaneous', 'Catch-all for irregular or uncategorized expenses');

--- This table stores information about budgets, such as their name, amount, duration, and associated user.
CREATE TABLE budgets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    amount INTEGER NOT NULL,
    currency VARCHAR(10) DEFAULT 'INR', --'INR' or 'USD' or 'EUR' or 'GBP' etc.
    period VARCHAR(50) NOT NULL, -- e.g., 'Monthly'- for now let us consider only monthly
    effective_from TIMESTAMP NOT NULL, -- Current date when the first budget is created
    effective_to TIMESTAMP NULL,       -- Current date of the a new budget, when it is created
    version INTEGER DEFAULT 1,
    user_id INTEGER NOT NULL REFERENCES users(id),
    category_id INTEGER NULL REFERENCES categories(id),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TRUNCATE TABLE budgets RESTART IDENTITY;

INSERT INTO budgets (name, amount, currency, period, start_date, end_date, user_id, category_id)
SELECT 'Monthly Total Budget', SUM(b.amount), 'INR', 'Monthly', CURRENT_DATE, date_trunc('month', CURRENT_DATE) + INTERVAL '1 month - 1 day', b.user_id, 0
FROM budgets b
GROUP BY b.user_id;
INSERT INTO budgets (name, amount, currency, period, effective_from, effective_to, version, user_id, category_id, is_active)
VALUES
('Monthly Total Budget', 10500, 'INR', 'Monthly', '2025-08-01', NULL, 1, 1, 0, TRUE),
('Grocery Budget', 8000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 1, 1, TRUE),
('Rent Budget', 12000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 1, 3, TRUE),
('Transport Budget', 3000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 1, 8, TRUE),
('Monthly Total Budget', 11000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 2, 0, TRUE),
('Food Budget', 9000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 2, 2, TRUE),
('Health Budget', 6000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 2, 7, TRUE),
('Misc Budget', 2500, 'INR', 'Monthly', '2025-08-01', NULL, 1, 2, 10, TRUE),
('Monthly Total Budget', 11500, 'INR', 'Monthly', '2025-08-01', NULL, 1, 3, 0, TRUE),
('Salary Budget', 50000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 3, 11, TRUE),
('Grocery Budget', 6000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 3, 1, TRUE),
('Entertainment Budget', 4000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 3, 4, TRUE),
('Monthly Total Budget', 12000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 4, 0, TRUE),
('Monthly Total Budget', 12500, 'INR', 'Monthly', '2025-08-01', NULL, 1, 5, 0, TRUE),
('Monthly Total Budget', 13000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 6, 0, TRUE),
('Monthly Total Budget', 13500, 'INR', 'Monthly', '2025-08-01', NULL, 1, 7, 0, TRUE),
('Monthly Total Budget', 14000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 8, 0, TRUE),
('Monthly Total Budget', 14500, 'INR', 'Monthly', '2025-08-01', NULL, 1, 9, 0, TRUE),
('Monthly Total Budget', 15000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 10, 0, TRUE),
('Monthly Total Budget', 15500, 'INR', 'Monthly', '2025-08-01', NULL, 1, 11, 0, TRUE),
('Monthly Total Budget', 16000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 12, 0, TRUE),
('Monthly Total Budget', 16500, 'INR', 'Monthly', '2025-08-01', NULL, 1, 13, 0, TRUE),
('Monthly Total Budget', 17000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 14, 0, TRUE),
('Monthly Total Budget', 17500, 'INR', 'Monthly', '2025-08-01', NULL, 1, 15, 0, TRUE),
('Monthly Total Budget', 18000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 16, 0, TRUE),
('Monthly Total Budget', 18500, 'INR', 'Monthly', '2025-08-01', NULL, 1, 17, 0, TRUE),
('Monthly Total Budget', 19000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 18, 0, TRUE),
('Monthly Total Budget', 19500, 'INR', 'Monthly', '2025-08-01', NULL, 1, 19, 0, TRUE),
('Monthly Total Budget', 20000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 20, 0, TRUE),
('Monthly Total Budget', 20500, 'INR', 'Monthly', '2025-08-01', NULL, 1, 21, 0, TRUE),
('Monthly Total Budget', 21000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 22, 0, TRUE),
('Monthly Total Budget', 21500, 'INR', 'Monthly', '2025-08-01', NULL, 1, 23, 0, TRUE),
('Monthly Total Budget', 22000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 24, 0, TRUE),
('Monthly Total Budget', 22500, 'INR', 'Monthly', '2025-08-01', NULL, 1, 25, 0, TRUE),
('Grocery Budget', 7000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 25, 1, TRUE),
('Rent Budget', 15000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 25, 3, TRUE),
('Monthly Total Budget', 23000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 26, 0, TRUE),
('Monthly Total Budget', 23500, 'INR', 'Monthly', '2025-08-01', NULL, 1, 27, 0, TRUE),
('Monthly Total Budget', 24000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 28, 0, TRUE),
('Monthly Total Budget', 24500, 'INR', 'Monthly', '2025-08-01', NULL, 1, 29, 0, TRUE),
('Monthly Total Budget', 25000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 30, 0, TRUE),
('Monthly Total Budget', 25500, 'INR', 'Monthly', '2025-08-01', NULL, 1, 31, 0, TRUE),
('Monthly Total Budget', 26000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 32, 0, TRUE),
('Monthly Total Budget', 26500, 'INR', 'Monthly', '2025-08-01', NULL, 1, 33, 0, TRUE),
('Monthly Total Budget', 27000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 34, 0, TRUE),
('Monthly Total Budget', 27500, 'INR', 'Monthly', '2025-08-01', NULL, 1, 35, 0, TRUE),
('Monthly Total Budget', 28000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 36, 0, TRUE),
('Monthly Total Budget', 28500, 'INR', 'Monthly', '2025-08-01', NULL, 1, 37, 0, TRUE),
('Monthly Total Budget', 29000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 38, 0, TRUE),
('Monthly Total Budget', 29500, 'INR', 'Monthly', '2025-08-01', NULL, 1, 39, 0, TRUE),
('Monthly Total Budget', 30000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 40, 0, TRUE),
('Monthly Total Budget', 30500, 'INR', 'Monthly', '2025-08-01', NULL, 1, 41, 0, TRUE),
('Monthly Total Budget', 31000, 'INR', 'Monthly', '2025-08-01', NULL, 1, 42, 0, TRUE),
('Monthly Total Budget', 31500, 'INR', 'Monthly', '2025-08-01', NULL, 1, 43, 0, TRUE),

-- 1	"Monthly Total Budget"	23000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	1	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 2	"Grocery Budget"	8000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	1	1	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 3	"Rent Budget"	12000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	1	3	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 4	"Transport Budget"	3000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	1	8	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 5	"Monthly Total Budget"	17500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	2	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 6	"Food Budget"	9000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	2	2	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 7	"Health Budget"	6000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	2	7	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 8	"Misc Budget"	2500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	2	10	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 9	"Monthly Total Budget"	60000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	3	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 10	"Salary Budget"	50000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	3	11	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 11	"Grocery Budget"	6000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	3	1	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 12	"Entertainment Budget"	4000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	3	4	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 13	"Monthly Total Budget"	12000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	4	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 14	"Monthly Total Budget"	12500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	5	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 15	"Monthly Total Budget"	13000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	6	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 16	"Monthly Total Budget"	13500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	7	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 17	"Monthly Total Budget"	14000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	8	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 18	"Monthly Total Budget"	14500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	9	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 19	"Monthly Total Budget"	13500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	10	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 20	"Health Budget"	9000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	10	7	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 21	"Transport Budget"	4500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	10	8	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 22	"Monthly Total Budget"	15500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	11	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 23	"Monthly Total Budget"	16000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	12	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 24	"Monthly Total Budget"	16500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	13	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 25	"Monthly Total Budget"	17000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	14	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 26	"Monthly Total Budget"	17500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	15	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 27	"Monthly Total Budget"	18000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	16	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 28	"Monthly Total Budget"	18500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	17	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 29	"Monthly Total Budget"	19000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	18	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 30	"Monthly Total Budget"	19500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	19	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 31	"Monthly Total Budget"	20000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	20	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 32	"Monthly Total Budget"	20500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	21	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 33	"Monthly Total Budget"	21000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	22	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 34	"Monthly Total Budget"	21500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	23	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 35	"Monthly Total Budget"	22000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	24	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 36	"Monthly Total Budget"	22000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	25	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 37	"Grocery Budget"	7000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	25	1	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 38	"Rent Budget"	15000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	25	3	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 39	"Monthly Total Budget"	23000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	26	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 40	"Monthly Total Budget"	23500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	27	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 41	"Monthly Total Budget"	24000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	28	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 42	"Monthly Total Budget"	24500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	29	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 43	"Monthly Total Budget"	25000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	30	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 44	"Monthly Total Budget"	25500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	31	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 45	"Monthly Total Budget"	26000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	32	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 46	"Monthly Total Budget"	26500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	33	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 47	"Monthly Total Budget"	27000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	34	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 48	"Monthly Total Budget"	27500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	35	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 49	"Monthly Total Budget"	28000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	36	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 50	"Monthly Total Budget"	28500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	37	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 51	"Monthly Total Budget"	29000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	38	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 52	"Monthly Total Budget"	29500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	39	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 53	"Monthly Total Budget"	30000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	40	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 54	"Monthly Total Budget"	30500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	41	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 55	"Monthly Total Budget"	31000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	42	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 56	"Monthly Total Budget"	31500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	43	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 57	"Monthly Total Budget"	32000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	44	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 58	"Monthly Total Budget"	32500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	45	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 59	"Monthly Total Budget"	33000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	46	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 60	"Monthly Total Budget"	33500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	47	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 61	"Monthly Total Budget"	34000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	48	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 62	"Monthly Total Budget"	34500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	49	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 63	"Monthly Total Budget"	35000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	50	0	true	"2025-11-24 19:53:39.030577"	"2025-11-24 19:53:39.030577"
-- 64	"Monthly Total Budget"	31000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	42	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 65	"Monthly Total Budget"	24500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	29	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 66	"Monthly Total Budget"	12000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	4	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 67	"Monthly Total Budget"	27000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	34	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 68	"Monthly Total Budget"	30500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	41	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 69	"Monthly Total Budget"	33000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	46	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 70	"Monthly Total Budget"	30000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	40	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 71	"Monthly Total Budget"	31500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	43	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 72	"Monthly Total Budget"	26000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	32	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 73	"Monthly Total Budget"	13500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	10	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 74	"Monthly Total Budget"	14500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	9	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 75	"Monthly Total Budget"	13500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	7	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 76	"Monthly Total Budget"	27500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	35	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 77	"Monthly Total Budget"	32500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	45	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 78	"Monthly Total Budget"	29000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	38	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 79	"Monthly Total Budget"	17500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	15	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 80	"Monthly Total Budget"	13000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	6	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 81	"Monthly Total Budget"	34000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	48	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 82	"Monthly Total Budget"	23000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	26	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 83	"Monthly Total Budget"	16000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	12	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 84	"Monthly Total Budget"	29500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	39	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 85	"Monthly Total Budget"	22000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	24	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 86	"Monthly Total Budget"	19500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	19	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 87	"Monthly Total Budget"	28000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	36	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 88	"Monthly Total Budget"	22000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	25	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 89	"Monthly Total Budget"	25500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	31	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 90	"Monthly Total Budget"	25000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	30	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 91	"Monthly Total Budget"	35000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	50	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 92	"Monthly Total Budget"	20500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	21	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 93	"Monthly Total Budget"	34500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	49	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 94	"Monthly Total Budget"	33500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	47	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 95	"Monthly Total Budget"	17000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	14	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 96	"Monthly Total Budget"	60000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	3	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 97	"Monthly Total Budget"	18500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	17	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 98	"Monthly Total Budget"	28500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	37	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 99	"Monthly Total Budget"	24000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	28	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 100	"Monthly Total Budget"	21000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	22	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 101	"Monthly Total Budget"	20000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	20	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 102	"Monthly Total Budget"	26500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	33	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 103	"Monthly Total Budget"	16500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	13	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 104	"Monthly Total Budget"	23000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	1	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 105	"Monthly Total Budget"	12500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	5	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 106	"Monthly Total Budget"	19000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	18	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 107	"Monthly Total Budget"	17500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	2	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 108	"Monthly Total Budget"	18000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	16	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 109	"Monthly Total Budget"	23500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	27	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 110	"Monthly Total Budget"	21500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	23	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 111	"Monthly Total Budget"	32000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	44	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 112	"Monthly Total Budget"	15500	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	11	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"
-- 113	"Monthly Total Budget"	14000	"INR"	"Monthly"	"2025-11-24 00:00:00"	"2025-11-30 00:00:00"	8	0	true	"2025-11-24 19:54:01.089229"	"2025-11-24 19:54:01.089229"


--- This table stores information about accounts, such as their name, type, balance, currency, and associated user.
CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(50) NOT NULL, -- e.g., 'Savings', 'Checking', 'Credit', 'Wallet' etc.
    balance FLOAT DEFAULT 0,
    currency VARCHAR(10) DEFAULT 'INR', --'INR' or 'USD' or 'EUR' or 'GBP' etc.
    user_id INTEGER NOT NULL REFERENCES users(id),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TRUNCATE TABLE accounts RESTART IDENTITY;

INSERT INTO accounts (name, type, balance, currency, user_id)
VALUES
('Emergency Fund Savings', 'Savings', 50100.00, 'INR', 1),
('Main Checking Account', 'Checking', 50200.00, 'USD', 2),
('Visa Credit Card', 'Credit', 50300.00, 'EUR', 3),
('PayPal Wallet', 'Wallet', 50400.00, 'GBP', 4),
('Vacation Savings', 'Savings', 50500.00, 'INR', 5),
('Household Checking', 'Checking', 50600.00, 'USD', 6),
('MasterCard Rewards', 'Credit', 50700.00, 'EUR', 7),
('Google Pay Wallet', 'Wallet', 50800.00, 'GBP', 8),
('Retirement Savings', 'Savings', 50900.00, 'INR', 9),
('Business Checking', 'Checking', 51000.00, 'USD', 10),
('Travel Credit Card', 'Credit', 51100.00, 'EUR', 11),
('Apple Wallet', 'Wallet', 51200.00, 'GBP', 12),
('College Fund Savings', 'Savings', 51300.00, 'INR', 13),
('Joint Checking Account', 'Checking', 51400.00, 'USD', 14),
('Corporate Credit Card', 'Credit', 51500.00, 'EUR', 15),
('Cash Wallet', 'Wallet', 51600.00, 'GBP', 16),
('Emergency Fund Savings', 'Savings', 51700.00, 'INR', 17),
('Main Checking Account', 'Checking', 51800.00, 'USD', 18),
('Visa Credit Card', 'Credit', 51900.00, 'EUR', 19),
('PayPal Wallet', 'Wallet', 52000.00, 'GBP', 20),
('Vacation Savings', 'Savings', 52100.00, 'INR', 21),
('Household Checking', 'Checking', 52200.00, 'USD', 22),
('MasterCard Rewards', 'Credit', 52300.00, 'EUR', 23),
('Google Pay Wallet', 'Wallet', 52400.00, 'GBP', 24),
('Retirement Savings', 'Savings', 52500.00, 'INR', 25),
('Business Checking', 'Checking', 52600.00, 'USD', 26),
('Travel Credit Card', 'Credit', 52700.00, 'EUR', 27),
('Apple Wallet', 'Wallet', 52800.00, 'GBP', 28),
('College Fund Savings', 'Savings', 52900.00, 'INR', 29),
('Joint Checking Account', 'Checking', 53000.00, 'USD', 30),
('Corporate Credit Card', 'Credit', 53100.00, 'EUR', 31),
('Cash Wallet', 'Wallet', 53200.00, 'GBP', 32),
('Emergency Fund Savings', 'Savings', 53300.00, 'INR', 33),
('Main Checking Account', 'Checking', 53400.00, 'USD', 34),
('Visa Credit Card', 'Credit', 53500.00, 'EUR', 35),
('PayPal Wallet', 'Wallet', 53600.00, 'GBP', 36),
('Vacation Savings', 'Savings', 53700.00, 'INR', 37),
('Household Checking', 'Checking', 53800.00, 'USD', 38),
('MasterCard Rewards', 'Credit', 53900.00, 'EUR', 39),
('Google PayWallet', 'Wallet', 54000.00, 'GBP', 40),
('Retirement Savings', 'Savings', 54100.00, 'INR', 41),
('Business Checking', 'Checking', 54200.00, 'USD', 42),
('Travel Credit Card', 'Credit', 54300.00, 'EUR', 43),
('Apple Wallet', 'Wallet', 54400.00, 'GBP', 44),
('College Fund Savings', 'Savings', 54500.00, 'INR', 45),
('Joint Checking Account', 'Checking', 54600.00, 'USD', 46),
('Corporate Credit Card', 'Credit', 54700.00, 'EUR', 47),
('Cash Wallet', 'Wallet', 54800.00, 'GBP', 48),
('Emergency Fund Savings', 'Savings', 54900.00, 'INR', 49),
('Main Checking Account', 'Checking', 55000.00, 'USD', 50);

--- This table stores information about transactions, such as their description, amount, category, and user.
CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    amount INTEGER NOT NULL,
    type VARCHAR(50) DEFAULT 'Expense', -- 'Expense' or 'Encome' or 'Transfer'
    currency VARCHAR(10) DEFAULT 'INR', --'INR' or 'USD' or 'EUR' or 'GBP' etc.
    category_id INTEGER NOT NULL REFERENCES categories(id),
    account_id INTEGER NOT NULL REFERENCES accounts(id),
    user_id INTEGER NOT NULL REFERENCES users(id),
    transaction_date TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TRUNCATE TABLE transactions RESTART IDENTITY;

INSERT INTO transactions (description, amount, type, currency, category_id, account_id, user_id, transaction_date)
VALUES
-- ------------------------------
-- USER 1 (Account 1)
-- ------------------------------
('Groceries for the week', 1500, 'Expense', 'INR', 1, 1, 1, CURRENT_DATE - INTERVAL '10 days'),
('Dinner at a restaurant', 800, 'Expense', 'INR', 2, 1, 1, CURRENT_DATE - INTERVAL '8 days'),
('Mobile bill payment', 400, 'Expense', 'INR', 6, 1, 1, CURRENT_DATE - INTERVAL '5 days'),
('Salary deposit', 35000, 'Income', 'INR', 11, 1, 1, CURRENT_DATE - INTERVAL '2 days'),
('Fuel for car', 2000, 'Expense', 'INR', 8, 1, 1, CURRENT_DATE - INTERVAL '1 day'),

-- ------------------------------
-- USER 2 (Account 2)
-- ------------------------------
('Shopping for new clothes', 3000, 'Expense', 'INR', 9, 2, 2, CURRENT_DATE - INTERVAL '7 days'),
('Online subscription fee', 199, 'Expense', 'INR', 10, 2, 2, CURRENT_DATE - INTERVAL '3 days'),
('Freelance payment received', 15000, 'Income', 'INR', 11, 2, 2, CURRENT_DATE - INTERVAL '1 day'),

-- ------------------------------
-- USER 3 (Account 3)
-- ------------------------------
('House rent payment', 12000, 'Expense', 'INR', 3, 3, 3, CURRENT_DATE - INTERVAL '15 days'),
('Doctor visit', 500, 'Expense', 'INR', 7, 3, 3, CURRENT_DATE - INTERVAL '6 days'),
('Gift received', 2000, 'Income', 'INR', 11, 3, 3, CURRENT_DATE - INTERVAL '2 days'),

-- ------------------------------
-- USER 4 (Account 4)
-- ------------------------------
('Public transport pass', 600, 'Expense', 'INR', 8, 4, 4, CURRENT_DATE - INTERVAL '10 days'),
('Coffee and snack', 120, 'Expense', 'INR', 2, 4, 4, CURRENT_DATE - INTERVAL '4 days'),
('Bonus from work', 5000, 'Income', 'INR', 11, 4, 4, CURRENT_DATE - INTERVAL '1 day'),

-- ------------------------------
-- USER 5 (Account 5)
-- ------------------------------
('Online shopping – clothes', 3000, 'Expense', 'INR', 9, 5, 5, CURRENT_DATE - INTERVAL '12 days'),
('Electricity bill', 1200, 'Expense', 'INR', 6, 5, 5, CURRENT_DATE - INTERVAL '9 days'),
('Freelance project payment', 15000, 'Income', 'INR', 11, 5, 5, CURRENT_DATE - INTERVAL '6 days'),
('Taxi fare', 350, 'Expense', 'INR', 8, 5, 5, CURRENT_DATE - INTERVAL '4 days'),
('Book purchase', 600, 'Expense', 'INR', 10, 5, 5, CURRENT_DATE - INTERVAL '3 days'),

-- ------------------------------
-- USER 6 (Account 6)
-- ------------------------------
('Dinner at restaurant', 750, 'Expense', 'INR', 2, 6, 6, CURRENT_DATE - INTERVAL '11 days'),
('Internet bill', 900, 'Expense', 'INR', 6, 6, 6, CURRENT_DATE - INTERVAL '5 days'),
('Service payment received', 8000, 'Income', 'INR', 11, 6, 6, CURRENT_DATE - INTERVAL '2 days'),

-- ------------------------------
-- USER 7 (Account 7)
-- ------------------------------
('New furniture purchase', 8500, 'Expense', 'INR', 9, 7, 7, CURRENT_DATE - INTERVAL '14 days'),
('Haircut and grooming', 350, 'Expense', 'INR', 10, 7, 7, CURRENT_DATE - INTERVAL '8 days'),
('Refund from store', 1200, 'Income', 'INR', 11, 7, 7, CURRENT_DATE - INTERVAL '3 days'),

-- ------------------------------
-- USER 8 (Account 8)
-- ------------------------------
('Movie tickets', 500, 'Expense', 'INR', 4, 8, 8, CURRENT_DATE - INTERVAL '9 days'),
('Cleaning supplies', 300, 'Expense', 'INR', 10, 8, 8, CURRENT_DATE - INTERVAL '4 days'),
('Dividend income', 2000, 'Income', 'INR', 11, 8, 8, CURRENT_DATE - INTERVAL '1 day'),

-- ------------------------------
-- USER 9 (Account 9)
-- ------------------------------
('Home repair service', 2500, 'Expense', 'INR', 10, 9, 9, CURRENT_DATE - INTERVAL '15 days'),
('Gym membership', 1000, 'Expense', 'INR', 7, 9, 9, CURRENT_DATE - INTERVAL '11 days'),
('Investment income', 5000, 'Income', 'INR', 11, 9, 9, CURRENT_DATE - INTERVAL '7 days'),
('Coffee shop visit', 250, 'Expense', 'INR', 2, 9, 9, CURRENT_DATE - INTERVAL '2 days'),
('Public transport ticket', 150, 'Expense', 'INR', 8, 9, 9, CURRENT_DATE - INTERVAL '1 day'),

-- ------------------------------
-- USER 10 (Account 10)
-- ------------------------------
('Groceries', 1200, 'Expense', 'INR', 1, 10, 10, CURRENT_DATE - INTERVAL '8 days'),
('Utilities bill', 1500, 'Expense', 'INR', 6, 10, 10, CURRENT_DATE - INTERVAL '3 days'),
('Side hustle earnings', 10000, 'Income', 'INR', 11, 10, 10, CURRENT_DATE - INTERVAL '1 day'),

-- ------------------------------
-- USER 11 (Account 11)
-- ------------------------------
('New shoes', 1800, 'Expense', 'INR', 9, 11, 11, CURRENT_DATE - INTERVAL '13 days'),
('Pharmacy medicine', 250, 'Expense', 'INR', 7, 11, 11, CURRENT_DATE - INTERVAL '5 days'),
('Gift received', 1200, 'Income', 'INR', 11, 11, 11, CURRENT_DATE - INTERVAL '2 days'),

-- ------------------------------
-- USER 12 (Account 12)
-- ------------------------------
('Concert tickets', 1500, 'Expense', 'INR', 4, 12, 12, CURRENT_DATE - INTERVAL '10 days'),
('Car maintenance', 3500, 'Expense', 'INR', 8, 12, 12, CURRENT_DATE - INTERVAL '6 days'),
('Sales commission', 6000, 'Income', 'INR', 11, 12, 12, CURRENT_DATE - INTERVAL '1 day'),

-- ------------------------------
-- USER 13 (Account 13)
-- ------------------------------
('Dining out', 1200, 'Expense', 'INR', 2, 13, 13, CURRENT_DATE - INTERVAL '9 days'),
('Electricity bill', 800, 'Expense', 'INR', 6, 13, 13, CURRENT_DATE - INTERVAL '4 days'),
('Consulting fee', 10000, 'Income', 'INR', 11, 13, 13, CURRENT_DATE - INTERVAL '2 days'),

-- ------------------------------
-- USER 14 (Account 14)
-- ------------------------------
('Books from Amazon', 650, 'Expense', 'INR', 10, 14, 14, CURRENT_DATE - INTERVAL '7 days'),
('Gym membership', 1400, 'Expense', 'INR', 7, 14, 14, CURRENT_DATE - INTERVAL '3 days'),
('Rental income', 15000, 'Income', 'INR', 11, 14, 14, CURRENT_DATE - INTERVAL '1 day'),

-- ------------------------------
-- USER 15 (Account 15)
-- ------------------------------
('Fuel for car', 2400, 'Expense', 'INR', 8, 15, 15, CURRENT_DATE - INTERVAL '12 days'),
('Mobile phone bill', 550, 'Expense', 'INR', 6, 15, 15, CURRENT_DATE - INTERVAL '5 days'),
('Project payment', 12000, 'Income', 'INR', 11, 15, 15, CURRENT_DATE - INTERVAL '2 days'),

-- ------------------------------
-- USER 16 (Account 16)
-- ------------------------------
('Home decor item', 900, 'Expense', 'INR', 10, 16, 16, CURRENT_DATE - INTERVAL '11 days'),
('Takeaway food', 300, 'Expense', 'INR', 2, 16, 16, CURRENT_DATE - INTERVAL '6 days'),
('Interest earned', 500, 'Income', 'INR', 11, 16, 16, CURRENT_DATE - INTERVAL '1 day'),

-- ------------------------------
-- USER 17 (Account 17)
-- ------------------------------
('New gadget', 8000, 'Expense', 'INR', 9, 17, 17, CURRENT_DATE - INTERVAL '14 days'),
('Internet bill', 750, 'Expense', 'INR', 6, 17, 17, CURRENT_DATE - INTERVAL '8 days'),
('Freelance work payment', 12000, 'Income', 'INR', 11, 17, 17, CURRENT_DATE - INTERVAL '3 days'),

-- ------------------------------
-- USER 18 (Account 18)
-- ------------------------------
('Groceries', 1000, 'Expense', 'INR', 1, 18, 18, CURRENT_DATE - INTERVAL '9 days'),
('Movie tickets', 300, 'Expense', 'INR', 4, 18, 18, CURRENT_DATE - INTERVAL '4 days'),
('Bonus payment', 7000, 'Income', 'INR', 11, 18, 18, CURRENT_DATE - INTERVAL '1 day'),

-- ------------------------------
-- USER 19 (Account 19)
-- ------------------------------
('Clothing purchase', 2700, 'Expense', 'INR', 9, 19, 19, CURRENT_DATE - INTERVAL '10 days'),
('Water bill', 450, 'Expense', 'INR', 6, 19, 19, CURRENT_DATE - INTERVAL '5 days'),
('Commission income', 3000, 'Income', 'INR', 11, 19, 19, CURRENT_DATE - INTERVAL '2 days'),

-- ------------------------------
-- USER 20 (Account 20)
-- ------------------------------
('Parking fee', 80, 'Expense', 'INR', 8, 20, 20, CURRENT_DATE - INTERVAL '7 days'),
('Coffee shop', 120, 'Expense', 'INR', 2, 20, 20, CURRENT_DATE - INTERVAL '3 days'),
('Gift from friend', 2000, 'Income', 'INR', 11, 20, 20, CURRENT_DATE - INTERVAL '1 day'),

-- ------------------------------
-- USER 21 (Account 21)
-- ------------------------------
('Kids activity fee', 2000, 'Expense', 'INR', 10, 21, 21, CURRENT_DATE - INTERVAL '13 days'),
('Gas bill', 900, 'Expense', 'INR', 6, 21, 21, CURRENT_DATE - INTERVAL '6 days'),
('Salary deposit', 40000, 'Income', 'INR', 11, 21, 21, CURRENT_DATE - INTERVAL '2 days'),

-- ------------------------------
-- USER 22 (Account 22)
-- ------------------------------
('Dining out', 800, 'Expense', 'INR', 2, 22, 22, CURRENT_DATE - INTERVAL '8 days'),
('Online course fee', 2500, 'Expense', 'INR', 5, 22, 22, CURRENT_DATE - INTERVAL '4 days'),
('Consulting income', 15000, 'Income', 'INR', 11, 22, 22, CURRENT_DATE - INTERVAL '1 day'),

-- ------------------------------
-- USER 23 (Account 23)
-- ------------------------------
('Groceries', 900, 'Expense', 'INR', 1, 23, 23, CURRENT_DATE - INTERVAL '11 days'),
('Pharmacy purchase', 350, 'Expense', 'INR', 7, 23, 23, CURRENT_DATE - INTERVAL '5 days'),
('Refund for return', 800, 'Income', 'INR', 11, 23, 23, CURRENT_DATE - INTERVAL '2 days');



--- This table stores information about recurring transactions, such as their description, amount, category, recurrence pattern, and associated user.
CREATE TABLE recurring_transactions (
    id SERIAL PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    amount INTEGER NOT NULL,
    type VARCHAR(50) DEFAULT 'Expense', -- 'Expense' or 'Income' or 'Transfer'
    currency VARCHAR(10) DEFAULT 'INR', --'INR' or 'USD' or 'EUR' or 'GBP' etc.
    category_id INTEGER NOT NULL REFERENCES categories(id),
    user_id INTEGER NOT NULL REFERENCES users(id),
    recurrence_pattern VARCHAR(50) NOT NULL, -- e.g., 'daily', 'weekly', 'monthly', 'yearly'
    next_occurrence TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)

-- This table stores information about feedbacks, such as their issue type, subject, description, rating, status, and associated user.
CREATE TABLE feedbacks (
    id SERIAL PRIMARY KEY,
    issue_type VARCHAR(255) NOT NULL,
    subject VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    rating INTEGER NOT NULL,
    status VARCHAR(255) NOT NULL,   -- 'Open', 'In Progress', 'Resolved', 'Closed',
    user_id INTEGER NOT NULL REFERENCES users(id),
    reply VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)

-- TRUNCATE TABLE feedbacks RESTART IDENTITY;

INSERT INTO feedbacks (issue_type, subject, description, rating, status, user_id, created_at) VALUES
('Bug / Error', 'App crashes on adding expense', 'The app crashes whenever I try to add a new expense above 10,000.', 2, 'Open', 1, '2025-01-05 10:15:00'),
('Feature Request', 'Add dark mode', 'It would be great to have a dark mode for using the app at night.', 5, 'Open', 2, '2025-01-06 09:20:00'),
('Bug / Error', 'Incorrect total in dashboard', 'The total expense in dashboard does not match the sum of listed expenses.', 3, 'In Progress', 3, '2025-01-07 14:32:00'),
('UI / UX Suggestion', 'Improve category icons', 'Category icons are too similar and confusing at a glance.', 4, 'Open', 4, '2025-01-08 18:45:00'),
('Performance Issue', 'Slow loading of reports', 'Reports page takes more than 10 seconds to load with many records.', 3, 'Open', 5, '2025-01-09 08:10:00'),
('Bug / Error', 'Date filter not working', 'Filtering expenses by date range returns incomplete results.', 2, 'Open', 6, '2025-01-10 11:05:00'),
('Feature Request', 'Support multiple currencies', 'Please allow tracking expenses in different currencies per account.', 5, 'Open', 7, '2025-01-11 16:50:00'),
('Bug / Error', 'Cannot delete category', 'Deleting an unused category shows an unknown error.', 3, 'Open', 8, '2025-01-12 19:25:00'),
('UI / UX Suggestion', 'Larger fonts on small devices', 'The font size is too small on my phone, hard to read.', 4, 'Open', 9, '2025-01-13 07:40:00'),
('Performance Issue', 'Lag when scrolling expense list', 'The expense list becomes laggy when more than 500 records exist.', 3, 'Open', 10, '2025-01-14 12:30:00'),
('Feature Request', 'Export to Excel', 'Kindly add an option to export expenses and budgets to Excel.', 5, 'Open', 1, '2025-01-15 09:15:00'),
('Bug / Error', 'Duplicate expenses after sync', 'After syncing, some expenses appear twice in the list.', 2, 'Open', 2, '2025-01-16 13:05:00'),
('UI / UX Suggestion', 'Show account name in expense list', 'Please show account name beside each expense for clarity.', 4, 'Open', 3, '2025-01-17 17:45:00'),
('Feature Request', 'Add reminders for bills', 'Would like reminders for recurring bills like rent and utilities.', 5, 'Open', 4, '2025-01-18 20:00:00'),
('Bug / Error', 'Cannot login after password reset', 'After resetting my password, the app shows invalid credentials.', 1, 'Open', 5, '2025-01-19 10:25:00'),
('Performance Issue', 'High battery usage', 'The app drains battery quickly when left open on dashboard.', 2, 'Open', 6, '2025-01-20 08:55:00'),
('Feature Request', 'Family sharing', 'Please add ability to share budgets and expenses with family members.', 5, 'Open', 7, '2025-01-21 15:20:00'),
('Bug / Error', 'Wrong currency symbol in reports', 'Reports show INR symbol even when account currency is USD.', 3, 'Open', 8, '2025-01-22 18:40:00'),
('UI / UX Suggestion', 'Better color coding', 'Use clearer colors to differentiate income, expense and transfer.', 4, 'Open', 9, '2025-01-23 07:35:00'),
('Feature Request', 'Attach receipts to expenses', 'I want to upload photo of bill/receipt with each expense.', 5, 'Open', 10, '2025-01-24 11:50:00'),
('Bug / Error', 'Categories not saving', 'Newly added categories disappear after app restart.', 2, 'In Progress', 1, '2025-01-25 09:45:00'),
('Performance Issue', 'Slow first-time startup', 'The app takes too long to open the first time after install.', 3, 'Open', 2, '2025-01-26 13:30:00'),
('UI / UX Suggestion', 'Show monthly summary chart', 'A simple bar chart on dashboard for monthly totals would help.', 5, 'Open', 3, '2025-01-27 16:05:00'),
('Feature Request', 'Biometric login', 'Allow fingerprint or face ID login for faster access.', 5, 'Open', 4, '2025-01-28 19:55:00'),
('Bug / Error', 'Incorrect sorting by date', 'Sorting by date puts some older entries at the top.', 2, 'Open', 5, '2025-01-29 08:20:00'),
('Feature Request', 'Custom categories per user', 'Each family member should be able to maintain their own categories.', 4, 'Open', 6, '2025-01-30 14:15:00'),
('UI / UX Suggestion', 'Highlight today’s expenses', 'Highlight entries for today with a subtle background color.', 4, 'Open', 7, '2025-01-31 18:10:00'),
('Bug / Error', 'Report filters reset randomly', 'Report filters reset when navigating back from details.', 3, 'Open', 8, '2025-02-01 09:05:00'),
('Feature Request', 'Offline mode', 'Allow adding expenses offline and sync when internet is back.', 5, 'Open', 9, '2025-02-02 12:40:00'),
('Performance Issue', 'Search is very slow', 'Searching for text in expenses takes several seconds.', 2, 'Open', 10, '2025-02-03 10:10:00'),
('Bug / Error', 'Negative balance not allowed', 'Transfers between accounts sometimes create negative balances.', 2, 'In Progress', 1, '2025-02-04 15:55:00'),
('Feature Request', 'Multi-language support', 'Please add support for Hindi and Arabic languages.', 5, 'Open', 2, '2025-02-05 19:30:00'),
('UI / UX Suggestion', 'More compact list view', 'Allow a dense mode to see more rows on one screen.', 4, 'Open', 3, '2025-02-06 07:50:00'),
('Bug / Error', 'Export CSV encoding issue', 'Exported CSV opens with garbled characters in Excel.', 3, 'Open', 4, '2025-02-07 11:25:00'),
('Feature Request', 'Goal-based saving', 'Feature to set savings goals and track progress.', 5, 'Open', 5, '2025-02-08 16:45:00'),
('Performance Issue', 'Charts take time to render', 'Analytics charts take too long to load with big datasets.', 3, 'Open', 6, '2025-02-09 20:05:00'),
('Bug / Error', 'Notification toggle not working', 'Disabling notifications has no effect, still getting alerts.', 2, 'Open', 7, '2025-02-10 09:35:00'),
('UI / UX Suggestion', 'Clearer error messages', 'Error messages should be more specific instead of generic.', 4, 'Open', 8, '2025-02-11 13:15:00'),
('Feature Request', 'Tag-based filtering', 'Allow adding tags to expenses and filter by multiple tags.', 5, 'Open', 9, '2025-02-12 17:50:00'),
('Bug / Error', 'Duplicated notifications', 'Getting the same reminder notification multiple times.', 2, 'Open', 10, '2025-02-13 08:05:00'),
('Performance Issue', 'Slow sync on mobile data', 'Sync is very slow when using mobile data compared to Wi-Fi.', 3, 'Open', 1, '2025-02-14 10:45:00'),
('Feature Request', 'Archive old accounts', 'Ability to archive accounts that are no longer used.', 4, 'Open', 2, '2025-02-15 14:25:00'),
('UI / UX Suggestion', 'Better empty state screens', 'Show tips and help text when there is no data yet.', 4, 'Open', 3, '2025-02-16 18:30:00'),

--- This table stores information about audit logs, such as the action, user, target table, and target ID.
CREATE TABLE audit_logs (
    id SERIAL PRIMARY KEY,
    action VARCHAR(255) NOT NULL,
    user_id INTEGER NOT NULL REFERENCES users(id),
    target_table VARCHAR(255) NOT NULL,
    target_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--- 6️⃣ `tokens`
CREATE TABLE tokens (
    id SERIAL PRIMARY KEY,
    token VARCHAR(255) NOT NULL,
    user_id INTEGER NOT NULL REFERENCES users(id),
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- For now let us cosnider only Monthly budget with current date as start date and end day of current month as end date. Only one budget  per month per user, so please update the create table script for budget here:
-- CREATE TABLE budgets (
--     id SERIAL PRIMARY KEY,
--     name VARCHAR(255) NOT NULL,
--     amount INTEGER NOT NULL,
--     currency VARCHAR(10) DEFAULT 'INR', --'INR' or 'USD' or 'EUR' or 'GBP' etc.
--     period VARCHAR(50) NOT NULL, -- e.g., 'monthly'- for now let us consider only monthly
--     start_date TIMESTAMP NOT NULL,
--     end_date TIMESTAMP NOT NULL,
--     user_id INTEGER NOT NULL REFERENCES users(id),
--     category_id INTEGER NOT NULL REFERENCES categories(id),
--     is_active BOOLEAN DEFAULT TRUE,
--     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
--     updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- );
-- Also provide about 10 most common categories, which cover all types of expenses and income (mainly salary) based on the new table design.