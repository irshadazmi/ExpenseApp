--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

ALTER USER postgres WITH PASSWORD '786$Germany';

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.accounts (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(50) NOT NULL,
    balance double precision DEFAULT 0,
    currency character varying(10) DEFAULT 'INR'::character varying,
    user_id integer NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.accounts_id_seq OWNED BY public.accounts.id;


--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audit_logs (
    id integer NOT NULL,
    action character varying(255) NOT NULL,
    user_id integer NOT NULL,
    target_table character varying(255) NOT NULL,
    target_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: audit_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.audit_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: audit_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.audit_logs_id_seq OWNED BY public.audit_logs.id;


--
-- Name: budgets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.budgets (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    amount integer NOT NULL,
    currency character varying(10) DEFAULT 'INR'::character varying,
    period character varying(50) NOT NULL,
    effective_from timestamp without time zone NOT NULL,
    effective_to timestamp without time zone,
    version integer DEFAULT 1,
    user_id integer NOT NULL,
    category_id integer,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: budgets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.budgets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: budgets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.budgets_id_seq OWNED BY public.budgets.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    short_name character varying(5) NOT NULL,
    description character varying(255),
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: feedbacks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feedbacks (
    id integer NOT NULL,
    issue_type character varying(255) NOT NULL,
    subject character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    rating integer NOT NULL,
    status character varying(255) NOT NULL,
    user_id integer NOT NULL,
    reply character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: feedbacks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.feedbacks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: feedbacks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.feedbacks_id_seq OWNED BY public.feedbacks.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(20) NOT NULL,
    description character varying(255)
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tokens (
    id integer NOT NULL,
    token character varying(255) NOT NULL,
    user_id integer NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tokens_id_seq OWNED BY public.tokens.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    description character varying(255) NOT NULL,
    amount integer NOT NULL,
    type character varying(50) DEFAULT 'Expense'::character varying,
    currency character varying(10) DEFAULT 'INR'::character varying,
    category_id integer NOT NULL,
    account_id integer NOT NULL,
    user_id integer NOT NULL,
    transaction_date timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: transactions_id_seq1; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.transactions_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transactions_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.transactions_id_seq1 OWNED BY public.transactions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    full_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(20) NOT NULL,
    password character varying(255) NOT NULL,
    role_id integer NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: accounts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts ALTER COLUMN id SET DEFAULT nextval('public.accounts_id_seq'::regclass);


--
-- Name: audit_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs ALTER COLUMN id SET DEFAULT nextval('public.audit_logs_id_seq'::regclass);


--
-- Name: budgets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.budgets ALTER COLUMN id SET DEFAULT nextval('public.budgets_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: feedbacks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feedbacks ALTER COLUMN id SET DEFAULT nextval('public.feedbacks_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tokens ALTER COLUMN id SET DEFAULT nextval('public.tokens_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq1'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.accounts VALUES (1, 'Emergency Fund Savings', 'Savings', 50100, 'INR', 1, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (2, 'Main Checking Account', 'Checking', 50200, 'USD', 2, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (3, 'Visa Credit Card', 'Credit', 50300, 'EUR', 3, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (4, 'PayPal Wallet', 'Wallet', 50400, 'GBP', 4, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (5, 'Vacation Savings', 'Savings', 50500, 'INR', 5, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (6, 'Household Checking', 'Checking', 50600, 'USD', 6, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (7, 'MasterCard Rewards', 'Credit', 50700, 'EUR', 7, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (8, 'Google Pay Wallet', 'Wallet', 50800, 'GBP', 8, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (9, 'Retirement Savings', 'Savings', 50900, 'INR', 9, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (10, 'Business Checking', 'Checking', 51000, 'USD', 10, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (11, 'Travel Credit Card', 'Credit', 51100, 'EUR', 11, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (12, 'Apple Wallet', 'Wallet', 51200, 'GBP', 12, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (13, 'College Fund Savings', 'Savings', 51300, 'INR', 13, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (14, 'Joint Checking Account', 'Checking', 51400, 'USD', 14, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (15, 'Corporate Credit Card', 'Credit', 51500, 'EUR', 15, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (16, 'Cash Wallet', 'Wallet', 51600, 'GBP', 16, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (17, 'Emergency Fund Savings', 'Savings', 51700, 'INR', 17, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (18, 'Main Checking Account', 'Checking', 51800, 'USD', 18, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (19, 'Visa Credit Card', 'Credit', 51900, 'EUR', 19, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (20, 'PayPal Wallet', 'Wallet', 52000, 'GBP', 20, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (21, 'Vacation Savings', 'Savings', 52100, 'INR', 21, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (22, 'Household Checking', 'Checking', 52200, 'USD', 22, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (23, 'MasterCard Rewards', 'Credit', 52300, 'EUR', 23, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (24, 'Google Pay Wallet', 'Wallet', 52400, 'GBP', 24, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (25, 'Retirement Savings', 'Savings', 52500, 'INR', 25, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (26, 'Business Checking', 'Checking', 52600, 'USD', 26, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (27, 'Travel Credit Card', 'Credit', 52700, 'EUR', 27, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (28, 'Apple Wallet', 'Wallet', 52800, 'GBP', 28, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (29, 'College Fund Savings', 'Savings', 52900, 'INR', 29, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (30, 'Joint Checking Account', 'Checking', 53000, 'USD', 30, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (31, 'Corporate Credit Card', 'Credit', 53100, 'EUR', 31, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (32, 'Cash Wallet', 'Wallet', 53200, 'GBP', 32, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (33, 'Emergency Fund Savings', 'Savings', 53300, 'INR', 33, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (34, 'Main Checking Account', 'Checking', 53400, 'USD', 34, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (35, 'Visa Credit Card', 'Credit', 53500, 'EUR', 35, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (36, 'PayPal Wallet', 'Wallet', 53600, 'GBP', 36, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (37, 'Vacation Savings', 'Savings', 53700, 'INR', 37, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (38, 'Household Checking', 'Checking', 53800, 'USD', 38, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (39, 'MasterCard Rewards', 'Credit', 53900, 'EUR', 39, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (40, 'Google PayWallet', 'Wallet', 54000, 'GBP', 40, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (41, 'Retirement Savings', 'Savings', 54100, 'INR', 41, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (42, 'Business Checking', 'Checking', 54200, 'USD', 42, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (43, 'Travel Credit Card', 'Credit', 54300, 'EUR', 43, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (44, 'Apple Wallet', 'Wallet', 54400, 'GBP', 44, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (45, 'College Fund Savings', 'Savings', 54500, 'INR', 45, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (46, 'Joint Checking Account', 'Checking', 54600, 'USD', 46, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (47, 'Corporate Credit Card', 'Credit', 54700, 'EUR', 47, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (48, 'Cash Wallet', 'Wallet', 54800, 'GBP', 48, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (49, 'Emergency Fund Savings', 'Savings', 54900, 'INR', 49, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');
INSERT INTO public.accounts VALUES (50, 'Main Checking Account', 'Checking', 55000, 'USD', 50, true, '2025-11-24 18:45:39.189789', '2025-11-24 18:45:39.189789');


--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: budgets; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.budgets VALUES (1, 'Monthly Total Budget', 30000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 1, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (2, 'Food & Dining Budget', 6600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 1, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (3, 'Transportation Budget', 3000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 1, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (4, 'Housing Budget', 9000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 1, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (5, 'Healthcare Budget', 1800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 1, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (6, 'Entertainment Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 1, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (7, 'Travel Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 1, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (8, 'Shopping Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 1, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (9, 'Education Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 1, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (10, 'Utilities Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 1, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (11, 'Miscellaneous Budget', 600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 1, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (12, 'Monthly Total Budget', 40000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 2, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (13, 'Food & Dining Budget', 8800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 2, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (14, 'Transportation Budget', 4000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 2, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (15, 'Housing Budget', 12000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 2, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (16, 'Healthcare Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 2, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (17, 'Entertainment Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 2, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (18, 'Travel Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 2, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (19, 'Shopping Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 2, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (20, 'Education Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 2, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (21, 'Utilities Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 2, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (22, 'Miscellaneous Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 2, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (23, 'Monthly Total Budget', 20000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 3, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (24, 'Food & Dining Budget', 4400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 3, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (25, 'Transportation Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 3, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (26, 'Housing Budget', 6000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 3, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (27, 'Healthcare Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 3, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (28, 'Entertainment Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 3, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (29, 'Travel Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 3, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (30, 'Shopping Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 3, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (31, 'Education Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 3, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (32, 'Utilities Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 3, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (33, 'Miscellaneous Budget', 400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 3, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (34, 'Monthly Total Budget', 30000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 4, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (35, 'Food & Dining Budget', 6600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 4, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (36, 'Transportation Budget', 3000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 4, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (37, 'Housing Budget', 9000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 4, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (38, 'Healthcare Budget', 1800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 4, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (39, 'Entertainment Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 4, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (40, 'Travel Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 4, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (41, 'Shopping Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 4, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (42, 'Education Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 4, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (43, 'Utilities Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 4, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (44, 'Miscellaneous Budget', 600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 4, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (45, 'Monthly Total Budget', 30000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 5, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (46, 'Food & Dining Budget', 6600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 5, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (47, 'Transportation Budget', 3000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 5, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (48, 'Housing Budget', 9000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 5, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (49, 'Healthcare Budget', 1800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 5, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (50, 'Entertainment Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 5, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (51, 'Travel Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 5, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (52, 'Shopping Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 5, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (53, 'Education Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 5, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (54, 'Utilities Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 5, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (55, 'Miscellaneous Budget', 600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 5, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (56, 'Monthly Total Budget', 20000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 6, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (57, 'Food & Dining Budget', 4400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 6, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (58, 'Transportation Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 6, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (59, 'Housing Budget', 6000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 6, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (60, 'Healthcare Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 6, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (61, 'Entertainment Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 6, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (62, 'Travel Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 6, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (63, 'Shopping Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 6, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (64, 'Education Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 6, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (65, 'Utilities Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 6, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (66, 'Miscellaneous Budget', 400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 6, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (67, 'Monthly Total Budget', 30000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 7, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (68, 'Food & Dining Budget', 6600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 7, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (69, 'Transportation Budget', 3000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 7, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (70, 'Housing Budget', 9000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 7, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (71, 'Healthcare Budget', 1800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 7, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (72, 'Entertainment Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 7, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (73, 'Travel Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 7, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (74, 'Shopping Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 7, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (75, 'Education Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 7, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (76, 'Utilities Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 7, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (77, 'Miscellaneous Budget', 600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 7, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (78, 'Monthly Total Budget', 40000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 8, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (79, 'Food & Dining Budget', 8800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 8, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (80, 'Transportation Budget', 4000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 8, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (81, 'Housing Budget', 12000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 8, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (82, 'Healthcare Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 8, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (83, 'Entertainment Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 8, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (84, 'Travel Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 8, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (85, 'Shopping Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 8, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (86, 'Education Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 8, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (87, 'Utilities Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 8, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (88, 'Miscellaneous Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 8, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (89, 'Monthly Total Budget', 30000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 9, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (90, 'Food & Dining Budget', 6600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 9, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (91, 'Transportation Budget', 3000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 9, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (92, 'Housing Budget', 9000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 9, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (93, 'Healthcare Budget', 1800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 9, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (94, 'Entertainment Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 9, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (95, 'Travel Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 9, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (96, 'Shopping Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 9, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (97, 'Education Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 9, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (98, 'Utilities Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 9, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (99, 'Miscellaneous Budget', 600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 9, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (100, 'Monthly Total Budget', 20000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 10, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (101, 'Food & Dining Budget', 4400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 10, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (102, 'Transportation Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 10, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (103, 'Housing Budget', 6000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 10, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (104, 'Healthcare Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 10, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (105, 'Entertainment Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 10, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (106, 'Travel Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 10, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (107, 'Shopping Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 10, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (108, 'Education Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 10, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (109, 'Utilities Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 10, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (110, 'Miscellaneous Budget', 400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 10, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (111, 'Monthly Total Budget', 30000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 11, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (112, 'Food & Dining Budget', 6600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 11, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (113, 'Transportation Budget', 3000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 11, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (114, 'Housing Budget', 9000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 11, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (115, 'Healthcare Budget', 1800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 11, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (116, 'Entertainment Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 11, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (117, 'Travel Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 11, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (118, 'Shopping Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 11, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (119, 'Education Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 11, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (120, 'Utilities Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 11, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (121, 'Miscellaneous Budget', 600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 11, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (122, 'Monthly Total Budget', 20000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 12, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (123, 'Food & Dining Budget', 4400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 12, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (124, 'Transportation Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 12, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (125, 'Housing Budget', 6000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 12, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (126, 'Healthcare Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 12, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (127, 'Entertainment Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 12, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (128, 'Travel Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 12, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (129, 'Shopping Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 12, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (130, 'Education Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 12, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (131, 'Utilities Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 12, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (132, 'Miscellaneous Budget', 400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 12, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (133, 'Monthly Total Budget', 30000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 13, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (134, 'Food & Dining Budget', 6600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 13, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (135, 'Transportation Budget', 3000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 13, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (136, 'Housing Budget', 9000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 13, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (137, 'Healthcare Budget', 1800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 13, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (138, 'Entertainment Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 13, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (139, 'Travel Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 13, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (140, 'Shopping Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 13, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (141, 'Education Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 13, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (142, 'Utilities Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 13, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (143, 'Miscellaneous Budget', 600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 13, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (144, 'Monthly Total Budget', 30000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 14, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (145, 'Food & Dining Budget', 6600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 14, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (146, 'Transportation Budget', 3000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 14, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (147, 'Housing Budget', 9000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 14, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (148, 'Healthcare Budget', 1800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 14, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (149, 'Entertainment Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 14, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (150, 'Travel Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 14, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (151, 'Shopping Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 14, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (152, 'Education Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 14, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (153, 'Utilities Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 14, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (154, 'Miscellaneous Budget', 600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 14, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (155, 'Monthly Total Budget', 40000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 15, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (156, 'Food & Dining Budget', 8800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 15, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (157, 'Transportation Budget', 4000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 15, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (158, 'Housing Budget', 12000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 15, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (159, 'Healthcare Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 15, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (160, 'Entertainment Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 15, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (161, 'Travel Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 15, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (162, 'Shopping Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 15, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (163, 'Education Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 15, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (164, 'Utilities Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 15, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (165, 'Miscellaneous Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 15, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (166, 'Monthly Total Budget', 40000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 16, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (167, 'Food & Dining Budget', 8800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 16, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (168, 'Transportation Budget', 4000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 16, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (169, 'Housing Budget', 12000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 16, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (170, 'Healthcare Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 16, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (171, 'Entertainment Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 16, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (172, 'Travel Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 16, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (173, 'Shopping Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 16, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (174, 'Education Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 16, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (175, 'Utilities Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 16, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (176, 'Miscellaneous Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 16, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (177, 'Monthly Total Budget', 20000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 17, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (178, 'Food & Dining Budget', 4400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 17, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (179, 'Transportation Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 17, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (180, 'Housing Budget', 6000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 17, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (181, 'Healthcare Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 17, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (182, 'Entertainment Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 17, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (183, 'Travel Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 17, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (184, 'Shopping Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 17, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (185, 'Education Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 17, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (186, 'Utilities Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 17, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (187, 'Miscellaneous Budget', 400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 17, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (188, 'Monthly Total Budget', 40000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 18, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (189, 'Food & Dining Budget', 8800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 18, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (190, 'Transportation Budget', 4000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 18, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (191, 'Housing Budget', 12000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 18, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (192, 'Healthcare Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 18, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (193, 'Entertainment Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 18, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (194, 'Travel Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 18, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (195, 'Shopping Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 18, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (196, 'Education Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 18, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (197, 'Utilities Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 18, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (198, 'Miscellaneous Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 18, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (199, 'Monthly Total Budget', 40000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 19, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (200, 'Food & Dining Budget', 8800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 19, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (201, 'Transportation Budget', 4000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 19, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (202, 'Housing Budget', 12000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 19, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (203, 'Healthcare Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 19, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (204, 'Entertainment Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 19, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (205, 'Travel Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 19, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (206, 'Shopping Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 19, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (207, 'Education Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 19, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (208, 'Utilities Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 19, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (209, 'Miscellaneous Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 19, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (210, 'Monthly Total Budget', 20000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 20, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (211, 'Food & Dining Budget', 4400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 20, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (212, 'Transportation Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 20, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (213, 'Housing Budget', 6000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 20, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (214, 'Healthcare Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 20, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (215, 'Entertainment Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 20, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (216, 'Travel Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 20, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (217, 'Shopping Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 20, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (218, 'Education Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 20, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (219, 'Utilities Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 20, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (220, 'Miscellaneous Budget', 400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 20, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (221, 'Monthly Total Budget', 30000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 21, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (222, 'Food & Dining Budget', 6600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 21, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (223, 'Transportation Budget', 3000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 21, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (224, 'Housing Budget', 9000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 21, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (225, 'Healthcare Budget', 1800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 21, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (226, 'Entertainment Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 21, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (227, 'Travel Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 21, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (228, 'Shopping Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 21, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (229, 'Education Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 21, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (230, 'Utilities Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 21, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (231, 'Miscellaneous Budget', 600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 21, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (232, 'Monthly Total Budget', 40000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 22, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (233, 'Food & Dining Budget', 8800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 22, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (234, 'Transportation Budget', 4000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 22, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (235, 'Housing Budget', 12000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 22, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (236, 'Healthcare Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 22, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (237, 'Entertainment Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 22, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (238, 'Travel Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 22, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (239, 'Shopping Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 22, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (240, 'Education Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 22, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (241, 'Utilities Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 22, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (242, 'Miscellaneous Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 22, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (243, 'Monthly Total Budget', 40000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 23, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (244, 'Food & Dining Budget', 8800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 23, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (245, 'Transportation Budget', 4000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 23, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (246, 'Housing Budget', 12000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 23, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (247, 'Healthcare Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 23, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (248, 'Entertainment Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 23, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (249, 'Travel Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 23, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (250, 'Shopping Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 23, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (251, 'Education Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 23, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (252, 'Utilities Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 23, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (253, 'Miscellaneous Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 23, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (254, 'Monthly Total Budget', 20000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 24, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (255, 'Food & Dining Budget', 4400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 24, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (256, 'Transportation Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 24, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (257, 'Housing Budget', 6000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 24, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (258, 'Healthcare Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 24, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (259, 'Entertainment Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 24, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (260, 'Travel Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 24, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (261, 'Shopping Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 24, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (262, 'Education Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 24, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (263, 'Utilities Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 24, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (264, 'Miscellaneous Budget', 400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 24, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (265, 'Monthly Total Budget', 40000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 25, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (266, 'Food & Dining Budget', 8800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 25, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (267, 'Transportation Budget', 4000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 25, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (268, 'Housing Budget', 12000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 25, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (269, 'Healthcare Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 25, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (270, 'Entertainment Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 25, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (271, 'Travel Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 25, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (272, 'Shopping Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 25, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (273, 'Education Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 25, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (274, 'Utilities Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 25, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (275, 'Miscellaneous Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 25, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (276, 'Monthly Total Budget', 40000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 26, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (277, 'Food & Dining Budget', 8800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 26, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (278, 'Transportation Budget', 4000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 26, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (279, 'Housing Budget', 12000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 26, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (280, 'Healthcare Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 26, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (281, 'Entertainment Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 26, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (282, 'Travel Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 26, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (283, 'Shopping Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 26, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (284, 'Education Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 26, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (285, 'Utilities Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 26, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (286, 'Miscellaneous Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 26, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (287, 'Monthly Total Budget', 30000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 27, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (288, 'Food & Dining Budget', 6600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 27, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (289, 'Transportation Budget', 3000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 27, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (290, 'Housing Budget', 9000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 27, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (291, 'Healthcare Budget', 1800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 27, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (292, 'Entertainment Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 27, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (293, 'Travel Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 27, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (294, 'Shopping Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 27, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (295, 'Education Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 27, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (296, 'Utilities Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 27, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (297, 'Miscellaneous Budget', 600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 27, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (298, 'Monthly Total Budget', 40000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 28, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (299, 'Food & Dining Budget', 8800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 28, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (300, 'Transportation Budget', 4000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 28, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (301, 'Housing Budget', 12000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 28, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (302, 'Healthcare Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 28, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (303, 'Entertainment Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 28, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (304, 'Travel Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 28, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (305, 'Shopping Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 28, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (306, 'Education Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 28, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (307, 'Utilities Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 28, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (308, 'Miscellaneous Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 28, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (309, 'Monthly Total Budget', 40000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 29, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (310, 'Food & Dining Budget', 8800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 29, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (311, 'Transportation Budget', 4000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 29, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (312, 'Housing Budget', 12000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 29, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (313, 'Healthcare Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 29, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (314, 'Entertainment Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 29, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (315, 'Travel Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 29, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (316, 'Shopping Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 29, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (317, 'Education Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 29, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (318, 'Utilities Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 29, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (319, 'Miscellaneous Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 29, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (320, 'Monthly Total Budget', 20000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 30, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (321, 'Food & Dining Budget', 4400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 30, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (322, 'Transportation Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 30, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (323, 'Housing Budget', 6000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 30, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (324, 'Healthcare Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 30, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (325, 'Entertainment Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 30, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (326, 'Travel Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 30, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (327, 'Shopping Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 30, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (328, 'Education Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 30, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (329, 'Utilities Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 30, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (330, 'Miscellaneous Budget', 400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 30, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (331, 'Monthly Total Budget', 20000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 31, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (332, 'Food & Dining Budget', 4400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 31, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (333, 'Transportation Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 31, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (334, 'Housing Budget', 6000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 31, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (335, 'Healthcare Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 31, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (336, 'Entertainment Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 31, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (337, 'Travel Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 31, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (338, 'Shopping Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 31, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (339, 'Education Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 31, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (340, 'Utilities Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 31, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (341, 'Miscellaneous Budget', 400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 31, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (342, 'Monthly Total Budget', 20000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 32, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (343, 'Food & Dining Budget', 4400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 32, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (344, 'Transportation Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 32, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (345, 'Housing Budget', 6000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 32, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (346, 'Healthcare Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 32, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (347, 'Entertainment Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 32, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (348, 'Travel Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 32, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (349, 'Shopping Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 32, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (350, 'Education Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 32, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (351, 'Utilities Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 32, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (352, 'Miscellaneous Budget', 400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 32, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (353, 'Monthly Total Budget', 40000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 33, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (354, 'Food & Dining Budget', 8800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 33, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (355, 'Transportation Budget', 4000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 33, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (356, 'Housing Budget', 12000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 33, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (357, 'Healthcare Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 33, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (358, 'Entertainment Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 33, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (359, 'Travel Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 33, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (360, 'Shopping Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 33, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (361, 'Education Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 33, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (362, 'Utilities Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 33, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (363, 'Miscellaneous Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 33, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (364, 'Monthly Total Budget', 20000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 34, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (365, 'Food & Dining Budget', 4400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 34, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (366, 'Transportation Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 34, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (367, 'Housing Budget', 6000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 34, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (368, 'Healthcare Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 34, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (369, 'Entertainment Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 34, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (370, 'Travel Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 34, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (371, 'Shopping Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 34, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (372, 'Education Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 34, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (373, 'Utilities Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 34, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (374, 'Miscellaneous Budget', 400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 34, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (375, 'Monthly Total Budget', 20000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 35, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (376, 'Food & Dining Budget', 4400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 35, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (377, 'Transportation Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 35, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (378, 'Housing Budget', 6000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 35, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (379, 'Healthcare Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 35, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (380, 'Entertainment Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 35, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (381, 'Travel Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 35, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (382, 'Shopping Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 35, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (383, 'Education Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 35, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (384, 'Utilities Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 35, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (385, 'Miscellaneous Budget', 400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 35, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (386, 'Monthly Total Budget', 30000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 36, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (387, 'Food & Dining Budget', 6600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 36, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (388, 'Transportation Budget', 3000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 36, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (389, 'Housing Budget', 9000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 36, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (390, 'Healthcare Budget', 1800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 36, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (391, 'Entertainment Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 36, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (392, 'Travel Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 36, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (393, 'Shopping Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 36, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (394, 'Education Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 36, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (395, 'Utilities Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 36, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (396, 'Miscellaneous Budget', 600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 36, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (397, 'Monthly Total Budget', 30000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 37, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (398, 'Food & Dining Budget', 6600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 37, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (399, 'Transportation Budget', 3000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 37, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (400, 'Housing Budget', 9000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 37, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (401, 'Healthcare Budget', 1800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 37, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (402, 'Entertainment Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 37, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (403, 'Travel Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 37, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (404, 'Shopping Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 37, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (405, 'Education Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 37, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (406, 'Utilities Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 37, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (407, 'Miscellaneous Budget', 600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 37, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (408, 'Monthly Total Budget', 20000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 38, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (409, 'Food & Dining Budget', 4400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 38, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (410, 'Transportation Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 38, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (411, 'Housing Budget', 6000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 38, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (412, 'Healthcare Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 38, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (413, 'Entertainment Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 38, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (414, 'Travel Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 38, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (415, 'Shopping Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 38, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (416, 'Education Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 38, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (417, 'Utilities Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 38, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (418, 'Miscellaneous Budget', 400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 38, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (419, 'Monthly Total Budget', 30000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 39, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (420, 'Food & Dining Budget', 6600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 39, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (421, 'Transportation Budget', 3000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 39, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (422, 'Housing Budget', 9000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 39, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (423, 'Healthcare Budget', 1800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 39, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (424, 'Entertainment Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 39, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (425, 'Travel Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 39, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (426, 'Shopping Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 39, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (427, 'Education Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 39, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (428, 'Utilities Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 39, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (429, 'Miscellaneous Budget', 600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 39, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (430, 'Monthly Total Budget', 30000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 40, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (431, 'Food & Dining Budget', 6600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 40, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (432, 'Transportation Budget', 3000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 40, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (433, 'Housing Budget', 9000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 40, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (434, 'Healthcare Budget', 1800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 40, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (435, 'Entertainment Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 40, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (436, 'Travel Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 40, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (437, 'Shopping Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 40, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (438, 'Education Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 40, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (439, 'Utilities Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 40, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (440, 'Miscellaneous Budget', 600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 40, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (441, 'Monthly Total Budget', 20000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 41, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (442, 'Food & Dining Budget', 4400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 41, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (443, 'Transportation Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 41, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (444, 'Housing Budget', 6000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 41, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (445, 'Healthcare Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 41, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (446, 'Entertainment Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 41, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (447, 'Travel Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 41, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (448, 'Shopping Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 41, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (449, 'Education Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 41, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (450, 'Utilities Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 41, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (451, 'Miscellaneous Budget', 400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 41, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (452, 'Monthly Total Budget', 40000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 42, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (453, 'Food & Dining Budget', 8800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 42, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (454, 'Transportation Budget', 4000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 42, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (455, 'Housing Budget', 12000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 42, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (456, 'Healthcare Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 42, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (457, 'Entertainment Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 42, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (458, 'Travel Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 42, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (459, 'Shopping Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 42, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (460, 'Education Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 42, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (461, 'Utilities Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 42, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (462, 'Miscellaneous Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 42, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (463, 'Monthly Total Budget', 40000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 43, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (464, 'Food & Dining Budget', 8800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 43, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (465, 'Transportation Budget', 4000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 43, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (466, 'Housing Budget', 12000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 43, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (467, 'Healthcare Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 43, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (468, 'Entertainment Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 43, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (469, 'Travel Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 43, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (470, 'Shopping Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 43, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (471, 'Education Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 43, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (472, 'Utilities Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 43, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (473, 'Miscellaneous Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 43, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (474, 'Monthly Total Budget', 40000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 44, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (475, 'Food & Dining Budget', 8800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 44, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (476, 'Transportation Budget', 4000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 44, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (477, 'Housing Budget', 12000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 44, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (478, 'Healthcare Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 44, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (479, 'Entertainment Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 44, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (480, 'Travel Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 44, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (481, 'Shopping Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 44, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (482, 'Education Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 44, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (483, 'Utilities Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 44, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (484, 'Miscellaneous Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 44, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (485, 'Monthly Total Budget', 30000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 45, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (486, 'Food & Dining Budget', 6600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 45, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (487, 'Transportation Budget', 3000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 45, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (488, 'Housing Budget', 9000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 45, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (489, 'Healthcare Budget', 1800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 45, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (490, 'Entertainment Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 45, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (491, 'Travel Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 45, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (492, 'Shopping Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 45, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (493, 'Education Budget', 1500, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 45, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (494, 'Utilities Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 45, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (495, 'Miscellaneous Budget', 600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 45, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (496, 'Monthly Total Budget', 20000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 46, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (497, 'Food & Dining Budget', 4400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 46, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (498, 'Transportation Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 46, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (499, 'Housing Budget', 6000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 46, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (500, 'Healthcare Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 46, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (501, 'Entertainment Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 46, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (502, 'Travel Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 46, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (503, 'Shopping Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 46, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (504, 'Education Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 46, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (505, 'Utilities Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 46, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (506, 'Miscellaneous Budget', 400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 46, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (507, 'Monthly Total Budget', 20000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 47, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (508, 'Food & Dining Budget', 4400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 47, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (509, 'Transportation Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 47, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (510, 'Housing Budget', 6000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 47, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (511, 'Healthcare Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 47, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (512, 'Entertainment Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 47, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (513, 'Travel Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 47, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (514, 'Shopping Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 47, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (515, 'Education Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 47, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (516, 'Utilities Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 47, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (517, 'Miscellaneous Budget', 400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 47, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (518, 'Monthly Total Budget', 40000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 48, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (519, 'Food & Dining Budget', 8800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 48, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (520, 'Transportation Budget', 4000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 48, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (521, 'Housing Budget', 12000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 48, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (522, 'Healthcare Budget', 2400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 48, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (523, 'Entertainment Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 48, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (524, 'Travel Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 48, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (525, 'Shopping Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 48, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (526, 'Education Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 48, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (527, 'Utilities Budget', 3200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 48, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (528, 'Miscellaneous Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 48, 10, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (529, 'Monthly Total Budget', 20000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 49, NULL, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (530, 'Food & Dining Budget', 4400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 49, 1, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (531, 'Transportation Budget', 2000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 49, 2, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (532, 'Housing Budget', 6000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 49, 3, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (533, 'Healthcare Budget', 1200, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 49, 4, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (534, 'Entertainment Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 49, 5, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (535, 'Travel Budget', 800, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 49, 6, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (536, 'Shopping Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 49, 7, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (537, 'Education Budget', 1000, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 49, 8, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (538, 'Utilities Budget', 1600, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 49, 9, true, '2025-12-01 16:41:21.015859', NULL);
INSERT INTO public.budgets VALUES (539, 'Miscellaneous Budget', 400, 'INR', 'Monthly', '2025-08-01 00:00:00', NULL, 1, 49, 10, true, '2025-12-01 16:41:21.015859', NULL);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.categories VALUES (1, 'Food & Dining', 'FDNG', 'Meals, groceries, cafes, restaurants, and takeout orders', true, '2025-12-03 16:35:06.963745', '2025-12-03 16:35:06.963745');
INSERT INTO public.categories VALUES (2, 'Transportation', 'TRAN', 'Fuel, public transit, ride-hailing, parking, and vehicle expenses', true, '2025-12-03 16:35:06.963745', '2025-12-03 16:35:06.963745');
INSERT INTO public.categories VALUES (3, 'Housing', 'HOUS', 'Rent, mortgage payments, property maintenance, and household utilities', true, '2025-12-03 16:35:06.963745', '2025-12-03 16:35:06.963745');
INSERT INTO public.categories VALUES (4, 'Healthcare', 'HLTH', 'Doctor visits, pharmacy purchases, medical insurance, and hospital bills', true, '2025-12-03 16:35:06.963745', '2025-12-03 16:35:06.963745');
INSERT INTO public.categories VALUES (5, 'Entertainment', 'ENTR', 'Movies, streaming subscriptions, concerts, gaming, and leisure activities', true, '2025-12-03 16:35:06.963745', '2025-12-03 16:35:06.963745');
INSERT INTO public.categories VALUES (6, 'Travel', 'TRVL', 'Flights, hotels, vacation packages, and related travel costs', true, '2025-12-03 16:35:06.963745', '2025-12-03 16:35:06.963745');
INSERT INTO public.categories VALUES (7, 'Shopping', 'SHOP', 'Clothing, electronics, household goods, and personal purchases', true, '2025-12-03 16:35:06.963745', '2025-12-03 16:35:06.963745');
INSERT INTO public.categories VALUES (8, 'Education', 'EDUC', 'Tuition fees, online courses, books, and professional training', true, '2025-12-03 16:35:06.963745', '2025-12-03 16:35:06.963745');
INSERT INTO public.categories VALUES (9, 'Bills & Utilities', 'BILS', 'Recurring service bills like internet, phone, cable, and electricity', true, '2025-12-03 16:35:06.963745', '2025-12-03 16:35:06.963745');
INSERT INTO public.categories VALUES (10, 'Miscellaneous', 'MISC', 'Catch-all for irregular or uncategorized expenses', true, '2025-12-03 16:35:06.963745', '2025-12-03 16:35:06.963745');
INSERT INTO public.categories VALUES (11, 'Income from Salary/Transfer', 'INCOM', 'Income from Salary, Bank/UPI/Other Online Transfer,', true, '2025-12-03 18:52:33.245303', '2025-12-03 18:52:33.245303');


--
-- Data for Name: feedbacks; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.feedbacks VALUES (1, 'Bug', 'App crashes on adding expense', 'The app crashes whenever I try to add a new expense above 10,000.', 2, 'Open', 1, NULL, '2025-01-05 10:15:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (2, 'Feature', 'Add dark mode', 'It would be great to have a dark mode for using the app at night.', 5, 'Open', 2, NULL, '2025-01-06 09:20:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (3, 'Bug', 'Incorrect total in dashboard', 'The total expense in dashboard does not match the sum of listed expenses.', 3, 'In Progress', 3, NULL, '2025-01-07 14:32:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (4, 'Design', 'Improve category icons', 'Category icons are too similar and confusing at a glance.', 4, 'Open', 4, NULL, '2025-01-08 18:45:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (5, 'Performance', 'Slow loading of reports', 'Reports page takes more than 10 seconds to load with many records.', 3, 'Open', 5, NULL, '2025-01-09 08:10:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (6, 'Bug', 'Date filter not working', 'Filtering expenses by date range returns incomplete results.', 2, 'Open', 6, NULL, '2025-01-10 11:05:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (7, 'Feature', 'Support multiple currencies', 'Please allow tracking expenses in different currencies per account.', 5, 'Open', 7, NULL, '2025-01-11 16:50:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (8, 'Bug', 'Cannot delete category', 'Deleting an unused category shows an unknown error.', 3, 'Open', 8, NULL, '2025-01-12 19:25:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (9, 'Design', 'Larger fonts on small devices', 'The font size is too small on my phone, hard to read.', 4, 'Open', 9, NULL, '2025-01-13 07:40:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (10, 'Performance', 'Lag when scrolling expense list', 'The expense list becomes laggy when more than 500 records exist.', 3, 'Open', 10, NULL, '2025-01-14 12:30:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (11, 'Feature', 'Export to Excel', 'Kindly add an option to export expenses and budgets to Excel.', 5, 'Open', 1, NULL, '2025-01-15 09:15:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (12, 'Bug', 'Duplicate expenses after sync', 'After syncing, some expenses appear twice in the list.', 2, 'Open', 2, NULL, '2025-01-16 13:05:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (13, 'Design', 'Show account name in expense list', 'Please show account name beside each expense for clarity.', 4, 'Open', 3, NULL, '2025-01-17 17:45:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (14, 'Feature', 'Add reminders for bills', 'Would like reminders for recurring bills like rent and utilities.', 5, 'Open', 4, NULL, '2025-01-18 20:00:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (15, 'Bug', 'Cannot login after password reset', 'After resetting my password, the app shows invalid credentials.', 1, 'Open', 5, NULL, '2025-01-19 10:25:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (16, 'Performance', 'High battery usage', 'The app drains battery quickly when left open on dashboard.', 2, 'Open', 6, NULL, '2025-01-20 08:55:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (17, 'Feature', 'Family sharing', 'Please add ability to share budgets and expenses with family members.', 5, 'Open', 7, NULL, '2025-01-21 15:20:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (18, 'Bug', 'Wrong currency symbol in reports', 'Reports show INR symbol even when account currency is USD.', 3, 'Open', 8, NULL, '2025-01-22 18:40:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (19, 'Design', 'Better color coding', 'Use clearer colors to differentiate income, expense and transfer.', 4, 'Open', 9, NULL, '2025-01-23 07:35:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (20, 'Feature', 'Attach receipts to expenses', 'I want to upload photo of bill/receipt with each expense.', 5, 'Open', 10, NULL, '2025-01-24 11:50:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (21, 'Bug', 'Categories not saving', 'Newly added categories disappear after app restart.', 2, 'In Progress', 1, NULL, '2025-01-25 09:45:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (22, 'Performance', 'Slow first-time startup', 'The app takes too long to open the first time after install.', 3, 'Open', 2, NULL, '2025-01-26 13:30:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (23, 'Design', 'Show monthly summary chart', 'A simple bar chart on dashboard for monthly totals would help.', 5, 'Open', 3, NULL, '2025-01-27 16:05:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (24, 'Feature', 'Biometric login', 'Allow fingerprint or face ID login for faster access.', 5, 'Open', 4, NULL, '2025-01-28 19:55:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (25, 'Bug', 'Incorrect sorting by date', 'Sorting by date puts some older entries at the top.', 2, 'Open', 5, NULL, '2025-01-29 08:20:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (26, 'Feature', 'Custom categories per user', 'Each family member should be able to maintain their own categories.', 4, 'Open', 6, NULL, '2025-01-30 14:15:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (27, 'Design', 'Highlight today’s expenses', 'Highlight entries for today with a subtle background color.', 4, 'Open', 7, NULL, '2025-01-31 18:10:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (28, 'Bug', 'Report filters reset randomly', 'Report filters reset when navigating back from details.', 3, 'Open', 8, NULL, '2025-02-01 09:05:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (29, 'Feature', 'Offline mode', 'Allow adding expenses offline and sync when internet is back.', 5, 'Open', 9, NULL, '2025-02-02 12:40:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (30, 'Performance', 'Search is very slow', 'Searching for text in expenses takes several seconds.', 2, 'Open', 10, NULL, '2025-02-03 10:10:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (31, 'Bug', 'Negative balance not allowed', 'Transfers between accounts sometimes create negative balances.', 2, 'In Progress', 1, NULL, '2025-02-04 15:55:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (32, 'Feature', 'Multi-language support', 'Please add support for Hindi and Arabic languages.', 5, 'Open', 2, NULL, '2025-02-05 19:30:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (33, 'Design', 'More compact list view', 'Allow a dense mode to see more rows on one screen.', 4, 'Open', 3, NULL, '2025-02-06 07:50:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (34, 'Bug', 'Export CSV encoding issue', 'Exported CSV opens with garbled characters in Excel.', 3, 'Open', 4, NULL, '2025-02-07 11:25:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (35, 'Feature', 'Goal-based saving', 'Feature to set savings goals and track progress.', 5, 'Open', 5, NULL, '2025-02-08 16:45:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (36, 'Performance', 'Charts take time to render', 'Analytics charts take too long to load with big datasets.', 3, 'Open', 6, NULL, '2025-02-09 20:05:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (37, 'Bug', 'Notification toggle not working', 'Disabling notifications has no effect, still getting alerts.', 2, 'Open', 7, NULL, '2025-02-10 09:35:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (38, 'Design', 'Clearer error messages', 'Error messages should be more specific instead of generic.', 4, 'Open', 8, NULL, '2025-02-11 13:15:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (39, 'Feature', 'Tag-based filtering', 'Allow adding tags to expenses and filter by multiple tags.', 5, 'Open', 9, NULL, '2025-02-12 17:50:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (40, 'Bug', 'Duplicated notifications', 'Getting the same reminder notification multiple times.', 2, 'Open', 10, NULL, '2025-02-13 08:05:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (41, 'Performance', 'Slow sync on mobile data', 'Sync is very slow when using mobile data compared to Wi-Fi.', 3, 'Open', 1, NULL, '2025-02-14 10:45:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (42, 'Feature', 'Archive old accounts', 'Ability to archive accounts that are no longer used.', 4, 'Open', 2, NULL, '2025-02-15 14:25:00', '2025-12-07 09:04:48.528242');
INSERT INTO public.feedbacks VALUES (43, 'Design', 'Better empty state screens', 'Show tips and help text when there is no data yet.', 4, 'Open', 3, NULL, '2025-02-16 18:30:00', '2025-12-07 09:04:48.528242');


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.roles VALUES (1, 'Super Admin', 'Super Admin');
INSERT INTO public.roles VALUES (2, 'Admin', 'Admin');
INSERT INTO public.roles VALUES (3, 'User', 'Normal User of the App');


--
-- Data for Name: tokens; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.transactions VALUES (1, 'Expense - Housing', 200, 'Expense', 'INR', 3, 1, 1, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 1, 1, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 1, 1, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (4, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 1, 1, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (5, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 1, 1, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (6, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 1, 1, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (7, 'Expense - Education', 200, 'Expense', 'INR', 8, 1, 1, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (8, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 1, 1, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (9, 'Expense - Travel', 200, 'Expense', 'INR', 6, 1, 1, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (10, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 1, 1, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (11, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 1, 1, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (12, 'Expense - Housing', 300, 'Expense', 'INR', 3, 1, 1, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (13, 'Expense - Travel', 200, 'Expense', 'INR', 6, 1, 1, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (14, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 1, 1, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (15, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 1, 1, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (16, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 1, 1, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (17, 'Expense - Housing', 500, 'Expense', 'INR', 3, 1, 1, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (18, 'Expense - Housing', 1500, 'Expense', 'INR', 3, 1, 1, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (19, 'Expense - Housing', 200, 'Expense', 'INR', 3, 1, 1, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (20, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 1, 1, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (21, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 1, 1, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (22, 'Expense - Housing', 200, 'Expense', 'INR', 3, 1, 1, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (23, 'Expense - Travel', 200, 'Expense', 'INR', 6, 1, 1, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (24, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 1, 1, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (25, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 1, 1, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (26, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 1, 1, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (27, 'Expense - Education', 200, 'Expense', 'INR', 8, 1, 1, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (28, 'Expense - Travel', 200, 'Expense', 'INR', 6, 1, 1, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (29, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 1, 1, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (30, 'Expense - Travel', 200, 'Expense', 'INR', 6, 1, 1, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (31, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 1, 1, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (32, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 1, 1, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (33, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 1, 1, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (34, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 1, 1, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (35, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 1, 1, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (36, 'Expense - Education', 200, 'Expense', 'INR', 8, 1, 1, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (37, 'Expense - Travel', 200, 'Expense', 'INR', 6, 1, 1, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (38, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 1, 1, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (39, 'Expense - Housing', 200, 'Expense', 'INR', 3, 1, 1, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (40, 'Expense - Transportation', 700, 'Expense', 'INR', 2, 1, 1, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (41, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 1, 1, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (42, 'Expense - Travel', 200, 'Expense', 'INR', 6, 1, 1, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (43, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 1, 1, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (44, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 1, 1, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (45, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 1, 1, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (46, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 1, 1, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (47, 'Expense - Housing', 600, 'Expense', 'INR', 3, 1, 1, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (48, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 1, 1, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (49, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 1, 1, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (50, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 1, 1, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (51, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 1, 1, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (52, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 1, 1, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (53, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 1, 1, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (54, 'Expense - Education', 200, 'Expense', 'INR', 8, 1, 1, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (55, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 1, 1, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (56, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 1, 1, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (57, 'Expense - Education', 200, 'Expense', 'INR', 8, 1, 1, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (58, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 2, 2, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (59, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 2, 2, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (60, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 2, 2, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (61, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 2, 2, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (62, 'Expense - Housing', 300, 'Expense', 'INR', 3, 2, 2, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (63, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 2, 2, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (64, 'Expense - Travel', 200, 'Expense', 'INR', 6, 2, 2, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (65, 'Expense - Utilities', 700, 'Expense', 'INR', 9, 2, 2, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (66, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 2, 2, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (67, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 2, 2, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (68, 'Expense - Entertainment', 400, 'Expense', 'INR', 5, 2, 2, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (69, 'Expense - Education', 200, 'Expense', 'INR', 8, 2, 2, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (70, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 2, 2, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (71, 'Expense - Education', 200, 'Expense', 'INR', 8, 2, 2, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (72, 'Expense - Education', 200, 'Expense', 'INR', 8, 2, 2, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (73, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 2, 2, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (74, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 2, 2, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (75, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 2, 2, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (76, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 2, 2, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (77, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 2, 2, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (78, 'Expense - Travel', 200, 'Expense', 'INR', 6, 2, 2, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (79, 'Expense - Healthcare', 300, 'Expense', 'INR', 4, 2, 2, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (80, 'Expense - Education', 500, 'Expense', 'INR', 8, 2, 2, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (81, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 2, 2, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (82, 'Expense - Education', 200, 'Expense', 'INR', 8, 2, 2, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (83, 'Expense - Housing', 900, 'Expense', 'INR', 3, 2, 2, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (84, 'Expense - Transportation', 900, 'Expense', 'INR', 2, 2, 2, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (85, 'Expense - Housing', 200, 'Expense', 'INR', 3, 2, 2, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (86, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 2, 2, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (87, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 2, 2, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (88, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 2, 2, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (89, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 2, 2, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (90, 'Expense - Utilities', 700, 'Expense', 'INR', 9, 2, 2, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (91, 'Expense - Education', 200, 'Expense', 'INR', 8, 2, 2, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (92, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 2, 2, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (93, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 2, 2, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (94, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 2, 2, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (95, 'Expense - Housing', 300, 'Expense', 'INR', 3, 2, 2, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (96, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 2, 2, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (97, 'Expense - Travel', 200, 'Expense', 'INR', 6, 2, 2, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (98, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 2, 2, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (99, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 2, 2, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (100, 'Expense - Housing', 1100, 'Expense', 'INR', 3, 2, 2, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (101, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 2, 2, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (102, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 2, 2, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (103, 'Expense - Travel', 200, 'Expense', 'INR', 6, 2, 2, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (104, 'Expense - Transportation', 1000, 'Expense', 'INR', 2, 2, 2, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (105, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 2, 2, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (106, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 2, 2, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (107, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 2, 2, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (108, 'Expense - Housing', 700, 'Expense', 'INR', 3, 2, 2, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (109, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 2, 2, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (110, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 2, 2, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (111, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 2, 2, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (112, 'Expense - Housing', 1300, 'Expense', 'INR', 3, 2, 2, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (113, 'Expense - Education', 200, 'Expense', 'INR', 8, 2, 2, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (114, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 2, 2, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (115, 'Expense - Travel', 200, 'Expense', 'INR', 6, 2, 2, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (116, 'Expense - Education', 200, 'Expense', 'INR', 8, 2, 2, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (117, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 2, 2, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (118, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 2, 2, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (119, 'Expense - Travel', 200, 'Expense', 'INR', 6, 2, 2, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (120, 'Expense - Travel', 200, 'Expense', 'INR', 6, 2, 2, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (121, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 2, 2, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (122, 'Expense - Housing', 1200, 'Expense', 'INR', 3, 2, 2, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (123, 'Expense - Education', 200, 'Expense', 'INR', 8, 2, 2, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (124, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 2, 2, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (125, 'Expense - Food & Dining', 800, 'Expense', 'INR', 1, 2, 2, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (126, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 2, 2, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (127, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 2, 2, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (128, 'Expense - Travel', 200, 'Expense', 'INR', 6, 2, 2, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (129, 'Expense - Healthcare', 500, 'Expense', 'INR', 4, 2, 2, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (130, 'Expense - Healthcare', 300, 'Expense', 'INR', 4, 2, 2, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (131, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 2, 2, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (132, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 2, 2, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (133, 'Expense - Travel', 200, 'Expense', 'INR', 6, 2, 2, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (134, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 2, 2, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (135, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 2, 2, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (136, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 2, 2, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (137, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 2, 2, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (138, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 2, 2, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (139, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 2, 2, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (140, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 3, 3, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (141, 'Expense - Travel', 200, 'Expense', 'INR', 6, 3, 3, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (142, 'Expense - Travel', 200, 'Expense', 'INR', 6, 3, 3, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (143, 'Expense - Housing', 200, 'Expense', 'INR', 3, 3, 3, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (144, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 3, 3, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (145, 'Expense - Education', 200, 'Expense', 'INR', 8, 3, 3, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (146, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 3, 3, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (147, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 3, 3, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (148, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 3, 3, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (149, 'Expense - Education', 200, 'Expense', 'INR', 8, 3, 3, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (150, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 3, 3, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (151, 'Expense - Education', 200, 'Expense', 'INR', 8, 3, 3, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (152, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 3, 3, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (153, 'Expense - Housing', 500, 'Expense', 'INR', 3, 3, 3, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (154, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 3, 3, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (155, 'Expense - Healthcare', 300, 'Expense', 'INR', 4, 3, 3, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (156, 'Expense - Housing', 400, 'Expense', 'INR', 3, 3, 3, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (157, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 3, 3, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (158, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 3, 3, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (159, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 3, 3, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (160, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 3, 3, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (161, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 3, 3, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (162, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 3, 3, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (163, 'Expense - Travel', 200, 'Expense', 'INR', 6, 3, 3, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (164, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 3, 3, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (165, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 3, 3, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (166, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 3, 3, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (167, 'Expense - Housing', 200, 'Expense', 'INR', 3, 3, 3, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (168, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 3, 3, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (169, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 3, 3, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (170, 'Expense - Travel', 200, 'Expense', 'INR', 6, 3, 3, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (171, 'Expense - Education', 200, 'Expense', 'INR', 8, 3, 3, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (172, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 3, 3, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (173, 'Expense - Education', 200, 'Expense', 'INR', 8, 3, 3, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (174, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 3, 3, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (175, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 3, 3, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (176, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 3, 3, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (177, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 3, 3, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (178, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 3, 3, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (179, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 3, 3, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (180, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 3, 3, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (181, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 3, 3, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (182, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 3, 3, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (183, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 3, 3, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (184, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 3, 3, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (185, 'Expense - Travel', 200, 'Expense', 'INR', 6, 3, 3, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (186, 'Expense - Housing', 200, 'Expense', 'INR', 3, 3, 3, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (187, 'Expense - Education', 200, 'Expense', 'INR', 8, 3, 3, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (188, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 3, 3, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (189, 'Expense - Travel', 200, 'Expense', 'INR', 6, 3, 3, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (190, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 4, 4, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (191, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 4, 4, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (192, 'Expense - Transportation', 400, 'Expense', 'INR', 2, 4, 4, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (193, 'Expense - Utilities', 500, 'Expense', 'INR', 9, 4, 4, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (194, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 4, 4, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (195, 'Expense - Education', 200, 'Expense', 'INR', 8, 4, 4, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (196, 'Expense - Entertainment', 500, 'Expense', 'INR', 5, 4, 4, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (197, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 4, 4, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (198, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 4, 4, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (199, 'Expense - Education', 200, 'Expense', 'INR', 8, 4, 4, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (200, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 4, 4, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (201, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 4, 4, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (202, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 4, 4, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (203, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 4, 4, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (204, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 4, 4, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (205, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 4, 4, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (206, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 4, 4, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (207, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 4, 4, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (208, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 4, 4, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (209, 'Expense - Education', 200, 'Expense', 'INR', 8, 4, 4, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (210, 'Expense - Education', 200, 'Expense', 'INR', 8, 4, 4, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (211, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 4, 4, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (212, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 4, 4, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (213, 'Expense - Travel', 200, 'Expense', 'INR', 6, 4, 4, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (214, 'Expense - Travel', 200, 'Expense', 'INR', 6, 4, 4, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (215, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 4, 4, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (216, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 4, 4, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (217, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 4, 4, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (218, 'Expense - Travel', 200, 'Expense', 'INR', 6, 4, 4, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (219, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 4, 4, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (220, 'Expense - Travel', 200, 'Expense', 'INR', 6, 4, 4, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (221, 'Expense - Housing', 2100, 'Expense', 'INR', 3, 4, 4, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (222, 'Expense - Education', 300, 'Expense', 'INR', 8, 4, 4, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (223, 'Expense - Housing', 500, 'Expense', 'INR', 3, 4, 4, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (224, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 4, 4, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (225, 'Expense - Education', 200, 'Expense', 'INR', 8, 4, 4, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (226, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 4, 4, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (227, 'Expense - Education', 200, 'Expense', 'INR', 8, 4, 4, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (228, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 4, 4, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (229, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 4, 4, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (230, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 4, 4, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (231, 'Expense - Travel', 200, 'Expense', 'INR', 6, 4, 4, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (232, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 4, 4, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (233, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 4, 4, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (234, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 4, 4, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (235, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 4, 4, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (236, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 4, 4, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (237, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 4, 4, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (238, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 4, 4, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (239, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 4, 4, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (240, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 4, 4, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (241, 'Expense - Housing', 200, 'Expense', 'INR', 3, 4, 4, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (242, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 4, 4, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (243, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 4, 4, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (244, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 4, 4, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (245, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 4, 4, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (246, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 4, 4, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (247, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 4, 4, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (248, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 4, 4, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (249, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 4, 4, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (250, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 4, 4, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (251, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 4, 4, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (252, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 5, 5, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (253, 'Expense - Housing', 1800, 'Expense', 'INR', 3, 5, 5, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (254, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 5, 5, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (255, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 5, 5, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (256, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 5, 5, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (257, 'Expense - Housing', 800, 'Expense', 'INR', 3, 5, 5, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (258, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 5, 5, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (259, 'Expense - Travel', 300, 'Expense', 'INR', 6, 5, 5, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (260, 'Expense - Education', 200, 'Expense', 'INR', 8, 5, 5, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (261, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 5, 5, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (262, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 5, 5, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (263, 'Expense - Housing', 200, 'Expense', 'INR', 3, 5, 5, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (264, 'Expense - Housing', 200, 'Expense', 'INR', 3, 5, 5, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (265, 'Expense - Travel', 200, 'Expense', 'INR', 6, 5, 5, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (266, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 5, 5, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (267, 'Expense - Travel', 200, 'Expense', 'INR', 6, 5, 5, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (268, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 5, 5, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (269, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 5, 5, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (270, 'Expense - Education', 200, 'Expense', 'INR', 8, 5, 5, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (271, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 5, 5, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (272, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 5, 5, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (273, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 5, 5, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (274, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 5, 5, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (275, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 5, 5, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (276, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 5, 5, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (277, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 5, 5, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (278, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 5, 5, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (279, 'Expense - Travel', 200, 'Expense', 'INR', 6, 5, 5, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (280, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 5, 5, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (281, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 5, 5, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (282, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 5, 5, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (283, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 5, 5, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (284, 'Expense - Shopping', 400, 'Expense', 'INR', 7, 5, 5, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (285, 'Expense - Education', 200, 'Expense', 'INR', 8, 5, 5, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (286, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 5, 5, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (287, 'Expense - Travel', 200, 'Expense', 'INR', 6, 5, 5, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (288, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 5, 5, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (289, 'Expense - Travel', 200, 'Expense', 'INR', 6, 5, 5, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (290, 'Expense - Transportation', 400, 'Expense', 'INR', 2, 5, 5, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (291, 'Expense - Housing', 300, 'Expense', 'INR', 3, 5, 5, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (292, 'Expense - Education', 200, 'Expense', 'INR', 8, 5, 5, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (293, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 5, 5, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (294, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 5, 5, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (295, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 5, 5, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (296, 'Expense - Education', 200, 'Expense', 'INR', 8, 5, 5, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (297, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 5, 5, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (298, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 5, 5, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (299, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 5, 5, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (300, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 5, 5, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (301, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 5, 5, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (302, 'Expense - Education', 200, 'Expense', 'INR', 8, 5, 5, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (303, 'Expense - Shopping', 400, 'Expense', 'INR', 7, 5, 5, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (304, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 5, 5, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (305, 'Expense - Housing', 200, 'Expense', 'INR', 3, 5, 5, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (306, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 5, 5, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (307, 'Expense - Travel', 200, 'Expense', 'INR', 6, 5, 5, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (308, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 5, 5, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (309, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 5, 5, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (310, 'Expense - Travel', 200, 'Expense', 'INR', 6, 5, 5, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (311, 'Expense - Education', 200, 'Expense', 'INR', 8, 6, 6, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (312, 'Expense - Education', 200, 'Expense', 'INR', 8, 6, 6, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (313, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 6, 6, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (314, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 6, 6, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (315, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 6, 6, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (316, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 6, 6, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (317, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 6, 6, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (318, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 6, 6, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (319, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 6, 6, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (320, 'Expense - Housing', 400, 'Expense', 'INR', 3, 6, 6, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (321, 'Expense - Education', 200, 'Expense', 'INR', 8, 6, 6, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (322, 'Expense - Travel', 200, 'Expense', 'INR', 6, 6, 6, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (323, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 6, 6, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (324, 'Expense - Travel', 200, 'Expense', 'INR', 6, 6, 6, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (325, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 6, 6, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (326, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 6, 6, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (327, 'Expense - Education', 200, 'Expense', 'INR', 8, 6, 6, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (328, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 6, 6, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (329, 'Expense - Travel', 200, 'Expense', 'INR', 6, 6, 6, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (330, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 6, 6, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (331, 'Expense - Education', 200, 'Expense', 'INR', 8, 6, 6, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (332, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 6, 6, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (333, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 6, 6, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (334, 'Expense - Housing', 600, 'Expense', 'INR', 3, 6, 6, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (335, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 6, 6, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (336, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 6, 6, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (337, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 6, 6, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (338, 'Expense - Travel', 200, 'Expense', 'INR', 6, 6, 6, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (339, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 6, 6, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (340, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 6, 6, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (341, 'Expense - Travel', 200, 'Expense', 'INR', 6, 6, 6, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (342, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 6, 6, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (343, 'Expense - Travel', 200, 'Expense', 'INR', 6, 6, 6, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (344, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 6, 6, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (345, 'Expense - Food & Dining', 1000, 'Expense', 'INR', 1, 6, 6, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (346, 'Expense - Housing', 1300, 'Expense', 'INR', 3, 6, 6, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (347, 'Expense - Travel', 200, 'Expense', 'INR', 6, 6, 6, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (348, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 6, 6, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (349, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 6, 6, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (350, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 6, 6, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (351, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 6, 6, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (352, 'Expense - Travel', 200, 'Expense', 'INR', 6, 6, 6, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (353, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 6, 6, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (354, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 6, 6, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (355, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 6, 6, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (356, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 6, 6, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (357, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 6, 6, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (358, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 6, 6, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (359, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 6, 6, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (360, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 6, 6, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (361, 'Expense - Travel', 200, 'Expense', 'INR', 6, 6, 6, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (362, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 6, 6, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (363, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 6, 6, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (364, 'Expense - Housing', 200, 'Expense', 'INR', 3, 6, 6, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (365, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 6, 6, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (366, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 6, 6, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (367, 'Expense - Travel', 200, 'Expense', 'INR', 6, 6, 6, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (368, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 6, 6, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (369, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 6, 6, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (370, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 6, 6, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (371, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 6, 6, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (372, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 6, 6, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (373, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 6, 6, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (374, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 6, 6, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (375, 'Expense - Housing', 500, 'Expense', 'INR', 3, 6, 6, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (376, 'Expense - Housing', 300, 'Expense', 'INR', 3, 6, 6, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (377, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 6, 6, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (378, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 7, 7, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (379, 'Expense - Housing', 300, 'Expense', 'INR', 3, 7, 7, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (380, 'Expense - Travel', 500, 'Expense', 'INR', 6, 7, 7, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (381, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 7, 7, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (382, 'Expense - Housing', 400, 'Expense', 'INR', 3, 7, 7, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (383, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 7, 7, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (384, 'Expense - Education', 200, 'Expense', 'INR', 8, 7, 7, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (385, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 7, 7, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (386, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 7, 7, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (387, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 7, 7, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (388, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 7, 7, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (389, 'Expense - Housing', 200, 'Expense', 'INR', 3, 7, 7, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (390, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 7, 7, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (391, 'Expense - Housing', 700, 'Expense', 'INR', 3, 7, 7, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (392, 'Expense - Food & Dining', 1500, 'Expense', 'INR', 1, 7, 7, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (393, 'Expense - Travel', 200, 'Expense', 'INR', 6, 7, 7, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (394, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 7, 7, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (395, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 7, 7, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (396, 'Expense - Education', 200, 'Expense', 'INR', 8, 7, 7, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (397, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 7, 7, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (398, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 7, 7, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (399, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 7, 7, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (400, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 7, 7, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (401, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 7, 7, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (402, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 7, 7, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (403, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 7, 7, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (404, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 7, 7, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (405, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 7, 7, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (406, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 7, 7, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (407, 'Expense - Housing', 500, 'Expense', 'INR', 3, 7, 7, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (408, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 7, 7, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (409, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 7, 7, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (410, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 7, 7, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (411, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 7, 7, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (412, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 7, 7, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (413, 'Expense - Healthcare', 400, 'Expense', 'INR', 4, 7, 7, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (414, 'Expense - Education', 200, 'Expense', 'INR', 8, 7, 7, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (415, 'Expense - Housing', 1300, 'Expense', 'INR', 3, 7, 7, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (416, 'Expense - Housing', 1400, 'Expense', 'INR', 3, 7, 7, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (417, 'Expense - Travel', 200, 'Expense', 'INR', 6, 7, 7, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (418, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 7, 7, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (419, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 7, 7, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (420, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 7, 7, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (421, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 7, 7, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (422, 'Expense - Travel', 300, 'Expense', 'INR', 6, 7, 7, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (423, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 7, 7, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (424, 'Expense - Housing', 200, 'Expense', 'INR', 3, 7, 7, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (425, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 7, 7, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (426, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 7, 7, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (427, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 7, 7, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (428, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 7, 7, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (429, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 7, 7, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (430, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 7, 7, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (431, 'Expense - Travel', 200, 'Expense', 'INR', 6, 7, 7, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (432, 'Expense - Travel', 200, 'Expense', 'INR', 6, 7, 7, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (433, 'Expense - Housing', 200, 'Expense', 'INR', 3, 7, 7, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (434, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 7, 7, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (435, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 7, 7, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (436, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 8, 8, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (437, 'Expense - Travel', 200, 'Expense', 'INR', 6, 8, 8, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (438, 'Expense - Food & Dining', 700, 'Expense', 'INR', 1, 8, 8, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (439, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 8, 8, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (440, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 8, 8, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (441, 'Expense - Food & Dining', 800, 'Expense', 'INR', 1, 8, 8, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (442, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 8, 8, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (443, 'Expense - Transportation', 900, 'Expense', 'INR', 2, 8, 8, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (444, 'Expense - Travel', 200, 'Expense', 'INR', 6, 8, 8, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (445, 'Expense - Travel', 200, 'Expense', 'INR', 6, 8, 8, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (446, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 8, 8, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (447, 'Expense - Shopping', 600, 'Expense', 'INR', 7, 8, 8, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (448, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 8, 8, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (449, 'Expense - Housing', 400, 'Expense', 'INR', 3, 8, 8, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (450, 'Expense - Shopping', 700, 'Expense', 'INR', 7, 8, 8, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (451, 'Expense - Utilities', 500, 'Expense', 'INR', 9, 8, 8, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (452, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 8, 8, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (453, 'Expense - Education', 200, 'Expense', 'INR', 8, 8, 8, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (454, 'Expense - Housing', 400, 'Expense', 'INR', 3, 8, 8, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (455, 'Expense - Food & Dining', 1300, 'Expense', 'INR', 1, 8, 8, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (456, 'Expense - Utilities', 500, 'Expense', 'INR', 9, 8, 8, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (457, 'Expense - Housing', 1000, 'Expense', 'INR', 3, 8, 8, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (458, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 8, 8, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (459, 'Expense - Travel', 200, 'Expense', 'INR', 6, 8, 8, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (460, 'Expense - Travel', 500, 'Expense', 'INR', 6, 8, 8, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (461, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 8, 8, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (462, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 8, 8, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (463, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 8, 8, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (464, 'Expense - Utilities', 700, 'Expense', 'INR', 9, 8, 8, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (465, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 8, 8, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (466, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 8, 8, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (467, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 8, 8, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (468, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 8, 8, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (469, 'Expense - Travel', 200, 'Expense', 'INR', 6, 8, 8, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (470, 'Expense - Education', 300, 'Expense', 'INR', 8, 8, 8, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (471, 'Expense - Housing', 900, 'Expense', 'INR', 3, 8, 8, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (472, 'Expense - Food & Dining', 800, 'Expense', 'INR', 1, 8, 8, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (473, 'Expense - Housing', 200, 'Expense', 'INR', 3, 8, 8, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (474, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 8, 8, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (475, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 8, 8, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (476, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 8, 8, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (477, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 8, 8, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (478, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 8, 8, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (479, 'Expense - Housing', 300, 'Expense', 'INR', 3, 8, 8, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (480, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 8, 8, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (481, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 8, 8, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (482, 'Expense - Education', 200, 'Expense', 'INR', 8, 8, 8, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (483, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 8, 8, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (484, 'Expense - Housing', 200, 'Expense', 'INR', 3, 8, 8, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (485, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 8, 8, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (486, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 8, 8, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (487, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 8, 8, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (488, 'Expense - Housing', 200, 'Expense', 'INR', 3, 8, 8, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (489, 'Expense - Housing', 400, 'Expense', 'INR', 3, 8, 8, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (490, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 8, 8, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (491, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 8, 8, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (492, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 8, 8, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (493, 'Expense - Travel', 200, 'Expense', 'INR', 6, 8, 8, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (494, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 9, 9, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (495, 'Expense - Healthcare', 300, 'Expense', 'INR', 4, 9, 9, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (496, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 9, 9, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (497, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 9, 9, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (498, 'Expense - Travel', 200, 'Expense', 'INR', 6, 9, 9, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (499, 'Expense - Education', 200, 'Expense', 'INR', 8, 9, 9, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (500, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 9, 9, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (501, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 9, 9, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (502, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 9, 9, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (503, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 9, 9, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (504, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 9, 9, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (505, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 9, 9, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (506, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 9, 9, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (507, 'Expense - Healthcare', 400, 'Expense', 'INR', 4, 9, 9, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (508, 'Expense - Travel', 200, 'Expense', 'INR', 6, 9, 9, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (509, 'Expense - Food & Dining', 900, 'Expense', 'INR', 1, 9, 9, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (510, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 9, 9, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (511, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 9, 9, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (512, 'Expense - Travel', 200, 'Expense', 'INR', 6, 9, 9, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (513, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 9, 9, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (514, 'Expense - Housing', 300, 'Expense', 'INR', 3, 9, 9, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (515, 'Expense - Travel', 200, 'Expense', 'INR', 6, 9, 9, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (516, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 9, 9, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (517, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 9, 9, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (518, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 9, 9, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (519, 'Expense - Housing', 600, 'Expense', 'INR', 3, 9, 9, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (520, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 9, 9, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (521, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 9, 9, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (522, 'Expense - Housing', 500, 'Expense', 'INR', 3, 9, 9, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (523, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 9, 9, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (524, 'Expense - Transportation', 400, 'Expense', 'INR', 2, 9, 9, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (525, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 9, 9, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (526, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 9, 9, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (527, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 9, 9, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (528, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 9, 9, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (529, 'Expense - Travel', 200, 'Expense', 'INR', 6, 9, 9, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (530, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 9, 9, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (531, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 9, 9, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (532, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 9, 9, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (533, 'Expense - Travel', 200, 'Expense', 'INR', 6, 9, 9, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (534, 'Expense - Travel', 200, 'Expense', 'INR', 6, 9, 9, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (535, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 9, 9, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (536, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 9, 9, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (537, 'Expense - Food & Dining', 1500, 'Expense', 'INR', 1, 9, 9, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (538, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 9, 9, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (539, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 9, 9, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (540, 'Expense - Education', 200, 'Expense', 'INR', 8, 9, 9, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (541, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 9, 9, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (542, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 9, 9, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (543, 'Expense - Travel', 200, 'Expense', 'INR', 6, 9, 9, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (544, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 9, 9, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (545, 'Expense - Utilities', 500, 'Expense', 'INR', 9, 9, 9, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (546, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 9, 9, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (547, 'Expense - Utilities', 400, 'Expense', 'INR', 9, 9, 9, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (548, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 9, 9, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (549, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 9, 9, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (550, 'Expense - Travel', 200, 'Expense', 'INR', 6, 9, 9, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (551, 'Expense - Housing', 1700, 'Expense', 'INR', 3, 9, 9, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (552, 'Expense - Housing', 200, 'Expense', 'INR', 3, 9, 9, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (553, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 9, 9, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (554, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 9, 9, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (555, 'Expense - Travel', 200, 'Expense', 'INR', 6, 9, 9, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (556, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 9, 9, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (557, 'Expense - Housing', 200, 'Expense', 'INR', 3, 10, 10, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (558, 'Expense - Travel', 200, 'Expense', 'INR', 6, 10, 10, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (559, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 10, 10, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (560, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 10, 10, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (561, 'Expense - Housing', 200, 'Expense', 'INR', 3, 10, 10, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (562, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 10, 10, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (563, 'Expense - Housing', 200, 'Expense', 'INR', 3, 10, 10, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (564, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 10, 10, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (565, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 10, 10, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (566, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 10, 10, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (567, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 10, 10, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (568, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 10, 10, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (569, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 10, 10, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (570, 'Expense - Housing', 200, 'Expense', 'INR', 3, 10, 10, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (571, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 10, 10, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (572, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 10, 10, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (573, 'Expense - Education', 200, 'Expense', 'INR', 8, 10, 10, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (574, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 10, 10, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (575, 'Expense - Travel', 200, 'Expense', 'INR', 6, 10, 10, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (576, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 10, 10, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (577, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 10, 10, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (578, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 10, 10, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (579, 'Expense - Housing', 200, 'Expense', 'INR', 3, 10, 10, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (580, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 10, 10, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (581, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 10, 10, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (582, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 10, 10, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (583, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 10, 10, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (584, 'Expense - Housing', 500, 'Expense', 'INR', 3, 10, 10, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (585, 'Expense - Housing', 200, 'Expense', 'INR', 3, 10, 10, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (586, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 10, 10, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (587, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 10, 10, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (588, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 10, 10, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (589, 'Expense - Education', 200, 'Expense', 'INR', 8, 10, 10, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (590, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 10, 10, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (591, 'Expense - Travel', 200, 'Expense', 'INR', 6, 10, 10, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (592, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 10, 10, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (593, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 10, 10, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (594, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 10, 10, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (595, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 10, 10, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (596, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 10, 10, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (597, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 10, 10, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (598, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 10, 10, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (599, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 10, 10, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (600, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 10, 10, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (601, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 10, 10, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (602, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 10, 10, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (603, 'Expense - Travel', 200, 'Expense', 'INR', 6, 10, 10, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (604, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 10, 10, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (605, 'Expense - Housing', 200, 'Expense', 'INR', 3, 10, 10, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (606, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 10, 10, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (607, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 10, 10, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (608, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 10, 10, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (609, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 10, 10, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (610, 'Expense - Housing', 300, 'Expense', 'INR', 3, 10, 10, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (611, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 10, 10, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (612, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 10, 10, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (613, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 10, 10, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (614, 'Expense - Food & Dining', 600, 'Expense', 'INR', 1, 10, 10, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (615, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 10, 10, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (616, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 10, 10, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (617, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 10, 10, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (618, 'Expense - Housing', 400, 'Expense', 'INR', 3, 10, 10, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (619, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 10, 10, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (620, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 10, 10, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (621, 'Expense - Housing', 200, 'Expense', 'INR', 3, 10, 10, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (622, 'Expense - Travel', 200, 'Expense', 'INR', 6, 10, 10, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (623, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 10, 10, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (624, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 10, 10, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (625, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 10, 10, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (626, 'Expense - Travel', 200, 'Expense', 'INR', 6, 10, 10, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (627, 'Expense - Healthcare', 400, 'Expense', 'INR', 4, 10, 10, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (628, 'Expense - Travel', 200, 'Expense', 'INR', 6, 10, 10, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (629, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 10, 10, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (630, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 10, 10, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (631, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 10, 10, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (632, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 10, 10, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (633, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 10, 10, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (634, 'Expense - Education', 200, 'Expense', 'INR', 8, 11, 11, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (635, 'Expense - Transportation', 500, 'Expense', 'INR', 2, 11, 11, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (636, 'Expense - Food & Dining', 1200, 'Expense', 'INR', 1, 11, 11, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (637, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 11, 11, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (638, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 11, 11, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (639, 'Expense - Housing', 200, 'Expense', 'INR', 3, 11, 11, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (640, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 11, 11, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (641, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 11, 11, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (642, 'Expense - Travel', 300, 'Expense', 'INR', 6, 11, 11, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (643, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 11, 11, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (644, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 11, 11, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (645, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 11, 11, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (646, 'Expense - Travel', 200, 'Expense', 'INR', 6, 11, 11, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (647, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 11, 11, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (648, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 11, 11, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (649, 'Expense - Housing', 300, 'Expense', 'INR', 3, 11, 11, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (650, 'Expense - Travel', 200, 'Expense', 'INR', 6, 11, 11, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (651, 'Expense - Education', 200, 'Expense', 'INR', 8, 11, 11, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (652, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 11, 11, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (653, 'Expense - Housing', 300, 'Expense', 'INR', 3, 11, 11, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (654, 'Expense - Food & Dining', 800, 'Expense', 'INR', 1, 11, 11, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (655, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 11, 11, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (656, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 11, 11, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (657, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 11, 11, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (658, 'Expense - Entertainment', 300, 'Expense', 'INR', 5, 11, 11, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (659, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 11, 11, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (660, 'Expense - Housing', 900, 'Expense', 'INR', 3, 11, 11, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (661, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 11, 11, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (662, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 11, 11, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (663, 'Expense - Education', 200, 'Expense', 'INR', 8, 11, 11, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (664, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 11, 11, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (665, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 11, 11, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (666, 'Expense - Education', 200, 'Expense', 'INR', 8, 11, 11, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (667, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 11, 11, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (668, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 11, 11, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (669, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 11, 11, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (670, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 11, 11, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (671, 'Expense - Housing', 800, 'Expense', 'INR', 3, 11, 11, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (672, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 11, 11, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (673, 'Expense - Education', 200, 'Expense', 'INR', 8, 11, 11, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (674, 'Expense - Travel', 200, 'Expense', 'INR', 6, 11, 11, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (675, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 11, 11, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (676, 'Expense - Housing', 600, 'Expense', 'INR', 3, 11, 11, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (677, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 11, 11, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (678, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 11, 11, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (679, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 11, 11, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (680, 'Expense - Travel', 200, 'Expense', 'INR', 6, 11, 11, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (681, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 11, 11, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (682, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 11, 11, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (683, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 11, 11, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (684, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 11, 11, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (685, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 11, 11, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (686, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 11, 11, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (687, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 11, 11, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (688, 'Expense - Travel', 200, 'Expense', 'INR', 6, 11, 11, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (689, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 11, 11, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (690, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 11, 11, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (691, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 11, 11, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (692, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 11, 11, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (693, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 11, 11, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (694, 'Expense - Utilities', 500, 'Expense', 'INR', 9, 11, 11, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (695, 'Expense - Housing', 200, 'Expense', 'INR', 3, 11, 11, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (696, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 11, 11, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (697, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 11, 11, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (698, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 11, 11, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (699, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 11, 11, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (700, 'Expense - Travel', 200, 'Expense', 'INR', 6, 11, 11, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (701, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 11, 11, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (702, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 11, 11, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (703, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 12, 12, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (704, 'Expense - Housing', 200, 'Expense', 'INR', 3, 12, 12, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (705, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 12, 12, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (706, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 12, 12, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (707, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 12, 12, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (708, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 12, 12, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (709, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 12, 12, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (710, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 12, 12, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (711, 'Expense - Education', 200, 'Expense', 'INR', 8, 12, 12, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (712, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 12, 12, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (713, 'Expense - Education', 200, 'Expense', 'INR', 8, 12, 12, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (714, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 12, 12, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (715, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 12, 12, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (716, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 12, 12, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (717, 'Expense - Education', 200, 'Expense', 'INR', 8, 12, 12, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (718, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 12, 12, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (719, 'Expense - Travel', 200, 'Expense', 'INR', 6, 12, 12, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (720, 'Expense - Housing', 200, 'Expense', 'INR', 3, 12, 12, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (721, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 12, 12, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (722, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 12, 12, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (723, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 12, 12, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (724, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 12, 12, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (725, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 12, 12, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (726, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 12, 12, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (727, 'Expense - Food & Dining', 1100, 'Expense', 'INR', 1, 12, 12, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (728, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 12, 12, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (729, 'Expense - Housing', 1100, 'Expense', 'INR', 3, 12, 12, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (730, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 12, 12, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (731, 'Expense - Education', 200, 'Expense', 'INR', 8, 12, 12, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (732, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 12, 12, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (733, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 12, 12, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (734, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 12, 12, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (735, 'Expense - Travel', 200, 'Expense', 'INR', 6, 12, 12, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (736, 'Expense - Travel', 200, 'Expense', 'INR', 6, 12, 12, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (737, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 12, 12, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (738, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 12, 12, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (739, 'Expense - Travel', 200, 'Expense', 'INR', 6, 12, 12, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (740, 'Expense - Travel', 200, 'Expense', 'INR', 6, 12, 12, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (741, 'Expense - Housing', 500, 'Expense', 'INR', 3, 12, 12, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (742, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 12, 12, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (743, 'Expense - Housing', 200, 'Expense', 'INR', 3, 12, 12, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (744, 'Expense - Travel', 200, 'Expense', 'INR', 6, 12, 12, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (745, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 12, 12, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (746, 'Expense - Education', 200, 'Expense', 'INR', 8, 12, 12, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (747, 'Expense - Food & Dining', 800, 'Expense', 'INR', 1, 12, 12, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (748, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 12, 12, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (749, 'Expense - Education', 200, 'Expense', 'INR', 8, 12, 12, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (750, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 12, 12, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (751, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 12, 12, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (752, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 12, 12, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (753, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 12, 12, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (754, 'Expense - Travel', 200, 'Expense', 'INR', 6, 12, 12, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (755, 'Expense - Shopping', 400, 'Expense', 'INR', 7, 12, 12, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (756, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 12, 12, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (757, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 12, 12, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (758, 'Expense - Travel', 200, 'Expense', 'INR', 6, 12, 12, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (759, 'Expense - Utilities', 400, 'Expense', 'INR', 9, 12, 12, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (760, 'Expense - Travel', 200, 'Expense', 'INR', 6, 12, 12, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (761, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 12, 12, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (762, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 12, 12, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (763, 'Expense - Education', 200, 'Expense', 'INR', 8, 13, 13, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (764, 'Expense - Education', 200, 'Expense', 'INR', 8, 13, 13, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (765, 'Expense - Travel', 200, 'Expense', 'INR', 6, 13, 13, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (766, 'Expense - Travel', 200, 'Expense', 'INR', 6, 13, 13, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (767, 'Expense - Education', 200, 'Expense', 'INR', 8, 13, 13, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (768, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 13, 13, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (769, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 13, 13, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (770, 'Expense - Housing', 600, 'Expense', 'INR', 3, 13, 13, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (771, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 13, 13, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (772, 'Expense - Education', 200, 'Expense', 'INR', 8, 13, 13, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (773, 'Expense - Travel', 200, 'Expense', 'INR', 6, 13, 13, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (774, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 13, 13, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (775, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 13, 13, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (776, 'Expense - Housing', 800, 'Expense', 'INR', 3, 13, 13, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (777, 'Expense - Utilities', 500, 'Expense', 'INR', 9, 13, 13, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (778, 'Expense - Education', 200, 'Expense', 'INR', 8, 13, 13, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (779, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 13, 13, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (780, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 13, 13, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (781, 'Expense - Housing', 200, 'Expense', 'INR', 3, 13, 13, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (782, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 13, 13, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (783, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 13, 13, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (784, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 13, 13, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (785, 'Expense - Travel', 200, 'Expense', 'INR', 6, 13, 13, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (786, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 13, 13, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (787, 'Expense - Education', 200, 'Expense', 'INR', 8, 13, 13, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (788, 'Expense - Travel', 200, 'Expense', 'INR', 6, 13, 13, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (789, 'Expense - Housing', 1400, 'Expense', 'INR', 3, 13, 13, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (790, 'Expense - Travel', 200, 'Expense', 'INR', 6, 13, 13, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (791, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 13, 13, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (792, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 13, 13, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (793, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 13, 13, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (794, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 13, 13, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (795, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 13, 13, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (796, 'Expense - Education', 200, 'Expense', 'INR', 8, 13, 13, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (797, 'Expense - Travel', 200, 'Expense', 'INR', 6, 13, 13, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (798, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 13, 13, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (799, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 14, 14, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (800, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 14, 14, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (801, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 14, 14, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (802, 'Expense - Education', 200, 'Expense', 'INR', 8, 14, 14, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (803, 'Expense - Housing', 300, 'Expense', 'INR', 3, 14, 14, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (804, 'Expense - Housing', 600, 'Expense', 'INR', 3, 14, 14, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (805, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 14, 14, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (806, 'Expense - Housing', 200, 'Expense', 'INR', 3, 14, 14, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (807, 'Expense - Healthcare', 400, 'Expense', 'INR', 4, 14, 14, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (808, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 14, 14, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (809, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 14, 14, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (810, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 14, 14, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (811, 'Expense - Food & Dining', 600, 'Expense', 'INR', 1, 14, 14, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (812, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 14, 14, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (813, 'Expense - Education', 200, 'Expense', 'INR', 8, 14, 14, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (814, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 14, 14, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (815, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 14, 14, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (816, 'Expense - Housing', 600, 'Expense', 'INR', 3, 14, 14, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (817, 'Expense - Healthcare', 300, 'Expense', 'INR', 4, 14, 14, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (818, 'Expense - Housing', 2200, 'Expense', 'INR', 3, 14, 14, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (819, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 14, 14, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (820, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 14, 14, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (821, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 14, 14, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (822, 'Expense - Education', 200, 'Expense', 'INR', 8, 14, 14, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (823, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 14, 14, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (824, 'Expense - Education', 200, 'Expense', 'INR', 8, 14, 14, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (825, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 14, 14, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (826, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 14, 14, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (827, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 14, 14, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (828, 'Expense - Housing', 800, 'Expense', 'INR', 3, 14, 14, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (829, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 14, 14, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (830, 'Expense - Education', 200, 'Expense', 'INR', 8, 14, 14, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (831, 'Expense - Housing', 500, 'Expense', 'INR', 3, 14, 14, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (832, 'Expense - Entertainment', 300, 'Expense', 'INR', 5, 14, 14, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (833, 'Expense - Education', 200, 'Expense', 'INR', 8, 14, 14, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (834, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 14, 14, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (835, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 14, 14, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (836, 'Expense - Transportation', 700, 'Expense', 'INR', 2, 14, 14, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (837, 'Expense - Travel', 300, 'Expense', 'INR', 6, 14, 14, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (838, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 14, 14, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (839, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 14, 14, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (840, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 14, 14, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (841, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 14, 14, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (842, 'Expense - Transportation', 700, 'Expense', 'INR', 2, 14, 14, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (843, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 14, 14, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (844, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 14, 14, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (845, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 14, 14, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (846, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 14, 14, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (847, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 14, 14, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (848, 'Expense - Travel', 200, 'Expense', 'INR', 6, 14, 14, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (849, 'Expense - Transportation', 600, 'Expense', 'INR', 2, 14, 14, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (850, 'Expense - Housing', 2200, 'Expense', 'INR', 3, 14, 14, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (851, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 14, 14, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (852, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 14, 14, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (853, 'Expense - Travel', 200, 'Expense', 'INR', 6, 14, 14, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (854, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 14, 14, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (855, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 14, 14, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (856, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 14, 14, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (857, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 14, 14, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (858, 'Expense - Education', 200, 'Expense', 'INR', 8, 14, 14, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (859, 'Expense - Housing', 400, 'Expense', 'INR', 3, 14, 14, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (860, 'Expense - Housing', 1400, 'Expense', 'INR', 3, 14, 14, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (861, 'Expense - Education', 200, 'Expense', 'INR', 8, 14, 14, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (862, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 14, 14, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (863, 'Expense - Housing', 600, 'Expense', 'INR', 3, 14, 14, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (864, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 14, 14, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (865, 'Expense - Education', 200, 'Expense', 'INR', 8, 14, 14, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (866, 'Expense - Education', 300, 'Expense', 'INR', 8, 14, 14, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (867, 'Expense - Travel', 200, 'Expense', 'INR', 6, 14, 14, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (868, 'Expense - Travel', 200, 'Expense', 'INR', 6, 14, 14, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (869, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 14, 14, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (870, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 14, 14, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (871, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 14, 14, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (872, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 14, 14, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (873, 'Expense - Travel', 200, 'Expense', 'INR', 6, 14, 14, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (874, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 14, 14, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (875, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 15, 15, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (876, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 15, 15, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (877, 'Expense - Healthcare', 500, 'Expense', 'INR', 4, 15, 15, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (878, 'Expense - Housing', 1100, 'Expense', 'INR', 3, 15, 15, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (879, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 15, 15, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (880, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 15, 15, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (881, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 15, 15, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (882, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 15, 15, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (883, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 15, 15, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (884, 'Expense - Travel', 200, 'Expense', 'INR', 6, 15, 15, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (885, 'Expense - Housing', 700, 'Expense', 'INR', 3, 15, 15, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (886, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 15, 15, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (887, 'Expense - Transportation', 600, 'Expense', 'INR', 2, 15, 15, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (888, 'Expense - Entertainment', 400, 'Expense', 'INR', 5, 15, 15, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (889, 'Expense - Shopping', 500, 'Expense', 'INR', 7, 15, 15, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (890, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 15, 15, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (891, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 15, 15, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (892, 'Expense - Travel', 400, 'Expense', 'INR', 6, 15, 15, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (893, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 15, 15, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (894, 'Expense - Travel', 200, 'Expense', 'INR', 6, 15, 15, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (895, 'Expense - Travel', 200, 'Expense', 'INR', 6, 15, 15, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (896, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 15, 15, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (897, 'Expense - Travel', 200, 'Expense', 'INR', 6, 15, 15, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (898, 'Expense - Food & Dining', 2100, 'Expense', 'INR', 1, 15, 15, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (899, 'Expense - Travel', 200, 'Expense', 'INR', 6, 15, 15, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (900, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 15, 15, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (901, 'Expense - Housing', 500, 'Expense', 'INR', 3, 15, 15, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (902, 'Expense - Housing', 900, 'Expense', 'INR', 3, 15, 15, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (903, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 15, 15, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (904, 'Expense - Travel', 200, 'Expense', 'INR', 6, 15, 15, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (905, 'Expense - Entertainment', 400, 'Expense', 'INR', 5, 15, 15, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (906, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 15, 15, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (907, 'Expense - Travel', 200, 'Expense', 'INR', 6, 15, 15, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (908, 'Expense - Housing', 300, 'Expense', 'INR', 3, 15, 15, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (909, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 15, 15, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (910, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 15, 15, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (911, 'Expense - Education', 200, 'Expense', 'INR', 8, 15, 15, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (912, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 15, 15, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (913, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 15, 15, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (914, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 15, 15, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (915, 'Expense - Travel', 200, 'Expense', 'INR', 6, 15, 15, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (916, 'Expense - Shopping', 500, 'Expense', 'INR', 7, 15, 15, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (917, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 15, 15, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (918, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 15, 15, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (919, 'Expense - Food & Dining', 900, 'Expense', 'INR', 1, 15, 15, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (920, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 15, 15, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (921, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 16, 16, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (922, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 16, 16, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (923, 'Expense - Education', 200, 'Expense', 'INR', 8, 16, 16, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (924, 'Expense - Travel', 200, 'Expense', 'INR', 6, 16, 16, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (925, 'Expense - Education', 200, 'Expense', 'INR', 8, 16, 16, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (926, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 16, 16, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (927, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 16, 16, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (928, 'Expense - Housing', 1200, 'Expense', 'INR', 3, 16, 16, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (929, 'Expense - Healthcare', 300, 'Expense', 'INR', 4, 16, 16, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (930, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 16, 16, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (931, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 16, 16, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (932, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 16, 16, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (933, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 16, 16, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (934, 'Expense - Education', 500, 'Expense', 'INR', 8, 16, 16, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (935, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 16, 16, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (936, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 16, 16, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (937, 'Expense - Transportation', 800, 'Expense', 'INR', 2, 16, 16, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (938, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 16, 16, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (939, 'Expense - Education', 200, 'Expense', 'INR', 8, 16, 16, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (940, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 16, 16, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (941, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 16, 16, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (942, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 16, 16, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (943, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 16, 16, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (944, 'Expense - Food & Dining', 900, 'Expense', 'INR', 1, 16, 16, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (945, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 16, 16, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (946, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 16, 16, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (947, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 16, 16, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (948, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 16, 16, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (949, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 16, 16, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (950, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 16, 16, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (951, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 16, 16, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (952, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 16, 16, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (953, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 16, 16, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (954, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 16, 16, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (955, 'Expense - Entertainment', 300, 'Expense', 'INR', 5, 16, 16, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (956, 'Expense - Education', 200, 'Expense', 'INR', 8, 16, 16, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (957, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 16, 16, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (958, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 16, 16, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (959, 'Expense - Education', 200, 'Expense', 'INR', 8, 16, 16, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (960, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 16, 16, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (961, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 16, 16, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (962, 'Expense - Housing', 1200, 'Expense', 'INR', 3, 16, 16, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (963, 'Expense - Housing', 1600, 'Expense', 'INR', 3, 16, 16, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (964, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 16, 16, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (965, 'Expense - Healthcare', 300, 'Expense', 'INR', 4, 16, 16, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (966, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 16, 16, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (967, 'Expense - Education', 200, 'Expense', 'INR', 8, 16, 16, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (968, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 16, 16, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (969, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 17, 17, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (970, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 17, 17, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (971, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 17, 17, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (972, 'Expense - Transportation', 400, 'Expense', 'INR', 2, 17, 17, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (973, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 17, 17, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (974, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 17, 17, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (975, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 17, 17, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (976, 'Expense - Housing', 200, 'Expense', 'INR', 3, 17, 17, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (977, 'Expense - Travel', 200, 'Expense', 'INR', 6, 17, 17, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (978, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 17, 17, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (979, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 17, 17, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (980, 'Expense - Food & Dining', 1100, 'Expense', 'INR', 1, 17, 17, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (981, 'Expense - Education', 200, 'Expense', 'INR', 8, 17, 17, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (982, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 17, 17, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (983, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 17, 17, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (984, 'Expense - Education', 200, 'Expense', 'INR', 8, 17, 17, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (985, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 17, 17, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (986, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 17, 17, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (987, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 17, 17, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (988, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 17, 17, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (989, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 17, 17, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (990, 'Expense - Education', 200, 'Expense', 'INR', 8, 17, 17, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (991, 'Expense - Housing', 500, 'Expense', 'INR', 3, 17, 17, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (992, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 17, 17, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (993, 'Expense - Education', 200, 'Expense', 'INR', 8, 17, 17, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (994, 'Expense - Housing', 300, 'Expense', 'INR', 3, 17, 17, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (995, 'Expense - Education', 200, 'Expense', 'INR', 8, 17, 17, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (996, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 17, 17, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (997, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 17, 17, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (998, 'Expense - Education', 200, 'Expense', 'INR', 8, 17, 17, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (999, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 17, 17, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1000, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 17, 17, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1001, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 17, 17, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1002, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 17, 17, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1003, 'Expense - Travel', 200, 'Expense', 'INR', 6, 17, 17, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1004, 'Expense - Food & Dining', 900, 'Expense', 'INR', 1, 17, 17, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1005, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 17, 17, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1006, 'Expense - Housing', 200, 'Expense', 'INR', 3, 17, 17, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1007, 'Expense - Travel', 200, 'Expense', 'INR', 6, 17, 17, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1008, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 17, 17, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1009, 'Expense - Housing', 200, 'Expense', 'INR', 3, 17, 17, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1010, 'Expense - Housing', 500, 'Expense', 'INR', 3, 17, 17, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1011, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 17, 17, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1012, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 17, 17, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1013, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 17, 17, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1014, 'Expense - Housing', 400, 'Expense', 'INR', 3, 17, 17, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1015, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 17, 17, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1016, 'Expense - Housing', 1200, 'Expense', 'INR', 3, 17, 17, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1017, 'Expense - Travel', 200, 'Expense', 'INR', 6, 17, 17, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1018, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 17, 17, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1019, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 17, 17, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1020, 'Expense - Miscellaneous', 300, 'Expense', 'INR', 10, 17, 17, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1021, 'Expense - Education', 200, 'Expense', 'INR', 8, 17, 17, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1022, 'Expense - Education', 200, 'Expense', 'INR', 8, 17, 17, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1023, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 17, 17, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1024, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 17, 17, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1025, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 17, 17, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1026, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 17, 17, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1027, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 17, 17, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1028, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 17, 17, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1029, 'Expense - Housing', 200, 'Expense', 'INR', 3, 17, 17, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1030, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 17, 17, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1031, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 17, 17, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1032, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 17, 17, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1033, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 17, 17, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1034, 'Expense - Housing', 200, 'Expense', 'INR', 3, 17, 17, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1035, 'Expense - Housing', 200, 'Expense', 'INR', 3, 17, 17, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1036, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 17, 17, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1037, 'Expense - Education', 200, 'Expense', 'INR', 8, 17, 17, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1038, 'Expense - Education', 200, 'Expense', 'INR', 8, 17, 17, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1039, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 17, 17, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1040, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 17, 17, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1041, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 17, 17, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1042, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 17, 17, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1043, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 17, 17, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1044, 'Expense - Education', 200, 'Expense', 'INR', 8, 17, 17, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1045, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 17, 17, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1046, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 17, 17, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1047, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 17, 17, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1048, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 17, 17, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1049, 'Expense - Education', 200, 'Expense', 'INR', 8, 17, 17, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1050, 'Expense - Housing', 200, 'Expense', 'INR', 3, 17, 17, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1051, 'Expense - Housing', 500, 'Expense', 'INR', 3, 17, 17, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1052, 'Expense - Travel', 200, 'Expense', 'INR', 6, 18, 18, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1053, 'Expense - Transportation', 400, 'Expense', 'INR', 2, 18, 18, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1054, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 18, 18, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1055, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 18, 18, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1056, 'Expense - Travel', 200, 'Expense', 'INR', 6, 18, 18, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1057, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 18, 18, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1058, 'Expense - Transportation', 1000, 'Expense', 'INR', 2, 18, 18, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1059, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 18, 18, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1060, 'Expense - Education', 200, 'Expense', 'INR', 8, 18, 18, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1061, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 18, 18, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1062, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 18, 18, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1063, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 18, 18, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1064, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 18, 18, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1065, 'Expense - Housing', 200, 'Expense', 'INR', 3, 18, 18, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1066, 'Expense - Housing', 1600, 'Expense', 'INR', 3, 18, 18, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1067, 'Expense - Housing', 1100, 'Expense', 'INR', 3, 18, 18, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1068, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 18, 18, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1069, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 18, 18, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1070, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 18, 18, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1071, 'Expense - Housing', 500, 'Expense', 'INR', 3, 18, 18, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1072, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 18, 18, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1073, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 18, 18, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1074, 'Expense - Transportation', 700, 'Expense', 'INR', 2, 18, 18, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1075, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 18, 18, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1076, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 18, 18, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1077, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 18, 18, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1078, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 18, 18, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1079, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 18, 18, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1080, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 18, 18, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1081, 'Expense - Education', 200, 'Expense', 'INR', 8, 18, 18, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1082, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 18, 18, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1083, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 18, 18, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1084, 'Expense - Education', 300, 'Expense', 'INR', 8, 18, 18, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1085, 'Expense - Shopping', 600, 'Expense', 'INR', 7, 18, 18, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1086, 'Expense - Healthcare', 300, 'Expense', 'INR', 4, 18, 18, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1087, 'Expense - Education', 200, 'Expense', 'INR', 8, 18, 18, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1088, 'Expense - Housing', 500, 'Expense', 'INR', 3, 18, 18, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1089, 'Expense - Healthcare', 400, 'Expense', 'INR', 4, 18, 18, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1090, 'Expense - Food & Dining', 700, 'Expense', 'INR', 1, 18, 18, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1091, 'Expense - Housing', 2000, 'Expense', 'INR', 3, 18, 18, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1092, 'Expense - Healthcare', 300, 'Expense', 'INR', 4, 19, 19, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1093, 'Expense - Travel', 200, 'Expense', 'INR', 6, 19, 19, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1094, 'Expense - Housing', 2500, 'Expense', 'INR', 3, 19, 19, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1095, 'Expense - Travel', 200, 'Expense', 'INR', 6, 19, 19, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1096, 'Expense - Travel', 200, 'Expense', 'INR', 6, 19, 19, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1097, 'Expense - Healthcare', 400, 'Expense', 'INR', 4, 19, 19, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1098, 'Expense - Travel', 200, 'Expense', 'INR', 6, 19, 19, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1099, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 19, 19, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1100, 'Expense - Education', 200, 'Expense', 'INR', 8, 19, 19, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1101, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 19, 19, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1102, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 19, 19, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1103, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 19, 19, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1104, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 19, 19, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1105, 'Expense - Education', 200, 'Expense', 'INR', 8, 19, 19, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1106, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 19, 19, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1107, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 19, 19, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1108, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 19, 19, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1109, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 19, 19, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1110, 'Expense - Travel', 200, 'Expense', 'INR', 6, 19, 19, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1111, 'Expense - Housing', 200, 'Expense', 'INR', 3, 19, 19, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1112, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 19, 19, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1113, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 19, 19, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1114, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 19, 19, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1115, 'Expense - Travel', 200, 'Expense', 'INR', 6, 19, 19, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1116, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 19, 19, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1117, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 19, 19, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1118, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 19, 19, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1119, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 19, 19, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1120, 'Expense - Housing', 800, 'Expense', 'INR', 3, 19, 19, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1121, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 19, 19, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1122, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 19, 19, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1123, 'Expense - Travel', 300, 'Expense', 'INR', 6, 19, 19, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1124, 'Expense - Housing', 500, 'Expense', 'INR', 3, 19, 19, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1125, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 19, 19, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1126, 'Expense - Education', 200, 'Expense', 'INR', 8, 19, 19, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1127, 'Expense - Housing', 400, 'Expense', 'INR', 3, 19, 19, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1128, 'Expense - Transportation', 400, 'Expense', 'INR', 2, 19, 19, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1129, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 19, 19, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1130, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 19, 19, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1131, 'Expense - Travel', 200, 'Expense', 'INR', 6, 19, 19, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1132, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 20, 20, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1133, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 20, 20, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1134, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 20, 20, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1135, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 20, 20, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1136, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 20, 20, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1137, 'Expense - Education', 200, 'Expense', 'INR', 8, 20, 20, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1138, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 20, 20, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1139, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 20, 20, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1140, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 20, 20, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1141, 'Expense - Shopping', 400, 'Expense', 'INR', 7, 20, 20, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1142, 'Expense - Travel', 200, 'Expense', 'INR', 6, 20, 20, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1143, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 20, 20, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1144, 'Expense - Travel', 200, 'Expense', 'INR', 6, 20, 20, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1145, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 20, 20, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1146, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 20, 20, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1147, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 20, 20, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1148, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 20, 20, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1149, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 20, 20, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1150, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 20, 20, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1151, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 20, 20, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1152, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 20, 20, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1153, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 20, 20, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1154, 'Expense - Housing', 200, 'Expense', 'INR', 3, 20, 20, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1155, 'Expense - Education', 200, 'Expense', 'INR', 8, 20, 20, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1156, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 20, 20, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1157, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 20, 20, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1158, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 20, 20, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1159, 'Expense - Education', 200, 'Expense', 'INR', 8, 20, 20, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1160, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 20, 20, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1161, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 20, 20, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1162, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 20, 20, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1163, 'Expense - Travel', 200, 'Expense', 'INR', 6, 20, 20, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1164, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 20, 20, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1165, 'Expense - Travel', 200, 'Expense', 'INR', 6, 20, 20, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1166, 'Expense - Housing', 200, 'Expense', 'INR', 3, 20, 20, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1167, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 20, 20, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1168, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 20, 20, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1169, 'Expense - Travel', 200, 'Expense', 'INR', 6, 20, 20, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1170, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 20, 20, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1171, 'Expense - Education', 200, 'Expense', 'INR', 8, 20, 20, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1172, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 20, 20, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1173, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 20, 20, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1174, 'Expense - Housing', 300, 'Expense', 'INR', 3, 20, 20, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1175, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 20, 20, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1176, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 20, 20, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1177, 'Expense - Travel', 200, 'Expense', 'INR', 6, 20, 20, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1178, 'Expense - Travel', 200, 'Expense', 'INR', 6, 20, 20, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1179, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 20, 20, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1180, 'Expense - Travel', 200, 'Expense', 'INR', 6, 20, 20, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1181, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 20, 20, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1182, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 20, 20, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1183, 'Expense - Housing', 200, 'Expense', 'INR', 3, 20, 20, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1184, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 20, 20, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1185, 'Expense - Housing', 500, 'Expense', 'INR', 3, 20, 20, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1186, 'Expense - Housing', 600, 'Expense', 'INR', 3, 20, 20, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1187, 'Expense - Travel', 200, 'Expense', 'INR', 6, 20, 20, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1188, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 20, 20, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1189, 'Expense - Education', 200, 'Expense', 'INR', 8, 20, 20, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1190, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 20, 20, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1191, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 20, 20, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1192, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 20, 20, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1193, 'Expense - Education', 200, 'Expense', 'INR', 8, 20, 20, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1194, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 20, 20, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1195, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 20, 20, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1196, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 20, 20, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1197, 'Expense - Housing', 1500, 'Expense', 'INR', 3, 20, 20, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1198, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 20, 20, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1199, 'Expense - Travel', 200, 'Expense', 'INR', 6, 20, 20, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1200, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 20, 20, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1201, 'Expense - Education', 200, 'Expense', 'INR', 8, 20, 20, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1202, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 20, 20, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1203, 'Expense - Travel', 200, 'Expense', 'INR', 6, 20, 20, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1204, 'Expense - Housing', 500, 'Expense', 'INR', 3, 21, 21, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1205, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 21, 21, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1206, 'Expense - Healthcare', 300, 'Expense', 'INR', 4, 21, 21, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1207, 'Expense - Education', 200, 'Expense', 'INR', 8, 21, 21, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1208, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 21, 21, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1209, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 21, 21, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1210, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 21, 21, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1211, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 21, 21, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1212, 'Expense - Housing', 200, 'Expense', 'INR', 3, 21, 21, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1213, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 21, 21, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1214, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 21, 21, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1215, 'Expense - Utilities', 400, 'Expense', 'INR', 9, 21, 21, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1216, 'Expense - Education', 200, 'Expense', 'INR', 8, 21, 21, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1217, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 21, 21, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1218, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 21, 21, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1219, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 21, 21, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1220, 'Expense - Education', 200, 'Expense', 'INR', 8, 21, 21, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1221, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 21, 21, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1222, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 21, 21, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1223, 'Expense - Education', 200, 'Expense', 'INR', 8, 21, 21, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1224, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 21, 21, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1225, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 21, 21, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1226, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 21, 21, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1227, 'Expense - Food & Dining', 1100, 'Expense', 'INR', 1, 21, 21, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1228, 'Expense - Housing', 1000, 'Expense', 'INR', 3, 21, 21, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1229, 'Expense - Housing', 2100, 'Expense', 'INR', 3, 21, 21, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1230, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 21, 21, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1231, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 21, 21, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1232, 'Expense - Travel', 200, 'Expense', 'INR', 6, 21, 21, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1233, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 21, 21, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1234, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 21, 21, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1235, 'Expense - Housing', 200, 'Expense', 'INR', 3, 21, 21, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1236, 'Expense - Travel', 200, 'Expense', 'INR', 6, 21, 21, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1237, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 21, 21, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1238, 'Expense - Travel', 200, 'Expense', 'INR', 6, 21, 21, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1239, 'Expense - Travel', 200, 'Expense', 'INR', 6, 21, 21, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1240, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 21, 21, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1241, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 21, 21, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1242, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 21, 21, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1243, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 21, 21, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1244, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 21, 21, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1245, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 21, 21, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1246, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 21, 21, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1247, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 21, 21, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1248, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 21, 21, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1249, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 21, 21, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1250, 'Expense - Housing', 800, 'Expense', 'INR', 3, 21, 21, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1251, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 21, 21, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1252, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 21, 21, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1253, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 21, 21, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1254, 'Expense - Travel', 200, 'Expense', 'INR', 6, 21, 21, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1255, 'Expense - Education', 200, 'Expense', 'INR', 8, 21, 21, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1256, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 21, 21, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1257, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 21, 21, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1258, 'Expense - Education', 200, 'Expense', 'INR', 8, 21, 21, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1259, 'Expense - Education', 200, 'Expense', 'INR', 8, 21, 21, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1260, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 21, 21, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1261, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 21, 21, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1262, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 21, 21, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1263, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 21, 21, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1264, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 21, 21, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1265, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 21, 21, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1266, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 21, 21, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1267, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 21, 21, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1268, 'Expense - Housing', 700, 'Expense', 'INR', 3, 21, 21, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1269, 'Expense - Travel', 200, 'Expense', 'INR', 6, 21, 21, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1270, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 21, 21, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1271, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 21, 21, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1272, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 21, 21, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1273, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 21, 21, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1274, 'Expense - Education', 200, 'Expense', 'INR', 8, 21, 21, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1275, 'Expense - Education', 200, 'Expense', 'INR', 8, 21, 21, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1276, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 22, 22, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1277, 'Expense - Education', 400, 'Expense', 'INR', 8, 22, 22, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1278, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 22, 22, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1279, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 22, 22, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1280, 'Expense - Travel', 200, 'Expense', 'INR', 6, 22, 22, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1281, 'Expense - Travel', 200, 'Expense', 'INR', 6, 22, 22, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1282, 'Expense - Education', 200, 'Expense', 'INR', 8, 22, 22, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1283, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 22, 22, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1284, 'Expense - Housing', 400, 'Expense', 'INR', 3, 22, 22, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1285, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 22, 22, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1286, 'Expense - Housing', 400, 'Expense', 'INR', 3, 22, 22, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1287, 'Expense - Housing', 300, 'Expense', 'INR', 3, 22, 22, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1288, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 22, 22, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1289, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 22, 22, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1290, 'Expense - Food & Dining', 1800, 'Expense', 'INR', 1, 22, 22, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1291, 'Expense - Education', 200, 'Expense', 'INR', 8, 22, 22, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1292, 'Expense - Education', 200, 'Expense', 'INR', 8, 22, 22, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1293, 'Expense - Travel', 200, 'Expense', 'INR', 6, 22, 22, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1294, 'Expense - Shopping', 700, 'Expense', 'INR', 7, 22, 22, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1295, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 22, 22, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1296, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 22, 22, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1297, 'Expense - Travel', 200, 'Expense', 'INR', 6, 22, 22, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1298, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 22, 22, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1299, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 22, 22, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1300, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 22, 22, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1301, 'Expense - Education', 200, 'Expense', 'INR', 8, 22, 22, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1302, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 22, 22, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1303, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 22, 22, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1304, 'Expense - Travel', 200, 'Expense', 'INR', 6, 22, 22, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1305, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 22, 22, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1306, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 22, 22, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1307, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 22, 22, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1308, 'Expense - Education', 200, 'Expense', 'INR', 8, 22, 22, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1309, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 22, 22, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1310, 'Expense - Travel', 200, 'Expense', 'INR', 6, 22, 22, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1311, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 22, 22, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1312, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 22, 22, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1313, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 22, 22, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1314, 'Expense - Food & Dining', 700, 'Expense', 'INR', 1, 22, 22, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1315, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 22, 22, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1316, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 22, 22, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1317, 'Expense - Housing', 300, 'Expense', 'INR', 3, 22, 22, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1318, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 22, 22, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1319, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 22, 22, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1320, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 22, 22, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1321, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 22, 22, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1322, 'Expense - Housing', 1300, 'Expense', 'INR', 3, 22, 22, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1323, 'Expense - Travel', 200, 'Expense', 'INR', 6, 22, 22, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1324, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 22, 22, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1325, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 22, 22, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1326, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 22, 22, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1327, 'Expense - Transportation', 400, 'Expense', 'INR', 2, 22, 22, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1328, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 22, 22, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1329, 'Expense - Shopping', 500, 'Expense', 'INR', 7, 22, 22, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1330, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 22, 22, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1331, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 22, 22, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1332, 'Expense - Food & Dining', 2000, 'Expense', 'INR', 1, 22, 22, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1333, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 22, 22, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1334, 'Expense - Transportation', 500, 'Expense', 'INR', 2, 22, 22, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1335, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 22, 22, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1336, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 22, 22, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1337, 'Expense - Housing', 2500, 'Expense', 'INR', 3, 22, 22, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1338, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 23, 23, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1339, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 23, 23, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1340, 'Expense - Education', 200, 'Expense', 'INR', 8, 23, 23, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1341, 'Expense - Education', 200, 'Expense', 'INR', 8, 23, 23, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1342, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 23, 23, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1343, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 23, 23, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1344, 'Expense - Education', 200, 'Expense', 'INR', 8, 23, 23, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1345, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 23, 23, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1346, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 23, 23, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1347, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 23, 23, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1348, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 23, 23, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1349, 'Expense - Food & Dining', 1700, 'Expense', 'INR', 1, 23, 23, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1350, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 23, 23, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1351, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 23, 23, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1352, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 23, 23, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1353, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 23, 23, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1354, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 23, 23, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1355, 'Expense - Housing', 200, 'Expense', 'INR', 3, 23, 23, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1356, 'Expense - Housing', 1100, 'Expense', 'INR', 3, 23, 23, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1357, 'Expense - Travel', 200, 'Expense', 'INR', 6, 23, 23, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1358, 'Expense - Healthcare', 400, 'Expense', 'INR', 4, 23, 23, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1359, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 23, 23, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1360, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 23, 23, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1361, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 23, 23, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1362, 'Expense - Education', 200, 'Expense', 'INR', 8, 23, 23, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1363, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 23, 23, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1364, 'Expense - Housing', 2900, 'Expense', 'INR', 3, 23, 23, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1365, 'Expense - Education', 200, 'Expense', 'INR', 8, 23, 23, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1366, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 23, 23, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1367, 'Expense - Travel', 200, 'Expense', 'INR', 6, 23, 23, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1368, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 23, 23, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1369, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 23, 23, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1370, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 23, 23, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1371, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 23, 23, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1372, 'Expense - Housing', 200, 'Expense', 'INR', 3, 23, 23, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1373, 'Expense - Education', 200, 'Expense', 'INR', 8, 23, 23, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1374, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 23, 23, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1375, 'Expense - Utilities', 600, 'Expense', 'INR', 9, 23, 23, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1376, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 23, 23, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1377, 'Expense - Housing', 2900, 'Expense', 'INR', 3, 23, 23, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1378, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 23, 23, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1379, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 23, 23, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1380, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 23, 23, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1381, 'Expense - Shopping', 600, 'Expense', 'INR', 7, 23, 23, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1382, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 23, 23, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1383, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 24, 24, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1384, 'Expense - Housing', 200, 'Expense', 'INR', 3, 24, 24, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1385, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 24, 24, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1386, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 24, 24, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1387, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 24, 24, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1388, 'Expense - Housing', 400, 'Expense', 'INR', 3, 24, 24, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1389, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 24, 24, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1390, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 24, 24, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1391, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 24, 24, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1392, 'Expense - Education', 200, 'Expense', 'INR', 8, 24, 24, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1393, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 24, 24, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1394, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 24, 24, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1395, 'Expense - Travel', 200, 'Expense', 'INR', 6, 24, 24, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1396, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 24, 24, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1397, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 24, 24, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1398, 'Expense - Education', 200, 'Expense', 'INR', 8, 24, 24, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1399, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 24, 24, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1400, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 24, 24, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1401, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 24, 24, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1402, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 24, 24, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1403, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 24, 24, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1404, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 24, 24, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1405, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 24, 24, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1406, 'Expense - Housing', 200, 'Expense', 'INR', 3, 24, 24, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1407, 'Expense - Housing', 600, 'Expense', 'INR', 3, 24, 24, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1408, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 24, 24, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1409, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 24, 24, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1410, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 24, 24, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1411, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 24, 24, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1412, 'Expense - Housing', 400, 'Expense', 'INR', 3, 24, 24, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1413, 'Expense - Travel', 200, 'Expense', 'INR', 6, 24, 24, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1414, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 24, 24, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1415, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 24, 24, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1416, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 24, 24, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1417, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 24, 24, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1418, 'Expense - Housing', 700, 'Expense', 'INR', 3, 24, 24, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1419, 'Expense - Housing', 200, 'Expense', 'INR', 3, 24, 24, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1420, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 24, 24, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1421, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 24, 24, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1422, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 24, 24, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1423, 'Expense - Education', 200, 'Expense', 'INR', 8, 24, 24, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1424, 'Expense - Travel', 200, 'Expense', 'INR', 6, 25, 25, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1425, 'Expense - Education', 200, 'Expense', 'INR', 8, 25, 25, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1426, 'Expense - Travel', 200, 'Expense', 'INR', 6, 25, 25, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1427, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 25, 25, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1428, 'Expense - Housing', 500, 'Expense', 'INR', 3, 25, 25, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1429, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 25, 25, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1430, 'Expense - Education', 300, 'Expense', 'INR', 8, 25, 25, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1431, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 25, 25, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1432, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 25, 25, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1433, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 25, 25, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1434, 'Expense - Healthcare', 300, 'Expense', 'INR', 4, 25, 25, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1435, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 25, 25, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1436, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 25, 25, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1437, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 25, 25, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1438, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 25, 25, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1439, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 25, 25, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1440, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 25, 25, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1441, 'Expense - Food & Dining', 2200, 'Expense', 'INR', 1, 25, 25, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1442, 'Expense - Travel', 200, 'Expense', 'INR', 6, 25, 25, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1443, 'Expense - Housing', 700, 'Expense', 'INR', 3, 25, 25, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1444, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 25, 25, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1445, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 25, 25, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1446, 'Expense - Healthcare', 400, 'Expense', 'INR', 4, 25, 25, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1447, 'Expense - Healthcare', 600, 'Expense', 'INR', 4, 25, 25, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1448, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 25, 25, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1449, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 25, 25, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1450, 'Expense - Travel', 200, 'Expense', 'INR', 6, 25, 25, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1451, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 25, 25, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1452, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 25, 25, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1453, 'Expense - Travel', 200, 'Expense', 'INR', 6, 25, 25, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1454, 'Expense - Housing', 800, 'Expense', 'INR', 3, 25, 25, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1455, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 25, 25, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1456, 'Expense - Education', 400, 'Expense', 'INR', 8, 25, 25, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1457, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 25, 25, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1458, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 25, 25, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1459, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 25, 25, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1460, 'Expense - Entertainment', 500, 'Expense', 'INR', 5, 25, 25, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1461, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 25, 25, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1462, 'Expense - Travel', 200, 'Expense', 'INR', 6, 25, 25, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1463, 'Expense - Travel', 200, 'Expense', 'INR', 6, 25, 25, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1464, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 25, 25, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1465, 'Expense - Food & Dining', 700, 'Expense', 'INR', 1, 25, 25, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1466, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 25, 25, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1467, 'Expense - Education', 200, 'Expense', 'INR', 8, 25, 25, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1468, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 25, 25, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1469, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 25, 25, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1470, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 25, 25, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1471, 'Expense - Travel', 200, 'Expense', 'INR', 6, 25, 25, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1472, 'Expense - Travel', 200, 'Expense', 'INR', 6, 25, 25, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1473, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 25, 25, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1474, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 25, 25, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1475, 'Expense - Education', 200, 'Expense', 'INR', 8, 25, 25, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1476, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 25, 25, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1477, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 25, 25, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1478, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 25, 25, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1479, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 26, 26, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1480, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 26, 26, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1481, 'Expense - Housing', 1100, 'Expense', 'INR', 3, 26, 26, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1482, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 26, 26, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1483, 'Expense - Education', 200, 'Expense', 'INR', 8, 26, 26, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1484, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 26, 26, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1485, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 26, 26, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1486, 'Expense - Travel', 200, 'Expense', 'INR', 6, 26, 26, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1487, 'Expense - Travel', 200, 'Expense', 'INR', 6, 26, 26, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1488, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 26, 26, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1489, 'Expense - Travel', 200, 'Expense', 'INR', 6, 26, 26, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1490, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 26, 26, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1491, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 26, 26, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1492, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 26, 26, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1493, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 26, 26, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1494, 'Expense - Housing', 300, 'Expense', 'INR', 3, 26, 26, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1495, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 26, 26, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1496, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 26, 26, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1497, 'Expense - Transportation', 900, 'Expense', 'INR', 2, 26, 26, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1498, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 26, 26, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1499, 'Expense - Utilities', 400, 'Expense', 'INR', 9, 26, 26, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1500, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 26, 26, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1501, 'Expense - Education', 200, 'Expense', 'INR', 8, 26, 26, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1502, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 26, 26, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1503, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 26, 26, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1504, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 26, 26, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1505, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 26, 26, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1506, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 26, 26, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1507, 'Expense - Education', 200, 'Expense', 'INR', 8, 26, 26, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1508, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 26, 26, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1509, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 26, 26, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1510, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 26, 26, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1511, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 26, 26, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1512, 'Expense - Housing', 200, 'Expense', 'INR', 3, 26, 26, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1513, 'Expense - Housing', 500, 'Expense', 'INR', 3, 26, 26, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1514, 'Expense - Housing', 700, 'Expense', 'INR', 3, 26, 26, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1515, 'Expense - Education', 200, 'Expense', 'INR', 8, 26, 26, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1516, 'Expense - Shopping', 800, 'Expense', 'INR', 7, 26, 26, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1517, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 26, 26, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1518, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 26, 26, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1519, 'Expense - Travel', 200, 'Expense', 'INR', 6, 26, 26, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1520, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 26, 26, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1521, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 26, 26, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1522, 'Expense - Housing', 200, 'Expense', 'INR', 3, 26, 26, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1523, 'Expense - Education', 200, 'Expense', 'INR', 8, 26, 26, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1524, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 26, 26, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1525, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 26, 26, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1526, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 26, 26, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1527, 'Expense - Entertainment', 500, 'Expense', 'INR', 5, 26, 26, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1528, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 26, 26, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1529, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 26, 26, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1530, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 26, 26, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1531, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 26, 26, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1532, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 26, 26, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1533, 'Expense - Shopping', 700, 'Expense', 'INR', 7, 26, 26, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1534, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 26, 26, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1535, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 26, 26, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1536, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 26, 26, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1537, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 26, 26, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1538, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 26, 26, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1539, 'Expense - Healthcare', 300, 'Expense', 'INR', 4, 27, 27, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1540, 'Expense - Travel', 200, 'Expense', 'INR', 6, 27, 27, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1541, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 27, 27, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1542, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 27, 27, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1543, 'Expense - Travel', 200, 'Expense', 'INR', 6, 27, 27, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1544, 'Expense - Education', 200, 'Expense', 'INR', 8, 27, 27, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1545, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 27, 27, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1546, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 27, 27, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1547, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 27, 27, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1548, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 27, 27, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1549, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 27, 27, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1550, 'Expense - Travel', 200, 'Expense', 'INR', 6, 27, 27, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1551, 'Expense - Travel', 200, 'Expense', 'INR', 6, 27, 27, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1552, 'Expense - Education', 200, 'Expense', 'INR', 8, 27, 27, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1553, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 27, 27, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1554, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 27, 27, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1555, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 27, 27, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1556, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 27, 27, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1557, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 27, 27, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1558, 'Expense - Housing', 300, 'Expense', 'INR', 3, 27, 27, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1559, 'Expense - Travel', 200, 'Expense', 'INR', 6, 27, 27, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1560, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 27, 27, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1561, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 27, 27, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1562, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 27, 27, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1563, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 27, 27, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1564, 'Expense - Healthcare', 300, 'Expense', 'INR', 4, 27, 27, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1565, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 27, 27, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1566, 'Expense - Travel', 200, 'Expense', 'INR', 6, 27, 27, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1567, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 27, 27, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1568, 'Expense - Education', 200, 'Expense', 'INR', 8, 27, 27, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1569, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 27, 27, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1570, 'Expense - Transportation', 600, 'Expense', 'INR', 2, 27, 27, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1571, 'Expense - Education', 200, 'Expense', 'INR', 8, 27, 27, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1572, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 27, 27, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1573, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 27, 27, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1574, 'Expense - Travel', 200, 'Expense', 'INR', 6, 27, 27, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1575, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 27, 27, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1576, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 27, 27, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1577, 'Expense - Shopping', 600, 'Expense', 'INR', 7, 27, 27, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1578, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 27, 27, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1579, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 27, 27, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1580, 'Expense - Education', 200, 'Expense', 'INR', 8, 27, 27, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1581, 'Expense - Travel', 200, 'Expense', 'INR', 6, 27, 27, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1582, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 27, 27, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1583, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 27, 27, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1584, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 27, 27, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1585, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 27, 27, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1586, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 27, 27, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1587, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 27, 27, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1588, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 27, 27, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1589, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 27, 27, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1590, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 27, 27, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1591, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 27, 27, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1592, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 27, 27, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1593, 'Expense - Housing', 500, 'Expense', 'INR', 3, 27, 27, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1594, 'Expense - Travel', 200, 'Expense', 'INR', 6, 27, 27, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1595, 'Expense - Transportation', 500, 'Expense', 'INR', 2, 27, 27, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1596, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 27, 27, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1597, 'Expense - Food & Dining', 1600, 'Expense', 'INR', 1, 27, 27, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1598, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 27, 27, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1599, 'Expense - Housing', 300, 'Expense', 'INR', 3, 27, 27, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1600, 'Expense - Education', 200, 'Expense', 'INR', 8, 27, 27, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1601, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 27, 27, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1602, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 27, 27, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1603, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 27, 27, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1604, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 27, 27, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1605, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 27, 27, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1606, 'Expense - Entertainment', 300, 'Expense', 'INR', 5, 27, 27, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1607, 'Expense - Utilities', 400, 'Expense', 'INR', 9, 27, 27, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1608, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 27, 27, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1609, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 28, 28, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1610, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 28, 28, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1611, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 28, 28, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1612, 'Expense - Transportation', 400, 'Expense', 'INR', 2, 28, 28, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1613, 'Expense - Housing', 200, 'Expense', 'INR', 3, 28, 28, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1614, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 28, 28, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1615, 'Expense - Housing', 500, 'Expense', 'INR', 3, 28, 28, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1616, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 28, 28, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1617, 'Expense - Education', 200, 'Expense', 'INR', 8, 28, 28, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1618, 'Expense - Education', 200, 'Expense', 'INR', 8, 28, 28, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1619, 'Expense - Transportation', 1700, 'Expense', 'INR', 2, 28, 28, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1620, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 28, 28, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1621, 'Expense - Transportation', 1000, 'Expense', 'INR', 2, 28, 28, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1622, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 28, 28, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1623, 'Expense - Travel', 200, 'Expense', 'INR', 6, 28, 28, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1624, 'Expense - Travel', 200, 'Expense', 'INR', 6, 28, 28, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1625, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 28, 28, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1626, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 28, 28, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1627, 'Expense - Education', 200, 'Expense', 'INR', 8, 28, 28, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1628, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 28, 28, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1629, 'Expense - Shopping', 500, 'Expense', 'INR', 7, 28, 28, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1630, 'Expense - Travel', 300, 'Expense', 'INR', 6, 28, 28, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1631, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 28, 28, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1632, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 28, 28, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1633, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 28, 28, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1634, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 28, 28, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1635, 'Expense - Transportation', 400, 'Expense', 'INR', 2, 28, 28, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1636, 'Expense - Education', 200, 'Expense', 'INR', 8, 28, 28, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1637, 'Expense - Transportation', 800, 'Expense', 'INR', 2, 28, 28, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1638, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 28, 28, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1639, 'Expense - Healthcare', 400, 'Expense', 'INR', 4, 28, 28, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1640, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 28, 28, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1641, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 28, 28, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1642, 'Expense - Education', 200, 'Expense', 'INR', 8, 28, 28, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1643, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 28, 28, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1644, 'Expense - Healthcare', 300, 'Expense', 'INR', 4, 28, 28, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1645, 'Expense - Education', 200, 'Expense', 'INR', 8, 28, 28, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1646, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 28, 28, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1647, 'Expense - Housing', 700, 'Expense', 'INR', 3, 28, 28, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1648, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 28, 28, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1649, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 28, 28, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1650, 'Expense - Travel', 200, 'Expense', 'INR', 6, 28, 28, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1651, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 28, 28, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1652, 'Expense - Travel', 200, 'Expense', 'INR', 6, 28, 28, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1653, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 28, 28, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1654, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 28, 28, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1655, 'Expense - Housing', 400, 'Expense', 'INR', 3, 28, 28, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1656, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 28, 28, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1657, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 28, 28, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1658, 'Expense - Housing', 700, 'Expense', 'INR', 3, 28, 28, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1659, 'Expense - Transportation', 400, 'Expense', 'INR', 2, 28, 28, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1660, 'Expense - Education', 200, 'Expense', 'INR', 8, 28, 28, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1661, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 28, 28, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1662, 'Expense - Shopping', 700, 'Expense', 'INR', 7, 28, 28, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1663, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 28, 28, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1664, 'Expense - Food & Dining', 600, 'Expense', 'INR', 1, 28, 28, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1665, 'Expense - Housing', 600, 'Expense', 'INR', 3, 28, 28, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1666, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 28, 28, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1667, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 28, 28, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1668, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 28, 28, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1669, 'Expense - Education', 200, 'Expense', 'INR', 8, 28, 28, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1670, 'Expense - Travel', 200, 'Expense', 'INR', 6, 28, 28, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1671, 'Expense - Education', 200, 'Expense', 'INR', 8, 28, 28, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1672, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 28, 28, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1673, 'Expense - Education', 200, 'Expense', 'INR', 8, 28, 28, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1674, 'Expense - Travel', 200, 'Expense', 'INR', 6, 28, 28, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1675, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 28, 28, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1676, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 28, 28, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1677, 'Expense - Housing', 600, 'Expense', 'INR', 3, 28, 28, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1678, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 28, 28, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1679, 'Expense - Travel', 200, 'Expense', 'INR', 6, 28, 28, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1680, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 29, 29, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1681, 'Expense - Travel', 300, 'Expense', 'INR', 6, 29, 29, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1682, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 29, 29, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1683, 'Expense - Food & Dining', 1700, 'Expense', 'INR', 1, 29, 29, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1684, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 29, 29, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1685, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 29, 29, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1686, 'Expense - Education', 200, 'Expense', 'INR', 8, 29, 29, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1687, 'Expense - Education', 200, 'Expense', 'INR', 8, 29, 29, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1688, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 29, 29, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1689, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 29, 29, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1690, 'Expense - Housing', 200, 'Expense', 'INR', 3, 29, 29, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1691, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 29, 29, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1692, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 29, 29, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1693, 'Expense - Food & Dining', 2000, 'Expense', 'INR', 1, 29, 29, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1694, 'Expense - Travel', 200, 'Expense', 'INR', 6, 29, 29, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1695, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 29, 29, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1696, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 29, 29, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1697, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 29, 29, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1698, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 29, 29, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1699, 'Expense - Travel', 200, 'Expense', 'INR', 6, 29, 29, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1700, 'Expense - Housing', 1400, 'Expense', 'INR', 3, 29, 29, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1701, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 29, 29, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1702, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 29, 29, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1703, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 29, 29, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1704, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 29, 29, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1705, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 29, 29, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1706, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 29, 29, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1707, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 29, 29, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1708, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 29, 29, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1709, 'Expense - Education', 300, 'Expense', 'INR', 8, 29, 29, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1710, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 29, 29, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1711, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 29, 29, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1712, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 29, 29, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1713, 'Expense - Entertainment', 300, 'Expense', 'INR', 5, 29, 29, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1714, 'Expense - Utilities', 400, 'Expense', 'INR', 9, 29, 29, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1715, 'Expense - Education', 200, 'Expense', 'INR', 8, 29, 29, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1716, 'Expense - Food & Dining', 700, 'Expense', 'INR', 1, 29, 29, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1717, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 29, 29, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1718, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 29, 29, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1719, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 29, 29, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1720, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 29, 29, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1721, 'Expense - Travel', 200, 'Expense', 'INR', 6, 29, 29, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1722, 'Expense - Travel', 200, 'Expense', 'INR', 6, 29, 29, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1723, 'Expense - Housing', 3000, 'Expense', 'INR', 3, 29, 29, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1724, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 29, 29, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1725, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 29, 29, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1726, 'Expense - Education', 200, 'Expense', 'INR', 8, 29, 29, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1727, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 29, 29, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1728, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 29, 29, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1729, 'Expense - Housing', 200, 'Expense', 'INR', 3, 29, 29, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1730, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 29, 29, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1731, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 29, 29, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1732, 'Expense - Travel', 200, 'Expense', 'INR', 6, 29, 29, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1733, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 29, 29, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1734, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 29, 29, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1735, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 29, 29, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1736, 'Expense - Food & Dining', 900, 'Expense', 'INR', 1, 29, 29, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1737, 'Expense - Housing', 700, 'Expense', 'INR', 3, 29, 29, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1738, 'Expense - Travel', 200, 'Expense', 'INR', 6, 29, 29, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1739, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 29, 29, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1740, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 29, 29, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1741, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 29, 29, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1742, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 29, 29, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1743, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 29, 29, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1744, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 29, 29, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1745, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 29, 29, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1746, 'Expense - Housing', 700, 'Expense', 'INR', 3, 29, 29, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1747, 'Expense - Housing', 1500, 'Expense', 'INR', 3, 29, 29, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1748, 'Expense - Travel', 200, 'Expense', 'INR', 6, 29, 29, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1749, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 29, 29, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1750, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 29, 29, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1751, 'Expense - Education', 200, 'Expense', 'INR', 8, 29, 29, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1752, 'Expense - Travel', 200, 'Expense', 'INR', 6, 29, 29, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1753, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 29, 29, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1754, 'Expense - Food & Dining', 700, 'Expense', 'INR', 1, 29, 29, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1755, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 29, 29, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1756, 'Expense - Travel', 300, 'Expense', 'INR', 6, 29, 29, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1757, 'Expense - Education', 200, 'Expense', 'INR', 8, 29, 29, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1758, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 29, 29, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1759, 'Expense - Utilities', 800, 'Expense', 'INR', 9, 29, 29, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1760, 'Expense - Housing', 500, 'Expense', 'INR', 3, 29, 29, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1761, 'Expense - Food & Dining', 800, 'Expense', 'INR', 1, 29, 29, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1762, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 30, 30, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1763, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 30, 30, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1764, 'Expense - Education', 200, 'Expense', 'INR', 8, 30, 30, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1765, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 30, 30, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1766, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 30, 30, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1767, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 30, 30, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1768, 'Expense - Education', 200, 'Expense', 'INR', 8, 30, 30, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1769, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 30, 30, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1770, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 30, 30, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1771, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 30, 30, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1772, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 30, 30, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1773, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 30, 30, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1774, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 30, 30, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1775, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 30, 30, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1776, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 30, 30, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1777, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 30, 30, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1778, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 30, 30, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1779, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 30, 30, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1780, 'Expense - Housing', 1300, 'Expense', 'INR', 3, 30, 30, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1781, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 30, 30, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1782, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 30, 30, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1783, 'Expense - Food & Dining', 700, 'Expense', 'INR', 1, 30, 30, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1784, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 30, 30, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1785, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 30, 30, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1786, 'Expense - Housing', 500, 'Expense', 'INR', 3, 30, 30, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1787, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 30, 30, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1788, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 30, 30, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1789, 'Expense - Travel', 200, 'Expense', 'INR', 6, 30, 30, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1790, 'Expense - Travel', 200, 'Expense', 'INR', 6, 30, 30, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1791, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 30, 30, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1792, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 30, 30, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1793, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 30, 30, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1794, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 30, 30, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1795, 'Expense - Housing', 200, 'Expense', 'INR', 3, 30, 30, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1796, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 30, 30, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1797, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 30, 30, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1798, 'Expense - Travel', 200, 'Expense', 'INR', 6, 30, 30, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1799, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 30, 30, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1800, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 31, 31, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1801, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 31, 31, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1802, 'Expense - Housing', 200, 'Expense', 'INR', 3, 31, 31, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1803, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 31, 31, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1804, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 31, 31, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1805, 'Expense - Travel', 200, 'Expense', 'INR', 6, 31, 31, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1806, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 31, 31, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1807, 'Expense - Housing', 300, 'Expense', 'INR', 3, 31, 31, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1808, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 31, 31, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1809, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 31, 31, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1810, 'Expense - Housing', 200, 'Expense', 'INR', 3, 31, 31, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1811, 'Expense - Travel', 200, 'Expense', 'INR', 6, 31, 31, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1812, 'Expense - Housing', 200, 'Expense', 'INR', 3, 31, 31, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1813, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 31, 31, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1814, 'Expense - Travel', 200, 'Expense', 'INR', 6, 31, 31, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1815, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 31, 31, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1816, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 31, 31, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1817, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 31, 31, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1818, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 31, 31, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1819, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 31, 31, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1820, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 31, 31, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1821, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 31, 31, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1822, 'Expense - Housing', 300, 'Expense', 'INR', 3, 31, 31, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1823, 'Expense - Housing', 200, 'Expense', 'INR', 3, 31, 31, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1824, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 31, 31, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1825, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 31, 31, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1826, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 31, 31, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1827, 'Expense - Housing', 200, 'Expense', 'INR', 3, 31, 31, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1828, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 31, 31, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1829, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 31, 31, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1830, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 31, 31, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1831, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 31, 31, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1832, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 31, 31, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1833, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 31, 31, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1834, 'Expense - Travel', 200, 'Expense', 'INR', 6, 31, 31, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1835, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 31, 31, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1836, 'Expense - Travel', 200, 'Expense', 'INR', 6, 31, 31, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1837, 'Expense - Travel', 200, 'Expense', 'INR', 6, 31, 31, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1838, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 31, 31, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1839, 'Expense - Food & Dining', 900, 'Expense', 'INR', 1, 31, 31, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1840, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 31, 31, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1841, 'Expense - Housing', 200, 'Expense', 'INR', 3, 31, 31, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1842, 'Expense - Housing', 1000, 'Expense', 'INR', 3, 31, 31, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1843, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 31, 31, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1844, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 31, 31, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1845, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 31, 31, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1846, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 32, 32, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1847, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 32, 32, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1848, 'Expense - Education', 200, 'Expense', 'INR', 8, 32, 32, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1849, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 32, 32, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1850, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 32, 32, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1851, 'Expense - Education', 200, 'Expense', 'INR', 8, 32, 32, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1852, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 32, 32, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1853, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 32, 32, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1854, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 32, 32, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1855, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 32, 32, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1856, 'Expense - Education', 200, 'Expense', 'INR', 8, 32, 32, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1857, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 32, 32, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1858, 'Expense - Travel', 200, 'Expense', 'INR', 6, 32, 32, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1859, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 32, 32, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1860, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 32, 32, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1861, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 32, 32, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1862, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 32, 32, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1863, 'Expense - Travel', 200, 'Expense', 'INR', 6, 32, 32, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1864, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 32, 32, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1865, 'Expense - Education', 200, 'Expense', 'INR', 8, 32, 32, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1866, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 32, 32, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1867, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 32, 32, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1868, 'Expense - Travel', 200, 'Expense', 'INR', 6, 32, 32, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1869, 'Expense - Education', 200, 'Expense', 'INR', 8, 32, 32, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1870, 'Expense - Education', 200, 'Expense', 'INR', 8, 32, 32, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1871, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 32, 32, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1872, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 32, 32, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1873, 'Expense - Food & Dining', 1000, 'Expense', 'INR', 1, 32, 32, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1874, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 32, 32, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1875, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 32, 32, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1876, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 32, 32, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1877, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 32, 32, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1878, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 32, 32, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1879, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 32, 32, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1880, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 32, 32, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1881, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 32, 32, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1882, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 32, 32, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1883, 'Expense - Housing', 400, 'Expense', 'INR', 3, 32, 32, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1884, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 32, 32, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1885, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 32, 32, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1886, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 32, 32, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1887, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 32, 32, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1888, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 32, 32, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1889, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 32, 32, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1890, 'Expense - Travel', 200, 'Expense', 'INR', 6, 32, 32, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1891, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 32, 32, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1892, 'Expense - Shopping', 400, 'Expense', 'INR', 7, 32, 32, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1893, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 32, 32, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1894, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 32, 32, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1895, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 32, 32, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1896, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 32, 32, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1897, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 32, 32, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1898, 'Expense - Education', 200, 'Expense', 'INR', 8, 32, 32, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1899, 'Expense - Travel', 200, 'Expense', 'INR', 6, 32, 32, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1900, 'Expense - Travel', 200, 'Expense', 'INR', 6, 32, 32, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1901, 'Expense - Housing', 200, 'Expense', 'INR', 3, 32, 32, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1902, 'Expense - Education', 200, 'Expense', 'INR', 8, 32, 32, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1903, 'Expense - Education', 200, 'Expense', 'INR', 8, 32, 32, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1904, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 33, 33, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1905, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 33, 33, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1906, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 33, 33, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1907, 'Expense - Education', 200, 'Expense', 'INR', 8, 33, 33, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1908, 'Expense - Travel', 200, 'Expense', 'INR', 6, 33, 33, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1909, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 33, 33, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1910, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 33, 33, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1911, 'Expense - Entertainment', 500, 'Expense', 'INR', 5, 33, 33, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1912, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 33, 33, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1913, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 33, 33, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1914, 'Expense - Transportation', 1000, 'Expense', 'INR', 2, 33, 33, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1915, 'Expense - Travel', 200, 'Expense', 'INR', 6, 33, 33, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1916, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 33, 33, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1917, 'Expense - Housing', 200, 'Expense', 'INR', 3, 33, 33, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1918, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 33, 33, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1919, 'Expense - Education', 200, 'Expense', 'INR', 8, 33, 33, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1920, 'Expense - Travel', 200, 'Expense', 'INR', 6, 33, 33, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1921, 'Expense - Shopping', 500, 'Expense', 'INR', 7, 33, 33, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1922, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 33, 33, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1923, 'Expense - Education', 200, 'Expense', 'INR', 8, 33, 33, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1924, 'Expense - Travel', 400, 'Expense', 'INR', 6, 33, 33, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1925, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 33, 33, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1926, 'Expense - Housing', 1000, 'Expense', 'INR', 3, 33, 33, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1927, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 33, 33, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1928, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 33, 33, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1929, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 33, 33, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1930, 'Expense - Education', 500, 'Expense', 'INR', 8, 33, 33, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1931, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 33, 33, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1932, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 33, 33, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1933, 'Expense - Utilities', 400, 'Expense', 'INR', 9, 33, 33, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1934, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 33, 33, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1935, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 33, 33, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1936, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 33, 33, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1937, 'Expense - Housing', 2300, 'Expense', 'INR', 3, 33, 33, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1938, 'Expense - Travel', 200, 'Expense', 'INR', 6, 33, 33, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1939, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 33, 33, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1940, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 33, 33, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1941, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 33, 33, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1942, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 33, 33, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1943, 'Expense - Travel', 200, 'Expense', 'INR', 6, 33, 33, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1944, 'Expense - Housing', 400, 'Expense', 'INR', 3, 33, 33, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1945, 'Expense - Food & Dining', 700, 'Expense', 'INR', 1, 33, 33, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1946, 'Expense - Housing', 1100, 'Expense', 'INR', 3, 33, 33, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1947, 'Expense - Travel', 200, 'Expense', 'INR', 6, 33, 33, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1948, 'Expense - Housing', 200, 'Expense', 'INR', 3, 33, 33, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1949, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 33, 33, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1950, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 33, 33, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1951, 'Expense - Food & Dining', 800, 'Expense', 'INR', 1, 33, 33, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1952, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 33, 33, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1953, 'Expense - Education', 200, 'Expense', 'INR', 8, 33, 33, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1954, 'Expense - Travel', 200, 'Expense', 'INR', 6, 33, 33, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1955, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 33, 33, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1956, 'Expense - Education', 200, 'Expense', 'INR', 8, 33, 33, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1957, 'Expense - Education', 200, 'Expense', 'INR', 8, 34, 34, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1958, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 34, 34, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1959, 'Expense - Housing', 200, 'Expense', 'INR', 3, 34, 34, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1960, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 34, 34, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1961, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 34, 34, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1962, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 34, 34, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1963, 'Expense - Travel', 200, 'Expense', 'INR', 6, 34, 34, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1964, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 34, 34, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1965, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 34, 34, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1966, 'Expense - Travel', 200, 'Expense', 'INR', 6, 34, 34, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1967, 'Expense - Housing', 200, 'Expense', 'INR', 3, 34, 34, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1968, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 34, 34, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1969, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 34, 34, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1970, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 34, 34, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1971, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 34, 34, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1972, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 34, 34, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1973, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 34, 34, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1974, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 34, 34, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1975, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 34, 34, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1976, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 34, 34, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1977, 'Expense - Travel', 200, 'Expense', 'INR', 6, 34, 34, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1978, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 34, 34, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1979, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 34, 34, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1980, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 34, 34, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1981, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 34, 34, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1982, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 34, 34, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1983, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 34, 34, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1984, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 34, 34, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1985, 'Expense - Travel', 200, 'Expense', 'INR', 6, 34, 34, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1986, 'Expense - Housing', 200, 'Expense', 'INR', 3, 34, 34, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1987, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 34, 34, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1988, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 34, 34, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1989, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 34, 34, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1990, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 34, 34, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1991, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 34, 34, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1992, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 34, 34, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1993, 'Expense - Education', 200, 'Expense', 'INR', 8, 34, 34, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1994, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 34, 34, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1995, 'Expense - Travel', 200, 'Expense', 'INR', 6, 34, 34, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1996, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 34, 34, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1997, 'Expense - Housing', 300, 'Expense', 'INR', 3, 34, 34, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1998, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 34, 34, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (1999, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 34, 34, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2000, 'Expense - Travel', 200, 'Expense', 'INR', 6, 34, 34, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2001, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 34, 34, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2002, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 34, 34, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2003, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 35, 35, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2004, 'Expense - Travel', 200, 'Expense', 'INR', 6, 35, 35, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2005, 'Expense - Education', 200, 'Expense', 'INR', 8, 35, 35, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2006, 'Expense - Education', 200, 'Expense', 'INR', 8, 35, 35, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2007, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 35, 35, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2008, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 35, 35, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2009, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 35, 35, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2010, 'Expense - Healthcare', 300, 'Expense', 'INR', 4, 35, 35, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2011, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 35, 35, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2012, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 35, 35, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2013, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 35, 35, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2014, 'Expense - Healthcare', 300, 'Expense', 'INR', 4, 35, 35, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2015, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 35, 35, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2016, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 35, 35, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2017, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 35, 35, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2018, 'Expense - Housing', 200, 'Expense', 'INR', 3, 35, 35, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2019, 'Expense - Travel', 200, 'Expense', 'INR', 6, 35, 35, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2020, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 35, 35, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2021, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 35, 35, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2022, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 35, 35, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2023, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 35, 35, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2024, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 35, 35, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2025, 'Expense - Housing', 200, 'Expense', 'INR', 3, 35, 35, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2026, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 35, 35, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2027, 'Expense - Housing', 200, 'Expense', 'INR', 3, 35, 35, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2028, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 35, 35, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2029, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 35, 35, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2030, 'Expense - Housing', 500, 'Expense', 'INR', 3, 35, 35, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2031, 'Expense - Travel', 200, 'Expense', 'INR', 6, 35, 35, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2032, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 35, 35, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2033, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 35, 35, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2034, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 35, 35, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2035, 'Expense - Travel', 200, 'Expense', 'INR', 6, 35, 35, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2036, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 35, 35, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2037, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 35, 35, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2038, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 35, 35, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2039, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 35, 35, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2040, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 35, 35, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2041, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 35, 35, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2042, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 35, 35, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2043, 'Expense - Housing', 400, 'Expense', 'INR', 3, 35, 35, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2044, 'Expense - Travel', 200, 'Expense', 'INR', 6, 35, 35, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2045, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 35, 35, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2046, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 35, 35, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2047, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 35, 35, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2048, 'Expense - Education', 200, 'Expense', 'INR', 8, 35, 35, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2049, 'Expense - Travel', 200, 'Expense', 'INR', 6, 35, 35, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2050, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 35, 35, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2051, 'Expense - Food & Dining', 1000, 'Expense', 'INR', 1, 35, 35, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2052, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 35, 35, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2053, 'Expense - Housing', 200, 'Expense', 'INR', 3, 35, 35, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2054, 'Expense - Housing', 200, 'Expense', 'INR', 3, 35, 35, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2055, 'Expense - Education', 200, 'Expense', 'INR', 8, 35, 35, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2056, 'Expense - Education', 200, 'Expense', 'INR', 8, 35, 35, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2057, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 35, 35, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2058, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 35, 35, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2059, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 35, 35, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2060, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 35, 35, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2061, 'Expense - Education', 200, 'Expense', 'INR', 8, 35, 35, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2062, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 35, 35, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2063, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 36, 36, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2064, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 36, 36, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2065, 'Expense - Utilities', 500, 'Expense', 'INR', 9, 36, 36, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2066, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 36, 36, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2067, 'Expense - Food & Dining', 700, 'Expense', 'INR', 1, 36, 36, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2068, 'Expense - Travel', 200, 'Expense', 'INR', 6, 36, 36, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2069, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 36, 36, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2070, 'Expense - Housing', 700, 'Expense', 'INR', 3, 36, 36, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2071, 'Expense - Education', 200, 'Expense', 'INR', 8, 36, 36, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2072, 'Expense - Education', 300, 'Expense', 'INR', 8, 36, 36, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2073, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 36, 36, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2074, 'Expense - Shopping', 400, 'Expense', 'INR', 7, 36, 36, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2075, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 36, 36, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2076, 'Expense - Housing', 700, 'Expense', 'INR', 3, 36, 36, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2077, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 36, 36, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2078, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 36, 36, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2079, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 36, 36, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2080, 'Expense - Education', 200, 'Expense', 'INR', 8, 36, 36, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2081, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 36, 36, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2082, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 36, 36, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2083, 'Expense - Housing', 500, 'Expense', 'INR', 3, 36, 36, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2084, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 36, 36, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2085, 'Expense - Education', 200, 'Expense', 'INR', 8, 36, 36, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2086, 'Expense - Education', 200, 'Expense', 'INR', 8, 36, 36, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2087, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 36, 36, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2088, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 36, 36, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2089, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 36, 36, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2090, 'Expense - Education', 200, 'Expense', 'INR', 8, 36, 36, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2091, 'Expense - Food & Dining', 1600, 'Expense', 'INR', 1, 36, 36, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2092, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 36, 36, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2093, 'Expense - Housing', 1000, 'Expense', 'INR', 3, 36, 36, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2094, 'Expense - Travel', 200, 'Expense', 'INR', 6, 36, 36, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2095, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 36, 36, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2096, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 36, 36, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2097, 'Expense - Housing', 700, 'Expense', 'INR', 3, 36, 36, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2098, 'Expense - Education', 200, 'Expense', 'INR', 8, 36, 36, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2099, 'Expense - Utilities', 400, 'Expense', 'INR', 9, 36, 36, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2100, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 36, 36, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2101, 'Expense - Shopping', 600, 'Expense', 'INR', 7, 36, 36, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2102, 'Expense - Travel', 200, 'Expense', 'INR', 6, 36, 36, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2103, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 36, 36, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2104, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 36, 36, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2105, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 36, 36, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2106, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 36, 36, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2107, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 36, 36, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2108, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 36, 36, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2109, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 36, 36, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2110, 'Expense - Travel', 200, 'Expense', 'INR', 6, 36, 36, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2111, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 36, 36, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2112, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 36, 36, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2113, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 36, 36, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2114, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 36, 36, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2115, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 36, 36, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2116, 'Expense - Education', 200, 'Expense', 'INR', 8, 36, 36, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2117, 'Expense - Housing', 300, 'Expense', 'INR', 3, 36, 36, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2118, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 37, 37, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2119, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 37, 37, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2120, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 37, 37, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2121, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 37, 37, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2122, 'Expense - Shopping', 400, 'Expense', 'INR', 7, 37, 37, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2123, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 37, 37, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2124, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 37, 37, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2125, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 37, 37, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2126, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 37, 37, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2127, 'Expense - Travel', 200, 'Expense', 'INR', 6, 37, 37, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2128, 'Expense - Education', 200, 'Expense', 'INR', 8, 37, 37, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2129, 'Expense - Housing', 300, 'Expense', 'INR', 3, 37, 37, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2130, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 37, 37, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2131, 'Expense - Housing', 400, 'Expense', 'INR', 3, 37, 37, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2132, 'Expense - Education', 200, 'Expense', 'INR', 8, 37, 37, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2133, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 37, 37, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2134, 'Expense - Education', 200, 'Expense', 'INR', 8, 37, 37, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2135, 'Expense - Healthcare', 300, 'Expense', 'INR', 4, 37, 37, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2136, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 37, 37, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2137, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 37, 37, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2138, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 37, 37, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2139, 'Expense - Education', 200, 'Expense', 'INR', 8, 37, 37, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2140, 'Expense - Housing', 200, 'Expense', 'INR', 3, 37, 37, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2141, 'Expense - Travel', 200, 'Expense', 'INR', 6, 37, 37, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2142, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 37, 37, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2143, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 37, 37, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2144, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 37, 37, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2145, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 37, 37, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2146, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 37, 37, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2147, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 37, 37, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2148, 'Expense - Travel', 200, 'Expense', 'INR', 6, 37, 37, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2149, 'Expense - Travel', 300, 'Expense', 'INR', 6, 37, 37, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2150, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 37, 37, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2151, 'Expense - Housing', 600, 'Expense', 'INR', 3, 37, 37, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2152, 'Expense - Housing', 1400, 'Expense', 'INR', 3, 37, 37, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2153, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 37, 37, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2154, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 37, 37, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2155, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 37, 37, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2156, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 37, 37, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2157, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 37, 37, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2158, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 37, 37, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2159, 'Expense - Travel', 200, 'Expense', 'INR', 6, 37, 37, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2160, 'Expense - Education', 200, 'Expense', 'INR', 8, 37, 37, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2161, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 37, 37, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2162, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 37, 37, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2163, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 37, 37, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2164, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 37, 37, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2165, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 37, 37, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2166, 'Expense - Travel', 200, 'Expense', 'INR', 6, 37, 37, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2167, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 37, 37, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2168, 'Expense - Utilities', 600, 'Expense', 'INR', 9, 37, 37, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2169, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 37, 37, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2170, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 37, 37, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2171, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 37, 37, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2172, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 37, 37, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2173, 'Expense - Travel', 200, 'Expense', 'INR', 6, 37, 37, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2174, 'Expense - Education', 200, 'Expense', 'INR', 8, 37, 37, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2175, 'Expense - Housing', 200, 'Expense', 'INR', 3, 37, 37, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2176, 'Expense - Housing', 200, 'Expense', 'INR', 3, 37, 37, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2177, 'Expense - Travel', 200, 'Expense', 'INR', 6, 37, 37, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2178, 'Expense - Housing', 200, 'Expense', 'INR', 3, 37, 37, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2179, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 37, 37, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2180, 'Expense - Food & Dining', 600, 'Expense', 'INR', 1, 37, 37, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2181, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 37, 37, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2182, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 37, 37, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2183, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 37, 37, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2184, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 37, 37, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2185, 'Expense - Entertainment', 400, 'Expense', 'INR', 5, 37, 37, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2186, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 37, 37, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2187, 'Expense - Education', 200, 'Expense', 'INR', 8, 37, 37, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2188, 'Expense - Housing', 200, 'Expense', 'INR', 3, 38, 38, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2189, 'Expense - Travel', 200, 'Expense', 'INR', 6, 38, 38, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2190, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 38, 38, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2191, 'Expense - Education', 200, 'Expense', 'INR', 8, 38, 38, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2192, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 38, 38, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2193, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 38, 38, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2194, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 38, 38, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2195, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 38, 38, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2196, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 38, 38, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2197, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 38, 38, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2198, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 38, 38, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2199, 'Expense - Shopping', 400, 'Expense', 'INR', 7, 38, 38, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2200, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 38, 38, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2201, 'Expense - Education', 200, 'Expense', 'INR', 8, 38, 38, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2202, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 38, 38, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2203, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 38, 38, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2204, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 38, 38, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2205, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 38, 38, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2206, 'Expense - Education', 200, 'Expense', 'INR', 8, 38, 38, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2207, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 38, 38, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2208, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 38, 38, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2209, 'Expense - Housing', 200, 'Expense', 'INR', 3, 38, 38, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2210, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 38, 38, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2211, 'Expense - Housing', 200, 'Expense', 'INR', 3, 38, 38, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2212, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 38, 38, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2213, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 38, 38, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2214, 'Expense - Housing', 200, 'Expense', 'INR', 3, 38, 38, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2215, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 38, 38, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2216, 'Expense - Travel', 200, 'Expense', 'INR', 6, 38, 38, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2217, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 38, 38, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2218, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 38, 38, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2219, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 38, 38, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2220, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 38, 38, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2221, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 38, 38, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2222, 'Expense - Utilities', 400, 'Expense', 'INR', 9, 38, 38, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2223, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 38, 38, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2224, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 38, 38, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2225, 'Expense - Housing', 200, 'Expense', 'INR', 3, 38, 38, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2226, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 38, 38, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2227, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 38, 38, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2228, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 38, 38, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2229, 'Expense - Housing', 400, 'Expense', 'INR', 3, 38, 38, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2230, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 38, 38, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2231, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 38, 38, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2232, 'Expense - Travel', 200, 'Expense', 'INR', 6, 38, 38, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2233, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 38, 38, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2234, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 38, 38, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2235, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 38, 38, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2236, 'Expense - Housing', 600, 'Expense', 'INR', 3, 38, 38, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2237, 'Expense - Education', 200, 'Expense', 'INR', 8, 38, 38, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2238, 'Expense - Housing', 500, 'Expense', 'INR', 3, 38, 38, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2239, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 38, 38, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2240, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 38, 38, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2241, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 38, 38, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2242, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 38, 38, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2243, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 38, 38, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2244, 'Expense - Travel', 200, 'Expense', 'INR', 6, 38, 38, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2245, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 38, 38, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2246, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 39, 39, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2247, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 39, 39, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2248, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 39, 39, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2249, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 39, 39, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2250, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 39, 39, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2251, 'Expense - Housing', 300, 'Expense', 'INR', 3, 39, 39, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2252, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 39, 39, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2253, 'Expense - Transportation', 700, 'Expense', 'INR', 2, 39, 39, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2254, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 39, 39, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2255, 'Expense - Travel', 200, 'Expense', 'INR', 6, 39, 39, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2256, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 39, 39, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2257, 'Expense - Education', 200, 'Expense', 'INR', 8, 39, 39, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2258, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 39, 39, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2259, 'Expense - Travel', 200, 'Expense', 'INR', 6, 39, 39, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2260, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 39, 39, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2261, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 39, 39, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2262, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 39, 39, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2263, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 39, 39, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2264, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 39, 39, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2265, 'Expense - Education', 200, 'Expense', 'INR', 8, 39, 39, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2266, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 39, 39, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2267, 'Expense - Travel', 200, 'Expense', 'INR', 6, 39, 39, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2268, 'Expense - Education', 200, 'Expense', 'INR', 8, 39, 39, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2269, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 39, 39, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2270, 'Expense - Travel', 200, 'Expense', 'INR', 6, 39, 39, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2271, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 39, 39, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2272, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 39, 39, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2273, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 39, 39, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2274, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 39, 39, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2275, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 39, 39, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2276, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 39, 39, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2277, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 39, 39, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2278, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 39, 39, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2279, 'Expense - Housing', 200, 'Expense', 'INR', 3, 39, 39, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2280, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 39, 39, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2281, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 39, 39, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2282, 'Expense - Travel', 200, 'Expense', 'INR', 6, 39, 39, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2283, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 39, 39, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2284, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 39, 39, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2285, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 39, 39, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2286, 'Expense - Travel', 200, 'Expense', 'INR', 6, 39, 39, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2287, 'Expense - Travel', 200, 'Expense', 'INR', 6, 39, 39, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2288, 'Expense - Education', 300, 'Expense', 'INR', 8, 39, 39, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2289, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 39, 39, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2290, 'Expense - Housing', 200, 'Expense', 'INR', 3, 39, 39, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2291, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 39, 39, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2292, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 39, 39, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2293, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 39, 39, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2294, 'Expense - Food & Dining', 1300, 'Expense', 'INR', 1, 39, 39, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2295, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 39, 39, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2296, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 39, 39, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2297, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 39, 39, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2298, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 39, 39, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2299, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 39, 39, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2300, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 39, 39, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2301, 'Expense - Food & Dining', 600, 'Expense', 'INR', 1, 39, 39, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2302, 'Expense - Education', 200, 'Expense', 'INR', 8, 39, 39, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2303, 'Expense - Housing', 600, 'Expense', 'INR', 3, 39, 39, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2304, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 39, 39, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2305, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 39, 39, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2306, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 39, 39, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2307, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 40, 40, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2308, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 40, 40, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2309, 'Expense - Food & Dining', 600, 'Expense', 'INR', 1, 40, 40, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2310, 'Expense - Housing', 3000, 'Expense', 'INR', 3, 40, 40, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2311, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 40, 40, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2312, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 40, 40, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2313, 'Expense - Education', 200, 'Expense', 'INR', 8, 40, 40, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2314, 'Expense - Education', 200, 'Expense', 'INR', 8, 40, 40, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2315, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 40, 40, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2316, 'Expense - Travel', 200, 'Expense', 'INR', 6, 40, 40, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2317, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 40, 40, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2318, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 40, 40, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2319, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 40, 40, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2320, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 40, 40, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2321, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 40, 40, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2322, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 40, 40, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2323, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 40, 40, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2324, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 40, 40, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2325, 'Expense - Utilities', 400, 'Expense', 'INR', 9, 40, 40, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2326, 'Expense - Housing', 200, 'Expense', 'INR', 3, 40, 40, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2327, 'Expense - Education', 200, 'Expense', 'INR', 8, 40, 40, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2328, 'Expense - Housing', 2100, 'Expense', 'INR', 3, 40, 40, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2329, 'Expense - Travel', 200, 'Expense', 'INR', 6, 40, 40, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2330, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 40, 40, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2331, 'Expense - Shopping', 600, 'Expense', 'INR', 7, 40, 40, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2332, 'Expense - Education', 200, 'Expense', 'INR', 8, 40, 40, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2333, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 40, 40, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2334, 'Expense - Shopping', 400, 'Expense', 'INR', 7, 40, 40, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2335, 'Expense - Education', 200, 'Expense', 'INR', 8, 40, 40, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2336, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 40, 40, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2337, 'Expense - Education', 200, 'Expense', 'INR', 8, 40, 40, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2338, 'Expense - Shopping', 400, 'Expense', 'INR', 7, 40, 40, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2339, 'Expense - Travel', 200, 'Expense', 'INR', 6, 40, 40, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2340, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 40, 40, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2341, 'Expense - Housing', 200, 'Expense', 'INR', 3, 40, 40, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2342, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 40, 40, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2343, 'Expense - Housing', 300, 'Expense', 'INR', 3, 40, 40, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2344, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 40, 40, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2345, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 40, 40, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2346, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 40, 40, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2347, 'Expense - Housing', 900, 'Expense', 'INR', 3, 40, 40, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2348, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 40, 40, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2349, 'Expense - Travel', 200, 'Expense', 'INR', 6, 40, 40, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2350, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 40, 40, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2351, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 40, 40, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2352, 'Expense - Housing', 200, 'Expense', 'INR', 3, 40, 40, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2353, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 40, 40, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2354, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 41, 41, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2355, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 41, 41, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2356, 'Expense - Housing', 200, 'Expense', 'INR', 3, 41, 41, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2357, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 41, 41, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2358, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 41, 41, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2359, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 41, 41, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2360, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 41, 41, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2361, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 41, 41, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2362, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 41, 41, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2363, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 41, 41, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2364, 'Expense - Travel', 200, 'Expense', 'INR', 6, 41, 41, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2365, 'Expense - Education', 200, 'Expense', 'INR', 8, 41, 41, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2366, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 41, 41, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2367, 'Expense - Housing', 200, 'Expense', 'INR', 3, 41, 41, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2368, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 41, 41, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2369, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 41, 41, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2370, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 41, 41, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2371, 'Expense - Travel', 200, 'Expense', 'INR', 6, 41, 41, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2372, 'Expense - Travel', 200, 'Expense', 'INR', 6, 41, 41, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2373, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 41, 41, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2374, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 41, 41, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2375, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 41, 41, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2376, 'Expense - Housing', 200, 'Expense', 'INR', 3, 41, 41, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2377, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 41, 41, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2378, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 41, 41, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2379, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 41, 41, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2380, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 41, 41, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2381, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 41, 41, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2382, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 41, 41, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2383, 'Expense - Education', 200, 'Expense', 'INR', 8, 41, 41, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2384, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 41, 41, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2385, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 41, 41, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2386, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 41, 41, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2387, 'Expense - Shopping', 400, 'Expense', 'INR', 7, 41, 41, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2388, 'Expense - Education', 200, 'Expense', 'INR', 8, 41, 41, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2389, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 41, 41, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2390, 'Expense - Education', 200, 'Expense', 'INR', 8, 41, 41, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2391, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 41, 41, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2392, 'Expense - Housing', 200, 'Expense', 'INR', 3, 41, 41, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2393, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 41, 41, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2394, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 41, 41, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2395, 'Expense - Travel', 200, 'Expense', 'INR', 6, 41, 41, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2396, 'Expense - Education', 200, 'Expense', 'INR', 8, 41, 41, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2397, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 41, 41, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2398, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 42, 42, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2399, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 42, 42, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2400, 'Expense - Housing', 400, 'Expense', 'INR', 3, 42, 42, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2401, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 42, 42, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2402, 'Expense - Travel', 200, 'Expense', 'INR', 6, 42, 42, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2403, 'Expense - Education', 200, 'Expense', 'INR', 8, 42, 42, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2404, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 42, 42, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2405, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 42, 42, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2406, 'Expense - Housing', 2000, 'Expense', 'INR', 3, 42, 42, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2407, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 42, 42, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2408, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 42, 42, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2409, 'Expense - Travel', 200, 'Expense', 'INR', 6, 42, 42, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2410, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 42, 42, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2411, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 42, 42, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2412, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 42, 42, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2413, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 42, 42, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2414, 'Expense - Education', 200, 'Expense', 'INR', 8, 42, 42, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2415, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 42, 42, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2416, 'Expense - Housing', 300, 'Expense', 'INR', 3, 42, 42, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2417, 'Expense - Education', 300, 'Expense', 'INR', 8, 42, 42, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2418, 'Expense - Travel', 200, 'Expense', 'INR', 6, 42, 42, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2419, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 42, 42, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2420, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 42, 42, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2421, 'Expense - Travel', 200, 'Expense', 'INR', 6, 42, 42, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2422, 'Expense - Housing', 400, 'Expense', 'INR', 3, 42, 42, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2423, 'Expense - Education', 200, 'Expense', 'INR', 8, 42, 42, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2424, 'Expense - Housing', 200, 'Expense', 'INR', 3, 42, 42, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2425, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 42, 42, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2426, 'Expense - Transportation', 400, 'Expense', 'INR', 2, 42, 42, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2427, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 42, 42, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2428, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 42, 42, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2429, 'Expense - Entertainment', 400, 'Expense', 'INR', 5, 42, 42, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2430, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 42, 42, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2431, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 42, 42, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2432, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 42, 42, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2433, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 42, 42, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2434, 'Expense - Education', 200, 'Expense', 'INR', 8, 42, 42, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2435, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 42, 42, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2436, 'Expense - Education', 200, 'Expense', 'INR', 8, 42, 42, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2437, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 42, 42, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2438, 'Expense - Food & Dining', 700, 'Expense', 'INR', 1, 42, 42, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2439, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 42, 42, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2440, 'Expense - Travel', 200, 'Expense', 'INR', 6, 42, 42, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2441, 'Expense - Education', 200, 'Expense', 'INR', 8, 42, 42, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2442, 'Expense - Food & Dining', 2100, 'Expense', 'INR', 1, 42, 42, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2443, 'Expense - Transportation', 400, 'Expense', 'INR', 2, 42, 42, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2444, 'Expense - Housing', 2200, 'Expense', 'INR', 3, 42, 42, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2445, 'Expense - Education', 200, 'Expense', 'INR', 8, 42, 42, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2446, 'Expense - Education', 200, 'Expense', 'INR', 8, 42, 42, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2447, 'Expense - Utilities', 800, 'Expense', 'INR', 9, 42, 42, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2448, 'Expense - Education', 200, 'Expense', 'INR', 8, 43, 43, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2449, 'Expense - Food & Dining', 800, 'Expense', 'INR', 1, 43, 43, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2450, 'Expense - Education', 200, 'Expense', 'INR', 8, 43, 43, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2451, 'Expense - Education', 200, 'Expense', 'INR', 8, 43, 43, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2452, 'Expense - Travel', 300, 'Expense', 'INR', 6, 43, 43, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2453, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 43, 43, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2454, 'Expense - Shopping', 800, 'Expense', 'INR', 7, 43, 43, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2455, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 43, 43, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2456, 'Expense - Housing', 700, 'Expense', 'INR', 3, 43, 43, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2457, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 43, 43, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2458, 'Expense - Food & Dining', 700, 'Expense', 'INR', 1, 43, 43, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2459, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 43, 43, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2460, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 43, 43, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2461, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 43, 43, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2462, 'Expense - Education', 200, 'Expense', 'INR', 8, 43, 43, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2463, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 43, 43, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2464, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 43, 43, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2465, 'Expense - Food & Dining', 700, 'Expense', 'INR', 1, 43, 43, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2466, 'Expense - Transportation', 400, 'Expense', 'INR', 2, 43, 43, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2467, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 43, 43, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2468, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 43, 43, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2998, 'Salary Income', 12500, 'Income', 'INR', 11, 13, 13, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2469, 'Expense - Travel', 200, 'Expense', 'INR', 6, 43, 43, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2470, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 43, 43, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2471, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 43, 43, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2472, 'Expense - Shopping', 400, 'Expense', 'INR', 7, 43, 43, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2473, 'Expense - Entertainment', 400, 'Expense', 'INR', 5, 43, 43, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2474, 'Expense - Healthcare', 500, 'Expense', 'INR', 4, 43, 43, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2475, 'Expense - Education', 200, 'Expense', 'INR', 8, 43, 43, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2476, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 43, 43, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2477, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 43, 43, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2478, 'Expense - Travel', 200, 'Expense', 'INR', 6, 43, 43, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2479, 'Expense - Housing', 600, 'Expense', 'INR', 3, 43, 43, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2480, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 43, 43, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2481, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 43, 43, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2482, 'Expense - Education', 200, 'Expense', 'INR', 8, 43, 43, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2483, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 43, 43, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2484, 'Expense - Food & Dining', 1700, 'Expense', 'INR', 1, 43, 43, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2485, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 43, 43, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2486, 'Expense - Travel', 200, 'Expense', 'INR', 6, 43, 43, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2487, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 43, 43, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2488, 'Expense - Food & Dining', 600, 'Expense', 'INR', 1, 43, 43, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2489, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 43, 43, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2490, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 43, 43, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2491, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 43, 43, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2492, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 43, 43, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2493, 'Expense - Education', 200, 'Expense', 'INR', 8, 43, 43, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2494, 'Expense - Housing', 900, 'Expense', 'INR', 3, 43, 43, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2495, 'Expense - Shopping', 800, 'Expense', 'INR', 7, 43, 43, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2496, 'Expense - Education', 200, 'Expense', 'INR', 8, 43, 43, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2497, 'Expense - Education', 200, 'Expense', 'INR', 8, 43, 43, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2498, 'Expense - Food & Dining', 1100, 'Expense', 'INR', 1, 43, 43, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2499, 'Expense - Education', 200, 'Expense', 'INR', 8, 43, 43, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2500, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 43, 43, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2501, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 43, 43, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2502, 'Expense - Travel', 200, 'Expense', 'INR', 6, 43, 43, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2503, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 43, 43, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2504, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 43, 43, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2505, 'Expense - Food & Dining', 700, 'Expense', 'INR', 1, 43, 43, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2506, 'Expense - Travel', 200, 'Expense', 'INR', 6, 43, 43, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2507, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 43, 43, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2508, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 43, 43, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2509, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 44, 44, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2510, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 44, 44, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2511, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 44, 44, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2512, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 44, 44, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2513, 'Expense - Housing', 2200, 'Expense', 'INR', 3, 44, 44, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2514, 'Expense - Education', 200, 'Expense', 'INR', 8, 44, 44, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2515, 'Expense - Travel', 200, 'Expense', 'INR', 6, 44, 44, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2516, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 44, 44, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2517, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 44, 44, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2518, 'Expense - Travel', 200, 'Expense', 'INR', 6, 44, 44, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2519, 'Expense - Housing', 200, 'Expense', 'INR', 3, 44, 44, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2520, 'Expense - Travel', 200, 'Expense', 'INR', 6, 44, 44, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2521, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 44, 44, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2522, 'Expense - Education', 200, 'Expense', 'INR', 8, 44, 44, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2523, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 44, 44, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2524, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 44, 44, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2525, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 44, 44, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2526, 'Expense - Housing', 300, 'Expense', 'INR', 3, 44, 44, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2527, 'Expense - Travel', 200, 'Expense', 'INR', 6, 44, 44, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2528, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 44, 44, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2529, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 44, 44, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2530, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 44, 44, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2531, 'Expense - Housing', 1000, 'Expense', 'INR', 3, 44, 44, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2532, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 44, 44, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2533, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 44, 44, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2534, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 44, 44, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2535, 'Expense - Travel', 200, 'Expense', 'INR', 6, 44, 44, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2536, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 44, 44, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2537, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 44, 44, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2538, 'Expense - Transportation', 600, 'Expense', 'INR', 2, 44, 44, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2539, 'Expense - Education', 200, 'Expense', 'INR', 8, 44, 44, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2540, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 44, 44, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2541, 'Expense - Transportation', 400, 'Expense', 'INR', 2, 44, 44, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2542, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 44, 44, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2543, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 44, 44, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2544, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 44, 44, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2545, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 44, 44, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2546, 'Expense - Food & Dining', 700, 'Expense', 'INR', 1, 44, 44, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2547, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 44, 44, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2548, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 44, 44, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2549, 'Expense - Education', 200, 'Expense', 'INR', 8, 44, 44, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2550, 'Expense - Travel', 200, 'Expense', 'INR', 6, 44, 44, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2551, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 44, 44, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2552, 'Expense - Travel', 200, 'Expense', 'INR', 6, 44, 44, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2553, 'Expense - Utilities', 400, 'Expense', 'INR', 9, 44, 44, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2554, 'Expense - Housing', 500, 'Expense', 'INR', 3, 44, 44, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2555, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 44, 44, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2556, 'Expense - Housing', 900, 'Expense', 'INR', 3, 44, 44, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2557, 'Expense - Transportation', 700, 'Expense', 'INR', 2, 44, 44, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2558, 'Expense - Food & Dining', 2000, 'Expense', 'INR', 1, 44, 44, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2559, 'Expense - Food & Dining', 700, 'Expense', 'INR', 1, 44, 44, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2560, 'Expense - Healthcare', 600, 'Expense', 'INR', 4, 44, 44, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2561, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 45, 45, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2562, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 45, 45, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2563, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 45, 45, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2564, 'Expense - Housing', 500, 'Expense', 'INR', 3, 45, 45, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2565, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 45, 45, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2566, 'Expense - Travel', 200, 'Expense', 'INR', 6, 45, 45, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2567, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 45, 45, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2568, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 45, 45, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2569, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 45, 45, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2570, 'Expense - Education', 200, 'Expense', 'INR', 8, 45, 45, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2571, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 45, 45, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2572, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 45, 45, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2573, 'Expense - Education', 200, 'Expense', 'INR', 8, 45, 45, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2574, 'Expense - Food & Dining', 900, 'Expense', 'INR', 1, 45, 45, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2575, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 45, 45, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2576, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 45, 45, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2577, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 45, 45, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2578, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 45, 45, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2579, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 45, 45, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2580, 'Expense - Housing', 200, 'Expense', 'INR', 3, 45, 45, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2581, 'Expense - Housing', 800, 'Expense', 'INR', 3, 45, 45, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2582, 'Expense - Housing', 200, 'Expense', 'INR', 3, 45, 45, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2583, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 45, 45, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2584, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 45, 45, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2585, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 45, 45, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2586, 'Expense - Housing', 200, 'Expense', 'INR', 3, 45, 45, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2587, 'Expense - Travel', 200, 'Expense', 'INR', 6, 45, 45, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2588, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 45, 45, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2589, 'Expense - Travel', 200, 'Expense', 'INR', 6, 45, 45, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2590, 'Expense - Travel', 200, 'Expense', 'INR', 6, 45, 45, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2591, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 45, 45, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2592, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 45, 45, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2593, 'Expense - Food & Dining', 1100, 'Expense', 'INR', 1, 45, 45, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2594, 'Expense - Housing', 300, 'Expense', 'INR', 3, 45, 45, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2595, 'Expense - Travel', 200, 'Expense', 'INR', 6, 45, 45, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2596, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 45, 45, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2597, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 45, 45, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2598, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 45, 45, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2599, 'Expense - Housing', 600, 'Expense', 'INR', 3, 45, 45, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2600, 'Expense - Travel', 300, 'Expense', 'INR', 6, 45, 45, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2601, 'Expense - Housing', 800, 'Expense', 'INR', 3, 45, 45, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2602, 'Expense - Travel', 200, 'Expense', 'INR', 6, 45, 45, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2603, 'Expense - Education', 200, 'Expense', 'INR', 8, 45, 45, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2604, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 45, 45, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2605, 'Expense - Travel', 200, 'Expense', 'INR', 6, 45, 45, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2606, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 45, 45, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2607, 'Expense - Travel', 200, 'Expense', 'INR', 6, 45, 45, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2608, 'Expense - Education', 200, 'Expense', 'INR', 8, 45, 45, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2609, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 45, 45, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2610, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 45, 45, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2611, 'Expense - Education', 200, 'Expense', 'INR', 8, 45, 45, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2612, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 45, 45, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2613, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 45, 45, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2614, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 45, 45, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2615, 'Expense - Food & Dining', 1500, 'Expense', 'INR', 1, 45, 45, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2616, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 45, 45, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2617, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 45, 45, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2618, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 45, 45, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2619, 'Expense - Education', 200, 'Expense', 'INR', 8, 45, 45, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2620, 'Expense - Travel', 200, 'Expense', 'INR', 6, 45, 45, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2621, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 45, 45, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2622, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 45, 45, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2623, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 45, 45, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2624, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 45, 45, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2625, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 45, 45, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2626, 'Expense - Food & Dining', 2000, 'Expense', 'INR', 1, 45, 45, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2627, 'Expense - Travel', 200, 'Expense', 'INR', 6, 45, 45, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2628, 'Expense - Shopping', 500, 'Expense', 'INR', 7, 45, 45, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2629, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 45, 45, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2630, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 45, 45, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2631, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 45, 45, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2632, 'Expense - Education', 400, 'Expense', 'INR', 8, 45, 45, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2633, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 45, 45, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2634, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 45, 45, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2635, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 45, 45, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2636, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 45, 45, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2637, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 45, 45, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2638, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 46, 46, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2639, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 46, 46, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2640, 'Expense - Housing', 200, 'Expense', 'INR', 3, 46, 46, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2641, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 46, 46, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2642, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 46, 46, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2643, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 46, 46, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2644, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 46, 46, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2645, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 46, 46, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2646, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 46, 46, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2647, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 46, 46, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2648, 'Expense - Transportation', 400, 'Expense', 'INR', 2, 46, 46, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2649, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 46, 46, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2650, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 46, 46, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2651, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 46, 46, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2652, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 46, 46, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2653, 'Expense - Travel', 200, 'Expense', 'INR', 6, 46, 46, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2654, 'Expense - Travel', 200, 'Expense', 'INR', 6, 46, 46, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2655, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 46, 46, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2656, 'Expense - Shopping', 400, 'Expense', 'INR', 7, 46, 46, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2657, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 46, 46, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2658, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 46, 46, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2659, 'Expense - Travel', 200, 'Expense', 'INR', 6, 46, 46, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2660, 'Expense - Housing', 200, 'Expense', 'INR', 3, 46, 46, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2661, 'Expense - Travel', 200, 'Expense', 'INR', 6, 46, 46, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2662, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 46, 46, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2663, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 46, 46, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2664, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 46, 46, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2665, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 46, 46, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2666, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 46, 46, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2667, 'Expense - Education', 200, 'Expense', 'INR', 8, 46, 46, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2668, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 46, 46, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2669, 'Expense - Housing', 500, 'Expense', 'INR', 3, 46, 46, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2670, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 46, 46, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2671, 'Expense - Education', 200, 'Expense', 'INR', 8, 46, 46, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2672, 'Expense - Education', 200, 'Expense', 'INR', 8, 46, 46, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2673, 'Expense - Education', 200, 'Expense', 'INR', 8, 46, 46, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2674, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 46, 46, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2675, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 46, 46, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2676, 'Expense - Travel', 200, 'Expense', 'INR', 6, 46, 46, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2677, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 46, 46, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2678, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 46, 46, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2679, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 46, 46, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2680, 'Expense - Travel', 200, 'Expense', 'INR', 6, 46, 46, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2681, 'Expense - Education', 200, 'Expense', 'INR', 8, 46, 46, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2682, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 46, 46, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2683, 'Expense - Housing', 600, 'Expense', 'INR', 3, 46, 46, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2684, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 46, 46, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2685, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 46, 46, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2686, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 46, 46, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2687, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 46, 46, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2688, 'Expense - Housing', 400, 'Expense', 'INR', 3, 46, 46, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2689, 'Expense - Education', 200, 'Expense', 'INR', 8, 46, 46, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2690, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 46, 46, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2691, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 46, 46, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2692, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 46, 46, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2693, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 46, 46, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2694, 'Expense - Education', 400, 'Expense', 'INR', 8, 46, 46, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2695, 'Expense - Housing', 400, 'Expense', 'INR', 3, 46, 46, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2696, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 46, 46, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2697, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 46, 46, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2698, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 46, 46, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2699, 'Expense - Transportation', 500, 'Expense', 'INR', 2, 46, 46, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2700, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 46, 46, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2701, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 46, 46, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2702, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 46, 46, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2703, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 46, 46, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2704, 'Expense - Housing', 1000, 'Expense', 'INR', 3, 46, 46, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2705, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 47, 47, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2706, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 47, 47, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2707, 'Expense - Housing', 200, 'Expense', 'INR', 3, 47, 47, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2708, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 47, 47, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2709, 'Expense - Education', 200, 'Expense', 'INR', 8, 47, 47, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2710, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 47, 47, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2711, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 47, 47, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2712, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 47, 47, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2713, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 47, 47, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2714, 'Expense - Education', 200, 'Expense', 'INR', 8, 47, 47, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2715, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 47, 47, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2716, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 47, 47, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2717, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 47, 47, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2718, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 47, 47, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2719, 'Expense - Travel', 200, 'Expense', 'INR', 6, 47, 47, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2720, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 47, 47, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2721, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 47, 47, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2722, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 47, 47, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2723, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 47, 47, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2724, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 47, 47, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2725, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 47, 47, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2726, 'Expense - Travel', 200, 'Expense', 'INR', 6, 47, 47, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2727, 'Expense - Travel', 200, 'Expense', 'INR', 6, 47, 47, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2728, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 47, 47, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2729, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 47, 47, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2730, 'Expense - Education', 200, 'Expense', 'INR', 8, 47, 47, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2731, 'Expense - Transportation', 400, 'Expense', 'INR', 2, 47, 47, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2732, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 47, 47, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2733, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 47, 47, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2734, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 47, 47, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2735, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 47, 47, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2736, 'Expense - Housing', 400, 'Expense', 'INR', 3, 47, 47, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2737, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 47, 47, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2738, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 47, 47, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2739, 'Expense - Utilities', 400, 'Expense', 'INR', 9, 47, 47, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2740, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 47, 47, '2025-11-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2741, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 47, 47, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2742, 'Expense - Travel', 200, 'Expense', 'INR', 6, 47, 47, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2743, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 47, 47, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2744, 'Expense - Housing', 200, 'Expense', 'INR', 3, 47, 47, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2745, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 47, 47, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2746, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 47, 47, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2747, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 47, 47, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2748, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 47, 47, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2749, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 47, 47, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2750, 'Expense - Travel', 200, 'Expense', 'INR', 6, 47, 47, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2751, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 47, 47, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2752, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 47, 47, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2753, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 47, 47, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2754, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 47, 47, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2755, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 47, 47, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2756, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 47, 47, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2757, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 47, 47, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2758, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 47, 47, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2759, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 47, 47, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2760, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 47, 47, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2761, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 47, 47, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2762, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 47, 47, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2763, 'Expense - Transportation', 400, 'Expense', 'INR', 2, 47, 47, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2764, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 47, 47, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2765, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 47, 47, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2766, 'Expense - Housing', 300, 'Expense', 'INR', 3, 47, 47, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2767, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 47, 47, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2768, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 47, 47, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2769, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 47, 47, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2770, 'Expense - Travel', 200, 'Expense', 'INR', 6, 47, 47, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2771, 'Expense - Education', 200, 'Expense', 'INR', 8, 47, 47, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2772, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 47, 47, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2773, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 47, 47, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2774, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 47, 47, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2775, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 47, 47, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2776, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 47, 47, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2777, 'Expense - Housing', 200, 'Expense', 'INR', 3, 47, 47, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2778, 'Expense - Education', 200, 'Expense', 'INR', 8, 47, 47, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2779, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 47, 47, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2780, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 47, 47, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2781, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 47, 47, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2782, 'Expense - Education', 200, 'Expense', 'INR', 8, 47, 47, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2783, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 47, 47, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2784, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 47, 47, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2785, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 47, 47, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2786, 'Expense - Housing', 1100, 'Expense', 'INR', 3, 47, 47, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2787, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 47, 47, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2788, 'Expense - Travel', 200, 'Expense', 'INR', 6, 48, 48, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2789, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 48, 48, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2790, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 48, 48, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2791, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 48, 48, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2792, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 48, 48, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2793, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 48, 48, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2794, 'Expense - Travel', 200, 'Expense', 'INR', 6, 48, 48, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2795, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 48, 48, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2796, 'Expense - Travel', 200, 'Expense', 'INR', 6, 48, 48, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2797, 'Expense - Food & Dining', 1500, 'Expense', 'INR', 1, 48, 48, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2798, 'Expense - Travel', 200, 'Expense', 'INR', 6, 48, 48, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2799, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 48, 48, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2800, 'Expense - Education', 200, 'Expense', 'INR', 8, 48, 48, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2801, 'Expense - Housing', 900, 'Expense', 'INR', 3, 48, 48, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2802, 'Expense - Housing', 2800, 'Expense', 'INR', 3, 48, 48, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2803, 'Expense - Food & Dining', 800, 'Expense', 'INR', 1, 48, 48, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2804, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 48, 48, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2805, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 48, 48, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2806, 'Expense - Housing', 2200, 'Expense', 'INR', 3, 48, 48, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2807, 'Expense - Transportation', 400, 'Expense', 'INR', 2, 48, 48, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2808, 'Expense - Food & Dining', 1500, 'Expense', 'INR', 1, 48, 48, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2809, 'Expense - Housing', 300, 'Expense', 'INR', 3, 48, 48, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2810, 'Expense - Travel', 200, 'Expense', 'INR', 6, 48, 48, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2811, 'Expense - Food & Dining', 700, 'Expense', 'INR', 1, 48, 48, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2812, 'Expense - Education', 200, 'Expense', 'INR', 8, 48, 48, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2813, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 48, 48, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2814, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 48, 48, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2815, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 48, 48, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2816, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 48, 48, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2817, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 48, 48, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2818, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 48, 48, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2819, 'Expense - Travel', 200, 'Expense', 'INR', 6, 48, 48, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2820, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 48, 48, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2821, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 48, 48, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2822, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 48, 48, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2823, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 48, 48, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2824, 'Expense - Housing', 2800, 'Expense', 'INR', 3, 48, 48, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2825, 'Expense - Education', 500, 'Expense', 'INR', 8, 48, 48, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2826, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 48, 48, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2827, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 48, 48, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2828, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 48, 48, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2829, 'Expense - Education', 300, 'Expense', 'INR', 8, 48, 48, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2830, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 48, 48, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2831, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 48, 48, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2832, 'Expense - Shopping', 800, 'Expense', 'INR', 7, 48, 48, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2833, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 48, 48, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2834, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 48, 48, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2835, 'Expense - Housing', 1000, 'Expense', 'INR', 3, 48, 48, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2836, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 48, 48, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2837, 'Expense - Utilities', 500, 'Expense', 'INR', 9, 48, 48, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2838, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 48, 48, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2839, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 48, 48, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2840, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 48, 48, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2841, 'Expense - Housing', 200, 'Expense', 'INR', 3, 48, 48, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2842, 'Expense - Entertainment', 400, 'Expense', 'INR', 5, 48, 48, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2843, 'Expense - Education', 200, 'Expense', 'INR', 8, 48, 48, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2844, 'Expense - Travel', 200, 'Expense', 'INR', 6, 48, 48, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2845, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 48, 48, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2846, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 48, 48, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2847, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 48, 48, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2848, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 48, 48, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2849, 'Expense - Housing', 400, 'Expense', 'INR', 3, 48, 48, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2850, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 48, 48, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2851, 'Expense - Entertainment', 500, 'Expense', 'INR', 5, 48, 48, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2852, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 49, 49, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2853, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 49, 49, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2854, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 49, 49, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2855, 'Expense - Food & Dining', 600, 'Expense', 'INR', 1, 49, 49, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2856, 'Expense - Education', 200, 'Expense', 'INR', 8, 49, 49, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2857, 'Expense - Education', 200, 'Expense', 'INR', 8, 49, 49, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2858, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 49, 49, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2859, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 49, 49, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2860, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 49, 49, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2861, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 49, 49, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2862, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 49, 49, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2863, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 49, 49, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2864, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 49, 49, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2865, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 49, 49, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2866, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 49, 49, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2867, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 49, 49, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2868, 'Expense - Housing', 400, 'Expense', 'INR', 3, 49, 49, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2869, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 49, 49, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2870, 'Expense - Travel', 200, 'Expense', 'INR', 6, 49, 49, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2871, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 49, 49, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2872, 'Expense - Housing', 500, 'Expense', 'INR', 3, 49, 49, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2873, 'Expense - Housing', 200, 'Expense', 'INR', 3, 49, 49, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2874, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 49, 49, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2875, 'Expense - Travel', 200, 'Expense', 'INR', 6, 49, 49, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2876, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 49, 49, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2877, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 49, 49, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2878, 'Expense - Education', 200, 'Expense', 'INR', 8, 49, 49, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2879, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 49, 49, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2880, 'Expense - Education', 200, 'Expense', 'INR', 8, 49, 49, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2881, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 49, 49, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2882, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 49, 49, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2883, 'Expense - Utilities', 600, 'Expense', 'INR', 9, 49, 49, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2884, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 49, 49, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2885, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 49, 49, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2886, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 49, 49, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2887, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 49, 49, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2888, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 49, 49, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2889, 'Expense - Education', 200, 'Expense', 'INR', 8, 49, 49, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2890, 'Expense - Food & Dining', 700, 'Expense', 'INR', 1, 49, 49, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2891, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 49, 49, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2892, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 49, 49, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2893, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 49, 49, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2894, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 49, 49, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2895, 'Expense - Housing', 200, 'Expense', 'INR', 3, 49, 49, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2896, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 49, 49, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2897, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 49, 49, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2898, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 49, 49, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2899, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 49, 49, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2900, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 49, 49, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2901, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 49, 49, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2902, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 49, 49, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2903, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 49, 49, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2904, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 49, 49, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2905, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 49, 49, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2906, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 49, 49, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2907, 'Expense - Education', 200, 'Expense', 'INR', 8, 49, 49, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2908, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 49, 49, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2909, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 49, 49, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2910, 'Expense - Education', 200, 'Expense', 'INR', 8, 49, 49, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2911, 'Expense - Education', 200, 'Expense', 'INR', 8, 49, 49, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2912, 'Expense - Housing', 300, 'Expense', 'INR', 3, 49, 49, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2913, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 49, 49, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2914, 'Expense - Travel', 200, 'Expense', 'INR', 6, 49, 49, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2915, 'Expense - Travel', 200, 'Expense', 'INR', 6, 49, 49, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2916, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 49, 49, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2917, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 49, 49, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2918, 'Expense - Travel', 200, 'Expense', 'INR', 6, 49, 49, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2919, 'Expense - Travel', 200, 'Expense', 'INR', 6, 49, 49, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2920, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 49, 49, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2921, 'Expense - Education', 200, 'Expense', 'INR', 8, 49, 49, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2922, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 49, 49, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2923, 'Salary Income', 18100, 'Income', 'INR', 11, 1, 1, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2924, 'Salary Income', 19400, 'Income', 'INR', 11, 1, 1, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2925, 'Salary Income', 13000, 'Income', 'INR', 11, 1, 1, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2926, 'Salary Income', 12900, 'Income', 'INR', 11, 1, 1, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2927, 'Salary Income', 12800, 'Income', 'INR', 11, 1, 1, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2928, 'Salary Income', 19500, 'Income', 'INR', 11, 1, 1, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2929, 'Salary Income', 18500, 'Income', 'INR', 11, 1, 1, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2930, 'Salary Income', 16400, 'Income', 'INR', 11, 2, 2, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2931, 'Salary Income', 16100, 'Income', 'INR', 11, 2, 2, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2932, 'Salary Income', 17300, 'Income', 'INR', 11, 2, 2, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2933, 'Salary Income', 17300, 'Income', 'INR', 11, 2, 2, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2934, 'Salary Income', 16100, 'Income', 'INR', 11, 2, 2, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2935, 'Salary Income', 16500, 'Income', 'INR', 11, 2, 2, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2936, 'Salary Income', 24300, 'Income', 'INR', 11, 2, 2, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2937, 'Salary Income', 25700, 'Income', 'INR', 11, 2, 2, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2938, 'Salary Income', 8600, 'Income', 'INR', 11, 3, 3, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2939, 'Salary Income', 8600, 'Income', 'INR', 11, 3, 3, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2940, 'Salary Income', 8200, 'Income', 'INR', 11, 3, 3, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2941, 'Salary Income', 24400, 'Income', 'INR', 11, 3, 3, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2942, 'Salary Income', 12400, 'Income', 'INR', 11, 3, 3, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2943, 'Salary Income', 12200, 'Income', 'INR', 11, 3, 3, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2944, 'Salary Income', 36100, 'Income', 'INR', 11, 4, 4, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2945, 'Salary Income', 12400, 'Income', 'INR', 11, 4, 4, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2946, 'Salary Income', 12500, 'Income', 'INR', 11, 4, 4, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2947, 'Salary Income', 12900, 'Income', 'INR', 11, 4, 4, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2948, 'Salary Income', 18600, 'Income', 'INR', 11, 4, 4, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2949, 'Salary Income', 18800, 'Income', 'INR', 11, 4, 4, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2950, 'Salary Income', 36300, 'Income', 'INR', 11, 5, 5, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2951, 'Salary Income', 12100, 'Income', 'INR', 11, 5, 5, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2952, 'Salary Income', 12700, 'Income', 'INR', 11, 5, 5, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2953, 'Salary Income', 12900, 'Income', 'INR', 11, 5, 5, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2954, 'Salary Income', 36300, 'Income', 'INR', 11, 5, 5, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2955, 'Salary Income', 8000, 'Income', 'INR', 11, 6, 6, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2956, 'Salary Income', 8500, 'Income', 'INR', 11, 6, 6, '2025-09-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2957, 'Salary Income', 8400, 'Income', 'INR', 11, 6, 6, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2958, 'Salary Income', 8100, 'Income', 'INR', 11, 6, 6, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2959, 'Salary Income', 8400, 'Income', 'INR', 11, 6, 6, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2960, 'Salary Income', 8200, 'Income', 'INR', 11, 6, 6, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2961, 'Salary Income', 24100, 'Income', 'INR', 11, 6, 6, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2962, 'Salary Income', 37500, 'Income', 'INR', 11, 7, 7, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2963, 'Salary Income', 38200, 'Income', 'INR', 11, 7, 7, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2964, 'Salary Income', 19200, 'Income', 'INR', 11, 7, 7, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2965, 'Salary Income', 18600, 'Income', 'INR', 11, 7, 7, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2966, 'Salary Income', 48900, 'Income', 'INR', 11, 8, 8, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2967, 'Salary Income', 50200, 'Income', 'INR', 11, 8, 8, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2968, 'Salary Income', 50700, 'Income', 'INR', 11, 8, 8, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2969, 'Salary Income', 12100, 'Income', 'INR', 11, 9, 9, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2970, 'Salary Income', 12400, 'Income', 'INR', 11, 9, 9, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2971, 'Salary Income', 12100, 'Income', 'INR', 11, 9, 9, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2972, 'Salary Income', 12000, 'Income', 'INR', 11, 9, 9, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2973, 'Salary Income', 12200, 'Income', 'INR', 11, 9, 9, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2974, 'Salary Income', 12200, 'Income', 'INR', 11, 9, 9, '2025-10-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2975, 'Salary Income', 12900, 'Income', 'INR', 11, 9, 9, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2976, 'Salary Income', 12600, 'Income', 'INR', 11, 9, 9, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2977, 'Salary Income', 12600, 'Income', 'INR', 11, 9, 9, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2978, 'Salary Income', 25000, 'Income', 'INR', 11, 10, 10, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2979, 'Salary Income', 24400, 'Income', 'INR', 11, 10, 10, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2980, 'Salary Income', 8100, 'Income', 'INR', 11, 10, 10, '2025-11-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2981, 'Salary Income', 8100, 'Income', 'INR', 11, 10, 10, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2982, 'Salary Income', 8200, 'Income', 'INR', 11, 10, 10, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2983, 'Salary Income', 19100, 'Income', 'INR', 11, 11, 11, '2025-09-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2984, 'Salary Income', 18600, 'Income', 'INR', 11, 11, 11, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2985, 'Salary Income', 12400, 'Income', 'INR', 11, 11, 11, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2986, 'Salary Income', 12900, 'Income', 'INR', 11, 11, 11, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2987, 'Salary Income', 12400, 'Income', 'INR', 11, 11, 11, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2988, 'Salary Income', 12500, 'Income', 'INR', 11, 11, 11, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2989, 'Salary Income', 12300, 'Income', 'INR', 11, 11, 11, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2990, 'Salary Income', 12200, 'Income', 'INR', 11, 11, 11, '2025-11-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2991, 'Salary Income', 25900, 'Income', 'INR', 11, 12, 12, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2992, 'Salary Income', 8100, 'Income', 'INR', 11, 12, 12, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2993, 'Salary Income', 8400, 'Income', 'INR', 11, 12, 12, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2994, 'Salary Income', 8500, 'Income', 'INR', 11, 12, 12, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2995, 'Salary Income', 25300, 'Income', 'INR', 11, 12, 12, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2996, 'Salary Income', 37800, 'Income', 'INR', 11, 13, 13, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2997, 'Salary Income', 12100, 'Income', 'INR', 11, 13, 13, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (2999, 'Salary Income', 12200, 'Income', 'INR', 11, 13, 13, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3000, 'Salary Income', 36700, 'Income', 'INR', 11, 13, 13, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3001, 'Salary Income', 12700, 'Income', 'INR', 11, 14, 14, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3002, 'Salary Income', 12300, 'Income', 'INR', 11, 14, 14, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3003, 'Salary Income', 12900, 'Income', 'INR', 11, 14, 14, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3004, 'Salary Income', 18000, 'Income', 'INR', 11, 14, 14, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3005, 'Salary Income', 19300, 'Income', 'INR', 11, 14, 14, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3006, 'Salary Income', 38400, 'Income', 'INR', 11, 14, 14, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3007, 'Salary Income', 25600, 'Income', 'INR', 11, 15, 15, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3008, 'Salary Income', 25500, 'Income', 'INR', 11, 15, 15, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3009, 'Salary Income', 17000, 'Income', 'INR', 11, 15, 15, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3010, 'Salary Income', 16100, 'Income', 'INR', 11, 15, 15, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3011, 'Salary Income', 16500, 'Income', 'INR', 11, 15, 15, '2025-10-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3012, 'Salary Income', 50200, 'Income', 'INR', 11, 15, 15, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3013, 'Salary Income', 25800, 'Income', 'INR', 11, 16, 16, '2025-09-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3014, 'Salary Income', 25300, 'Income', 'INR', 11, 16, 16, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3015, 'Salary Income', 24800, 'Income', 'INR', 11, 16, 16, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3016, 'Salary Income', 25000, 'Income', 'INR', 11, 16, 16, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3017, 'Salary Income', 51000, 'Income', 'INR', 11, 16, 16, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3018, 'Salary Income', 25300, 'Income', 'INR', 11, 17, 17, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3019, 'Salary Income', 8200, 'Income', 'INR', 11, 17, 17, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3020, 'Salary Income', 8400, 'Income', 'INR', 11, 17, 17, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3021, 'Salary Income', 8400, 'Income', 'INR', 11, 17, 17, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3022, 'Salary Income', 12400, 'Income', 'INR', 11, 17, 17, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3023, 'Salary Income', 12700, 'Income', 'INR', 11, 17, 17, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3024, 'Salary Income', 17100, 'Income', 'INR', 11, 18, 18, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3025, 'Salary Income', 16200, 'Income', 'INR', 11, 18, 18, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3026, 'Salary Income', 17300, 'Income', 'INR', 11, 18, 18, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3027, 'Salary Income', 24200, 'Income', 'INR', 11, 18, 18, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3028, 'Salary Income', 25000, 'Income', 'INR', 11, 18, 18, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3029, 'Salary Income', 25800, 'Income', 'INR', 11, 18, 18, '2025-11-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3030, 'Salary Income', 25100, 'Income', 'INR', 11, 18, 18, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3031, 'Salary Income', 49000, 'Income', 'INR', 11, 19, 19, '2025-09-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3032, 'Salary Income', 25100, 'Income', 'INR', 11, 19, 19, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3033, 'Salary Income', 25500, 'Income', 'INR', 11, 19, 19, '2025-10-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3034, 'Salary Income', 16500, 'Income', 'INR', 11, 19, 19, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3035, 'Salary Income', 16900, 'Income', 'INR', 11, 19, 19, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3036, 'Salary Income', 17200, 'Income', 'INR', 11, 19, 19, '2025-11-28 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3037, 'Salary Income', 8100, 'Income', 'INR', 11, 20, 20, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3038, 'Salary Income', 8400, 'Income', 'INR', 11, 20, 20, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3039, 'Salary Income', 8400, 'Income', 'INR', 11, 20, 20, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3040, 'Salary Income', 12000, 'Income', 'INR', 11, 20, 20, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3041, 'Salary Income', 12700, 'Income', 'INR', 11, 20, 20, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3042, 'Salary Income', 12600, 'Income', 'INR', 11, 20, 20, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3043, 'Salary Income', 12700, 'Income', 'INR', 11, 20, 20, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3044, 'Salary Income', 12900, 'Income', 'INR', 11, 21, 21, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3045, 'Salary Income', 12900, 'Income', 'INR', 11, 21, 21, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3046, 'Salary Income', 12400, 'Income', 'INR', 11, 21, 21, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3047, 'Salary Income', 12800, 'Income', 'INR', 11, 21, 21, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3048, 'Salary Income', 12600, 'Income', 'INR', 11, 21, 21, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3049, 'Salary Income', 12500, 'Income', 'INR', 11, 21, 21, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3050, 'Salary Income', 19400, 'Income', 'INR', 11, 21, 21, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3051, 'Salary Income', 19400, 'Income', 'INR', 11, 21, 21, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3052, 'Salary Income', 16500, 'Income', 'INR', 11, 22, 22, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3053, 'Salary Income', 17000, 'Income', 'INR', 11, 22, 22, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3054, 'Salary Income', 16900, 'Income', 'INR', 11, 22, 22, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3055, 'Salary Income', 16900, 'Income', 'INR', 11, 22, 22, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3056, 'Salary Income', 17000, 'Income', 'INR', 11, 22, 22, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3057, 'Salary Income', 17000, 'Income', 'INR', 11, 22, 22, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3058, 'Salary Income', 49400, 'Income', 'INR', 11, 22, 22, '2025-11-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3059, 'Salary Income', 51100, 'Income', 'INR', 11, 23, 23, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3060, 'Salary Income', 51000, 'Income', 'INR', 11, 23, 23, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3061, 'Salary Income', 17100, 'Income', 'INR', 11, 23, 23, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3062, 'Salary Income', 16400, 'Income', 'INR', 11, 23, 23, '2025-11-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3063, 'Salary Income', 17200, 'Income', 'INR', 11, 23, 23, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3064, 'Salary Income', 12600, 'Income', 'INR', 11, 24, 24, '2025-09-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3065, 'Salary Income', 12100, 'Income', 'INR', 11, 24, 24, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3066, 'Salary Income', 12700, 'Income', 'INR', 11, 24, 24, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3067, 'Salary Income', 12900, 'Income', 'INR', 11, 24, 24, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3068, 'Salary Income', 25300, 'Income', 'INR', 11, 24, 24, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3069, 'Salary Income', 16600, 'Income', 'INR', 11, 25, 25, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3070, 'Salary Income', 16000, 'Income', 'INR', 11, 25, 25, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3071, 'Salary Income', 16300, 'Income', 'INR', 11, 25, 25, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3072, 'Salary Income', 25200, 'Income', 'INR', 11, 25, 25, '2025-10-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3073, 'Salary Income', 25200, 'Income', 'INR', 11, 25, 25, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3074, 'Salary Income', 24800, 'Income', 'INR', 11, 25, 25, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3075, 'Salary Income', 24000, 'Income', 'INR', 11, 25, 25, '2025-11-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3076, 'Salary Income', 49800, 'Income', 'INR', 11, 26, 26, '2025-09-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3077, 'Salary Income', 24700, 'Income', 'INR', 11, 26, 26, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3078, 'Salary Income', 24000, 'Income', 'INR', 11, 26, 26, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3079, 'Salary Income', 17000, 'Income', 'INR', 11, 26, 26, '2025-11-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3080, 'Salary Income', 16600, 'Income', 'INR', 11, 26, 26, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3081, 'Salary Income', 16800, 'Income', 'INR', 11, 26, 26, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3082, 'Salary Income', 18700, 'Income', 'INR', 11, 27, 27, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3083, 'Salary Income', 18500, 'Income', 'INR', 11, 27, 27, '2025-09-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3084, 'Salary Income', 36300, 'Income', 'INR', 11, 27, 27, '2025-10-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3085, 'Salary Income', 18500, 'Income', 'INR', 11, 27, 27, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3086, 'Salary Income', 18100, 'Income', 'INR', 11, 27, 27, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3087, 'Salary Income', 16500, 'Income', 'INR', 11, 28, 28, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3088, 'Salary Income', 16100, 'Income', 'INR', 11, 28, 28, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3089, 'Salary Income', 16200, 'Income', 'INR', 11, 28, 28, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3090, 'Salary Income', 16700, 'Income', 'INR', 11, 28, 28, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3091, 'Salary Income', 17200, 'Income', 'INR', 11, 28, 28, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3092, 'Salary Income', 17100, 'Income', 'INR', 11, 28, 28, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3093, 'Salary Income', 50000, 'Income', 'INR', 11, 28, 28, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3094, 'Salary Income', 16300, 'Income', 'INR', 11, 29, 29, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3095, 'Salary Income', 17000, 'Income', 'INR', 11, 29, 29, '2025-09-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3096, 'Salary Income', 16800, 'Income', 'INR', 11, 29, 29, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3097, 'Salary Income', 16800, 'Income', 'INR', 11, 29, 29, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3098, 'Salary Income', 17000, 'Income', 'INR', 11, 29, 29, '2025-10-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3099, 'Salary Income', 16600, 'Income', 'INR', 11, 29, 29, '2025-10-06 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3100, 'Salary Income', 25500, 'Income', 'INR', 11, 29, 29, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3101, 'Salary Income', 25900, 'Income', 'INR', 11, 29, 29, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3102, 'Salary Income', 24600, 'Income', 'INR', 11, 30, 30, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3103, 'Salary Income', 8400, 'Income', 'INR', 11, 30, 30, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3104, 'Salary Income', 8200, 'Income', 'INR', 11, 30, 30, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3105, 'Salary Income', 8300, 'Income', 'INR', 11, 30, 30, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3106, 'Salary Income', 12600, 'Income', 'INR', 11, 30, 30, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3107, 'Salary Income', 12900, 'Income', 'INR', 11, 30, 30, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3108, 'Salary Income', 8100, 'Income', 'INR', 11, 31, 31, '2025-09-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3109, 'Salary Income', 8300, 'Income', 'INR', 11, 31, 31, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3110, 'Salary Income', 8500, 'Income', 'INR', 11, 31, 31, '2025-09-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3111, 'Salary Income', 12600, 'Income', 'INR', 11, 31, 31, '2025-10-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3112, 'Salary Income', 12900, 'Income', 'INR', 11, 31, 31, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3113, 'Salary Income', 25100, 'Income', 'INR', 11, 31, 31, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3114, 'Salary Income', 24800, 'Income', 'INR', 11, 32, 32, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3115, 'Salary Income', 24300, 'Income', 'INR', 11, 32, 32, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3116, 'Salary Income', 12700, 'Income', 'INR', 11, 32, 32, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3117, 'Salary Income', 12500, 'Income', 'INR', 11, 32, 32, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3118, 'Salary Income', 51900, 'Income', 'INR', 11, 33, 33, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3119, 'Salary Income', 24500, 'Income', 'INR', 11, 33, 33, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3120, 'Salary Income', 24400, 'Income', 'INR', 11, 33, 33, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3121, 'Salary Income', 16600, 'Income', 'INR', 11, 33, 33, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3122, 'Salary Income', 16000, 'Income', 'INR', 11, 33, 33, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3123, 'Salary Income', 16600, 'Income', 'INR', 11, 33, 33, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3124, 'Salary Income', 12600, 'Income', 'INR', 11, 34, 34, '2025-09-25 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3125, 'Salary Income', 12800, 'Income', 'INR', 11, 34, 34, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3126, 'Salary Income', 8300, 'Income', 'INR', 11, 34, 34, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3127, 'Salary Income', 8000, 'Income', 'INR', 11, 34, 34, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3128, 'Salary Income', 8200, 'Income', 'INR', 11, 34, 34, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3129, 'Salary Income', 25900, 'Income', 'INR', 11, 34, 34, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3130, 'Salary Income', 24400, 'Income', 'INR', 11, 35, 35, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3131, 'Salary Income', 26000, 'Income', 'INR', 11, 35, 35, '2025-10-30 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3132, 'Salary Income', 8400, 'Income', 'INR', 11, 35, 35, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3133, 'Salary Income', 8300, 'Income', 'INR', 11, 35, 35, '2025-11-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3134, 'Salary Income', 8200, 'Income', 'INR', 11, 35, 35, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3135, 'Salary Income', 36700, 'Income', 'INR', 11, 36, 36, '2025-09-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3136, 'Salary Income', 13000, 'Income', 'INR', 11, 36, 36, '2025-10-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3137, 'Salary Income', 12600, 'Income', 'INR', 11, 36, 36, '2025-10-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3138, 'Salary Income', 12800, 'Income', 'INR', 11, 36, 36, '2025-10-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3139, 'Salary Income', 12600, 'Income', 'INR', 11, 36, 36, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3140, 'Salary Income', 12300, 'Income', 'INR', 11, 36, 36, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3141, 'Salary Income', 13000, 'Income', 'INR', 11, 36, 36, '2025-11-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3142, 'Salary Income', 19100, 'Income', 'INR', 11, 37, 37, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3143, 'Salary Income', 18800, 'Income', 'INR', 11, 37, 37, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3144, 'Salary Income', 36500, 'Income', 'INR', 11, 37, 37, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3145, 'Salary Income', 18700, 'Income', 'INR', 11, 37, 37, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3146, 'Salary Income', 18100, 'Income', 'INR', 11, 37, 37, '2025-11-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3147, 'Salary Income', 12400, 'Income', 'INR', 11, 38, 38, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3148, 'Salary Income', 12900, 'Income', 'INR', 11, 38, 38, '2025-09-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3149, 'Salary Income', 24100, 'Income', 'INR', 11, 38, 38, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3150, 'Salary Income', 25800, 'Income', 'INR', 11, 38, 38, '2025-11-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3151, 'Salary Income', 18500, 'Income', 'INR', 11, 39, 39, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3152, 'Salary Income', 19000, 'Income', 'INR', 11, 39, 39, '2025-09-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3153, 'Salary Income', 38400, 'Income', 'INR', 11, 39, 39, '2025-10-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3154, 'Salary Income', 12600, 'Income', 'INR', 11, 39, 39, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3155, 'Salary Income', 12500, 'Income', 'INR', 11, 39, 39, '2025-11-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3156, 'Salary Income', 12400, 'Income', 'INR', 11, 39, 39, '2025-11-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3157, 'Salary Income', 36400, 'Income', 'INR', 11, 40, 40, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3158, 'Salary Income', 36800, 'Income', 'INR', 11, 40, 40, '2025-10-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3159, 'Salary Income', 19300, 'Income', 'INR', 11, 40, 40, '2025-11-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3160, 'Salary Income', 19400, 'Income', 'INR', 11, 40, 40, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3161, 'Salary Income', 25300, 'Income', 'INR', 11, 41, 41, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3162, 'Salary Income', 24500, 'Income', 'INR', 11, 41, 41, '2025-10-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3163, 'Salary Income', 8500, 'Income', 'INR', 11, 41, 41, '2025-11-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3164, 'Salary Income', 8300, 'Income', 'INR', 11, 41, 41, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3165, 'Salary Income', 8700, 'Income', 'INR', 11, 41, 41, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3166, 'Salary Income', 16700, 'Income', 'INR', 11, 42, 42, '2025-09-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3167, 'Salary Income', 17000, 'Income', 'INR', 11, 42, 42, '2025-09-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3168, 'Salary Income', 16600, 'Income', 'INR', 11, 42, 42, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3169, 'Salary Income', 16900, 'Income', 'INR', 11, 42, 42, '2025-10-15 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3170, 'Salary Income', 16200, 'Income', 'INR', 11, 42, 42, '2025-10-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3171, 'Salary Income', 16500, 'Income', 'INR', 11, 42, 42, '2025-10-21 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3172, 'Salary Income', 16200, 'Income', 'INR', 11, 42, 42, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3173, 'Salary Income', 16500, 'Income', 'INR', 11, 42, 42, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3174, 'Salary Income', 16300, 'Income', 'INR', 11, 42, 42, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3175, 'Salary Income', 49600, 'Income', 'INR', 11, 43, 43, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3176, 'Salary Income', 50300, 'Income', 'INR', 11, 43, 43, '2025-10-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3177, 'Salary Income', 25800, 'Income', 'INR', 11, 43, 43, '2025-11-12 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3178, 'Salary Income', 25900, 'Income', 'INR', 11, 43, 43, '2025-11-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3179, 'Salary Income', 17300, 'Income', 'INR', 11, 44, 44, '2025-09-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3180, 'Salary Income', 16300, 'Income', 'INR', 11, 44, 44, '2025-09-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3181, 'Salary Income', 16300, 'Income', 'INR', 11, 44, 44, '2025-09-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3182, 'Salary Income', 51200, 'Income', 'INR', 11, 44, 44, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3183, 'Salary Income', 25700, 'Income', 'INR', 11, 44, 44, '2025-11-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3184, 'Salary Income', 24600, 'Income', 'INR', 11, 44, 44, '2025-11-14 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3185, 'Salary Income', 19400, 'Income', 'INR', 11, 45, 45, '2025-09-05 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3186, 'Salary Income', 19500, 'Income', 'INR', 11, 45, 45, '2025-09-13 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3187, 'Salary Income', 12800, 'Income', 'INR', 11, 45, 45, '2025-10-24 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3188, 'Salary Income', 12000, 'Income', 'INR', 11, 45, 45, '2025-10-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3189, 'Salary Income', 12600, 'Income', 'INR', 11, 45, 45, '2025-10-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3190, 'Salary Income', 18300, 'Income', 'INR', 11, 45, 45, '2025-11-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3191, 'Salary Income', 18200, 'Income', 'INR', 11, 45, 45, '2025-11-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3192, 'Salary Income', 8300, 'Income', 'INR', 11, 46, 46, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3193, 'Salary Income', 8100, 'Income', 'INR', 11, 46, 46, '2025-09-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3194, 'Salary Income', 8200, 'Income', 'INR', 11, 46, 46, '2025-09-17 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3195, 'Salary Income', 12700, 'Income', 'INR', 11, 46, 46, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3196, 'Salary Income', 12600, 'Income', 'INR', 11, 46, 46, '2025-10-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3197, 'Salary Income', 12100, 'Income', 'INR', 11, 46, 46, '2025-11-11 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3198, 'Salary Income', 12300, 'Income', 'INR', 11, 46, 46, '2025-11-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3199, 'Salary Income', 12900, 'Income', 'INR', 11, 47, 47, '2025-09-10 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3200, 'Salary Income', 12300, 'Income', 'INR', 11, 47, 47, '2025-09-16 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3201, 'Salary Income', 8000, 'Income', 'INR', 11, 47, 47, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3202, 'Salary Income', 8100, 'Income', 'INR', 11, 47, 47, '2025-10-19 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3203, 'Salary Income', 8600, 'Income', 'INR', 11, 47, 47, '2025-10-07 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3204, 'Salary Income', 25400, 'Income', 'INR', 11, 47, 47, '2025-11-09 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3205, 'Salary Income', 50000, 'Income', 'INR', 11, 48, 48, '2025-09-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3206, 'Salary Income', 24200, 'Income', 'INR', 11, 48, 48, '2025-10-31 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3207, 'Salary Income', 24900, 'Income', 'INR', 11, 48, 48, '2025-10-18 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3208, 'Salary Income', 50200, 'Income', 'INR', 11, 48, 48, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3209, 'Salary Income', 12800, 'Income', 'INR', 11, 49, 49, '2025-09-22 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3210, 'Salary Income', 12700, 'Income', 'INR', 11, 49, 49, '2025-09-20 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3211, 'Salary Income', 8500, 'Income', 'INR', 11, 49, 49, '2025-10-29 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3212, 'Salary Income', 8100, 'Income', 'INR', 11, 49, 49, '2025-10-03 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3213, 'Salary Income', 8400, 'Income', 'INR', 11, 49, 49, '2025-10-08 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3214, 'Salary Income', 24900, 'Income', 'INR', 11, 49, 49, '2025-11-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3215, 'Salary Income', 32500, 'Income', 'INR', 11, 50, 50, '2025-09-27 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3216, 'Salary Income', 30000, 'Income', 'INR', 11, 50, 50, '2025-09-02 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3217, 'Salary Income', 63600, 'Income', 'INR', 11, 50, 50, '2025-10-04 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3218, 'Salary Income', 21100, 'Income', 'INR', 11, 50, 50, '2025-11-26 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3219, 'Salary Income', 21600, 'Income', 'INR', 11, 50, 50, '2025-11-23 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3220, 'Salary Income', 20200, 'Income', 'INR', 11, 50, 50, '2025-11-01 00:00:00', '2025-12-03 20:23:56.23761', NULL);
INSERT INTO public.transactions VALUES (3221, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 1, 1, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3222, 'Expense - Housing', 200, 'Expense', 'INR', 3, 1, 1, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3223, 'Expense - Transportation', 700, 'Expense', 'INR', 2, 1, 1, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3224, 'Expense - Travel', 200, 'Expense', 'INR', 6, 1, 1, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3225, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 1, 1, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3226, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 1, 1, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3227, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 1, 1, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3228, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 1, 1, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3229, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 1, 1, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3230, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 1, 1, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3231, 'Expense - Education', 200, 'Expense', 'INR', 8, 1, 1, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3232, 'Expense - Travel', 200, 'Expense', 'INR', 6, 1, 1, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3233, 'Expense - Utilities', 400, 'Expense', 'INR', 9, 1, 1, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3234, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 1, 1, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3235, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 1, 1, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3236, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 1, 1, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3237, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 1, 1, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3238, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 1, 1, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3239, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 1, 1, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3240, 'Expense - Education', 200, 'Expense', 'INR', 8, 1, 1, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3241, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 1, 1, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3242, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 2, 2, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3243, 'Expense - Education', 200, 'Expense', 'INR', 8, 2, 2, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3244, 'Expense - Travel', 200, 'Expense', 'INR', 6, 2, 2, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3245, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 2, 2, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3246, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 2, 2, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3247, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 2, 2, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3248, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 2, 2, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3249, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 2, 2, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3250, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 2, 2, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3251, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 2, 2, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3252, 'Expense - Travel', 200, 'Expense', 'INR', 6, 2, 2, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3253, 'Expense - Education', 200, 'Expense', 'INR', 8, 2, 2, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3254, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 2, 2, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3255, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 2, 2, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3256, 'Expense - Education', 200, 'Expense', 'INR', 8, 2, 2, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3257, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 2, 2, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3258, 'Expense - Shopping', 500, 'Expense', 'INR', 7, 2, 2, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3259, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 2, 2, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3260, 'Expense - Education', 400, 'Expense', 'INR', 8, 2, 2, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3261, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 2, 2, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3262, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 2, 2, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3263, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 2, 2, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3264, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 2, 2, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3265, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 2, 2, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3266, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 2, 2, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3267, 'Expense - Travel', 200, 'Expense', 'INR', 6, 2, 2, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3268, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 2, 2, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3269, 'Expense - Housing', 1200, 'Expense', 'INR', 3, 2, 2, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3270, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 2, 2, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3271, 'Expense - Food & Dining', 1800, 'Expense', 'INR', 1, 2, 2, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3272, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 2, 2, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3273, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 2, 2, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3274, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 2, 2, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3275, 'Expense - Housing', 400, 'Expense', 'INR', 3, 2, 2, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3276, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 2, 2, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3277, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 2, 2, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3278, 'Expense - Education', 200, 'Expense', 'INR', 8, 2, 2, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3279, 'Expense - Transportation', 800, 'Expense', 'INR', 2, 2, 2, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3280, 'Expense - Housing', 200, 'Expense', 'INR', 3, 2, 2, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3281, 'Expense - Transportation', 400, 'Expense', 'INR', 2, 2, 2, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3282, 'Expense - Education', 400, 'Expense', 'INR', 8, 2, 2, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3283, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 3, 3, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3284, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 3, 3, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3285, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 4, 4, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3286, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 4, 4, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3287, 'Expense - Travel', 200, 'Expense', 'INR', 6, 4, 4, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3288, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 4, 4, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3289, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 4, 4, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3290, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 4, 4, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3291, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 4, 4, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3292, 'Expense - Housing', 300, 'Expense', 'INR', 3, 4, 4, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3293, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 4, 4, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3294, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 4, 4, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3295, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 4, 4, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3296, 'Expense - Travel', 200, 'Expense', 'INR', 6, 4, 4, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3297, 'Expense - Travel', 200, 'Expense', 'INR', 6, 4, 4, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3298, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 4, 4, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3299, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 5, 5, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3300, 'Expense - Housing', 400, 'Expense', 'INR', 3, 5, 5, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3301, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 5, 5, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3302, 'Expense - Housing', 600, 'Expense', 'INR', 3, 5, 5, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3303, 'Expense - Transportation', 500, 'Expense', 'INR', 2, 5, 5, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3304, 'Expense - Travel', 200, 'Expense', 'INR', 6, 5, 5, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3305, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 5, 5, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3306, 'Expense - Education', 200, 'Expense', 'INR', 8, 5, 5, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3307, 'Expense - Education', 200, 'Expense', 'INR', 8, 5, 5, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3308, 'Expense - Housing', 500, 'Expense', 'INR', 3, 5, 5, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3309, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 5, 5, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3310, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 5, 5, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3311, 'Expense - Housing', 500, 'Expense', 'INR', 3, 5, 5, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3312, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 5, 5, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3313, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 5, 5, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3314, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 5, 5, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3315, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 5, 5, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3316, 'Expense - Travel', 200, 'Expense', 'INR', 6, 5, 5, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3317, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 6, 6, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3318, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 6, 6, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3319, 'Expense - Education', 200, 'Expense', 'INR', 8, 6, 6, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3320, 'Expense - Healthcare', 300, 'Expense', 'INR', 4, 6, 6, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3321, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 6, 6, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3322, 'Expense - Housing', 1300, 'Expense', 'INR', 3, 6, 6, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3323, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 6, 6, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3324, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 7, 7, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3325, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 7, 7, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3326, 'Expense - Housing', 200, 'Expense', 'INR', 3, 7, 7, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3327, 'Expense - Utilities', 400, 'Expense', 'INR', 9, 7, 7, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3328, 'Expense - Travel', 200, 'Expense', 'INR', 6, 7, 7, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3329, 'Expense - Education', 200, 'Expense', 'INR', 8, 7, 7, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3330, 'Expense - Food & Dining', 1300, 'Expense', 'INR', 1, 7, 7, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3331, 'Expense - Education', 200, 'Expense', 'INR', 8, 7, 7, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3332, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 7, 7, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3333, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 7, 7, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3334, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 7, 7, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3335, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 7, 7, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3336, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 7, 7, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3337, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 7, 7, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3338, 'Expense - Education', 500, 'Expense', 'INR', 8, 8, 8, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3339, 'Expense - Travel', 200, 'Expense', 'INR', 6, 8, 8, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3340, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 8, 8, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3341, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 8, 8, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3342, 'Expense - Education', 400, 'Expense', 'INR', 8, 8, 8, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3343, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 8, 8, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3344, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 8, 8, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3345, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 8, 8, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3346, 'Expense - Education', 200, 'Expense', 'INR', 8, 8, 8, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3347, 'Expense - Food & Dining', 800, 'Expense', 'INR', 1, 8, 8, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3348, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 8, 8, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3349, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 8, 8, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3350, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 8, 8, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3351, 'Expense - Travel', 200, 'Expense', 'INR', 6, 8, 8, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3352, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 8, 8, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3353, 'Expense - Education', 200, 'Expense', 'INR', 8, 8, 8, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3354, 'Expense - Education', 200, 'Expense', 'INR', 8, 8, 8, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3355, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 8, 8, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3356, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 8, 8, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3357, 'Expense - Travel', 200, 'Expense', 'INR', 6, 8, 8, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3358, 'Expense - Education', 200, 'Expense', 'INR', 8, 8, 8, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3359, 'Expense - Transportation', 600, 'Expense', 'INR', 2, 8, 8, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3360, 'Expense - Healthcare', 600, 'Expense', 'INR', 4, 8, 8, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3361, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 8, 8, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3362, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 8, 8, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3363, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 8, 8, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3364, 'Expense - Travel', 200, 'Expense', 'INR', 6, 8, 8, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3365, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 8, 8, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3366, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 8, 8, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3367, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 8, 8, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3368, 'Expense - Housing', 400, 'Expense', 'INR', 3, 8, 8, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3369, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 8, 8, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3370, 'Expense - Housing', 1500, 'Expense', 'INR', 3, 9, 9, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3371, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 9, 9, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3372, 'Expense - Shopping', 400, 'Expense', 'INR', 7, 9, 9, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3373, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 9, 9, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3374, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 9, 9, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3375, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 9, 9, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3376, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 9, 9, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3377, 'Expense - Entertainment', 300, 'Expense', 'INR', 5, 9, 9, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3378, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 9, 9, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3379, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 9, 9, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3380, 'Expense - Utilities', 600, 'Expense', 'INR', 9, 9, 9, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3381, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 9, 9, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3382, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 9, 9, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3383, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 9, 9, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3384, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 9, 9, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3385, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 9, 9, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3386, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 9, 9, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3387, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 9, 9, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3388, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 9, 9, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3389, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 9, 9, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3390, 'Expense - Travel', 200, 'Expense', 'INR', 6, 9, 9, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3391, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 9, 9, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3392, 'Expense - Entertainment', 300, 'Expense', 'INR', 5, 9, 9, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3393, 'Expense - Food & Dining', 1100, 'Expense', 'INR', 1, 10, 10, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3394, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 10, 10, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3395, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 10, 10, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3396, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 10, 10, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3397, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 10, 10, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3398, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 11, 11, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3399, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 11, 11, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3400, 'Expense - Education', 200, 'Expense', 'INR', 8, 11, 11, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3401, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 11, 11, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3402, 'Expense - Education', 200, 'Expense', 'INR', 8, 11, 11, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3403, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 11, 11, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3404, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 11, 11, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3405, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 11, 11, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3406, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 11, 11, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3407, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 11, 11, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3408, 'Expense - Travel', 200, 'Expense', 'INR', 6, 11, 11, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3409, 'Expense - Housing', 300, 'Expense', 'INR', 3, 11, 11, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3410, 'Expense - Travel', 200, 'Expense', 'INR', 6, 11, 11, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3411, 'Expense - Food & Dining', 1300, 'Expense', 'INR', 1, 11, 11, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3412, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 11, 11, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3413, 'Expense - Education', 200, 'Expense', 'INR', 8, 11, 11, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3414, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 11, 11, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3415, 'Expense - Housing', 1000, 'Expense', 'INR', 3, 11, 11, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3416, 'Expense - Housing', 300, 'Expense', 'INR', 3, 11, 11, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3417, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 12, 12, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3418, 'Expense - Travel', 200, 'Expense', 'INR', 6, 12, 12, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3419, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 12, 12, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3420, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 12, 12, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3421, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 12, 12, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3422, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 13, 13, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3423, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 13, 13, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3424, 'Expense - Food & Dining', 600, 'Expense', 'INR', 1, 13, 13, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3425, 'Expense - Education', 200, 'Expense', 'INR', 8, 13, 13, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3426, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 13, 13, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3427, 'Expense - Shopping', 400, 'Expense', 'INR', 7, 13, 13, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3428, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 13, 13, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3429, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 13, 13, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3430, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 13, 13, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3431, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 13, 13, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3432, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 13, 13, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3433, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 13, 13, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3434, 'Expense - Travel', 200, 'Expense', 'INR', 6, 13, 13, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3435, 'Expense - Food & Dining', 700, 'Expense', 'INR', 1, 13, 13, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3436, 'Expense - Shopping', 600, 'Expense', 'INR', 7, 13, 13, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3437, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 13, 13, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3438, 'Expense - Housing', 300, 'Expense', 'INR', 3, 13, 13, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3439, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 13, 13, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3440, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 13, 13, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3441, 'Expense - Education', 200, 'Expense', 'INR', 8, 13, 13, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3442, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 13, 13, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3443, 'Expense - Travel', 200, 'Expense', 'INR', 6, 13, 13, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3444, 'Expense - Shopping', 500, 'Expense', 'INR', 7, 14, 14, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3445, 'Expense - Housing', 1700, 'Expense', 'INR', 3, 14, 14, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3446, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 14, 14, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3447, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 14, 14, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3448, 'Expense - Food & Dining', 1000, 'Expense', 'INR', 1, 14, 14, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3449, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 14, 14, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3450, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 14, 14, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3451, 'Expense - Housing', 1000, 'Expense', 'INR', 3, 14, 14, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3452, 'Expense - Travel', 200, 'Expense', 'INR', 6, 14, 14, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3453, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 14, 14, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3454, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 14, 14, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3455, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 14, 14, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3456, 'Expense - Transportation', 500, 'Expense', 'INR', 2, 15, 15, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3457, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 15, 15, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3458, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 15, 15, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3459, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 15, 15, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3460, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 15, 15, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3461, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 15, 15, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3462, 'Expense - Housing', 400, 'Expense', 'INR', 3, 15, 15, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3463, 'Expense - Food & Dining', 1400, 'Expense', 'INR', 1, 15, 15, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3464, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 15, 15, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3465, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 15, 15, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3466, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 15, 15, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3467, 'Expense - Travel', 200, 'Expense', 'INR', 6, 15, 15, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3468, 'Expense - Education', 200, 'Expense', 'INR', 8, 15, 15, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3469, 'Expense - Travel', 200, 'Expense', 'INR', 6, 15, 15, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3470, 'Expense - Education', 200, 'Expense', 'INR', 8, 15, 15, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3471, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 15, 15, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3472, 'Expense - Travel', 200, 'Expense', 'INR', 6, 15, 15, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3473, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 15, 15, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3474, 'Expense - Education', 200, 'Expense', 'INR', 8, 15, 15, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3475, 'Expense - Travel', 300, 'Expense', 'INR', 6, 15, 15, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3476, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 15, 15, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3477, 'Expense - Housing', 1100, 'Expense', 'INR', 3, 15, 15, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3478, 'Expense - Housing', 600, 'Expense', 'INR', 3, 15, 15, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3479, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 15, 15, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3480, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 15, 15, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3481, 'Expense - Housing', 400, 'Expense', 'INR', 3, 15, 15, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3482, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 15, 15, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3483, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 15, 15, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3484, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 15, 15, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3485, 'Expense - Education', 200, 'Expense', 'INR', 8, 15, 15, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3486, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 15, 15, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3487, 'Expense - Utilities', 500, 'Expense', 'INR', 9, 15, 15, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3488, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 16, 16, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3489, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 16, 16, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3490, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 16, 16, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3491, 'Expense - Entertainment', 400, 'Expense', 'INR', 5, 16, 16, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3492, 'Expense - Education', 200, 'Expense', 'INR', 8, 16, 16, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3493, 'Expense - Utilities', 500, 'Expense', 'INR', 9, 16, 16, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3494, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 16, 16, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3495, 'Expense - Education', 200, 'Expense', 'INR', 8, 16, 16, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3496, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 16, 16, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3497, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 16, 16, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3498, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 16, 16, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3499, 'Expense - Education', 200, 'Expense', 'INR', 8, 16, 16, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3500, 'Expense - Education', 200, 'Expense', 'INR', 8, 16, 16, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3501, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 16, 16, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3502, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 16, 16, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3503, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 16, 16, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3504, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 16, 16, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3505, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 16, 16, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3506, 'Expense - Travel', 200, 'Expense', 'INR', 6, 16, 16, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3507, 'Expense - Travel', 200, 'Expense', 'INR', 6, 16, 16, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3508, 'Expense - Travel', 200, 'Expense', 'INR', 6, 16, 16, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3509, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 16, 16, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3510, 'Expense - Travel', 200, 'Expense', 'INR', 6, 16, 16, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3511, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 16, 16, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3512, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 16, 16, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3513, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 16, 16, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3514, 'Expense - Education', 200, 'Expense', 'INR', 8, 16, 16, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3515, 'Expense - Travel', 200, 'Expense', 'INR', 6, 16, 16, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3516, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 16, 16, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3517, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 16, 16, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3518, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 16, 16, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3519, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 16, 16, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3520, 'Expense - Entertainment', 500, 'Expense', 'INR', 5, 16, 16, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3521, 'Expense - Utilities', 700, 'Expense', 'INR', 9, 16, 16, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3522, 'Expense - Education', 200, 'Expense', 'INR', 8, 16, 16, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3523, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 17, 17, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3524, 'Expense - Travel', 200, 'Expense', 'INR', 6, 17, 17, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3525, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 17, 17, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3526, 'Expense - Housing', 200, 'Expense', 'INR', 3, 17, 17, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3527, 'Expense - Utilities', 400, 'Expense', 'INR', 9, 17, 17, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3528, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 17, 17, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3529, 'Expense - Education', 200, 'Expense', 'INR', 8, 17, 17, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3530, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 18, 18, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3531, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 18, 18, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3532, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 18, 18, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3533, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 18, 18, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3534, 'Expense - Education', 200, 'Expense', 'INR', 8, 18, 18, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3535, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 18, 18, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3536, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 18, 18, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3537, 'Expense - Education', 200, 'Expense', 'INR', 8, 18, 18, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3538, 'Expense - Housing', 400, 'Expense', 'INR', 3, 18, 18, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3539, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 18, 18, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3540, 'Expense - Food & Dining', 700, 'Expense', 'INR', 1, 18, 18, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3541, 'Expense - Utilities', 400, 'Expense', 'INR', 9, 18, 18, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3542, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 18, 18, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3543, 'Expense - Food & Dining', 800, 'Expense', 'INR', 1, 18, 18, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3544, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 18, 18, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3545, 'Expense - Education', 200, 'Expense', 'INR', 8, 18, 18, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3546, 'Expense - Healthcare', 500, 'Expense', 'INR', 4, 18, 18, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3547, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 18, 18, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3548, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 18, 18, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3549, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 18, 18, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3550, 'Expense - Education', 200, 'Expense', 'INR', 8, 18, 18, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3551, 'Expense - Travel', 200, 'Expense', 'INR', 6, 18, 18, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3552, 'Expense - Housing', 2600, 'Expense', 'INR', 3, 18, 18, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3553, 'Expense - Education', 200, 'Expense', 'INR', 8, 18, 18, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3554, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 18, 18, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3555, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 18, 18, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3556, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 18, 18, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3557, 'Expense - Shopping', 400, 'Expense', 'INR', 7, 18, 18, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3558, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 18, 18, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3559, 'Expense - Travel', 200, 'Expense', 'INR', 6, 18, 18, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3560, 'Expense - Travel', 200, 'Expense', 'INR', 6, 18, 18, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3561, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 18, 18, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3562, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 18, 18, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3563, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 18, 18, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3564, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 19, 19, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3565, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 19, 19, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3566, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 19, 19, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3567, 'Expense - Education', 200, 'Expense', 'INR', 8, 19, 19, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3568, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 19, 19, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3569, 'Expense - Travel', 200, 'Expense', 'INR', 6, 19, 19, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3570, 'Expense - Transportation', 900, 'Expense', 'INR', 2, 19, 19, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3571, 'Expense - Travel', 200, 'Expense', 'INR', 6, 19, 19, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3572, 'Expense - Shopping', 700, 'Expense', 'INR', 7, 19, 19, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3573, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 19, 19, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3574, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 19, 19, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3575, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 19, 19, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3576, 'Expense - Shopping', 400, 'Expense', 'INR', 7, 19, 19, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3577, 'Expense - Healthcare', 400, 'Expense', 'INR', 4, 19, 19, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3578, 'Expense - Housing', 200, 'Expense', 'INR', 3, 19, 19, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3579, 'Expense - Transportation', 400, 'Expense', 'INR', 2, 19, 19, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3580, 'Expense - Education', 200, 'Expense', 'INR', 8, 19, 19, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3581, 'Expense - Housing', 300, 'Expense', 'INR', 3, 19, 19, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3582, 'Expense - Travel', 200, 'Expense', 'INR', 6, 19, 19, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3583, 'Expense - Housing', 300, 'Expense', 'INR', 3, 19, 19, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3584, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 19, 19, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3585, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 19, 19, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3586, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 19, 19, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3587, 'Expense - Education', 200, 'Expense', 'INR', 8, 19, 19, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3588, 'Expense - Education', 200, 'Expense', 'INR', 8, 19, 19, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3589, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 19, 19, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3590, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 19, 19, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3591, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 19, 19, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3592, 'Expense - Education', 200, 'Expense', 'INR', 8, 19, 19, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3593, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 19, 19, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3594, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 19, 19, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3595, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 20, 20, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3596, 'Expense - Housing', 200, 'Expense', 'INR', 3, 20, 20, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3597, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 20, 20, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3598, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 20, 20, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3599, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 20, 20, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3600, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 20, 20, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3601, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 21, 21, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3602, 'Expense - Transportation', 600, 'Expense', 'INR', 2, 21, 21, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3603, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 21, 21, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3604, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 21, 21, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3605, 'Expense - Education', 300, 'Expense', 'INR', 8, 21, 21, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3606, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 21, 21, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3607, 'Expense - Housing', 500, 'Expense', 'INR', 3, 21, 21, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3608, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 21, 21, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3609, 'Expense - Education', 200, 'Expense', 'INR', 8, 21, 21, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3610, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 21, 21, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3611, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 21, 21, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3612, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 21, 21, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3613, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 21, 21, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3614, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 21, 21, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3615, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 21, 21, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3616, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 21, 21, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3617, 'Expense - Education', 300, 'Expense', 'INR', 8, 21, 21, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3618, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 22, 22, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3619, 'Expense - Entertainment', 500, 'Expense', 'INR', 5, 22, 22, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3620, 'Expense - Education', 200, 'Expense', 'INR', 8, 22, 22, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3621, 'Expense - Travel', 200, 'Expense', 'INR', 6, 22, 22, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3622, 'Expense - Education', 200, 'Expense', 'INR', 8, 22, 22, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3623, 'Expense - Food & Dining', 1600, 'Expense', 'INR', 1, 22, 22, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3624, 'Expense - Healthcare', 400, 'Expense', 'INR', 4, 22, 22, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3625, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 22, 22, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3626, 'Expense - Education', 200, 'Expense', 'INR', 8, 22, 22, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3627, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 22, 22, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3628, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 22, 22, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3629, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 22, 22, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3630, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 22, 22, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3631, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 22, 22, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3632, 'Expense - Shopping', 400, 'Expense', 'INR', 7, 22, 22, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3633, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 22, 22, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3634, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 22, 22, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3635, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 22, 22, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3636, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 22, 22, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3637, 'Expense - Shopping', 700, 'Expense', 'INR', 7, 22, 22, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3638, 'Expense - Education', 200, 'Expense', 'INR', 8, 22, 22, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3639, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 22, 22, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3640, 'Expense - Food & Dining', 1700, 'Expense', 'INR', 1, 22, 22, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3641, 'Expense - Housing', 200, 'Expense', 'INR', 3, 22, 22, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3642, 'Expense - Travel', 200, 'Expense', 'INR', 6, 22, 22, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3643, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 22, 22, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3644, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 22, 22, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3645, 'Expense - Education', 200, 'Expense', 'INR', 8, 22, 22, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3646, 'Expense - Shopping', 600, 'Expense', 'INR', 7, 22, 22, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3647, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 22, 22, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3648, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 22, 22, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3649, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 22, 22, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3650, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 22, 22, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3651, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 22, 22, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3652, 'Expense - Education', 200, 'Expense', 'INR', 8, 22, 22, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3653, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 22, 22, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3654, 'Expense - Housing', 300, 'Expense', 'INR', 3, 22, 22, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3655, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 22, 22, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3656, 'Expense - Travel', 200, 'Expense', 'INR', 6, 22, 22, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3657, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 22, 22, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3658, 'Expense - Travel', 200, 'Expense', 'INR', 6, 22, 22, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3659, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 22, 22, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3660, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 22, 22, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3661, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 23, 23, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3662, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 23, 23, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3663, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 23, 23, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3664, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 23, 23, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3665, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 23, 23, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3666, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 23, 23, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3667, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 23, 23, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3668, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 23, 23, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3669, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 23, 23, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3670, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 23, 23, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3671, 'Expense - Shopping', 400, 'Expense', 'INR', 7, 23, 23, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3672, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 23, 23, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3673, 'Expense - Travel', 200, 'Expense', 'INR', 6, 23, 23, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3674, 'Expense - Housing', 1500, 'Expense', 'INR', 3, 23, 23, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3675, 'Expense - Travel', 400, 'Expense', 'INR', 6, 23, 23, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3676, 'Expense - Housing', 1100, 'Expense', 'INR', 3, 23, 23, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3677, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 23, 23, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3678, 'Expense - Education', 400, 'Expense', 'INR', 8, 23, 23, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3679, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 23, 23, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3680, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 23, 23, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3681, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 23, 23, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3682, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 23, 23, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3683, 'Expense - Education', 200, 'Expense', 'INR', 8, 23, 23, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3684, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 23, 23, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3685, 'Expense - Housing', 800, 'Expense', 'INR', 3, 23, 23, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3686, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 23, 23, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3687, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 23, 23, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3688, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 23, 23, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3689, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 23, 23, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3690, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 23, 23, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3691, 'Expense - Travel', 200, 'Expense', 'INR', 6, 23, 23, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3692, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 23, 23, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3693, 'Expense - Housing', 1000, 'Expense', 'INR', 3, 23, 23, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3694, 'Expense - Housing', 1400, 'Expense', 'INR', 3, 23, 23, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3695, 'Expense - Housing', 200, 'Expense', 'INR', 3, 23, 23, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3696, 'Expense - Travel', 200, 'Expense', 'INR', 6, 23, 23, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3697, 'Expense - Education', 200, 'Expense', 'INR', 8, 23, 23, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3698, 'Expense - Travel', 200, 'Expense', 'INR', 6, 23, 23, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3699, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 23, 23, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3700, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 23, 23, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3701, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 23, 23, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3702, 'Expense - Travel', 200, 'Expense', 'INR', 6, 25, 25, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3703, 'Expense - Education', 200, 'Expense', 'INR', 8, 25, 25, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3704, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 25, 25, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3705, 'Expense - Travel', 200, 'Expense', 'INR', 6, 25, 25, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3706, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 25, 25, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3707, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 25, 25, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3708, 'Expense - Travel', 200, 'Expense', 'INR', 6, 25, 25, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3709, 'Expense - Food & Dining', 1500, 'Expense', 'INR', 1, 25, 25, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3710, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 25, 25, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3711, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 25, 25, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3712, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 25, 25, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3713, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 25, 25, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3714, 'Expense - Food & Dining', 600, 'Expense', 'INR', 1, 25, 25, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3715, 'Expense - Shopping', 800, 'Expense', 'INR', 7, 25, 25, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3716, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 25, 25, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3717, 'Expense - Housing', 200, 'Expense', 'INR', 3, 25, 25, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3718, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 25, 25, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3719, 'Expense - Housing', 1700, 'Expense', 'INR', 3, 25, 25, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3720, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 25, 25, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3721, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 25, 25, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3722, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 25, 25, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3723, 'Expense - Housing', 300, 'Expense', 'INR', 3, 25, 25, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3724, 'Expense - Travel', 200, 'Expense', 'INR', 6, 25, 25, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3725, 'Expense - Transportation', 900, 'Expense', 'INR', 2, 25, 25, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3726, 'Expense - Utilities', 500, 'Expense', 'INR', 9, 25, 25, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3727, 'Expense - Travel', 200, 'Expense', 'INR', 6, 25, 25, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3728, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 25, 25, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3729, 'Expense - Travel', 200, 'Expense', 'INR', 6, 25, 25, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3730, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 25, 25, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3731, 'Expense - Education', 200, 'Expense', 'INR', 8, 26, 26, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3732, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 26, 26, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3733, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 26, 26, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3734, 'Expense - Education', 200, 'Expense', 'INR', 8, 26, 26, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3735, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 26, 26, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3736, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 26, 26, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3737, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 26, 26, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3738, 'Expense - Shopping', 600, 'Expense', 'INR', 7, 26, 26, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3739, 'Expense - Housing', 400, 'Expense', 'INR', 3, 26, 26, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3740, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 26, 26, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3741, 'Expense - Education', 200, 'Expense', 'INR', 8, 26, 26, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3742, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 26, 26, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3743, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 26, 26, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3744, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 26, 26, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3745, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 26, 26, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3746, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 26, 26, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3747, 'Expense - Transportation', 700, 'Expense', 'INR', 2, 26, 26, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3748, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 26, 26, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3749, 'Expense - Utilities', 600, 'Expense', 'INR', 9, 26, 26, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3750, 'Expense - Education', 200, 'Expense', 'INR', 8, 26, 26, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3751, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 26, 26, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3752, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 26, 26, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3753, 'Expense - Travel', 200, 'Expense', 'INR', 6, 26, 26, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3754, 'Expense - Travel', 200, 'Expense', 'INR', 6, 26, 26, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3755, 'Expense - Housing', 500, 'Expense', 'INR', 3, 26, 26, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3756, 'Expense - Travel', 200, 'Expense', 'INR', 6, 26, 26, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3757, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 26, 26, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3758, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 26, 26, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3759, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 26, 26, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3760, 'Expense - Transportation', 400, 'Expense', 'INR', 2, 26, 26, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3761, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 26, 26, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3762, 'Expense - Entertainment', 400, 'Expense', 'INR', 5, 26, 26, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3763, 'Expense - Housing', 200, 'Expense', 'INR', 3, 26, 26, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3764, 'Expense - Food & Dining', 1700, 'Expense', 'INR', 1, 26, 26, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3765, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 26, 26, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3766, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 26, 26, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3767, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 26, 26, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3768, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 26, 26, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3769, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 26, 26, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3770, 'Expense - Food & Dining', 800, 'Expense', 'INR', 1, 26, 26, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3771, 'Expense - Travel', 200, 'Expense', 'INR', 6, 26, 26, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3772, 'Expense - Housing', 700, 'Expense', 'INR', 3, 26, 26, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3773, 'Expense - Housing', 600, 'Expense', 'INR', 3, 27, 27, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3774, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 27, 27, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3775, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 27, 27, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3776, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 27, 27, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3777, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 27, 27, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3778, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 27, 27, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3779, 'Expense - Education', 200, 'Expense', 'INR', 8, 27, 27, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3780, 'Expense - Housing', 300, 'Expense', 'INR', 3, 27, 27, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3781, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 27, 27, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3782, 'Expense - Transportation', 400, 'Expense', 'INR', 2, 27, 27, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3783, 'Expense - Food & Dining', 1000, 'Expense', 'INR', 1, 27, 27, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3784, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 27, 27, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3785, 'Expense - Travel', 200, 'Expense', 'INR', 6, 27, 27, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3786, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 27, 27, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3787, 'Expense - Education', 200, 'Expense', 'INR', 8, 27, 27, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3788, 'Expense - Housing', 800, 'Expense', 'INR', 3, 27, 27, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3789, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 27, 27, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3790, 'Expense - Shopping', 400, 'Expense', 'INR', 7, 27, 27, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3791, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 27, 27, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3792, 'Expense - Transportation', 600, 'Expense', 'INR', 2, 27, 27, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3793, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 27, 27, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3794, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 27, 27, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3795, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 28, 28, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3796, 'Expense - Housing', 200, 'Expense', 'INR', 3, 28, 28, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3797, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 28, 28, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3798, 'Expense - Education', 200, 'Expense', 'INR', 8, 28, 28, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3799, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 28, 28, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3800, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 28, 28, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3801, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 28, 28, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3802, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 28, 28, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3803, 'Expense - Travel', 300, 'Expense', 'INR', 6, 28, 28, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3804, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 28, 28, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3805, 'Expense - Education', 200, 'Expense', 'INR', 8, 28, 28, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3806, 'Expense - Housing', 2700, 'Expense', 'INR', 3, 28, 28, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3807, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 28, 28, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3808, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 28, 28, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3809, 'Expense - Housing', 2600, 'Expense', 'INR', 3, 28, 28, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3810, 'Expense - Education', 200, 'Expense', 'INR', 8, 28, 28, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3811, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 28, 28, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3812, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 28, 28, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3813, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 28, 28, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3814, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 28, 28, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3815, 'Expense - Shopping', 300, 'Expense', 'INR', 7, 28, 28, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3816, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 28, 28, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3817, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 28, 28, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3818, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 28, 28, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3819, 'Expense - Housing', 900, 'Expense', 'INR', 3, 28, 28, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3820, 'Expense - Travel', 200, 'Expense', 'INR', 6, 28, 28, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3821, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 28, 28, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3822, 'Expense - Shopping', 700, 'Expense', 'INR', 7, 28, 28, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3823, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 28, 28, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3824, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 28, 28, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3825, 'Expense - Education', 200, 'Expense', 'INR', 8, 28, 28, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3826, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 28, 28, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3827, 'Expense - Utilities', 500, 'Expense', 'INR', 9, 28, 28, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3828, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 29, 29, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3829, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 29, 29, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3830, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 29, 29, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3831, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 29, 29, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3832, 'Expense - Food & Dining', 800, 'Expense', 'INR', 1, 29, 29, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3833, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 29, 29, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3834, 'Expense - Travel', 200, 'Expense', 'INR', 6, 29, 29, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3835, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 29, 29, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3836, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 29, 29, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3837, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 29, 29, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3838, 'Expense - Housing', 500, 'Expense', 'INR', 3, 29, 29, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3839, 'Expense - Shopping', 500, 'Expense', 'INR', 7, 29, 29, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3840, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 29, 29, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3841, 'Expense - Travel', 200, 'Expense', 'INR', 6, 29, 29, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3842, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 29, 29, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3843, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 29, 29, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3844, 'Expense - Housing', 800, 'Expense', 'INR', 3, 29, 29, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3845, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 29, 29, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3846, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 29, 29, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3847, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 29, 29, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3848, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 29, 29, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3849, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 29, 29, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3850, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 29, 29, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3851, 'Expense - Healthcare', 400, 'Expense', 'INR', 4, 29, 29, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3852, 'Expense - Education', 200, 'Expense', 'INR', 8, 29, 29, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3853, 'Expense - Housing', 300, 'Expense', 'INR', 3, 29, 29, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3854, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 29, 29, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3855, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 30, 30, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3856, 'Expense - Housing', 200, 'Expense', 'INR', 3, 30, 30, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3857, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 30, 30, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3858, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 30, 30, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3859, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 30, 30, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3860, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 31, 31, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3861, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 31, 31, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3862, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 31, 31, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3863, 'Expense - Housing', 600, 'Expense', 'INR', 3, 31, 31, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3864, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 32, 32, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3865, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 32, 32, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3866, 'Expense - Travel', 200, 'Expense', 'INR', 6, 32, 32, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3867, 'Expense - Education', 200, 'Expense', 'INR', 8, 32, 32, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3868, 'Expense - Housing', 1100, 'Expense', 'INR', 3, 32, 32, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3869, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 32, 32, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3870, 'Expense - Travel', 200, 'Expense', 'INR', 6, 32, 32, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3871, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 32, 32, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3872, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 32, 32, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3873, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 33, 33, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3874, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 33, 33, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3875, 'Expense - Housing', 400, 'Expense', 'INR', 3, 33, 33, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3876, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 33, 33, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3877, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 33, 33, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3878, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 33, 33, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3879, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 33, 33, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3880, 'Expense - Housing', 600, 'Expense', 'INR', 3, 33, 33, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3881, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 33, 33, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3882, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 33, 33, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3883, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 33, 33, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3884, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 33, 33, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3885, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 33, 33, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3886, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 33, 33, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3887, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 33, 33, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3888, 'Expense - Education', 200, 'Expense', 'INR', 8, 33, 33, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3889, 'Expense - Housing', 400, 'Expense', 'INR', 3, 33, 33, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3890, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 33, 33, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3891, 'Expense - Transportation', 600, 'Expense', 'INR', 2, 33, 33, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3892, 'Expense - Travel', 200, 'Expense', 'INR', 6, 33, 33, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3893, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 33, 33, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3894, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 33, 33, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3895, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 33, 33, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3896, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 33, 33, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3897, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 33, 33, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3898, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 33, 33, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3899, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 33, 33, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3900, 'Expense - Travel', 200, 'Expense', 'INR', 6, 33, 33, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3901, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 33, 33, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3902, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 33, 33, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3903, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 33, 33, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3904, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 33, 33, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3905, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 33, 33, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3906, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 33, 33, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3907, 'Expense - Education', 200, 'Expense', 'INR', 8, 33, 33, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3908, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 33, 33, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3909, 'Expense - Healthcare', 500, 'Expense', 'INR', 4, 33, 33, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3910, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 33, 33, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3911, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 33, 33, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3912, 'Expense - Food & Dining', 700, 'Expense', 'INR', 1, 33, 33, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3913, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 33, 33, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3914, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 34, 34, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3915, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 34, 34, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3916, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 35, 35, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3917, 'Expense - Housing', 400, 'Expense', 'INR', 3, 35, 35, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3918, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 35, 35, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3919, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 35, 35, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3920, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 35, 35, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3921, 'Expense - Housing', 200, 'Expense', 'INR', 3, 35, 35, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3922, 'Expense - Housing', 200, 'Expense', 'INR', 3, 35, 35, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3923, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 36, 36, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3924, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 36, 36, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3925, 'Expense - Travel', 300, 'Expense', 'INR', 6, 36, 36, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3926, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 36, 36, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3927, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 36, 36, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3928, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 36, 36, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3929, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 36, 36, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3930, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 36, 36, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3931, 'Expense - Education', 200, 'Expense', 'INR', 8, 36, 36, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3932, 'Expense - Travel', 200, 'Expense', 'INR', 6, 36, 36, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3933, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 36, 36, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3934, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 36, 36, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3935, 'Expense - Travel', 300, 'Expense', 'INR', 6, 36, 36, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3936, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 36, 36, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3937, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 36, 36, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3938, 'Expense - Travel', 200, 'Expense', 'INR', 6, 36, 36, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3939, 'Expense - Healthcare', 400, 'Expense', 'INR', 4, 36, 36, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3940, 'Expense - Housing', 800, 'Expense', 'INR', 3, 37, 37, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3941, 'Expense - Travel', 300, 'Expense', 'INR', 6, 37, 37, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3942, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 37, 37, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3943, 'Expense - Travel', 200, 'Expense', 'INR', 6, 37, 37, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3944, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 37, 37, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3945, 'Expense - Entertainment', 400, 'Expense', 'INR', 5, 37, 37, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3946, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 37, 37, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3947, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 37, 37, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3948, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 37, 37, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3949, 'Expense - Travel', 200, 'Expense', 'INR', 6, 37, 37, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3950, 'Expense - Housing', 3600, 'Expense', 'INR', 3, 37, 37, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3951, 'Expense - Education', 200, 'Expense', 'INR', 8, 37, 37, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3952, 'Expense - Transportation', 600, 'Expense', 'INR', 2, 37, 37, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3953, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 37, 37, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3954, 'Expense - Travel', 200, 'Expense', 'INR', 6, 37, 37, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3955, 'Expense - Healthcare', 300, 'Expense', 'INR', 4, 37, 37, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3956, 'Expense - Housing', 600, 'Expense', 'INR', 3, 38, 38, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3957, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 38, 38, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3958, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 39, 39, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3959, 'Expense - Travel', 200, 'Expense', 'INR', 6, 39, 39, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3960, 'Expense - Shopping', 400, 'Expense', 'INR', 7, 39, 39, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3961, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 39, 39, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3962, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 39, 39, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3963, 'Expense - Housing', 900, 'Expense', 'INR', 3, 39, 39, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3964, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 39, 39, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3965, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 39, 39, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3966, 'Expense - Education', 200, 'Expense', 'INR', 8, 39, 39, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3967, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 39, 39, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3968, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 39, 39, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3969, 'Expense - Travel', 200, 'Expense', 'INR', 6, 39, 39, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3970, 'Expense - Travel', 200, 'Expense', 'INR', 6, 39, 39, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3971, 'Expense - Transportation', 700, 'Expense', 'INR', 2, 39, 39, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3972, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 39, 39, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3973, 'Expense - Travel', 200, 'Expense', 'INR', 6, 39, 39, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3974, 'Expense - Housing', 2000, 'Expense', 'INR', 3, 39, 39, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3975, 'Expense - Education', 200, 'Expense', 'INR', 8, 39, 39, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3976, 'Expense - Utilities', 400, 'Expense', 'INR', 9, 39, 39, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3977, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 39, 39, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3978, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 39, 39, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3979, 'Expense - Travel', 200, 'Expense', 'INR', 6, 39, 39, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3980, 'Expense - Housing', 600, 'Expense', 'INR', 3, 39, 39, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3981, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 39, 39, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3982, 'Expense - Housing', 300, 'Expense', 'INR', 3, 39, 39, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3983, 'Expense - Housing', 600, 'Expense', 'INR', 3, 40, 40, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3984, 'Expense - Travel', 200, 'Expense', 'INR', 6, 40, 40, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3985, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 40, 40, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3986, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 40, 40, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3987, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 40, 40, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3988, 'Expense - Education', 200, 'Expense', 'INR', 8, 40, 40, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3989, 'Expense - Education', 400, 'Expense', 'INR', 8, 40, 40, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3990, 'Expense - Education', 200, 'Expense', 'INR', 8, 40, 40, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3991, 'Expense - Utilities', 400, 'Expense', 'INR', 9, 40, 40, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3992, 'Expense - Food & Dining', 500, 'Expense', 'INR', 1, 40, 40, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3993, 'Expense - Food & Dining', 800, 'Expense', 'INR', 1, 40, 40, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3994, 'Expense - Entertainment', 300, 'Expense', 'INR', 5, 40, 40, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3995, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 40, 40, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3996, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 40, 40, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3997, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 40, 40, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3998, 'Expense - Housing', 700, 'Expense', 'INR', 3, 40, 40, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (3999, 'Expense - Travel', 200, 'Expense', 'INR', 6, 42, 42, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4000, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 42, 42, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4001, 'Expense - Travel', 200, 'Expense', 'INR', 6, 42, 42, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4002, 'Expense - Education', 200, 'Expense', 'INR', 8, 42, 42, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4003, 'Expense - Education', 200, 'Expense', 'INR', 8, 42, 42, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4004, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 42, 42, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4005, 'Expense - Housing', 600, 'Expense', 'INR', 3, 42, 42, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4006, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 42, 42, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4007, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 42, 42, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4008, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 42, 42, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4009, 'Expense - Housing', 300, 'Expense', 'INR', 3, 42, 42, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4010, 'Expense - Education', 200, 'Expense', 'INR', 8, 42, 42, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4011, 'Expense - Healthcare', 500, 'Expense', 'INR', 4, 42, 42, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4012, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 42, 42, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4013, 'Expense - Healthcare', 300, 'Expense', 'INR', 4, 42, 42, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4014, 'Expense - Travel', 200, 'Expense', 'INR', 6, 42, 42, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4015, 'Expense - Food & Dining', 700, 'Expense', 'INR', 1, 42, 42, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4016, 'Expense - Utilities', 700, 'Expense', 'INR', 9, 42, 42, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4017, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 42, 42, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4018, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 42, 42, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4019, 'Expense - Education', 200, 'Expense', 'INR', 8, 42, 42, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4020, 'Expense - Food & Dining', 1900, 'Expense', 'INR', 1, 42, 42, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4021, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 42, 42, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4022, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 42, 42, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4023, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 42, 42, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4024, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 42, 42, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4025, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 42, 42, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4026, 'Expense - Travel', 400, 'Expense', 'INR', 6, 42, 42, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4027, 'Expense - Education', 200, 'Expense', 'INR', 8, 43, 43, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4028, 'Expense - Travel', 400, 'Expense', 'INR', 6, 43, 43, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4029, 'Expense - Shopping', 600, 'Expense', 'INR', 7, 43, 43, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4030, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 43, 43, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4031, 'Expense - Education', 200, 'Expense', 'INR', 8, 43, 43, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4032, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 43, 43, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4033, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 43, 43, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4034, 'Expense - Food & Dining', 600, 'Expense', 'INR', 1, 43, 43, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4035, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 43, 43, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4036, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 43, 43, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4037, 'Expense - Housing', 400, 'Expense', 'INR', 3, 43, 43, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4038, 'Expense - Travel', 200, 'Expense', 'INR', 6, 43, 43, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4039, 'Expense - Housing', 1700, 'Expense', 'INR', 3, 43, 43, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4040, 'Expense - Housing', 200, 'Expense', 'INR', 3, 43, 43, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4041, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 43, 43, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4042, 'Expense - Healthcare', 400, 'Expense', 'INR', 4, 43, 43, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4043, 'Expense - Housing', 200, 'Expense', 'INR', 3, 43, 43, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4044, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 43, 43, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4045, 'Expense - Food & Dining', 700, 'Expense', 'INR', 1, 43, 43, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4046, 'Expense - Travel', 200, 'Expense', 'INR', 6, 43, 43, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4047, 'Expense - Travel', 200, 'Expense', 'INR', 6, 43, 43, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4048, 'Expense - Housing', 1000, 'Expense', 'INR', 3, 43, 43, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4049, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 43, 43, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4050, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 43, 43, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4051, 'Expense - Travel', 200, 'Expense', 'INR', 6, 43, 43, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4052, 'Expense - Food & Dining', 1200, 'Expense', 'INR', 1, 43, 43, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4053, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 43, 43, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4054, 'Expense - Education', 400, 'Expense', 'INR', 8, 43, 43, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4055, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 43, 43, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4056, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 43, 43, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4057, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 43, 43, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4058, 'Expense - Housing', 800, 'Expense', 'INR', 3, 43, 43, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4059, 'Expense - Food & Dining', 400, 'Expense', 'INR', 1, 43, 43, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4060, 'Expense - Utilities', 700, 'Expense', 'INR', 9, 43, 43, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4061, 'Expense - Education', 500, 'Expense', 'INR', 8, 43, 43, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4062, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 43, 43, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4063, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 43, 43, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4064, 'Expense - Travel', 200, 'Expense', 'INR', 6, 43, 43, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4065, 'Expense - Shopping', 700, 'Expense', 'INR', 7, 43, 43, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4066, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 43, 43, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4067, 'Expense - Housing', 200, 'Expense', 'INR', 3, 44, 44, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4068, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 44, 44, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4069, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 44, 44, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4070, 'Expense - Travel', 200, 'Expense', 'INR', 6, 44, 44, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4071, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 44, 44, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4072, 'Expense - Housing', 2000, 'Expense', 'INR', 3, 44, 44, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4073, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 44, 44, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4074, 'Expense - Education', 200, 'Expense', 'INR', 8, 44, 44, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4075, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 44, 44, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4076, 'Expense - Education', 200, 'Expense', 'INR', 8, 44, 44, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4077, 'Expense - Travel', 200, 'Expense', 'INR', 6, 44, 44, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4078, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 44, 44, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4079, 'Expense - Transportation', 700, 'Expense', 'INR', 2, 44, 44, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4080, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 44, 44, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4081, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 44, 44, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4082, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 44, 44, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4083, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 44, 44, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4084, 'Expense - Housing', 1100, 'Expense', 'INR', 3, 44, 44, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4085, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 44, 44, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4086, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 44, 44, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4087, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 44, 44, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4088, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 44, 44, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4089, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 44, 44, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4090, 'Expense - Housing', 600, 'Expense', 'INR', 3, 44, 44, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4091, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 44, 44, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4092, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 44, 44, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4093, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 44, 44, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4094, 'Expense - Housing', 2800, 'Expense', 'INR', 3, 44, 44, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4095, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 44, 44, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4096, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 44, 44, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4097, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 44, 44, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4098, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 44, 44, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4099, 'Expense - Education', 200, 'Expense', 'INR', 8, 44, 44, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4100, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 44, 44, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4101, 'Expense - Housing', 300, 'Expense', 'INR', 3, 44, 44, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4102, 'Expense - Food & Dining', 300, 'Expense', 'INR', 1, 44, 44, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4103, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 44, 44, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4104, 'Expense - Housing', 300, 'Expense', 'INR', 3, 44, 44, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4105, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 44, 44, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4106, 'Expense - Transportation', 300, 'Expense', 'INR', 2, 44, 44, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4107, 'Expense - Travel', 200, 'Expense', 'INR', 6, 44, 44, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4108, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 44, 44, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4109, 'Expense - Travel', 200, 'Expense', 'INR', 6, 44, 44, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4110, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 45, 45, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4111, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 45, 45, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4112, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 45, 45, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4113, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 45, 45, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4114, 'Expense - Education', 200, 'Expense', 'INR', 8, 45, 45, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4115, 'Expense - Education', 200, 'Expense', 'INR', 8, 45, 45, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4116, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 45, 45, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4117, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 45, 45, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4118, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 45, 45, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4119, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 45, 45, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4120, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 45, 45, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4121, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 45, 45, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4122, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 45, 45, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4123, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 45, 45, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4124, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 45, 45, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4125, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 45, 45, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4126, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 45, 45, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4127, 'Expense - Housing', 200, 'Expense', 'INR', 3, 45, 45, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4128, 'Expense - Food & Dining', 2700, 'Expense', 'INR', 1, 45, 45, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4129, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 45, 45, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4130, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 45, 45, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4131, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 46, 46, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4132, 'Expense - Travel', 200, 'Expense', 'INR', 6, 48, 48, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4133, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 48, 48, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4134, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 48, 48, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4135, 'Expense - Travel', 200, 'Expense', 'INR', 6, 48, 48, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4136, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 48, 48, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4137, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 48, 48, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4138, 'Expense - Food & Dining', 600, 'Expense', 'INR', 1, 48, 48, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4139, 'Expense - Food & Dining', 200, 'Expense', 'INR', 1, 48, 48, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4140, 'Expense - Food & Dining', 2000, 'Expense', 'INR', 1, 48, 48, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4141, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 48, 48, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4142, 'Expense - Entertainment', 400, 'Expense', 'INR', 5, 48, 48, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4143, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 48, 48, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4144, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 48, 48, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4145, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 48, 48, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4146, 'Expense - Entertainment', 300, 'Expense', 'INR', 5, 48, 48, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4147, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 48, 48, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4148, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 48, 48, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4149, 'Expense - Housing', 1600, 'Expense', 'INR', 3, 48, 48, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4150, 'Expense - Travel', 200, 'Expense', 'INR', 6, 48, 48, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4151, 'Expense - Utilities', 300, 'Expense', 'INR', 9, 48, 48, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4152, 'Expense - Education', 200, 'Expense', 'INR', 8, 48, 48, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4153, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 48, 48, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4154, 'Expense - Housing', 1000, 'Expense', 'INR', 3, 48, 48, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4155, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 48, 48, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4156, 'Expense - Shopping', 700, 'Expense', 'INR', 7, 48, 48, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4157, 'Expense - Miscellaneous', 200, 'Expense', 'INR', 10, 48, 48, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4158, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 48, 48, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4159, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 48, 48, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4160, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 48, 48, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4161, 'Expense - Housing', 200, 'Expense', 'INR', 3, 48, 48, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4162, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 48, 48, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4163, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 48, 48, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4164, 'Expense - Transportation', 400, 'Expense', 'INR', 2, 48, 48, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4165, 'Expense - Housing', 1500, 'Expense', 'INR', 3, 48, 48, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4166, 'Expense - Housing', 200, 'Expense', 'INR', 3, 48, 48, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4167, 'Expense - Utilities', 700, 'Expense', 'INR', 9, 48, 48, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4168, 'Expense - Healthcare', 200, 'Expense', 'INR', 4, 48, 48, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4169, 'Expense - Shopping', 200, 'Expense', 'INR', 7, 48, 48, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4170, 'Expense - Travel', 200, 'Expense', 'INR', 6, 48, 48, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4171, 'Expense - Entertainment', 200, 'Expense', 'INR', 5, 49, 49, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4172, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 49, 49, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4173, 'Expense - Travel', 200, 'Expense', 'INR', 6, 49, 49, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4174, 'Expense - Transportation', 200, 'Expense', 'INR', 2, 49, 49, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4175, 'Expense - Travel', 200, 'Expense', 'INR', 6, 49, 49, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4176, 'Expense - Utilities', 200, 'Expense', 'INR', 9, 49, 49, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4177, 'Salary Income', 12600, 'Income', 'INR', 11, 1, 1, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4178, 'Salary Income', 17300, 'Income', 'INR', 11, 2, 2, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4179, 'Salary Income', 16800, 'Income', 'INR', 11, 2, 2, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4180, 'Salary Income', 8300, 'Income', 'INR', 11, 3, 3, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4181, 'Salary Income', 12200, 'Income', 'INR', 11, 4, 4, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4182, 'Salary Income', 8300, 'Income', 'INR', 11, 6, 6, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4183, 'Salary Income', 8500, 'Income', 'INR', 11, 6, 6, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4184, 'Salary Income', 12600, 'Income', 'INR', 11, 9, 9, '2025-12-10 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4185, 'Salary Income', 12900, 'Income', 'INR', 11, 9, 9, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4186, 'Salary Income', 12400, 'Income', 'INR', 11, 9, 9, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4187, 'Salary Income', 12700, 'Income', 'INR', 11, 10, 10, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4188, 'Salary Income', 12600, 'Income', 'INR', 11, 14, 14, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4189, 'Salary Income', 17000, 'Income', 'INR', 11, 16, 16, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4190, 'Salary Income', 48600, 'Income', 'INR', 11, 18, 18, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4191, 'Salary Income', 50100, 'Income', 'INR', 11, 19, 19, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4192, 'Salary Income', 24800, 'Income', 'INR', 11, 20, 20, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4193, 'Salary Income', 16000, 'Income', 'INR', 11, 25, 25, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4194, 'Salary Income', 17300, 'Income', 'INR', 11, 28, 28, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4195, 'Salary Income', 8500, 'Income', 'INR', 11, 32, 32, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4196, 'Salary Income', 8600, 'Income', 'INR', 11, 32, 32, '2025-12-03 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4197, 'Salary Income', 8600, 'Income', 'INR', 11, 32, 32, '2025-12-08 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4198, 'Salary Income', 48500, 'Income', 'INR', 11, 33, 33, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4199, 'Salary Income', 12600, 'Income', 'INR', 11, 34, 34, '2025-12-05 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4200, 'Salary Income', 12400, 'Income', 'INR', 11, 34, 34, '2025-12-07 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4201, 'Salary Income', 8200, 'Income', 'INR', 11, 38, 38, '2025-12-04 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4202, 'Salary Income', 12600, 'Income', 'INR', 11, 39, 39, '2025-12-06 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4203, 'Salary Income', 26000, 'Income', 'INR', 11, 41, 41, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4204, 'Salary Income', 17000, 'Income', 'INR', 11, 44, 44, '2025-12-02 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4205, 'Salary Income', 12200, 'Income', 'INR', 11, 45, 45, '2025-12-01 00:00:00', '2025-12-10 17:57:56.172765', NULL);
INSERT INTO public.transactions VALUES (4206, 'Salary Income', 13000, 'Income', 'INR', 11, 45, 45, '2025-12-09 00:00:00', '2025-12-10 17:57:56.172765', NULL);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users VALUES (1, 'Irshad Ahmad', 'irshad_ahmad@hotmail.com', '9090909090', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 1, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (2, 'Umair Ahmed', 'umair_ahmed@hotmail.com', '8989898989', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 2, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (3, 'Rifa Ahmed', 'rifa_ahmed@hotmail.com', '8888888888', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 2, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (4, 'John Doe', 'john.doe@example.com', '1234567890', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 1, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (5, 'Jane Doe', 'jane.doe@example.com', '1234567891', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 2, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (6, 'Bob Smith', 'bob.smith@example.com', '1234567892', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 3, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (7, 'Alice Johnson', 'alice.johnson@example.com', '1234567893', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 1, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (8, 'Charlie Brown', 'charlie.brown@example.com', '1234567894', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 2, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (9, 'David Jones', 'david.jones@example.com', '1234567895', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 3, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (10, 'Emily Williams', 'emily.williams@example.com', '1234567896', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 1, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (11, 'Frank Lee', 'frank.lee@example.com', '1234567897', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 2, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (12, 'George Miller', 'george.miller@example.com', '1234567898', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 3, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (13, 'Harry White', 'harry.white@example.com', '1234567899', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 1, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (14, 'Karen Johnson', 'karen.johnson@example.com', '1234567900', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 2, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (15, 'Lisa Brown', 'lisa.brown@example.com', '1234567901', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 3, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (16, 'Mike Davis', 'mike.davis@example.com', '1234567902', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 1, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (17, 'Nancy Smith', 'nancy.smith@example.com', '1234567903', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 2, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (18, 'Oliver Jones', 'oliver.jones@example.com', '1234567904', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 3, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (19, 'Peter Johnson', 'peter.johnson@example.com', '1234567905', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 1, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (20, 'Sarah Lee', 'sarah.lee@example.com', '1234567906', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 2, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (21, 'Thomas Brown', 'thomas.brown@example.com', '1234567907', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 3, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (22, 'Victoria Smith', 'victoria.smith@example.com', '1234567908', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 1, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (23, 'William Jones', 'william.jones@example.com', '1234567909', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 2, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (24, 'Zachary White', 'zachary.white@example.com', '1234567910', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 3, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (25, 'Amy Johnson', 'amy.johnson@example.com', '1234567911', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 1, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (26, 'Brian Brown', 'brian.brown@example.com', '1234567912', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 2, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (27, 'Carol Jones', 'carol.jones@example.com', '1234567913', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 3, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (28, 'Daniel Smith', 'daniel.smith@example.com', '1234567914', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 1, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (29, 'Elizabeth Lee', 'elizabeth.lee@example.com', '1234567915', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 2, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (30, 'Franklin Jones', 'franklin.jones@example.com', '1234567916', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 3, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (31, 'George Williams', 'george.williams@example.com', '1234567917', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 1, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (32, 'Helen Brown', 'helen.brown@example.com', '1234567918', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 2, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (33, 'Isaac Johnson', 'isaac.johnson@example.com', '1234567919', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 3, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (34, 'James Smith', 'james.smith@example.com', '1234567920', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 1, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (35, 'Julie Jones', 'julie.jones@example.com', '1234567921', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 2, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (36, 'Katherine Lee', 'katherine.lee@example.com', '1234567922', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 3, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (37, 'Linda Johnson', 'linda.johnson@example.com', '1234567923', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 1, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (38, 'Margaret Brown', 'margaret.brown@example.com', '1234567924', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 2, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (39, 'Matthew Smith', 'matthew.smith@example.com', '1234567925', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 3, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (40, 'Nicholas Jones', 'nicholas.jones@example.com', '1234567926', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 1, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (41, 'Olivia Lee', 'olivia.lee@example.com', '1234567927', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 2, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (42, 'Patrick Johnson', 'patrick.johnson@example.com', '1234567928', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 3, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (43, 'Rachel Smith', 'rachel.smith@example.com', '1234567929', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 1, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (44, 'Robert Jones', 'robert.jones@example.com', '1234567930', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 2, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (45, 'Samuel Brown', 'samuel.brown@example.com', '1234567931', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 3, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (46, 'Sophia Johnson', 'sophia.johnson@example.com', '1234567932', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 1, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (47, 'Thomas Smith', 'thomas.smith@example.com', '1234567933', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 2, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (48, 'Victoria Jones', 'victoria.jones@example.com', '1234567934', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 3, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (49, 'William Brown', 'william.brown@example.com', '1234567935', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 1, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');
INSERT INTO public.users VALUES (50, 'Zachary Johnson', 'zachary.johnson@example.com', '1234567936', '$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu', 2, true, '2025-11-22 09:29:08.012651', '2025-11-22 09:29:08.012651');


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.accounts_id_seq', 50, true);


--
-- Name: audit_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.audit_logs_id_seq', 1, false);


--
-- Name: budgets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.budgets_id_seq', 539, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categories_id_seq', 11, true);


--
-- Name: feedbacks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.feedbacks_id_seq', 43, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.roles_id_seq', 3, true);


--
-- Name: tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tokens_id_seq', 1, false);


--
-- Name: transactions_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.transactions_id_seq1', 4206, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 52, true);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- Name: budgets budgets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.budgets
    ADD CONSTRAINT budgets_pkey PRIMARY KEY (id);


--
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: categories categories_short_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_short_name_key UNIQUE (short_name);


--
-- Name: feedbacks feedbacks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedbacks_pkey PRIMARY KEY (id);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey1; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey1 PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: accounts accounts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: budgets budgets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.budgets
    ADD CONSTRAINT budgets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: users fk_role; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: transactions transactions_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: transactions transactions_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: transactions transactions_user_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_fkey1 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

