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

--- This table stores information about categories, such as their name and description.
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    short_name VARCHAR(5) UNIQUE NOT NULL,
    description VARCHAR(255),   
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TRUNCATE TABLE categories RESTART IDENTITY;

INSERT INTO categories (name, short_name, description) VALUES
('Food & Dining', 'FDNG', 'Meals, groceries, cafes, restaurants, and takeout orders'),
('Transportation', 'TRAN', 'Fuel, public transit, ride-hailing, parking, and vehicle expenses'),
('Housing', 'HOUS', 'Rent, mortgage payments, property maintenance, and household utilities'),
('Healthcare', 'HLTH', 'Doctor visits, pharmacy purchases, medical insurance, and hospital bills'),
('Entertainment', 'ENTR', 'Movies, streaming subscriptions, concerts, gaming, and leisure activities'),
('Travel', 'TRVL', 'Flights, hotels, vacation packages, and related travel costs'),
('Shopping', 'SHOP', 'Clothing, electronics, household goods, and personal purchases'),
('Education', 'EDUC', 'Tuition fees, online courses, books, and professional training'),
('Bills & Utilities', 'BILS', 'Recurring service bills like internet, phone, cable, and electricity'),
('Miscellaneous', 'MISC', 'Catch-all for irregular or uncategorized expenses');

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