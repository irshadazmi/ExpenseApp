--- This table stores information about roles, such as their name and description.
CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL UNIQUE, 
    description VARCHAR(255)
);

-- This table stores information about users, such as their name, contact details, and employment status.
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    role_id INTEGER NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES roles (id)
);

INSERT INTO users (email, password, phone, role_id, is_active)
VALUES
    ('john.doe@example.com', 'password123', '1234567890', 1, TRUE),
    ('jane.doe@example.com', 'password123', '1234567891', 2, TRUE),
    ('bob.smith@example.com', 'password123', '1234567892', 3, TRUE),
    ('alice.johnson@example.com', 'password123', '1234567893', 1, TRUE),
    ('charlie.brown@example.com', 'password123', '1234567894', 2, TRUE),
    ('david.jones@example.com', 'password123', '1234567895', 3, TRUE),
    ('emily.williams@example.com', 'password123', '1234567896', 1, TRUE),
    ('frank.lee@example.com', 'password123', '1234567897', 2, TRUE),
    ('george.miller@example.com', 'password123', '1234567898', 3, TRUE),
    ('harry.white@example.com', 'password123', '1234567899', 1, TRUE),
    ('karen.johnson@example.com', 'password123', '1234567900', 2, TRUE),
    ('lisa.brown@example.com', 'password123', '1234567901', 3, TRUE),
    ('mike.davis@example.com', 'password123', '1234567902', 1, TRUE),
    ('nancy.smith@example.com', 'password123', '1234567903', 2, TRUE),
    ('oliver.jones@example.com', 'password123', '1234567904', 3, TRUE),
    ('peter.johnson@example.com', 'password123', '1234567905', 1, TRUE),
    ('sarah.lee@example.com', 'password123', '1234567906', 2, TRUE),
    ('thomas.brown@example.com', 'password123', '1234567907', 3, TRUE),
    ('victoria.smith@example.com', 'password123', '1234567908', 1, TRUE),
    ('william.jones@example.com', 'password123', '1234567909', 2, TRUE),
    ('zachary.white@example.com', 'password123', '1234567910', 3, TRUE),
    ('amy.johnson@example.com', 'password123', '1234567911', 1, TRUE),
    ('brian.brown@example.com', 'password123', '1234567912', 2, TRUE),
    ('carol.jones@example.com', 'password123', '1234567913', 3, TRUE),
    ('daniel.smith@example.com', 'password123', '1234567914', 1, TRUE),
    ('elizabeth.lee@example.com', 'password123', '1234567915', 2, TRUE),
    ('franklin.jones@example.com', 'password123', '1234567916', 3, TRUE),
    ('george.williams@example.com', 'password123', '1234567917', 1, TRUE),
    ('helen.brown@example.com', 'password123', '1234567918', 2, TRUE),
    ('isaac.johnson@example.com', 'password123', '1234567919', 3, TRUE),
    ('james.smith@example.com', 'password123', '1234567920', 1, TRUE),
    ('julie.jones@example.com', 'password123', '1234567921', 2, TRUE),
    ('katherine.lee@example.com', 'password123', '1234567922', 3, TRUE),
    ('linda.johnson@example.com', 'password123', '1234567923', 1, TRUE),
    ('margaret.brown@example.com', 'password123', '1234567924', 2, TRUE),
    ('matthew.smith@example.com', 'password123', '1234567925', 3, TRUE),
    ('nicholas.jones@example.com', 'password123', '1234567926', 1, TRUE),
    ('olivia.lee@example.com', 'password123', '1234567927', 2, TRUE),
    ('patrick.johnson@example.com', 'password123', '1234567928', 3, TRUE),
    ('rachel.smith@example.com', 'password123', '1234567929', 1, TRUE),
    ('robert.jones@example.com', 'password123', '1234567930', 2, TRUE),
    ('samuel.brown@example.com', 'password123', '1234567931', 3, TRUE),
    ('sophia.johnson@example.com', 'password123', '1234567932', 1, TRUE),
    ('thomas.smith@example.com', 'password123', '1234567933', 2, TRUE),
    ('victoria.jones@example.com', 'password123', '1234567934', 3, TRUE),
    ('william.brown@example.com', 'password123', '1234567935', 1, TRUE),
    ('zachary.johnson@example.com', 'password123', '1234567936', 2, TRUE);

--- This table stores information about categories, such as their name and description.
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO categories (name) VALUES
-- 🛒 Essentials
('Groceries'),
('Supermarket'),
('Fresh Market'),

-- 🍽️ Food & Dining
('Dining Out'),
('Takeaway / Delivery'),
('Coffee & Snacks'),

-- 🚗 Transportation
('Fuel / Gas'),
('Public Transport'),
('Taxi & Ride Share'),
('Car Maintenance'),
('Parking & Tolls'),

-- 🏠 Housing & Utilities
('Rent / Mortgage'),
('Electricity'),
('Water'),
('Gas'),
('Internet'),
('Mobile Phone'),

-- 🎓 Education & Kids
('School Fees'),
('Kids Activities'),

-- 🏥 Health & Wellness
('Medical / Doctor'),
('Pharmacy / Medicine'),
('Haircuts & Salon'),
('Fitness & Wellness'),

-- 👗 Personal & Home
('Clothing & Shoes'),
('Home Maintenance'),
('Cleaning Supplies'),
('Furniture & Decor'),

-- 📺 Entertainment
('Cable / Streaming'),
('Movies & Entertainment'),
('Family Outings'),
('Books & Magazines'),

-- 🎁 Giving & Fees
('Gifts'),
('Donations'),
('Bank Fees'),

-- 🧩 Other
('Miscellaneous');

--- This table stores information about expenses, such as their description, amount, category, and user.
CREATE TABLE expenses (
    id SERIAL PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    amount INTEGER NOT NULL,
    type VARCHAR(50) DEFAULT 'expense', -- 'expense' or 'income' or 'transfer'
    currency VARCHAR(10) DEFAULT 'INR', --'INR' or 'USD' or 'EUR' or 'GBP' etc.
    category_id INTEGER NOT NULL REFERENCES categories(id),
    user_id INTEGER NOT NULL REFERENCES users(id),
    expense_date TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TRUNCATE TABLE expenses RESTART IDENTITY;

INSERT INTO expenses (description, amount, type, currency, category_id, user_id, expense_date)
VALUES
('Weekly groceries from local store', 2200, 'Expense', 'INR', 1, 1, CURRENT_DATE - INTERVAL '1 day'),
('Monthly supermarket bulk buy', 4500, 'Expense', 'INR', 2, 1, CURRENT_DATE - INTERVAL '3 days'),
('Fresh produce from market', 800, 'Expense', 'INR', 3, 1, CURRENT_DATE - INTERVAL '5 days'),
('Dinner at Italian restaurant', 1200, 'Expense', 'INR', 4, 1, CURRENT_DATE - INTERVAL '7 days'),
('Pizza delivery night', 950, 'Expense', 'INR', 5, 1, CURRENT_DATE - INTERVAL '9 days'),
('Morning coffee and croissant', 250, 'Income', 'INR', 6, 1, CURRENT_DATE - INTERVAL '11 days'),
('Fuel refill for car', 3200, 'Expense', 'INR', 7, 1, CURRENT_DATE - INTERVAL '13 days'),
('Metro card recharge', 600, 'Expense', 'INR', 8, 1, CURRENT_DATE - INTERVAL '15 days'),
('Uber to airport', 850, 'Expense', 'INR', 9, 1, CURRENT_DATE - INTERVAL '17 days'),
('Car oil change and service', 2800, 'Expense', 'INR', 10, 1, CURRENT_DATE - INTERVAL '19 days'),
('Highway toll charges', 300, 'Expense', 'INR', 11, 1, CURRENT_DATE - INTERVAL '21 days'),
('Monthly rent payment', 18000, 'Expense', 'INR', 12, 1, CURRENT_DATE - INTERVAL '23 days'),
('Electricity bill', 2200, 'Expense', 'INR', 13, 1, CURRENT_DATE - INTERVAL '25 days'),
('Water bill', 600, 'Expense', 'INR', 14, 1, CURRENT_DATE - INTERVAL '27 days'),
('Gas cylinder refill', 950, 'Expense', 'INR', 15, 1, CURRENT_DATE - INTERVAL '29 days'),
('Wi-Fi subscription', 1200, 'Expense', 'INR', 16, 1, CURRENT_DATE - INTERVAL '31 days'),
('Mobile recharge', 499, 'Income', 'INR', 17, 1, CURRENT_DATE - INTERVAL '33 days'),
('Quarterly school fees', 15000, 'Expense', 'INR', 18, 1, CURRENT_DATE - INTERVAL '35 days'),
('Dance class for kids', 1800, 'Expense', 'INR', 19, 1, CURRENT_DATE - INTERVAL '37 days'),
('Doctor consultation', 700, 'Expense', 'INR', 20, 1, CURRENT_DATE - INTERVAL '39 days'),
('Pharmacy purchase', 350, 'Expense', 'INR', 21, 1, CURRENT_DATE - INTERVAL '41 days'),
('Salon haircut', 600, 'Expense', 'INR', 22, 1, CURRENT_DATE - INTERVAL '43 days'),
('Gym membership renewal', 2500, 'Expense', 'INR', 23, 1, CURRENT_DATE - INTERVAL '45 days'),
('New shoes for work', 1800, 'Expense', 'INR', 24, 1, CURRENT_DATE - INTERVAL '47 days'),
('Plumbing repair', 2200, 'Expense', 'INR', 25, 1, CURRENT_DATE - INTERVAL '49 days'),
('Cleaning supplies restock', 450, 'Expense', 'INR', 26, 1, CURRENT_DATE - INTERVAL '51 days'),
('New sofa purchase', 12000, 'Expense', 'INR', 27, 1, CURRENT_DATE - INTERVAL '53 days'),
('Netflix subscription', 649, 'Expense', 'INR', 28, 1, CURRENT_DATE - INTERVAL '55 days'),
('Movie night with family', 1200, 'Expense', 'INR', 29, 1, CURRENT_DATE - INTERVAL '57 days'),
('Zoo visit with kids', 1800, 'Expense', 'INR', 30, 1, CURRENT_DATE - INTERVAL '59 days'),
('Bookstore haul', 950, 'Expense', 'INR', 31, 1, CURRENT_DATE - INTERVAL '61 days'),
('Birthday gift for friend', 1500, 'Expense', 'INR', 32, 1, CURRENT_DATE - INTERVAL '63 days'),
('Charity donation', 2000, 'Expense', 'INR', 33, 1, CURRENT_DATE - INTERVAL '65 days'),
('ATM withdrawal fee', 25, 'Expense', 'INR', 34, 1, CURRENT_DATE - INTERVAL '67 days'),
('Uncategorized expense', 500, 'Expense', 'INR', 35, 1, CURRENT_DATE - INTERVAL '69 days'),
-- Repeat with varied descriptions and dates
('Weekly groceries', 2100, 'Expense', 'INR', 1, 1, CURRENT_DATE - INTERVAL '71 days'),
('Supermarket snacks', 750, 'Expense', 'INR', 2, 1, CURRENT_DATE - INTERVAL '73 days'),
('Fresh fruit basket', 650, 'Expense', 'INR', 3, 1, CURRENT_DATE - INTERVAL '75 days'),
('Lunch with colleagues', 900, 'Expense', 'INR', 4, 1, CURRENT_DATE - INTERVAL '77 days'),
('Burger delivery', 550, 'Expense', 'INR', 5, 1, CURRENT_DATE - INTERVAL '79 days'),
('Evening tea and samosa', 180, 'Income', 'INR', 6, 1, CURRENT_DATE - INTERVAL '81 days'),
('Fuel top-up', 3000, 'Expense', 'INR', 7, 1, CURRENT_DATE - INTERVAL '83 days'),
('Bus fare', 100, 'Expense', 'INR', 8, 1, CURRENT_DATE - INTERVAL '85 days'),
('Cab to mall', 400, 'Expense', 'INR', 9, 1, CURRENT_DATE - INTERVAL '87 days'),
('Brake pad replacement', 3500, 'Expense', 'INR', 10, 1, CURRENT_DATE - INTERVAL '89 days'),
('Parking at event', 150, 'Expense', 'INR', 11, 1, CURRENT_DATE - INTERVAL '91 days'),
('Rent paid', 18000, 'Expense', 'INR', 12, 1, CURRENT_DATE - INTERVAL '93 days'),
('Electricity charges', 2100, 'Expense', 'INR', 13, 1, CURRENT_DATE - INTERVAL '95 days'),
('Water usage bill', 550, 'Expense', 'INR', 14, 1, CURRENT_DATE - INTERVAL '97 days'),
('Gas refill', 900, 'Expense', 'INR', 15, 1, CURRENT_DATE - INTERVAL '99 days'),
('Internet bill', 1100, 'Expense', 'INR', 16, 1, CURRENT_DATE - INTERVAL '101 days'),
('Mobile top-up', 399, 'Income', 'INR', 17, 1, CURRENT_DATE - INTERVAL '103 days'),
('School books', 2500, 'Expense', 'INR', 18, 1, CURRENT_DATE - INTERVAL '105 days'),
('Kids swimming class', 1200, 'Expense', 'INR', 19, 1, CURRENT_DATE - INTERVAL '107 days'),
('Dental checkup', 850, 'Expense', 'INR', 20, 1, CURRENT_DATE - INTERVAL '109 days'),
('Cough syrup', 300, 'Expense', 'INR', 21, 1, CURRENT_DATE - INTERVAL '111 days'),
('Hair spa', 1200, 'Expense', 'INR', 22, 1, CURRENT_DATE - INTERVAL '113 days'),
('Yoga subscription', 1800, 'Expense', 'INR', 23, 1, CURRENT_DATE - INTERVAL '115 days'),
('Winter jacket', 2200, 'Expense', 'INR', 24, 1, CURRENT_DATE - INTERVAL '117 days')

--- This table stores information about accounts, such as their name, type, balance, currency, and associated user.
CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(50) NOT NULL, -- e.g., 'savings', 'checking', 'credit', 'wallet' etc.
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
('Savings Account', 'Savings', 100000, 'INR', 1),
('Checking Account', 'Checking', 20000, 'USD', 2),
('Credit Card', 'Credit', 50000, 'EUR', 3),
('Wallet', 'Wallet', 10000, 'GBP', 1),
('Salary Account', 'Savings', 50000, 'INR', 2),
('Business Account', 'Checking', 100000, 'USD', 3),
('Loan Account', 'Credit', 20000, 'EUR', 1),
('Current Account', 'Checking', 50000, 'GBP', 2),
('Fixed Deposit', 'Savings', 20000, 'INR', 3),
('Recurring deposit', 'Savings', 10000, 'USD', 1),
('Debit Card', 'Credit', 50000, 'EUR', 2),
('Credit Card 2', 'Credit', 20000, 'GBP', 3),
('Salary Account 2', 'Savings', 10000, 'INR', 1),
('Business Account 2', 'Checking', 50000, 'USD', 2),
('Loan Account 2', 'Credit', 20000, 'EUR', 3),
('Current Account 2', 'Checking', 10000, 'GBP', 1),
('Fixed deposit 2', 'Savings', 50000, 'INR', 2),
('Recurring deposit 2', 'Savings', 20000, 'USD', 3);

--- This table stores information about recurring expenses, such as their description, amount, category, recurrence pattern, and associated user.
CREATE TABLE recurring_expenses (
    id SERIAL PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    amount INTEGER NOT NULL,
    type VARCHAR(50) DEFAULT 'expense', -- 'expense' or 'income' or 'transfer'
    currency VARCHAR(10) DEFAULT 'INR', --'INR' or 'USD' or 'EUR' or 'GBP' etc.
    category_id INTEGER NOT NULL REFERENCES categories(id),
    user_id INTEGER NOT NULL REFERENCES users(id),
    recurrence_pattern VARCHAR(50) NOT NULL, -- e.g., 'daily', 'weekly', 'monthly', 'yearly'
    next_occurrence TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)

--- This table stores information about budgets, such as their name, amount, duration, and associated user.
CREATE TABLE budgets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    amount INTEGER NOT NULL,
    currency VARCHAR(10) DEFAULT 'INR', --'INR' or 'USD' or 'EUR' or 'GBP' etc.
    period VARCHAR(50) NOT NULL, -- e.g., 'daily', 'weekly', 'monthly', 'yearly'
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    user_id INTEGER NOT NULL REFERENCES users(id),
    category_id INTEGER NOT NULL REFERENCES categories(id),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TRUNCATE TABLE budgets RESTART IDENTITY;

INSERT INTO budgets (name, amount, currency, period, start_date, end_date, user_id, category_id)
VALUES
('Monthly Grocery Budget', 10000, 'INR', 'Monthly', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month', 1, 1),
('Daily Commute Budget', 500, 'INR', 'Daily', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 day', 2, 2),
('Yearly Entertainment Budget', 20000, 'INR', 'Yearly', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 year', 3, 3),
('Weekly Food Budget', 2000, 'INR', 'Weekly', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 week', 1, 4),
('Monthly Rent Budget', 50000, 'INR', 'Monthly', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month', 2, 5),
('Quarterly Education Budget', 10000, 'INR', 'Quarterly', CURRENT_DATE, CURRENT_DATE + INTERVAL '3 months', 3, 6),
('Daily Health Budget', 1000, 'INR', 'Daily', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 day', 1, 7),
('Yearly Personal Budget', 100000, 'INR', 'Yearly', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 year', 2, 8),
('Monthly Miscellaneous Budget', 5000, 'INR', 'Monthly', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month', 3, 9),
('Weekly Entertainment Budget', 2000, 'INR', 'Weekly', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 week', 1, 10),
('Quarterly Transportation Budget', 5000, 'INR', 'Quarterly', CURRENT_DATE, CURRENT_DATE + INTERVAL '3 months', 2, 11),
('Daily Education Budget', 500, 'INR', 'Daily', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 day', 3, 12),
('Yearly Health Budget', 50000, 'INR', 'Yearly', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 year', 1, 13),
('Monthly Personal Budget', 20000, 'INR', 'Monthly', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month', 2, 14),
('Weekly Miscellaneous Budget', 1000, 'INR', 'Weekly', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 week', 3, 15),
('Quarterly Education Budget', 20000, 'INR', 'Quarterly', CURRENT_DATE, CURRENT_DATE + INTERVAL '3 months', 1, 16),
('Daily Health Budget', 2000, 'INR', 'Daily', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 day', 2, 17),
('Yearly Transportation Budget', 100000, 'INR', 'Yearly', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 year', 3, 18),
('Monthly Education Budget', 5000, 'INR', 'Monthly', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month', 1, 19),
('Weekly Personal Budget', 5000, 'INR', 'Weekly', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 week', 2, 20),
('Quarterly Health Budget', 10000, 'INR', 'Quarterly', CURRENT_DATE, CURRENT_DATE + INTERVAL '3 months', 3, 21),
('Daily Education Budget', 1000, 'INR', 'Daily', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 day', 1, 22),
('Yearly Miscellaneous Budget', 50000, 'INR', 'Yearly', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 year', 2, 23),
('Monthly Transportation Budget', 20000, 'INR', 'Monthly', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month', 3, 24),
('Weekly Health Budget', 2000, 'INR', 'Weekly', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 week', 1, 25),
('Quarterly Personal Budget', 5000, 'INR', 'Quarterly', CURRENT_DATE, CURRENT_DATE + INTERVAL '3 months', 2, 26),
('Daily Health Budget', 2000, 'INR', 'Daily', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 day', 3, 27),
('Yearly Health Budget', 100000, 'INR', 'Yearly', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 year', 1, 28),
('Monthly Health Budget', 5000, 'INR', 'Monthly', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month', 2, 29),
('Weekly Transportation Budget', 5000, 'INR', 'Weekly', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 week', 3, 30),
('Quarterly Health Budget', 20000, 'INR', 'Quarterly', CURRENT_DATE, CURRENT_DATE + INTERVAL '3 months', 1, 31),
('Daily Personal Budget', 5000, 'INR', 'Daily', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 day', 2, 32),
('Yearly Miscellaneous Budget', 200000, 'INR', 'Yearly', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 year', 3, 33),
('Monthly Education Budget', 10000, 'INR', 'Monthly', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month', 1, 34),
('Weekly Health Budget', 10000, 'INR', 'Weekly', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 week', 2, 35);

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