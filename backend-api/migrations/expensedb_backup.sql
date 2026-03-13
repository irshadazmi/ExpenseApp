--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2026-03-08 14:43:19

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
-- TOC entry 228 (class 1259 OID 18413)
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.accounts OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 18412)
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.accounts_id_seq OWNER TO postgres;

--
-- TOC entry 5017 (class 0 OID 0)
-- Dependencies: 227
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_id_seq OWNED BY public.accounts.id;


--
-- TOC entry 222 (class 1259 OID 16555)
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.audit_logs (
    id integer NOT NULL,
    action character varying(255) NOT NULL,
    user_id integer NOT NULL,
    target_table character varying(255) NOT NULL,
    target_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.audit_logs OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16554)
-- Name: audit_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.audit_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.audit_logs_id_seq OWNER TO postgres;

--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 221
-- Name: audit_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.audit_logs_id_seq OWNED BY public.audit_logs.id;


--
-- TOC entry 230 (class 1259 OID 18468)
-- Name: budgets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.budgets (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    amount integer NOT NULL,
    currency character varying(10) DEFAULT 'INR'::character varying,
    period character varying(50) NOT NULL,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    version integer DEFAULT 1,
    user_id integer NOT NULL,
    category_id integer,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.budgets OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 18467)
-- Name: budgets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.budgets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.budgets_id_seq OWNER TO postgres;

--
-- TOC entry 5019 (class 0 OID 0)
-- Dependencies: 229
-- Name: budgets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.budgets_id_seq OWNED BY public.budgets.id;


--
-- TOC entry 232 (class 1259 OID 18496)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 18495)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 231
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 224 (class 1259 OID 18284)
-- Name: feedbacks; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.feedbacks OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 18283)
-- Name: feedbacks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.feedbacks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.feedbacks_id_seq OWNER TO postgres;

--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 223
-- Name: feedbacks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.feedbacks_id_seq OWNED BY public.feedbacks.id;


--
-- TOC entry 218 (class 1259 OID 16493)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(20) NOT NULL,
    description character varying(255)
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16492)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 217
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 220 (class 1259 OID 16542)
-- Name: tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tokens (
    id integer NOT NULL,
    token character varying(255) NOT NULL,
    user_id integer NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tokens OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16541)
-- Name: tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tokens_id_seq OWNER TO postgres;

--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 219
-- Name: tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tokens_id_seq OWNED BY public.tokens.id;


--
-- TOC entry 234 (class 1259 OID 18546)
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.transactions OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 18545)
-- Name: transactions_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_id_seq1 OWNER TO postgres;

--
-- TOC entry 5024 (class 0 OID 0)
-- Dependencies: 233
-- Name: transactions_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_id_seq1 OWNED BY public.transactions.id;


--
-- TOC entry 226 (class 1259 OID 18328)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 18327)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5025 (class 0 OID 0)
-- Dependencies: 225
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4794 (class 2604 OID 18416)
-- Name: accounts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts ALTER COLUMN id SET DEFAULT nextval('public.accounts_id_seq'::regclass);


--
-- TOC entry 4785 (class 2604 OID 16558)
-- Name: audit_logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs ALTER COLUMN id SET DEFAULT nextval('public.audit_logs_id_seq'::regclass);


--
-- TOC entry 4800 (class 2604 OID 18471)
-- Name: budgets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.budgets ALTER COLUMN id SET DEFAULT nextval('public.budgets_id_seq'::regclass);


--
-- TOC entry 4806 (class 2604 OID 18499)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 4787 (class 2604 OID 18287)
-- Name: feedbacks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedbacks ALTER COLUMN id SET DEFAULT nextval('public.feedbacks_id_seq'::regclass);


--
-- TOC entry 4782 (class 2604 OID 16496)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 4783 (class 2604 OID 16545)
-- Name: tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tokens ALTER COLUMN id SET DEFAULT nextval('public.tokens_id_seq'::regclass);


--
-- TOC entry 4810 (class 2604 OID 18549)
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq1'::regclass);


--
-- TOC entry 4790 (class 2604 OID 18331)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5005 (class 0 OID 18413)
-- Dependencies: 228
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts (id, name, type, balance, currency, user_id, is_active, created_at, updated_at) FROM stdin;
1	Emergency Fund Savings	Savings	50100	INR	1	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
2	Main Checking Account	Checking	50200	USD	2	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
3	Visa Credit Card	Credit	50300	EUR	3	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
4	PayPal Wallet	Wallet	50400	GBP	4	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
5	Vacation Savings	Savings	50500	INR	5	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
6	Household Checking	Checking	50600	USD	6	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
7	MasterCard Rewards	Credit	50700	EUR	7	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
8	Google Pay Wallet	Wallet	50800	GBP	8	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
9	Retirement Savings	Savings	50900	INR	9	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
10	Business Checking	Checking	51000	USD	10	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
11	Travel Credit Card	Credit	51100	EUR	11	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
12	Apple Wallet	Wallet	51200	GBP	12	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
13	College Fund Savings	Savings	51300	INR	13	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
14	Joint Checking Account	Checking	51400	USD	14	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
15	Corporate Credit Card	Credit	51500	EUR	15	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
16	Cash Wallet	Wallet	51600	GBP	16	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
17	Emergency Fund Savings	Savings	51700	INR	17	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
18	Main Checking Account	Checking	51800	USD	18	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
19	Visa Credit Card	Credit	51900	EUR	19	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
20	PayPal Wallet	Wallet	52000	GBP	20	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
21	Vacation Savings	Savings	52100	INR	21	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
22	Household Checking	Checking	52200	USD	22	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
23	MasterCard Rewards	Credit	52300	EUR	23	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
24	Google Pay Wallet	Wallet	52400	GBP	24	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
25	Retirement Savings	Savings	52500	INR	25	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
26	Business Checking	Checking	52600	USD	26	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
27	Travel Credit Card	Credit	52700	EUR	27	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
28	Apple Wallet	Wallet	52800	GBP	28	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
29	College Fund Savings	Savings	52900	INR	29	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
30	Joint Checking Account	Checking	53000	USD	30	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
31	Corporate Credit Card	Credit	53100	EUR	31	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
32	Cash Wallet	Wallet	53200	GBP	32	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
33	Emergency Fund Savings	Savings	53300	INR	33	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
34	Main Checking Account	Checking	53400	USD	34	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
35	Visa Credit Card	Credit	53500	EUR	35	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
36	PayPal Wallet	Wallet	53600	GBP	36	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
37	Vacation Savings	Savings	53700	INR	37	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
38	Household Checking	Checking	53800	USD	38	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
39	MasterCard Rewards	Credit	53900	EUR	39	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
40	Google PayWallet	Wallet	54000	GBP	40	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
41	Retirement Savings	Savings	54100	INR	41	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
42	Business Checking	Checking	54200	USD	42	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
43	Travel Credit Card	Credit	54300	EUR	43	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
44	Apple Wallet	Wallet	54400	GBP	44	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
45	College Fund Savings	Savings	54500	INR	45	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
46	Joint Checking Account	Checking	54600	USD	46	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
47	Corporate Credit Card	Credit	54700	EUR	47	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
48	Cash Wallet	Wallet	54800	GBP	48	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
49	Emergency Fund Savings	Savings	54900	INR	49	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
50	Main Checking Account	Checking	55000	USD	50	t	2025-11-24 18:45:39.189789	2025-11-24 18:45:39.189789
\.


--
-- TOC entry 4999 (class 0 OID 16555)
-- Dependencies: 222
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.audit_logs (id, action, user_id, target_table, target_id, created_at) FROM stdin;
\.


--
-- TOC entry 5007 (class 0 OID 18468)
-- Dependencies: 230
-- Data for Name: budgets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.budgets (id, name, amount, currency, period, effective_from, effective_to, version, user_id, category_id, is_active, created_at, updated_at) FROM stdin;
1	Food & Dining Budget	6000	INR	Monthly	2025-12-15 17:39:40.495474	\N	1	1	1	t	2025-12-15 17:38:04.045436	2025-12-15 17:39:40.495482
2	Transportation Budget	2000	INR	Monthly	2025-12-15 17:39:40.501233	\N	1	1	2	t	2025-12-15 17:38:04.050174	2025-12-15 17:39:40.501237
3	Housing Budget	10000	INR	Monthly	2025-12-15 17:39:40.505164	\N	1	1	3	t	2025-12-15 17:38:04.0553	2025-12-15 17:39:40.505171
4	Healthcare Budget	3000	INR	Monthly	2025-12-15 17:39:40.50882	\N	1	1	4	t	2025-12-15 17:38:04.058872	2025-12-15 17:39:40.508824
5	Entertainment Budget	1500	INR	Monthly	2025-12-15 17:39:40.512276	\N	1	1	5	t	2025-12-15 17:38:04.06204	2025-12-15 17:39:40.51228
6	Travel Budget	1500	INR	Monthly	2025-12-15 17:39:40.515576	\N	1	1	6	t	2025-12-15 17:38:04.065119	2025-12-15 17:39:40.51558
7	Shopping Budget	2000	INR	Monthly	2025-12-15 17:39:40.518648	\N	1	1	7	t	2025-12-15 17:38:04.067897	2025-12-15 17:39:40.518651
8	Education Budget	3000	INR	Monthly	2025-12-15 17:39:40.522255	\N	1	1	8	t	2025-12-15 17:38:04.070998	2025-12-15 17:39:40.522259
9	Bills & Utilities Budget	4000	INR	Monthly	2025-12-15 17:39:40.525525	\N	1	1	9	t	2025-12-15 17:38:04.073918	2025-12-15 17:39:40.525532
10	Miscellaneous Budget	2000	INR	Monthly	2025-12-15 17:39:40.528767	\N	1	1	10	t	2025-12-15 17:38:04.076695	2025-12-15 17:39:40.528774
11	Monthly Total Budget	35000	INR	Monthly	2025-12-15 17:39:40.532214	\N	1	1	\N	t	2025-12-15 17:38:04.07955	2025-12-15 17:39:40.532217
12	Food & Dining Budget	0	EUR	Monthly	\N	\N	0	3	1	t	2025-12-23 12:34:47.350024	\N
13	Transportation Budget	0	EUR	Monthly	\N	\N	0	3	2	t	2025-12-23 12:34:47.377105	\N
14	Housing Budget	0	EUR	Monthly	\N	\N	0	3	3	t	2025-12-23 12:34:47.380555	\N
15	Healthcare Budget	0	EUR	Monthly	\N	\N	0	3	4	t	2025-12-23 12:34:47.385141	\N
16	Entertainment Budget	0	EUR	Monthly	\N	\N	0	3	5	t	2025-12-23 12:34:47.389023	\N
17	Travel Budget	0	EUR	Monthly	\N	\N	0	3	6	t	2025-12-23 12:34:47.392073	\N
18	Shopping Budget	0	EUR	Monthly	\N	\N	0	3	7	t	2025-12-23 12:34:47.39507	\N
19	Education Budget	0	EUR	Monthly	\N	\N	0	3	8	t	2025-12-23 12:34:47.397627	\N
20	Bills & Utilities Budget	0	EUR	Monthly	\N	\N	0	3	9	t	2025-12-23 12:34:47.399914	\N
21	Miscellaneous Budget	0	EUR	Monthly	\N	\N	0	3	10	t	2025-12-23 12:34:47.402728	\N
22	Monthly Total Budget	0	EUR	Monthly	\N	\N	0	3	\N	t	2025-12-23 12:34:47.405281	\N
23	Food & Dining Budget	0	USD	Monthly	\N	\N	0	2	1	t	2025-12-23 12:35:15.598464	\N
24	Transportation Budget	0	USD	Monthly	\N	\N	0	2	2	t	2025-12-23 12:35:15.605815	\N
25	Housing Budget	0	USD	Monthly	\N	\N	0	2	3	t	2025-12-23 12:35:15.609586	\N
26	Healthcare Budget	0	USD	Monthly	\N	\N	0	2	4	t	2025-12-23 12:35:15.612904	\N
27	Entertainment Budget	0	USD	Monthly	\N	\N	0	2	5	t	2025-12-23 12:35:15.61581	\N
28	Travel Budget	0	USD	Monthly	\N	\N	0	2	6	t	2025-12-23 12:35:15.618957	\N
29	Shopping Budget	0	USD	Monthly	\N	\N	0	2	7	t	2025-12-23 12:35:15.622178	\N
30	Education Budget	0	USD	Monthly	\N	\N	0	2	8	t	2025-12-23 12:35:15.625231	\N
31	Bills & Utilities Budget	0	USD	Monthly	\N	\N	0	2	9	t	2025-12-23 12:35:15.628264	\N
32	Miscellaneous Budget	0	USD	Monthly	\N	\N	0	2	10	t	2025-12-23 12:35:15.63139	\N
33	Monthly Total Budget	0	USD	Monthly	\N	\N	0	2	\N	t	2025-12-23 12:35:15.634867	\N
\.


--
-- TOC entry 5009 (class 0 OID 18496)
-- Dependencies: 232
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name, short_name, description, is_active, created_at, updated_at) FROM stdin;
1	Food & Dining	FDNG	Meals, groceries, cafes, restaurants, and takeout orders	t	2025-12-03 16:35:06.963745	2025-12-03 16:35:06.963745
2	Transportation	TRAN	Fuel, public transit, ride-hailing, parking, and vehicle expenses	t	2025-12-03 16:35:06.963745	2025-12-03 16:35:06.963745
3	Housing	HOUS	Rent, mortgage payments, property maintenance, and household utilities	t	2025-12-03 16:35:06.963745	2025-12-03 16:35:06.963745
4	Healthcare	HLTH	Doctor visits, pharmacy purchases, medical insurance, and hospital bills	t	2025-12-03 16:35:06.963745	2025-12-03 16:35:06.963745
5	Entertainment	ENTR	Movies, streaming subscriptions, concerts, gaming, and leisure activities	t	2025-12-03 16:35:06.963745	2025-12-03 16:35:06.963745
6	Travel	TRVL	Flights, hotels, vacation packages, and related travel costs	t	2025-12-03 16:35:06.963745	2025-12-03 16:35:06.963745
7	Shopping	SHOP	Clothing, electronics, household goods, and personal purchases	t	2025-12-03 16:35:06.963745	2025-12-03 16:35:06.963745
8	Education	EDUC	Tuition fees, online courses, books, and professional training	t	2025-12-03 16:35:06.963745	2025-12-03 16:35:06.963745
9	Bills & Utilities	BILS	Recurring service bills like internet, phone, cable, and electricity	t	2025-12-03 16:35:06.963745	2025-12-03 16:35:06.963745
10	Miscellaneous	MISC	Catch-all for irregular or uncategorized expenses	t	2025-12-03 16:35:06.963745	2025-12-03 16:35:06.963745
11	Income from Salary/Transfer	INCOM	Income from Salary, Bank/UPI/Other Online Transfer,	t	2025-12-03 18:52:33.245303	2025-12-03 18:52:33.245303
\.


--
-- TOC entry 5001 (class 0 OID 18284)
-- Dependencies: 224
-- Data for Name: feedbacks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.feedbacks (id, issue_type, subject, description, rating, status, user_id, reply, created_at, updated_at) FROM stdin;
1	Bug	App crashes on adding expense	The app crashes whenever I try to add a new expense above 10,000.	2	Open	1	\N	2025-01-05 10:15:00	2025-12-07 09:04:48.528242
2	Feature	Add dark mode	It would be great to have a dark mode for using the app at night.	5	Open	2	\N	2025-01-06 09:20:00	2025-12-07 09:04:48.528242
3	Bug	Incorrect total in dashboard	The total expense in dashboard does not match the sum of listed expenses.	3	In Progress	3	\N	2025-01-07 14:32:00	2025-12-07 09:04:48.528242
4	Design	Improve category icons	Category icons are too similar and confusing at a glance.	4	Open	4	\N	2025-01-08 18:45:00	2025-12-07 09:04:48.528242
5	Performance	Slow loading of reports	Reports page takes more than 10 seconds to load with many records.	3	Open	5	\N	2025-01-09 08:10:00	2025-12-07 09:04:48.528242
6	Bug	Date filter not working	Filtering expenses by date range returns incomplete results.	2	Open	6	\N	2025-01-10 11:05:00	2025-12-07 09:04:48.528242
7	Feature	Support multiple currencies	Please allow tracking expenses in different currencies per account.	5	Open	7	\N	2025-01-11 16:50:00	2025-12-07 09:04:48.528242
8	Bug	Cannot delete category	Deleting an unused category shows an unknown error.	3	Open	8	\N	2025-01-12 19:25:00	2025-12-07 09:04:48.528242
9	Design	Larger fonts on small devices	The font size is too small on my phone, hard to read.	4	Open	9	\N	2025-01-13 07:40:00	2025-12-07 09:04:48.528242
10	Performance	Lag when scrolling expense list	The expense list becomes laggy when more than 500 records exist.	3	Open	10	\N	2025-01-14 12:30:00	2025-12-07 09:04:48.528242
11	Feature	Export to Excel	Kindly add an option to export expenses and budgets to Excel.	5	Open	1	\N	2025-01-15 09:15:00	2025-12-07 09:04:48.528242
12	Bug	Duplicate expenses after sync	After syncing, some expenses appear twice in the list.	2	Open	2	\N	2025-01-16 13:05:00	2025-12-07 09:04:48.528242
13	Design	Show account name in expense list	Please show account name beside each expense for clarity.	4	Open	3	\N	2025-01-17 17:45:00	2025-12-07 09:04:48.528242
14	Feature	Add reminders for bills	Would like reminders for recurring bills like rent and utilities.	5	Open	4	\N	2025-01-18 20:00:00	2025-12-07 09:04:48.528242
15	Bug	Cannot login after password reset	After resetting my password, the app shows invalid credentials.	1	Open	5	\N	2025-01-19 10:25:00	2025-12-07 09:04:48.528242
16	Performance	High battery usage	The app drains battery quickly when left open on dashboard.	2	Open	6	\N	2025-01-20 08:55:00	2025-12-07 09:04:48.528242
17	Feature	Family sharing	Please add ability to share budgets and expenses with family members.	5	Open	7	\N	2025-01-21 15:20:00	2025-12-07 09:04:48.528242
18	Bug	Wrong currency symbol in reports	Reports show INR symbol even when account currency is USD.	3	Open	8	\N	2025-01-22 18:40:00	2025-12-07 09:04:48.528242
19	Design	Better color coding	Use clearer colors to differentiate income, expense and transfer.	4	Open	9	\N	2025-01-23 07:35:00	2025-12-07 09:04:48.528242
20	Feature	Attach receipts to expenses	I want to upload photo of bill/receipt with each expense.	5	Open	10	\N	2025-01-24 11:50:00	2025-12-07 09:04:48.528242
21	Bug	Categories not saving	Newly added categories disappear after app restart.	2	In Progress	1	\N	2025-01-25 09:45:00	2025-12-07 09:04:48.528242
22	Performance	Slow first-time startup	The app takes too long to open the first time after install.	3	Open	2	\N	2025-01-26 13:30:00	2025-12-07 09:04:48.528242
23	Design	Show monthly summary chart	A simple bar chart on dashboard for monthly totals would help.	5	Open	3	\N	2025-01-27 16:05:00	2025-12-07 09:04:48.528242
24	Feature	Biometric login	Allow fingerprint or face ID login for faster access.	5	Open	4	\N	2025-01-28 19:55:00	2025-12-07 09:04:48.528242
25	Bug	Incorrect sorting by date	Sorting by date puts some older entries at the top.	2	Open	5	\N	2025-01-29 08:20:00	2025-12-07 09:04:48.528242
26	Feature	Custom categories per user	Each family member should be able to maintain their own categories.	4	Open	6	\N	2025-01-30 14:15:00	2025-12-07 09:04:48.528242
27	Design	Highlight today’s expenses	Highlight entries for today with a subtle background color.	4	Open	7	\N	2025-01-31 18:10:00	2025-12-07 09:04:48.528242
28	Bug	Report filters reset randomly	Report filters reset when navigating back from details.	3	Open	8	\N	2025-02-01 09:05:00	2025-12-07 09:04:48.528242
29	Feature	Offline mode	Allow adding expenses offline and sync when internet is back.	5	Open	9	\N	2025-02-02 12:40:00	2025-12-07 09:04:48.528242
30	Performance	Search is very slow	Searching for text in expenses takes several seconds.	2	Open	10	\N	2025-02-03 10:10:00	2025-12-07 09:04:48.528242
31	Bug	Negative balance not allowed	Transfers between accounts sometimes create negative balances.	2	In Progress	1	\N	2025-02-04 15:55:00	2025-12-07 09:04:48.528242
32	Feature	Multi-language support	Please add support for Hindi and Arabic languages.	5	Open	2	\N	2025-02-05 19:30:00	2025-12-07 09:04:48.528242
33	Design	More compact list view	Allow a dense mode to see more rows on one screen.	4	Open	3	\N	2025-02-06 07:50:00	2025-12-07 09:04:48.528242
34	Bug	Export CSV encoding issue	Exported CSV opens with garbled characters in Excel.	3	Open	4	\N	2025-02-07 11:25:00	2025-12-07 09:04:48.528242
35	Feature	Goal-based saving	Feature to set savings goals and track progress.	5	Open	5	\N	2025-02-08 16:45:00	2025-12-07 09:04:48.528242
36	Performance	Charts take time to render	Analytics charts take too long to load with big datasets.	3	Open	6	\N	2025-02-09 20:05:00	2025-12-07 09:04:48.528242
37	Bug	Notification toggle not working	Disabling notifications has no effect, still getting alerts.	2	Open	7	\N	2025-02-10 09:35:00	2025-12-07 09:04:48.528242
38	Design	Clearer error messages	Error messages should be more specific instead of generic.	4	Open	8	\N	2025-02-11 13:15:00	2025-12-07 09:04:48.528242
39	Feature	Tag-based filtering	Allow adding tags to expenses and filter by multiple tags.	5	Open	9	\N	2025-02-12 17:50:00	2025-12-07 09:04:48.528242
40	Bug	Duplicated notifications	Getting the same reminder notification multiple times.	2	Open	10	\N	2025-02-13 08:05:00	2025-12-07 09:04:48.528242
41	Performance	Slow sync on mobile data	Sync is very slow when using mobile data compared to Wi-Fi.	3	Open	1	\N	2025-02-14 10:45:00	2025-12-07 09:04:48.528242
42	Feature	Archive old accounts	Ability to archive accounts that are no longer used.	4	Open	2	\N	2025-02-15 14:25:00	2025-12-07 09:04:48.528242
43	Design	Better empty state screens	Show tips and help text when there is no data yet.	4	Open	3	\N	2025-02-16 18:30:00	2025-12-07 09:04:48.528242
\.


--
-- TOC entry 4995 (class 0 OID 16493)
-- Dependencies: 218
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name, description) FROM stdin;
1	Super Admin	Super Admin
2	Admin	Admin
3	User	Normal User of the App
\.


--
-- TOC entry 4997 (class 0 OID 16542)
-- Dependencies: 220
-- Data for Name: tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tokens (id, token, user_id, expires_at, created_at) FROM stdin;
\.


--
-- TOC entry 5011 (class 0 OID 18546)
-- Dependencies: 234
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, description, amount, type, currency, category_id, account_id, user_id, transaction_date, created_at, updated_at) FROM stdin;
1	Expense - Housing	200	Expense	INR	3	1	1	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
2	Expense - Transportation	200	Expense	INR	2	1	1	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
3	Expense - Healthcare	200	Expense	INR	4	1	1	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
4	Expense - Transportation	200	Expense	INR	2	1	1	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
5	Expense - Utilities	200	Expense	INR	9	1	1	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
6	Expense - Transportation	300	Expense	INR	2	1	1	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
7	Expense - Education	200	Expense	INR	8	1	1	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
8	Expense - Shopping	200	Expense	INR	7	1	1	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
9	Expense - Travel	200	Expense	INR	6	1	1	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
10	Expense - Shopping	200	Expense	INR	7	1	1	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
11	Expense - Shopping	200	Expense	INR	7	1	1	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
12	Expense - Housing	300	Expense	INR	3	1	1	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
13	Expense - Travel	200	Expense	INR	6	1	1	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
14	Expense - Utilities	200	Expense	INR	9	1	1	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
15	Expense - Healthcare	200	Expense	INR	4	1	1	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
16	Expense - Miscellaneous	200	Expense	INR	10	1	1	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
17	Expense - Housing	500	Expense	INR	3	1	1	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
18	Expense - Housing	1500	Expense	INR	3	1	1	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
19	Expense - Housing	200	Expense	INR	3	1	1	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
20	Expense - Healthcare	200	Expense	INR	4	1	1	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
21	Expense - Miscellaneous	200	Expense	INR	10	1	1	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
22	Expense - Housing	200	Expense	INR	3	1	1	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
23	Expense - Travel	200	Expense	INR	6	1	1	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
24	Expense - Utilities	200	Expense	INR	9	1	1	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
25	Expense - Shopping	200	Expense	INR	7	1	1	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
26	Expense - Utilities	200	Expense	INR	9	1	1	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
27	Expense - Education	200	Expense	INR	8	1	1	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
28	Expense - Travel	200	Expense	INR	6	1	1	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
29	Expense - Miscellaneous	200	Expense	INR	10	1	1	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
30	Expense - Travel	200	Expense	INR	6	1	1	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
31	Expense - Shopping	200	Expense	INR	7	1	1	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
32	Expense - Shopping	200	Expense	INR	7	1	1	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
33	Expense - Utilities	200	Expense	INR	9	1	1	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
34	Expense - Entertainment	200	Expense	INR	5	1	1	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
35	Expense - Miscellaneous	200	Expense	INR	10	1	1	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
36	Expense - Education	200	Expense	INR	8	1	1	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
37	Expense - Travel	200	Expense	INR	6	1	1	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
38	Expense - Utilities	200	Expense	INR	9	1	1	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
39	Expense - Housing	200	Expense	INR	3	1	1	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
40	Expense - Transportation	700	Expense	INR	2	1	1	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
41	Expense - Utilities	200	Expense	INR	9	1	1	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
42	Expense - Travel	200	Expense	INR	6	1	1	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
43	Expense - Healthcare	200	Expense	INR	4	1	1	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
44	Expense - Transportation	200	Expense	INR	2	1	1	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
45	Expense - Utilities	200	Expense	INR	9	1	1	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
46	Expense - Transportation	200	Expense	INR	2	1	1	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
47	Expense - Housing	600	Expense	INR	3	1	1	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
48	Expense - Transportation	200	Expense	INR	2	1	1	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
49	Expense - Food & Dining	200	Expense	INR	1	1	1	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
50	Expense - Miscellaneous	200	Expense	INR	10	1	1	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
51	Expense - Utilities	200	Expense	INR	9	1	1	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
52	Expense - Entertainment	200	Expense	INR	5	1	1	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
53	Expense - Miscellaneous	200	Expense	INR	10	1	1	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
54	Expense - Education	200	Expense	INR	8	1	1	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
55	Expense - Miscellaneous	200	Expense	INR	10	1	1	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
56	Expense - Food & Dining	200	Expense	INR	1	1	1	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
57	Expense - Education	200	Expense	INR	8	1	1	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
58	Expense - Food & Dining	400	Expense	INR	1	2	2	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
59	Expense - Miscellaneous	200	Expense	INR	10	2	2	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
60	Expense - Food & Dining	300	Expense	INR	1	2	2	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
61	Expense - Miscellaneous	200	Expense	INR	10	2	2	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
62	Expense - Housing	300	Expense	INR	3	2	2	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
63	Expense - Miscellaneous	200	Expense	INR	10	2	2	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
64	Expense - Travel	200	Expense	INR	6	2	2	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
65	Expense - Utilities	700	Expense	INR	9	2	2	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
66	Expense - Utilities	200	Expense	INR	9	2	2	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
67	Expense - Utilities	300	Expense	INR	9	2	2	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
68	Expense - Entertainment	400	Expense	INR	5	2	2	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
69	Expense - Education	200	Expense	INR	8	2	2	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
70	Expense - Utilities	200	Expense	INR	9	2	2	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
71	Expense - Education	200	Expense	INR	8	2	2	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
72	Expense - Education	200	Expense	INR	8	2	2	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
73	Expense - Miscellaneous	200	Expense	INR	10	2	2	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
74	Expense - Food & Dining	200	Expense	INR	1	2	2	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
75	Expense - Miscellaneous	200	Expense	INR	10	2	2	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
76	Expense - Healthcare	200	Expense	INR	4	2	2	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
77	Expense - Utilities	200	Expense	INR	9	2	2	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
78	Expense - Travel	200	Expense	INR	6	2	2	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
79	Expense - Healthcare	300	Expense	INR	4	2	2	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
80	Expense - Education	500	Expense	INR	8	2	2	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
81	Expense - Shopping	200	Expense	INR	7	2	2	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
82	Expense - Education	200	Expense	INR	8	2	2	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
83	Expense - Housing	900	Expense	INR	3	2	2	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
84	Expense - Transportation	900	Expense	INR	2	2	2	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
85	Expense - Housing	200	Expense	INR	3	2	2	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
86	Expense - Entertainment	200	Expense	INR	5	2	2	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
87	Expense - Food & Dining	400	Expense	INR	1	2	2	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
88	Expense - Transportation	200	Expense	INR	2	2	2	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
89	Expense - Miscellaneous	200	Expense	INR	10	2	2	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
90	Expense - Utilities	700	Expense	INR	9	2	2	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
91	Expense - Education	200	Expense	INR	8	2	2	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
92	Expense - Transportation	300	Expense	INR	2	2	2	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
93	Expense - Transportation	300	Expense	INR	2	2	2	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
94	Expense - Shopping	200	Expense	INR	7	2	2	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
95	Expense - Housing	300	Expense	INR	3	2	2	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
96	Expense - Entertainment	200	Expense	INR	5	2	2	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
97	Expense - Travel	200	Expense	INR	6	2	2	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
98	Expense - Utilities	200	Expense	INR	9	2	2	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
99	Expense - Entertainment	200	Expense	INR	5	2	2	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
100	Expense - Housing	1100	Expense	INR	3	2	2	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
101	Expense - Healthcare	200	Expense	INR	4	2	2	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
102	Expense - Food & Dining	300	Expense	INR	1	2	2	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
103	Expense - Travel	200	Expense	INR	6	2	2	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
104	Expense - Transportation	1000	Expense	INR	2	2	2	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
105	Expense - Shopping	300	Expense	INR	7	2	2	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
106	Expense - Healthcare	200	Expense	INR	4	2	2	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
107	Expense - Transportation	200	Expense	INR	2	2	2	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
108	Expense - Housing	700	Expense	INR	3	2	2	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
109	Expense - Miscellaneous	200	Expense	INR	10	2	2	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
110	Expense - Entertainment	200	Expense	INR	5	2	2	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
111	Expense - Healthcare	200	Expense	INR	4	2	2	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
112	Expense - Housing	1300	Expense	INR	3	2	2	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
113	Expense - Education	200	Expense	INR	8	2	2	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
114	Expense - Utilities	300	Expense	INR	9	2	2	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
115	Expense - Travel	200	Expense	INR	6	2	2	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
116	Expense - Education	200	Expense	INR	8	2	2	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
117	Expense - Utilities	200	Expense	INR	9	2	2	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
118	Expense - Transportation	200	Expense	INR	2	2	2	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
119	Expense - Travel	200	Expense	INR	6	2	2	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
120	Expense - Travel	200	Expense	INR	6	2	2	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
121	Expense - Healthcare	200	Expense	INR	4	2	2	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
122	Expense - Housing	1200	Expense	INR	3	2	2	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
123	Expense - Education	200	Expense	INR	8	2	2	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
124	Expense - Entertainment	200	Expense	INR	5	2	2	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
125	Expense - Food & Dining	800	Expense	INR	1	2	2	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
126	Expense - Miscellaneous	200	Expense	INR	10	2	2	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
127	Expense - Food & Dining	300	Expense	INR	1	2	2	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
128	Expense - Travel	200	Expense	INR	6	2	2	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
129	Expense - Healthcare	500	Expense	INR	4	2	2	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
130	Expense - Healthcare	300	Expense	INR	4	2	2	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
131	Expense - Healthcare	200	Expense	INR	4	2	2	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
132	Expense - Entertainment	200	Expense	INR	5	2	2	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
133	Expense - Travel	200	Expense	INR	6	2	2	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
134	Expense - Transportation	200	Expense	INR	2	2	2	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
135	Expense - Miscellaneous	200	Expense	INR	10	2	2	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
136	Expense - Healthcare	200	Expense	INR	4	2	2	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
137	Expense - Utilities	300	Expense	INR	9	2	2	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
138	Expense - Utilities	300	Expense	INR	9	2	2	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
139	Expense - Entertainment	200	Expense	INR	5	2	2	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
140	Expense - Utilities	200	Expense	INR	9	3	3	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
141	Expense - Travel	200	Expense	INR	6	3	3	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
142	Expense - Travel	200	Expense	INR	6	3	3	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
143	Expense - Housing	200	Expense	INR	3	3	3	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
144	Expense - Entertainment	200	Expense	INR	5	3	3	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
145	Expense - Education	200	Expense	INR	8	3	3	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
146	Expense - Healthcare	200	Expense	INR	4	3	3	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
147	Expense - Food & Dining	300	Expense	INR	1	3	3	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
148	Expense - Entertainment	200	Expense	INR	5	3	3	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
149	Expense - Education	200	Expense	INR	8	3	3	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
150	Expense - Miscellaneous	200	Expense	INR	10	3	3	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
151	Expense - Education	200	Expense	INR	8	3	3	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
152	Expense - Food & Dining	200	Expense	INR	1	3	3	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
153	Expense - Housing	500	Expense	INR	3	3	3	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
154	Expense - Shopping	200	Expense	INR	7	3	3	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
155	Expense - Healthcare	300	Expense	INR	4	3	3	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
156	Expense - Housing	400	Expense	INR	3	3	3	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
157	Expense - Transportation	200	Expense	INR	2	3	3	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
158	Expense - Food & Dining	300	Expense	INR	1	3	3	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
159	Expense - Utilities	200	Expense	INR	9	3	3	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
160	Expense - Entertainment	200	Expense	INR	5	3	3	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
161	Expense - Utilities	200	Expense	INR	9	3	3	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
162	Expense - Utilities	200	Expense	INR	9	3	3	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
163	Expense - Travel	200	Expense	INR	6	3	3	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
164	Expense - Entertainment	200	Expense	INR	5	3	3	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
165	Expense - Utilities	200	Expense	INR	9	3	3	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
166	Expense - Miscellaneous	200	Expense	INR	10	3	3	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
167	Expense - Housing	200	Expense	INR	3	3	3	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
168	Expense - Shopping	200	Expense	INR	7	3	3	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
169	Expense - Food & Dining	200	Expense	INR	1	3	3	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
170	Expense - Travel	200	Expense	INR	6	3	3	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
171	Expense - Education	200	Expense	INR	8	3	3	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
172	Expense - Entertainment	200	Expense	INR	5	3	3	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
173	Expense - Education	200	Expense	INR	8	3	3	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
174	Expense - Entertainment	200	Expense	INR	5	3	3	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
175	Expense - Entertainment	200	Expense	INR	5	3	3	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
176	Expense - Miscellaneous	200	Expense	INR	10	3	3	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
177	Expense - Transportation	200	Expense	INR	2	3	3	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
178	Expense - Miscellaneous	200	Expense	INR	10	3	3	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
179	Expense - Miscellaneous	200	Expense	INR	10	3	3	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
180	Expense - Entertainment	200	Expense	INR	5	3	3	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
181	Expense - Utilities	200	Expense	INR	9	3	3	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
182	Expense - Shopping	200	Expense	INR	7	3	3	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
183	Expense - Entertainment	200	Expense	INR	5	3	3	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
184	Expense - Entertainment	200	Expense	INR	5	3	3	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
185	Expense - Travel	200	Expense	INR	6	3	3	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
186	Expense - Housing	200	Expense	INR	3	3	3	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
187	Expense - Education	200	Expense	INR	8	3	3	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
188	Expense - Transportation	200	Expense	INR	2	3	3	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
189	Expense - Travel	200	Expense	INR	6	3	3	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
190	Expense - Food & Dining	200	Expense	INR	1	4	4	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
191	Expense - Utilities	200	Expense	INR	9	4	4	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
192	Expense - Transportation	400	Expense	INR	2	4	4	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
193	Expense - Utilities	500	Expense	INR	9	4	4	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
194	Expense - Entertainment	200	Expense	INR	5	4	4	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
195	Expense - Education	200	Expense	INR	8	4	4	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
196	Expense - Entertainment	500	Expense	INR	5	4	4	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
197	Expense - Healthcare	200	Expense	INR	4	4	4	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
198	Expense - Shopping	200	Expense	INR	7	4	4	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
199	Expense - Education	200	Expense	INR	8	4	4	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
200	Expense - Healthcare	200	Expense	INR	4	4	4	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
201	Expense - Entertainment	200	Expense	INR	5	4	4	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
202	Expense - Shopping	200	Expense	INR	7	4	4	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
203	Expense - Food & Dining	200	Expense	INR	1	4	4	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
204	Expense - Utilities	200	Expense	INR	9	4	4	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
205	Expense - Miscellaneous	200	Expense	INR	10	4	4	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
206	Expense - Healthcare	200	Expense	INR	4	4	4	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
207	Expense - Food & Dining	400	Expense	INR	1	4	4	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
208	Expense - Healthcare	200	Expense	INR	4	4	4	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
209	Expense - Education	200	Expense	INR	8	4	4	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
210	Expense - Education	200	Expense	INR	8	4	4	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
211	Expense - Shopping	300	Expense	INR	7	4	4	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
212	Expense - Food & Dining	200	Expense	INR	1	4	4	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
213	Expense - Travel	200	Expense	INR	6	4	4	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
214	Expense - Travel	200	Expense	INR	6	4	4	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
215	Expense - Shopping	200	Expense	INR	7	4	4	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
216	Expense - Shopping	200	Expense	INR	7	4	4	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
217	Expense - Miscellaneous	200	Expense	INR	10	4	4	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
218	Expense - Travel	200	Expense	INR	6	4	4	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
219	Expense - Entertainment	200	Expense	INR	5	4	4	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
220	Expense - Travel	200	Expense	INR	6	4	4	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
221	Expense - Housing	2100	Expense	INR	3	4	4	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
222	Expense - Education	300	Expense	INR	8	4	4	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
223	Expense - Housing	500	Expense	INR	3	4	4	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
224	Expense - Entertainment	200	Expense	INR	5	4	4	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
225	Expense - Education	200	Expense	INR	8	4	4	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
226	Expense - Shopping	200	Expense	INR	7	4	4	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
227	Expense - Education	200	Expense	INR	8	4	4	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
228	Expense - Utilities	200	Expense	INR	9	4	4	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
229	Expense - Miscellaneous	200	Expense	INR	10	4	4	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
230	Expense - Shopping	200	Expense	INR	7	4	4	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
231	Expense - Travel	200	Expense	INR	6	4	4	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
232	Expense - Healthcare	200	Expense	INR	4	4	4	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
233	Expense - Shopping	200	Expense	INR	7	4	4	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
234	Expense - Utilities	200	Expense	INR	9	4	4	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
235	Expense - Healthcare	200	Expense	INR	4	4	4	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
236	Expense - Food & Dining	500	Expense	INR	1	4	4	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
237	Expense - Utilities	200	Expense	INR	9	4	4	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
238	Expense - Entertainment	200	Expense	INR	5	4	4	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
239	Expense - Transportation	200	Expense	INR	2	4	4	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
240	Expense - Miscellaneous	200	Expense	INR	10	4	4	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
241	Expense - Housing	200	Expense	INR	3	4	4	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
242	Expense - Food & Dining	500	Expense	INR	1	4	4	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
243	Expense - Transportation	200	Expense	INR	2	4	4	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
244	Expense - Entertainment	200	Expense	INR	5	4	4	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
245	Expense - Miscellaneous	200	Expense	INR	10	4	4	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
246	Expense - Entertainment	200	Expense	INR	5	4	4	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
247	Expense - Miscellaneous	200	Expense	INR	10	4	4	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
248	Expense - Shopping	200	Expense	INR	7	4	4	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
249	Expense - Miscellaneous	200	Expense	INR	10	4	4	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
250	Expense - Shopping	200	Expense	INR	7	4	4	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
251	Expense - Shopping	200	Expense	INR	7	4	4	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
252	Expense - Healthcare	200	Expense	INR	4	5	5	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
253	Expense - Housing	1800	Expense	INR	3	5	5	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
254	Expense - Food & Dining	200	Expense	INR	1	5	5	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
255	Expense - Miscellaneous	200	Expense	INR	10	5	5	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
256	Expense - Food & Dining	300	Expense	INR	1	5	5	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
257	Expense - Housing	800	Expense	INR	3	5	5	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
258	Expense - Transportation	200	Expense	INR	2	5	5	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
259	Expense - Travel	300	Expense	INR	6	5	5	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
260	Expense - Education	200	Expense	INR	8	5	5	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
261	Expense - Utilities	200	Expense	INR	9	5	5	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
262	Expense - Utilities	200	Expense	INR	9	5	5	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
263	Expense - Housing	200	Expense	INR	3	5	5	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
264	Expense - Housing	200	Expense	INR	3	5	5	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
265	Expense - Travel	200	Expense	INR	6	5	5	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
266	Expense - Miscellaneous	200	Expense	INR	10	5	5	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
267	Expense - Travel	200	Expense	INR	6	5	5	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
268	Expense - Transportation	200	Expense	INR	2	5	5	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
269	Expense - Miscellaneous	200	Expense	INR	10	5	5	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
270	Expense - Education	200	Expense	INR	8	5	5	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
271	Expense - Entertainment	200	Expense	INR	5	5	5	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
272	Expense - Healthcare	200	Expense	INR	4	5	5	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
273	Expense - Shopping	200	Expense	INR	7	5	5	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
274	Expense - Miscellaneous	200	Expense	INR	10	5	5	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
275	Expense - Healthcare	200	Expense	INR	4	5	5	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
276	Expense - Healthcare	200	Expense	INR	4	5	5	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
277	Expense - Shopping	200	Expense	INR	7	5	5	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
278	Expense - Transportation	200	Expense	INR	2	5	5	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
279	Expense - Travel	200	Expense	INR	6	5	5	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
280	Expense - Utilities	200	Expense	INR	9	5	5	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
281	Expense - Shopping	200	Expense	INR	7	5	5	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
282	Expense - Utilities	200	Expense	INR	9	5	5	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
283	Expense - Healthcare	200	Expense	INR	4	5	5	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
284	Expense - Shopping	400	Expense	INR	7	5	5	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
285	Expense - Education	200	Expense	INR	8	5	5	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
286	Expense - Miscellaneous	200	Expense	INR	10	5	5	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
287	Expense - Travel	200	Expense	INR	6	5	5	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
288	Expense - Utilities	200	Expense	INR	9	5	5	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
289	Expense - Travel	200	Expense	INR	6	5	5	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
290	Expense - Transportation	400	Expense	INR	2	5	5	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
291	Expense - Housing	300	Expense	INR	3	5	5	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
292	Expense - Education	200	Expense	INR	8	5	5	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
293	Expense - Utilities	200	Expense	INR	9	5	5	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
294	Expense - Food & Dining	300	Expense	INR	1	5	5	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
295	Expense - Food & Dining	200	Expense	INR	1	5	5	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
296	Expense - Education	200	Expense	INR	8	5	5	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
297	Expense - Food & Dining	400	Expense	INR	1	5	5	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
298	Expense - Entertainment	200	Expense	INR	5	5	5	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
299	Expense - Healthcare	200	Expense	INR	4	5	5	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
300	Expense - Healthcare	200	Expense	INR	4	5	5	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
301	Expense - Transportation	200	Expense	INR	2	5	5	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
302	Expense - Education	200	Expense	INR	8	5	5	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
303	Expense - Shopping	400	Expense	INR	7	5	5	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
304	Expense - Entertainment	200	Expense	INR	5	5	5	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
305	Expense - Housing	200	Expense	INR	3	5	5	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
306	Expense - Food & Dining	200	Expense	INR	1	5	5	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
307	Expense - Travel	200	Expense	INR	6	5	5	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
308	Expense - Miscellaneous	200	Expense	INR	10	5	5	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
309	Expense - Food & Dining	200	Expense	INR	1	5	5	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
310	Expense - Travel	200	Expense	INR	6	5	5	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
311	Expense - Education	200	Expense	INR	8	6	6	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
312	Expense - Education	200	Expense	INR	8	6	6	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
313	Expense - Food & Dining	500	Expense	INR	1	6	6	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
314	Expense - Utilities	200	Expense	INR	9	6	6	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
315	Expense - Healthcare	200	Expense	INR	4	6	6	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
316	Expense - Miscellaneous	200	Expense	INR	10	6	6	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
317	Expense - Miscellaneous	200	Expense	INR	10	6	6	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
318	Expense - Food & Dining	200	Expense	INR	1	6	6	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
319	Expense - Transportation	200	Expense	INR	2	6	6	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
320	Expense - Housing	400	Expense	INR	3	6	6	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
321	Expense - Education	200	Expense	INR	8	6	6	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
322	Expense - Travel	200	Expense	INR	6	6	6	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
323	Expense - Utilities	300	Expense	INR	9	6	6	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
324	Expense - Travel	200	Expense	INR	6	6	6	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
325	Expense - Shopping	200	Expense	INR	7	6	6	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
326	Expense - Entertainment	200	Expense	INR	5	6	6	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
327	Expense - Education	200	Expense	INR	8	6	6	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
328	Expense - Food & Dining	200	Expense	INR	1	6	6	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
329	Expense - Travel	200	Expense	INR	6	6	6	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
330	Expense - Miscellaneous	200	Expense	INR	10	6	6	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
331	Expense - Education	200	Expense	INR	8	6	6	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
332	Expense - Entertainment	200	Expense	INR	5	6	6	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
333	Expense - Shopping	200	Expense	INR	7	6	6	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
334	Expense - Housing	600	Expense	INR	3	6	6	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
335	Expense - Miscellaneous	200	Expense	INR	10	6	6	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
336	Expense - Entertainment	200	Expense	INR	5	6	6	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
337	Expense - Healthcare	200	Expense	INR	4	6	6	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
338	Expense - Travel	200	Expense	INR	6	6	6	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
339	Expense - Food & Dining	200	Expense	INR	1	6	6	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
340	Expense - Transportation	200	Expense	INR	2	6	6	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
341	Expense - Travel	200	Expense	INR	6	6	6	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
342	Expense - Utilities	200	Expense	INR	9	6	6	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
343	Expense - Travel	200	Expense	INR	6	6	6	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
344	Expense - Entertainment	200	Expense	INR	5	6	6	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
345	Expense - Food & Dining	1000	Expense	INR	1	6	6	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
346	Expense - Housing	1300	Expense	INR	3	6	6	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
347	Expense - Travel	200	Expense	INR	6	6	6	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
348	Expense - Miscellaneous	200	Expense	INR	10	6	6	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
349	Expense - Miscellaneous	200	Expense	INR	10	6	6	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
350	Expense - Shopping	200	Expense	INR	7	6	6	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
351	Expense - Entertainment	200	Expense	INR	5	6	6	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
352	Expense - Travel	200	Expense	INR	6	6	6	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
353	Expense - Utilities	200	Expense	INR	9	6	6	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
354	Expense - Entertainment	200	Expense	INR	5	6	6	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
355	Expense - Entertainment	200	Expense	INR	5	6	6	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
356	Expense - Entertainment	200	Expense	INR	5	6	6	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
357	Expense - Healthcare	200	Expense	INR	4	6	6	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
358	Expense - Utilities	200	Expense	INR	9	6	6	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
359	Expense - Healthcare	200	Expense	INR	4	6	6	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
360	Expense - Utilities	200	Expense	INR	9	6	6	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
361	Expense - Travel	200	Expense	INR	6	6	6	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
362	Expense - Entertainment	200	Expense	INR	5	6	6	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
363	Expense - Shopping	200	Expense	INR	7	6	6	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
364	Expense - Housing	200	Expense	INR	3	6	6	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
365	Expense - Transportation	200	Expense	INR	2	6	6	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
366	Expense - Shopping	200	Expense	INR	7	6	6	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
367	Expense - Travel	200	Expense	INR	6	6	6	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
368	Expense - Shopping	200	Expense	INR	7	6	6	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
369	Expense - Miscellaneous	200	Expense	INR	10	6	6	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
370	Expense - Miscellaneous	200	Expense	INR	10	6	6	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
371	Expense - Transportation	200	Expense	INR	2	6	6	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
372	Expense - Shopping	200	Expense	INR	7	6	6	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
373	Expense - Healthcare	200	Expense	INR	4	6	6	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
374	Expense - Shopping	200	Expense	INR	7	6	6	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
375	Expense - Housing	500	Expense	INR	3	6	6	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
376	Expense - Housing	300	Expense	INR	3	6	6	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
377	Expense - Shopping	200	Expense	INR	7	6	6	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
378	Expense - Transportation	300	Expense	INR	2	7	7	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
379	Expense - Housing	300	Expense	INR	3	7	7	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
380	Expense - Travel	500	Expense	INR	6	7	7	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
381	Expense - Entertainment	200	Expense	INR	5	7	7	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
382	Expense - Housing	400	Expense	INR	3	7	7	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
383	Expense - Entertainment	200	Expense	INR	5	7	7	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
384	Expense - Education	200	Expense	INR	8	7	7	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
385	Expense - Food & Dining	200	Expense	INR	1	7	7	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
386	Expense - Shopping	200	Expense	INR	7	7	7	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
387	Expense - Shopping	200	Expense	INR	7	7	7	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
388	Expense - Food & Dining	200	Expense	INR	1	7	7	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
389	Expense - Housing	200	Expense	INR	3	7	7	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
390	Expense - Transportation	200	Expense	INR	2	7	7	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
391	Expense - Housing	700	Expense	INR	3	7	7	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
392	Expense - Food & Dining	1500	Expense	INR	1	7	7	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
393	Expense - Travel	200	Expense	INR	6	7	7	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
394	Expense - Utilities	200	Expense	INR	9	7	7	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
395	Expense - Shopping	200	Expense	INR	7	7	7	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
396	Expense - Education	200	Expense	INR	8	7	7	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
397	Expense - Healthcare	200	Expense	INR	4	7	7	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
398	Expense - Utilities	200	Expense	INR	9	7	7	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
399	Expense - Transportation	200	Expense	INR	2	7	7	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
400	Expense - Entertainment	200	Expense	INR	5	7	7	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
401	Expense - Food & Dining	300	Expense	INR	1	7	7	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
402	Expense - Transportation	300	Expense	INR	2	7	7	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
403	Expense - Miscellaneous	200	Expense	INR	10	7	7	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
404	Expense - Miscellaneous	200	Expense	INR	10	7	7	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
405	Expense - Miscellaneous	200	Expense	INR	10	7	7	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
406	Expense - Transportation	300	Expense	INR	2	7	7	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
407	Expense - Housing	500	Expense	INR	3	7	7	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
408	Expense - Food & Dining	500	Expense	INR	1	7	7	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
409	Expense - Transportation	200	Expense	INR	2	7	7	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
410	Expense - Shopping	200	Expense	INR	7	7	7	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
411	Expense - Transportation	300	Expense	INR	2	7	7	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
412	Expense - Healthcare	200	Expense	INR	4	7	7	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
413	Expense - Healthcare	400	Expense	INR	4	7	7	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
414	Expense - Education	200	Expense	INR	8	7	7	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
415	Expense - Housing	1300	Expense	INR	3	7	7	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
416	Expense - Housing	1400	Expense	INR	3	7	7	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
417	Expense - Travel	200	Expense	INR	6	7	7	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
418	Expense - Shopping	200	Expense	INR	7	7	7	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
419	Expense - Shopping	200	Expense	INR	7	7	7	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
420	Expense - Utilities	200	Expense	INR	9	7	7	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
421	Expense - Entertainment	200	Expense	INR	5	7	7	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
422	Expense - Travel	300	Expense	INR	6	7	7	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
423	Expense - Food & Dining	200	Expense	INR	1	7	7	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
424	Expense - Housing	200	Expense	INR	3	7	7	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
425	Expense - Utilities	200	Expense	INR	9	7	7	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
426	Expense - Shopping	200	Expense	INR	7	7	7	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
427	Expense - Utilities	200	Expense	INR	9	7	7	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
428	Expense - Utilities	200	Expense	INR	9	7	7	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
429	Expense - Transportation	200	Expense	INR	2	7	7	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
430	Expense - Shopping	200	Expense	INR	7	7	7	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
431	Expense - Travel	200	Expense	INR	6	7	7	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
432	Expense - Travel	200	Expense	INR	6	7	7	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
433	Expense - Housing	200	Expense	INR	3	7	7	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
434	Expense - Entertainment	200	Expense	INR	5	7	7	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
435	Expense - Entertainment	200	Expense	INR	5	7	7	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
436	Expense - Healthcare	200	Expense	INR	4	8	8	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
437	Expense - Travel	200	Expense	INR	6	8	8	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
438	Expense - Food & Dining	700	Expense	INR	1	8	8	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
439	Expense - Utilities	300	Expense	INR	9	8	8	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
440	Expense - Transportation	200	Expense	INR	2	8	8	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
441	Expense - Food & Dining	800	Expense	INR	1	8	8	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
442	Expense - Transportation	200	Expense	INR	2	8	8	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
443	Expense - Transportation	900	Expense	INR	2	8	8	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
444	Expense - Travel	200	Expense	INR	6	8	8	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
445	Expense - Travel	200	Expense	INR	6	8	8	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
446	Expense - Utilities	200	Expense	INR	9	8	8	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
447	Expense - Shopping	600	Expense	INR	7	8	8	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
448	Expense - Entertainment	200	Expense	INR	5	8	8	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
449	Expense - Housing	400	Expense	INR	3	8	8	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
450	Expense - Shopping	700	Expense	INR	7	8	8	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
451	Expense - Utilities	500	Expense	INR	9	8	8	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
452	Expense - Transportation	200	Expense	INR	2	8	8	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
453	Expense - Education	200	Expense	INR	8	8	8	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
454	Expense - Housing	400	Expense	INR	3	8	8	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
455	Expense - Food & Dining	1300	Expense	INR	1	8	8	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
456	Expense - Utilities	500	Expense	INR	9	8	8	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
457	Expense - Housing	1000	Expense	INR	3	8	8	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
458	Expense - Transportation	200	Expense	INR	2	8	8	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
459	Expense - Travel	200	Expense	INR	6	8	8	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
460	Expense - Travel	500	Expense	INR	6	8	8	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
461	Expense - Transportation	200	Expense	INR	2	8	8	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
462	Expense - Healthcare	200	Expense	INR	4	8	8	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
463	Expense - Transportation	200	Expense	INR	2	8	8	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
464	Expense - Utilities	700	Expense	INR	9	8	8	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
465	Expense - Transportation	200	Expense	INR	2	8	8	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
466	Expense - Entertainment	200	Expense	INR	5	8	8	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
467	Expense - Healthcare	200	Expense	INR	4	8	8	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
468	Expense - Miscellaneous	200	Expense	INR	10	8	8	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
469	Expense - Travel	200	Expense	INR	6	8	8	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
470	Expense - Education	300	Expense	INR	8	8	8	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
471	Expense - Housing	900	Expense	INR	3	8	8	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
472	Expense - Food & Dining	800	Expense	INR	1	8	8	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
473	Expense - Housing	200	Expense	INR	3	8	8	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
474	Expense - Food & Dining	200	Expense	INR	1	8	8	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
475	Expense - Transportation	200	Expense	INR	2	8	8	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
476	Expense - Shopping	200	Expense	INR	7	8	8	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
477	Expense - Transportation	200	Expense	INR	2	8	8	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
478	Expense - Utilities	200	Expense	INR	9	8	8	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
479	Expense - Housing	300	Expense	INR	3	8	8	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
480	Expense - Food & Dining	300	Expense	INR	1	8	8	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
481	Expense - Transportation	200	Expense	INR	2	8	8	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
482	Expense - Education	200	Expense	INR	8	8	8	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
483	Expense - Healthcare	200	Expense	INR	4	8	8	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
484	Expense - Housing	200	Expense	INR	3	8	8	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
485	Expense - Miscellaneous	200	Expense	INR	10	8	8	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
486	Expense - Shopping	200	Expense	INR	7	8	8	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
487	Expense - Utilities	200	Expense	INR	9	8	8	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
488	Expense - Housing	200	Expense	INR	3	8	8	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
489	Expense - Housing	400	Expense	INR	3	8	8	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
490	Expense - Healthcare	200	Expense	INR	4	8	8	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
491	Expense - Healthcare	200	Expense	INR	4	8	8	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
492	Expense - Healthcare	200	Expense	INR	4	8	8	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
493	Expense - Travel	200	Expense	INR	6	8	8	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
494	Expense - Transportation	200	Expense	INR	2	9	9	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
495	Expense - Healthcare	300	Expense	INR	4	9	9	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
496	Expense - Entertainment	200	Expense	INR	5	9	9	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
497	Expense - Shopping	200	Expense	INR	7	9	9	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
498	Expense - Travel	200	Expense	INR	6	9	9	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
499	Expense - Education	200	Expense	INR	8	9	9	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
500	Expense - Utilities	200	Expense	INR	9	9	9	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
501	Expense - Transportation	200	Expense	INR	2	9	9	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
502	Expense - Utilities	200	Expense	INR	9	9	9	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
503	Expense - Miscellaneous	200	Expense	INR	10	9	9	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
504	Expense - Transportation	200	Expense	INR	2	9	9	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
505	Expense - Shopping	200	Expense	INR	7	9	9	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
506	Expense - Miscellaneous	200	Expense	INR	10	9	9	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
507	Expense - Healthcare	400	Expense	INR	4	9	9	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
508	Expense - Travel	200	Expense	INR	6	9	9	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
509	Expense - Food & Dining	900	Expense	INR	1	9	9	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
510	Expense - Miscellaneous	200	Expense	INR	10	9	9	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
511	Expense - Entertainment	200	Expense	INR	5	9	9	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
512	Expense - Travel	200	Expense	INR	6	9	9	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
513	Expense - Healthcare	200	Expense	INR	4	9	9	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
514	Expense - Housing	300	Expense	INR	3	9	9	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
515	Expense - Travel	200	Expense	INR	6	9	9	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
516	Expense - Transportation	200	Expense	INR	2	9	9	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
517	Expense - Miscellaneous	200	Expense	INR	10	9	9	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
518	Expense - Healthcare	200	Expense	INR	4	9	9	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
519	Expense - Housing	600	Expense	INR	3	9	9	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
520	Expense - Miscellaneous	200	Expense	INR	10	9	9	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
521	Expense - Utilities	200	Expense	INR	9	9	9	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
522	Expense - Housing	500	Expense	INR	3	9	9	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
523	Expense - Shopping	200	Expense	INR	7	9	9	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
524	Expense - Transportation	400	Expense	INR	2	9	9	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
525	Expense - Miscellaneous	200	Expense	INR	10	9	9	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
526	Expense - Healthcare	200	Expense	INR	4	9	9	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
527	Expense - Healthcare	200	Expense	INR	4	9	9	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
528	Expense - Miscellaneous	200	Expense	INR	10	9	9	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
529	Expense - Travel	200	Expense	INR	6	9	9	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
530	Expense - Entertainment	200	Expense	INR	5	9	9	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
531	Expense - Transportation	200	Expense	INR	2	9	9	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
532	Expense - Food & Dining	200	Expense	INR	1	9	9	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
533	Expense - Travel	200	Expense	INR	6	9	9	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
534	Expense - Travel	200	Expense	INR	6	9	9	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
535	Expense - Utilities	200	Expense	INR	9	9	9	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
536	Expense - Shopping	200	Expense	INR	7	9	9	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
537	Expense - Food & Dining	1500	Expense	INR	1	9	9	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
538	Expense - Miscellaneous	200	Expense	INR	10	9	9	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
539	Expense - Miscellaneous	200	Expense	INR	10	9	9	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
540	Expense - Education	200	Expense	INR	8	9	9	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
541	Expense - Shopping	200	Expense	INR	7	9	9	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
542	Expense - Healthcare	200	Expense	INR	4	9	9	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
543	Expense - Travel	200	Expense	INR	6	9	9	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
544	Expense - Utilities	200	Expense	INR	9	9	9	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
545	Expense - Utilities	500	Expense	INR	9	9	9	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
546	Expense - Shopping	200	Expense	INR	7	9	9	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
547	Expense - Utilities	400	Expense	INR	9	9	9	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
548	Expense - Transportation	300	Expense	INR	2	9	9	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
549	Expense - Healthcare	200	Expense	INR	4	9	9	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
550	Expense - Travel	200	Expense	INR	6	9	9	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
551	Expense - Housing	1700	Expense	INR	3	9	9	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
552	Expense - Housing	200	Expense	INR	3	9	9	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
553	Expense - Food & Dining	200	Expense	INR	1	9	9	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
554	Expense - Healthcare	200	Expense	INR	4	9	9	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
555	Expense - Travel	200	Expense	INR	6	9	9	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
556	Expense - Food & Dining	300	Expense	INR	1	9	9	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
557	Expense - Housing	200	Expense	INR	3	10	10	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
558	Expense - Travel	200	Expense	INR	6	10	10	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
559	Expense - Transportation	200	Expense	INR	2	10	10	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
560	Expense - Food & Dining	200	Expense	INR	1	10	10	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
561	Expense - Housing	200	Expense	INR	3	10	10	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
562	Expense - Utilities	200	Expense	INR	9	10	10	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
563	Expense - Housing	200	Expense	INR	3	10	10	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
564	Expense - Shopping	200	Expense	INR	7	10	10	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
565	Expense - Healthcare	200	Expense	INR	4	10	10	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
566	Expense - Entertainment	200	Expense	INR	5	10	10	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
567	Expense - Food & Dining	200	Expense	INR	1	10	10	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
568	Expense - Miscellaneous	200	Expense	INR	10	10	10	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
569	Expense - Shopping	200	Expense	INR	7	10	10	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
570	Expense - Housing	200	Expense	INR	3	10	10	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
571	Expense - Shopping	200	Expense	INR	7	10	10	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
572	Expense - Transportation	200	Expense	INR	2	10	10	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
573	Expense - Education	200	Expense	INR	8	10	10	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
574	Expense - Miscellaneous	200	Expense	INR	10	10	10	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
575	Expense - Travel	200	Expense	INR	6	10	10	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
576	Expense - Transportation	200	Expense	INR	2	10	10	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
577	Expense - Utilities	200	Expense	INR	9	10	10	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
578	Expense - Transportation	200	Expense	INR	2	10	10	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
579	Expense - Housing	200	Expense	INR	3	10	10	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
580	Expense - Transportation	200	Expense	INR	2	10	10	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
581	Expense - Healthcare	200	Expense	INR	4	10	10	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
582	Expense - Utilities	200	Expense	INR	9	10	10	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
583	Expense - Shopping	300	Expense	INR	7	10	10	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
584	Expense - Housing	500	Expense	INR	3	10	10	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
585	Expense - Housing	200	Expense	INR	3	10	10	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
586	Expense - Transportation	200	Expense	INR	2	10	10	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
587	Expense - Healthcare	200	Expense	INR	4	10	10	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
588	Expense - Shopping	200	Expense	INR	7	10	10	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
589	Expense - Education	200	Expense	INR	8	10	10	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
590	Expense - Healthcare	200	Expense	INR	4	10	10	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
591	Expense - Travel	200	Expense	INR	6	10	10	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
592	Expense - Transportation	200	Expense	INR	2	10	10	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
593	Expense - Healthcare	200	Expense	INR	4	10	10	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
594	Expense - Shopping	200	Expense	INR	7	10	10	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
595	Expense - Healthcare	200	Expense	INR	4	10	10	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
596	Expense - Shopping	200	Expense	INR	7	10	10	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
597	Expense - Shopping	200	Expense	INR	7	10	10	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
598	Expense - Utilities	200	Expense	INR	9	10	10	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
599	Expense - Entertainment	200	Expense	INR	5	10	10	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
600	Expense - Entertainment	200	Expense	INR	5	10	10	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
601	Expense - Utilities	300	Expense	INR	9	10	10	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
602	Expense - Food & Dining	200	Expense	INR	1	10	10	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
603	Expense - Travel	200	Expense	INR	6	10	10	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
604	Expense - Miscellaneous	200	Expense	INR	10	10	10	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
605	Expense - Housing	200	Expense	INR	3	10	10	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
606	Expense - Healthcare	200	Expense	INR	4	10	10	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
607	Expense - Entertainment	200	Expense	INR	5	10	10	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
608	Expense - Transportation	200	Expense	INR	2	10	10	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
609	Expense - Healthcare	200	Expense	INR	4	10	10	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
610	Expense - Housing	300	Expense	INR	3	10	10	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
611	Expense - Miscellaneous	200	Expense	INR	10	10	10	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
612	Expense - Healthcare	200	Expense	INR	4	10	10	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
613	Expense - Entertainment	200	Expense	INR	5	10	10	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
614	Expense - Food & Dining	600	Expense	INR	1	10	10	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
615	Expense - Utilities	200	Expense	INR	9	10	10	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
616	Expense - Utilities	200	Expense	INR	9	10	10	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
617	Expense - Healthcare	200	Expense	INR	4	10	10	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
618	Expense - Housing	400	Expense	INR	3	10	10	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
619	Expense - Transportation	200	Expense	INR	2	10	10	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
620	Expense - Shopping	200	Expense	INR	7	10	10	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
621	Expense - Housing	200	Expense	INR	3	10	10	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
622	Expense - Travel	200	Expense	INR	6	10	10	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
623	Expense - Miscellaneous	200	Expense	INR	10	10	10	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
624	Expense - Entertainment	200	Expense	INR	5	10	10	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
625	Expense - Utilities	200	Expense	INR	9	10	10	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
626	Expense - Travel	200	Expense	INR	6	10	10	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
627	Expense - Healthcare	400	Expense	INR	4	10	10	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
628	Expense - Travel	200	Expense	INR	6	10	10	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
629	Expense - Healthcare	200	Expense	INR	4	10	10	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
630	Expense - Food & Dining	500	Expense	INR	1	10	10	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
631	Expense - Utilities	200	Expense	INR	9	10	10	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
632	Expense - Miscellaneous	200	Expense	INR	10	10	10	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
633	Expense - Utilities	200	Expense	INR	9	10	10	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
634	Expense - Education	200	Expense	INR	8	11	11	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
635	Expense - Transportation	500	Expense	INR	2	11	11	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
636	Expense - Food & Dining	1200	Expense	INR	1	11	11	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
637	Expense - Entertainment	200	Expense	INR	5	11	11	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
638	Expense - Miscellaneous	200	Expense	INR	10	11	11	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
639	Expense - Housing	200	Expense	INR	3	11	11	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
640	Expense - Transportation	200	Expense	INR	2	11	11	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
641	Expense - Entertainment	200	Expense	INR	5	11	11	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
642	Expense - Travel	300	Expense	INR	6	11	11	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
643	Expense - Transportation	200	Expense	INR	2	11	11	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
644	Expense - Food & Dining	200	Expense	INR	1	11	11	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
645	Expense - Utilities	200	Expense	INR	9	11	11	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
646	Expense - Travel	200	Expense	INR	6	11	11	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
647	Expense - Shopping	200	Expense	INR	7	11	11	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
648	Expense - Miscellaneous	200	Expense	INR	10	11	11	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
649	Expense - Housing	300	Expense	INR	3	11	11	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
650	Expense - Travel	200	Expense	INR	6	11	11	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
651	Expense - Education	200	Expense	INR	8	11	11	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
652	Expense - Utilities	200	Expense	INR	9	11	11	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
653	Expense - Housing	300	Expense	INR	3	11	11	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
654	Expense - Food & Dining	800	Expense	INR	1	11	11	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
655	Expense - Entertainment	200	Expense	INR	5	11	11	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
656	Expense - Miscellaneous	200	Expense	INR	10	11	11	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
657	Expense - Transportation	200	Expense	INR	2	11	11	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
658	Expense - Entertainment	300	Expense	INR	5	11	11	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
659	Expense - Entertainment	200	Expense	INR	5	11	11	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
660	Expense - Housing	900	Expense	INR	3	11	11	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
661	Expense - Miscellaneous	200	Expense	INR	10	11	11	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
662	Expense - Miscellaneous	200	Expense	INR	10	11	11	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
663	Expense - Education	200	Expense	INR	8	11	11	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
664	Expense - Miscellaneous	200	Expense	INR	10	11	11	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
665	Expense - Healthcare	200	Expense	INR	4	11	11	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
666	Expense - Education	200	Expense	INR	8	11	11	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
667	Expense - Shopping	200	Expense	INR	7	11	11	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
668	Expense - Transportation	200	Expense	INR	2	11	11	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
669	Expense - Food & Dining	300	Expense	INR	1	11	11	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
670	Expense - Utilities	200	Expense	INR	9	11	11	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
671	Expense - Housing	800	Expense	INR	3	11	11	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
672	Expense - Healthcare	200	Expense	INR	4	11	11	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
673	Expense - Education	200	Expense	INR	8	11	11	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
674	Expense - Travel	200	Expense	INR	6	11	11	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
675	Expense - Entertainment	200	Expense	INR	5	11	11	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
676	Expense - Housing	600	Expense	INR	3	11	11	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
677	Expense - Miscellaneous	200	Expense	INR	10	11	11	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
678	Expense - Healthcare	200	Expense	INR	4	11	11	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
679	Expense - Healthcare	200	Expense	INR	4	11	11	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
680	Expense - Travel	200	Expense	INR	6	11	11	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
681	Expense - Miscellaneous	200	Expense	INR	10	11	11	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
682	Expense - Healthcare	200	Expense	INR	4	11	11	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
683	Expense - Transportation	200	Expense	INR	2	11	11	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
684	Expense - Miscellaneous	200	Expense	INR	10	11	11	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
685	Expense - Shopping	200	Expense	INR	7	11	11	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
686	Expense - Shopping	200	Expense	INR	7	11	11	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
687	Expense - Utilities	200	Expense	INR	9	11	11	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
688	Expense - Travel	200	Expense	INR	6	11	11	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
689	Expense - Utilities	200	Expense	INR	9	11	11	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
690	Expense - Entertainment	200	Expense	INR	5	11	11	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
691	Expense - Healthcare	200	Expense	INR	4	11	11	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
692	Expense - Transportation	200	Expense	INR	2	11	11	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
693	Expense - Shopping	200	Expense	INR	7	11	11	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
694	Expense - Utilities	500	Expense	INR	9	11	11	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
695	Expense - Housing	200	Expense	INR	3	11	11	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
696	Expense - Miscellaneous	200	Expense	INR	10	11	11	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
697	Expense - Healthcare	200	Expense	INR	4	11	11	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
698	Expense - Healthcare	200	Expense	INR	4	11	11	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
699	Expense - Healthcare	200	Expense	INR	4	11	11	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
700	Expense - Travel	200	Expense	INR	6	11	11	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
701	Expense - Shopping	200	Expense	INR	7	11	11	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
702	Expense - Shopping	200	Expense	INR	7	11	11	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
703	Expense - Food & Dining	300	Expense	INR	1	12	12	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
704	Expense - Housing	200	Expense	INR	3	12	12	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
705	Expense - Transportation	200	Expense	INR	2	12	12	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
706	Expense - Entertainment	200	Expense	INR	5	12	12	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
707	Expense - Miscellaneous	200	Expense	INR	10	12	12	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
708	Expense - Food & Dining	200	Expense	INR	1	12	12	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
709	Expense - Entertainment	200	Expense	INR	5	12	12	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
710	Expense - Healthcare	200	Expense	INR	4	12	12	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
711	Expense - Education	200	Expense	INR	8	12	12	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
712	Expense - Healthcare	200	Expense	INR	4	12	12	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
713	Expense - Education	200	Expense	INR	8	12	12	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
714	Expense - Shopping	300	Expense	INR	7	12	12	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
715	Expense - Transportation	200	Expense	INR	2	12	12	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
716	Expense - Healthcare	200	Expense	INR	4	12	12	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
717	Expense - Education	200	Expense	INR	8	12	12	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
718	Expense - Utilities	200	Expense	INR	9	12	12	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
719	Expense - Travel	200	Expense	INR	6	12	12	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
720	Expense - Housing	200	Expense	INR	3	12	12	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
721	Expense - Shopping	200	Expense	INR	7	12	12	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
722	Expense - Shopping	300	Expense	INR	7	12	12	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
723	Expense - Shopping	300	Expense	INR	7	12	12	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
724	Expense - Miscellaneous	200	Expense	INR	10	12	12	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
725	Expense - Shopping	300	Expense	INR	7	12	12	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
726	Expense - Shopping	200	Expense	INR	7	12	12	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
727	Expense - Food & Dining	1100	Expense	INR	1	12	12	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
728	Expense - Shopping	200	Expense	INR	7	12	12	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
729	Expense - Housing	1100	Expense	INR	3	12	12	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
730	Expense - Utilities	300	Expense	INR	9	12	12	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
731	Expense - Education	200	Expense	INR	8	12	12	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
732	Expense - Shopping	200	Expense	INR	7	12	12	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
733	Expense - Food & Dining	200	Expense	INR	1	12	12	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
734	Expense - Food & Dining	200	Expense	INR	1	12	12	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
735	Expense - Travel	200	Expense	INR	6	12	12	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
736	Expense - Travel	200	Expense	INR	6	12	12	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
737	Expense - Food & Dining	200	Expense	INR	1	12	12	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
738	Expense - Healthcare	200	Expense	INR	4	12	12	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
739	Expense - Travel	200	Expense	INR	6	12	12	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
740	Expense - Travel	200	Expense	INR	6	12	12	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
741	Expense - Housing	500	Expense	INR	3	12	12	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
742	Expense - Food & Dining	300	Expense	INR	1	12	12	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
743	Expense - Housing	200	Expense	INR	3	12	12	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
744	Expense - Travel	200	Expense	INR	6	12	12	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
745	Expense - Miscellaneous	200	Expense	INR	10	12	12	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
746	Expense - Education	200	Expense	INR	8	12	12	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
747	Expense - Food & Dining	800	Expense	INR	1	12	12	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
748	Expense - Food & Dining	200	Expense	INR	1	12	12	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
749	Expense - Education	200	Expense	INR	8	12	12	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
750	Expense - Transportation	200	Expense	INR	2	12	12	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
751	Expense - Healthcare	200	Expense	INR	4	12	12	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
752	Expense - Transportation	200	Expense	INR	2	12	12	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
753	Expense - Utilities	200	Expense	INR	9	12	12	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
754	Expense - Travel	200	Expense	INR	6	12	12	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
755	Expense - Shopping	400	Expense	INR	7	12	12	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
756	Expense - Miscellaneous	200	Expense	INR	10	12	12	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
757	Expense - Entertainment	200	Expense	INR	5	12	12	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
758	Expense - Travel	200	Expense	INR	6	12	12	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
759	Expense - Utilities	400	Expense	INR	9	12	12	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
760	Expense - Travel	200	Expense	INR	6	12	12	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
761	Expense - Healthcare	200	Expense	INR	4	12	12	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
762	Expense - Utilities	200	Expense	INR	9	12	12	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
763	Expense - Education	200	Expense	INR	8	13	13	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
764	Expense - Education	200	Expense	INR	8	13	13	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
765	Expense - Travel	200	Expense	INR	6	13	13	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
766	Expense - Travel	200	Expense	INR	6	13	13	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
767	Expense - Education	200	Expense	INR	8	13	13	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
768	Expense - Food & Dining	200	Expense	INR	1	13	13	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
769	Expense - Miscellaneous	200	Expense	INR	10	13	13	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
770	Expense - Housing	600	Expense	INR	3	13	13	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
771	Expense - Shopping	200	Expense	INR	7	13	13	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
772	Expense - Education	200	Expense	INR	8	13	13	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
773	Expense - Travel	200	Expense	INR	6	13	13	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
774	Expense - Utilities	200	Expense	INR	9	13	13	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
775	Expense - Healthcare	200	Expense	INR	4	13	13	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
776	Expense - Housing	800	Expense	INR	3	13	13	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
777	Expense - Utilities	500	Expense	INR	9	13	13	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
778	Expense - Education	200	Expense	INR	8	13	13	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
779	Expense - Miscellaneous	200	Expense	INR	10	13	13	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
780	Expense - Transportation	200	Expense	INR	2	13	13	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
781	Expense - Housing	200	Expense	INR	3	13	13	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
782	Expense - Food & Dining	200	Expense	INR	1	13	13	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
783	Expense - Utilities	200	Expense	INR	9	13	13	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
784	Expense - Shopping	200	Expense	INR	7	13	13	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
785	Expense - Travel	200	Expense	INR	6	13	13	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
786	Expense - Utilities	200	Expense	INR	9	13	13	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
787	Expense - Education	200	Expense	INR	8	13	13	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
788	Expense - Travel	200	Expense	INR	6	13	13	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
789	Expense - Housing	1400	Expense	INR	3	13	13	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
790	Expense - Travel	200	Expense	INR	6	13	13	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
791	Expense - Transportation	200	Expense	INR	2	13	13	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
792	Expense - Utilities	200	Expense	INR	9	13	13	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
793	Expense - Shopping	200	Expense	INR	7	13	13	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
794	Expense - Miscellaneous	200	Expense	INR	10	13	13	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
795	Expense - Utilities	200	Expense	INR	9	13	13	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
796	Expense - Education	200	Expense	INR	8	13	13	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
797	Expense - Travel	200	Expense	INR	6	13	13	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
798	Expense - Food & Dining	200	Expense	INR	1	13	13	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
799	Expense - Miscellaneous	200	Expense	INR	10	14	14	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
800	Expense - Transportation	200	Expense	INR	2	14	14	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
801	Expense - Shopping	300	Expense	INR	7	14	14	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
802	Expense - Education	200	Expense	INR	8	14	14	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
803	Expense - Housing	300	Expense	INR	3	14	14	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
804	Expense - Housing	600	Expense	INR	3	14	14	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
805	Expense - Food & Dining	200	Expense	INR	1	14	14	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
806	Expense - Housing	200	Expense	INR	3	14	14	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
807	Expense - Healthcare	400	Expense	INR	4	14	14	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
808	Expense - Shopping	200	Expense	INR	7	14	14	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
809	Expense - Utilities	200	Expense	INR	9	14	14	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
810	Expense - Transportation	200	Expense	INR	2	14	14	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
811	Expense - Food & Dining	600	Expense	INR	1	14	14	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
812	Expense - Entertainment	200	Expense	INR	5	14	14	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
813	Expense - Education	200	Expense	INR	8	14	14	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
814	Expense - Shopping	200	Expense	INR	7	14	14	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
815	Expense - Healthcare	200	Expense	INR	4	14	14	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
816	Expense - Housing	600	Expense	INR	3	14	14	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
817	Expense - Healthcare	300	Expense	INR	4	14	14	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
818	Expense - Housing	2200	Expense	INR	3	14	14	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
819	Expense - Food & Dining	200	Expense	INR	1	14	14	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
820	Expense - Healthcare	200	Expense	INR	4	14	14	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
821	Expense - Transportation	200	Expense	INR	2	14	14	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
822	Expense - Education	200	Expense	INR	8	14	14	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
823	Expense - Shopping	200	Expense	INR	7	14	14	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
824	Expense - Education	200	Expense	INR	8	14	14	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
825	Expense - Shopping	200	Expense	INR	7	14	14	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
826	Expense - Utilities	300	Expense	INR	9	14	14	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
827	Expense - Shopping	200	Expense	INR	7	14	14	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
828	Expense - Housing	800	Expense	INR	3	14	14	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
829	Expense - Miscellaneous	200	Expense	INR	10	14	14	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
830	Expense - Education	200	Expense	INR	8	14	14	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
831	Expense - Housing	500	Expense	INR	3	14	14	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
832	Expense - Entertainment	300	Expense	INR	5	14	14	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
833	Expense - Education	200	Expense	INR	8	14	14	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
834	Expense - Food & Dining	200	Expense	INR	1	14	14	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
835	Expense - Miscellaneous	200	Expense	INR	10	14	14	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
836	Expense - Transportation	700	Expense	INR	2	14	14	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
837	Expense - Travel	300	Expense	INR	6	14	14	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
838	Expense - Entertainment	200	Expense	INR	5	14	14	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
839	Expense - Shopping	200	Expense	INR	7	14	14	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
840	Expense - Shopping	300	Expense	INR	7	14	14	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
841	Expense - Utilities	200	Expense	INR	9	14	14	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
842	Expense - Transportation	700	Expense	INR	2	14	14	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
843	Expense - Healthcare	200	Expense	INR	4	14	14	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
844	Expense - Food & Dining	200	Expense	INR	1	14	14	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
845	Expense - Entertainment	200	Expense	INR	5	14	14	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
846	Expense - Food & Dining	500	Expense	INR	1	14	14	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
847	Expense - Healthcare	200	Expense	INR	4	14	14	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
848	Expense - Travel	200	Expense	INR	6	14	14	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
849	Expense - Transportation	600	Expense	INR	2	14	14	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
850	Expense - Housing	2200	Expense	INR	3	14	14	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
851	Expense - Shopping	200	Expense	INR	7	14	14	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
852	Expense - Shopping	200	Expense	INR	7	14	14	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
853	Expense - Travel	200	Expense	INR	6	14	14	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
854	Expense - Entertainment	200	Expense	INR	5	14	14	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
855	Expense - Entertainment	200	Expense	INR	5	14	14	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
856	Expense - Food & Dining	200	Expense	INR	1	14	14	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
857	Expense - Miscellaneous	200	Expense	INR	10	14	14	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
858	Expense - Education	200	Expense	INR	8	14	14	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
859	Expense - Housing	400	Expense	INR	3	14	14	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
860	Expense - Housing	1400	Expense	INR	3	14	14	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
861	Expense - Education	200	Expense	INR	8	14	14	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
862	Expense - Shopping	200	Expense	INR	7	14	14	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
863	Expense - Housing	600	Expense	INR	3	14	14	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
864	Expense - Healthcare	200	Expense	INR	4	14	14	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
865	Expense - Education	200	Expense	INR	8	14	14	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
866	Expense - Education	300	Expense	INR	8	14	14	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
867	Expense - Travel	200	Expense	INR	6	14	14	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
868	Expense - Travel	200	Expense	INR	6	14	14	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
869	Expense - Entertainment	200	Expense	INR	5	14	14	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
870	Expense - Utilities	200	Expense	INR	9	14	14	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
871	Expense - Transportation	200	Expense	INR	2	14	14	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
872	Expense - Miscellaneous	200	Expense	INR	10	14	14	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
873	Expense - Travel	200	Expense	INR	6	14	14	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
874	Expense - Utilities	200	Expense	INR	9	14	14	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
875	Expense - Transportation	200	Expense	INR	2	15	15	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
876	Expense - Shopping	200	Expense	INR	7	15	15	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
877	Expense - Healthcare	500	Expense	INR	4	15	15	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
878	Expense - Housing	1100	Expense	INR	3	15	15	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
879	Expense - Food & Dining	300	Expense	INR	1	15	15	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
880	Expense - Healthcare	200	Expense	INR	4	15	15	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
881	Expense - Miscellaneous	200	Expense	INR	10	15	15	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
882	Expense - Entertainment	200	Expense	INR	5	15	15	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
883	Expense - Food & Dining	200	Expense	INR	1	15	15	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
884	Expense - Travel	200	Expense	INR	6	15	15	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
885	Expense - Housing	700	Expense	INR	3	15	15	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
886	Expense - Healthcare	200	Expense	INR	4	15	15	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
887	Expense - Transportation	600	Expense	INR	2	15	15	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
888	Expense - Entertainment	400	Expense	INR	5	15	15	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
889	Expense - Shopping	500	Expense	INR	7	15	15	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
890	Expense - Food & Dining	200	Expense	INR	1	15	15	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
891	Expense - Miscellaneous	200	Expense	INR	10	15	15	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
892	Expense - Travel	400	Expense	INR	6	15	15	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
893	Expense - Entertainment	200	Expense	INR	5	15	15	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
894	Expense - Travel	200	Expense	INR	6	15	15	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
895	Expense - Travel	200	Expense	INR	6	15	15	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
896	Expense - Shopping	200	Expense	INR	7	15	15	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
897	Expense - Travel	200	Expense	INR	6	15	15	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
898	Expense - Food & Dining	2100	Expense	INR	1	15	15	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
899	Expense - Travel	200	Expense	INR	6	15	15	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
900	Expense - Miscellaneous	200	Expense	INR	10	15	15	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
901	Expense - Housing	500	Expense	INR	3	15	15	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
902	Expense - Housing	900	Expense	INR	3	15	15	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
903	Expense - Transportation	200	Expense	INR	2	15	15	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
904	Expense - Travel	200	Expense	INR	6	15	15	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
905	Expense - Entertainment	400	Expense	INR	5	15	15	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
906	Expense - Entertainment	200	Expense	INR	5	15	15	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
907	Expense - Travel	200	Expense	INR	6	15	15	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
908	Expense - Housing	300	Expense	INR	3	15	15	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
909	Expense - Miscellaneous	200	Expense	INR	10	15	15	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
910	Expense - Food & Dining	200	Expense	INR	1	15	15	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
911	Expense - Education	200	Expense	INR	8	15	15	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
912	Expense - Shopping	200	Expense	INR	7	15	15	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
913	Expense - Utilities	200	Expense	INR	9	15	15	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
914	Expense - Healthcare	200	Expense	INR	4	15	15	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
915	Expense - Travel	200	Expense	INR	6	15	15	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
916	Expense - Shopping	500	Expense	INR	7	15	15	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
917	Expense - Entertainment	200	Expense	INR	5	15	15	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
918	Expense - Shopping	200	Expense	INR	7	15	15	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
919	Expense - Food & Dining	900	Expense	INR	1	15	15	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
920	Expense - Miscellaneous	200	Expense	INR	10	15	15	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
921	Expense - Shopping	200	Expense	INR	7	16	16	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
922	Expense - Utilities	200	Expense	INR	9	16	16	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
923	Expense - Education	200	Expense	INR	8	16	16	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
924	Expense - Travel	200	Expense	INR	6	16	16	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
925	Expense - Education	200	Expense	INR	8	16	16	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
926	Expense - Miscellaneous	200	Expense	INR	10	16	16	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
927	Expense - Healthcare	200	Expense	INR	4	16	16	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
928	Expense - Housing	1200	Expense	INR	3	16	16	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
929	Expense - Healthcare	300	Expense	INR	4	16	16	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
930	Expense - Miscellaneous	200	Expense	INR	10	16	16	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
931	Expense - Miscellaneous	200	Expense	INR	10	16	16	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
932	Expense - Entertainment	200	Expense	INR	5	16	16	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
933	Expense - Utilities	200	Expense	INR	9	16	16	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
934	Expense - Education	500	Expense	INR	8	16	16	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
935	Expense - Food & Dining	300	Expense	INR	1	16	16	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
936	Expense - Miscellaneous	200	Expense	INR	10	16	16	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
937	Expense - Transportation	800	Expense	INR	2	16	16	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
938	Expense - Shopping	200	Expense	INR	7	16	16	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
939	Expense - Education	200	Expense	INR	8	16	16	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
940	Expense - Healthcare	200	Expense	INR	4	16	16	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
941	Expense - Transportation	200	Expense	INR	2	16	16	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
942	Expense - Entertainment	200	Expense	INR	5	16	16	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
943	Expense - Healthcare	200	Expense	INR	4	16	16	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
944	Expense - Food & Dining	900	Expense	INR	1	16	16	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
945	Expense - Food & Dining	200	Expense	INR	1	16	16	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
946	Expense - Entertainment	200	Expense	INR	5	16	16	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
947	Expense - Food & Dining	200	Expense	INR	1	16	16	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
948	Expense - Utilities	200	Expense	INR	9	16	16	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
949	Expense - Healthcare	200	Expense	INR	4	16	16	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
950	Expense - Transportation	200	Expense	INR	2	16	16	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
951	Expense - Transportation	200	Expense	INR	2	16	16	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
952	Expense - Entertainment	200	Expense	INR	5	16	16	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
953	Expense - Healthcare	200	Expense	INR	4	16	16	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
954	Expense - Transportation	200	Expense	INR	2	16	16	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
955	Expense - Entertainment	300	Expense	INR	5	16	16	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
956	Expense - Education	200	Expense	INR	8	16	16	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
957	Expense - Utilities	200	Expense	INR	9	16	16	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
958	Expense - Utilities	200	Expense	INR	9	16	16	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
959	Expense - Education	200	Expense	INR	8	16	16	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
960	Expense - Shopping	200	Expense	INR	7	16	16	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
961	Expense - Healthcare	200	Expense	INR	4	16	16	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
962	Expense - Housing	1200	Expense	INR	3	16	16	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
963	Expense - Housing	1600	Expense	INR	3	16	16	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
964	Expense - Miscellaneous	200	Expense	INR	10	16	16	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
965	Expense - Healthcare	300	Expense	INR	4	16	16	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
966	Expense - Shopping	200	Expense	INR	7	16	16	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
967	Expense - Education	200	Expense	INR	8	16	16	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
968	Expense - Utilities	300	Expense	INR	9	16	16	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
969	Expense - Utilities	200	Expense	INR	9	17	17	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
970	Expense - Utilities	200	Expense	INR	9	17	17	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
971	Expense - Transportation	200	Expense	INR	2	17	17	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
972	Expense - Transportation	400	Expense	INR	2	17	17	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
973	Expense - Utilities	200	Expense	INR	9	17	17	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
974	Expense - Entertainment	200	Expense	INR	5	17	17	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
975	Expense - Shopping	300	Expense	INR	7	17	17	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
976	Expense - Housing	200	Expense	INR	3	17	17	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
977	Expense - Travel	200	Expense	INR	6	17	17	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
978	Expense - Shopping	200	Expense	INR	7	17	17	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
979	Expense - Transportation	200	Expense	INR	2	17	17	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
980	Expense - Food & Dining	1100	Expense	INR	1	17	17	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
981	Expense - Education	200	Expense	INR	8	17	17	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
982	Expense - Food & Dining	200	Expense	INR	1	17	17	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
983	Expense - Healthcare	200	Expense	INR	4	17	17	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
984	Expense - Education	200	Expense	INR	8	17	17	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
985	Expense - Miscellaneous	200	Expense	INR	10	17	17	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
986	Expense - Utilities	200	Expense	INR	9	17	17	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
987	Expense - Food & Dining	400	Expense	INR	1	17	17	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
988	Expense - Shopping	200	Expense	INR	7	17	17	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
989	Expense - Entertainment	200	Expense	INR	5	17	17	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
990	Expense - Education	200	Expense	INR	8	17	17	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
991	Expense - Housing	500	Expense	INR	3	17	17	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
992	Expense - Healthcare	200	Expense	INR	4	17	17	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
993	Expense - Education	200	Expense	INR	8	17	17	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
994	Expense - Housing	300	Expense	INR	3	17	17	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
995	Expense - Education	200	Expense	INR	8	17	17	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
996	Expense - Shopping	200	Expense	INR	7	17	17	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
997	Expense - Entertainment	200	Expense	INR	5	17	17	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
998	Expense - Education	200	Expense	INR	8	17	17	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
999	Expense - Transportation	200	Expense	INR	2	17	17	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
1000	Expense - Transportation	200	Expense	INR	2	17	17	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
1001	Expense - Utilities	200	Expense	INR	9	17	17	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
1002	Expense - Miscellaneous	200	Expense	INR	10	17	17	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
1003	Expense - Travel	200	Expense	INR	6	17	17	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
1004	Expense - Food & Dining	900	Expense	INR	1	17	17	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
1005	Expense - Food & Dining	300	Expense	INR	1	17	17	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
1006	Expense - Housing	200	Expense	INR	3	17	17	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
1007	Expense - Travel	200	Expense	INR	6	17	17	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
1008	Expense - Entertainment	200	Expense	INR	5	17	17	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
1009	Expense - Housing	200	Expense	INR	3	17	17	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
1010	Expense - Housing	500	Expense	INR	3	17	17	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
1011	Expense - Food & Dining	200	Expense	INR	1	17	17	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
1012	Expense - Utilities	200	Expense	INR	9	17	17	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
1013	Expense - Entertainment	200	Expense	INR	5	17	17	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
1014	Expense - Housing	400	Expense	INR	3	17	17	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
1015	Expense - Food & Dining	300	Expense	INR	1	17	17	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
1016	Expense - Housing	1200	Expense	INR	3	17	17	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
1017	Expense - Travel	200	Expense	INR	6	17	17	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
1018	Expense - Healthcare	200	Expense	INR	4	17	17	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
1019	Expense - Utilities	300	Expense	INR	9	17	17	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
1020	Expense - Miscellaneous	300	Expense	INR	10	17	17	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
1021	Expense - Education	200	Expense	INR	8	17	17	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
1022	Expense - Education	200	Expense	INR	8	17	17	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
1023	Expense - Transportation	200	Expense	INR	2	17	17	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
1024	Expense - Shopping	200	Expense	INR	7	17	17	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
1025	Expense - Healthcare	200	Expense	INR	4	17	17	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
1026	Expense - Shopping	300	Expense	INR	7	17	17	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
1027	Expense - Transportation	200	Expense	INR	2	17	17	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
1028	Expense - Utilities	200	Expense	INR	9	17	17	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
1029	Expense - Housing	200	Expense	INR	3	17	17	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
1030	Expense - Miscellaneous	200	Expense	INR	10	17	17	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
1031	Expense - Shopping	200	Expense	INR	7	17	17	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
1032	Expense - Miscellaneous	200	Expense	INR	10	17	17	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
1033	Expense - Miscellaneous	200	Expense	INR	10	17	17	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
1034	Expense - Housing	200	Expense	INR	3	17	17	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
1035	Expense - Housing	200	Expense	INR	3	17	17	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
1036	Expense - Utilities	200	Expense	INR	9	17	17	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
1037	Expense - Education	200	Expense	INR	8	17	17	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
1038	Expense - Education	200	Expense	INR	8	17	17	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
1039	Expense - Shopping	200	Expense	INR	7	17	17	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
1040	Expense - Food & Dining	300	Expense	INR	1	17	17	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
1041	Expense - Utilities	200	Expense	INR	9	17	17	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
1042	Expense - Transportation	200	Expense	INR	2	17	17	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
1043	Expense - Food & Dining	200	Expense	INR	1	17	17	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
1044	Expense - Education	200	Expense	INR	8	17	17	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
1045	Expense - Shopping	200	Expense	INR	7	17	17	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
1046	Expense - Shopping	200	Expense	INR	7	17	17	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
1047	Expense - Utilities	200	Expense	INR	9	17	17	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
1048	Expense - Miscellaneous	200	Expense	INR	10	17	17	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
1049	Expense - Education	200	Expense	INR	8	17	17	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
1050	Expense - Housing	200	Expense	INR	3	17	17	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
1051	Expense - Housing	500	Expense	INR	3	17	17	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
1052	Expense - Travel	200	Expense	INR	6	18	18	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
1053	Expense - Transportation	400	Expense	INR	2	18	18	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
1054	Expense - Entertainment	200	Expense	INR	5	18	18	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
1055	Expense - Utilities	200	Expense	INR	9	18	18	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
1056	Expense - Travel	200	Expense	INR	6	18	18	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
1057	Expense - Utilities	200	Expense	INR	9	18	18	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
1058	Expense - Transportation	1000	Expense	INR	2	18	18	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
1059	Expense - Shopping	200	Expense	INR	7	18	18	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
1060	Expense - Education	200	Expense	INR	8	18	18	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
1061	Expense - Healthcare	200	Expense	INR	4	18	18	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
1062	Expense - Utilities	200	Expense	INR	9	18	18	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
1063	Expense - Food & Dining	200	Expense	INR	1	18	18	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
1064	Expense - Utilities	200	Expense	INR	9	18	18	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
1065	Expense - Housing	200	Expense	INR	3	18	18	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
1066	Expense - Housing	1600	Expense	INR	3	18	18	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
1067	Expense - Housing	1100	Expense	INR	3	18	18	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
1068	Expense - Utilities	200	Expense	INR	9	18	18	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
1069	Expense - Entertainment	200	Expense	INR	5	18	18	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
1070	Expense - Shopping	200	Expense	INR	7	18	18	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
1071	Expense - Housing	500	Expense	INR	3	18	18	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
1072	Expense - Shopping	200	Expense	INR	7	18	18	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
1073	Expense - Healthcare	200	Expense	INR	4	18	18	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
1074	Expense - Transportation	700	Expense	INR	2	18	18	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
1075	Expense - Food & Dining	200	Expense	INR	1	18	18	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
1076	Expense - Miscellaneous	200	Expense	INR	10	18	18	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
1077	Expense - Healthcare	200	Expense	INR	4	18	18	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
1078	Expense - Healthcare	200	Expense	INR	4	18	18	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
1079	Expense - Utilities	200	Expense	INR	9	18	18	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
1080	Expense - Transportation	200	Expense	INR	2	18	18	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
1081	Expense - Education	200	Expense	INR	8	18	18	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
1082	Expense - Healthcare	200	Expense	INR	4	18	18	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
1083	Expense - Food & Dining	300	Expense	INR	1	18	18	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
1084	Expense - Education	300	Expense	INR	8	18	18	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
1085	Expense - Shopping	600	Expense	INR	7	18	18	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
1086	Expense - Healthcare	300	Expense	INR	4	18	18	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
1087	Expense - Education	200	Expense	INR	8	18	18	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
1088	Expense - Housing	500	Expense	INR	3	18	18	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
1089	Expense - Healthcare	400	Expense	INR	4	18	18	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
1090	Expense - Food & Dining	700	Expense	INR	1	18	18	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
1091	Expense - Housing	2000	Expense	INR	3	18	18	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
1092	Expense - Healthcare	300	Expense	INR	4	19	19	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
1093	Expense - Travel	200	Expense	INR	6	19	19	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
1094	Expense - Housing	2500	Expense	INR	3	19	19	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
1095	Expense - Travel	200	Expense	INR	6	19	19	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
1096	Expense - Travel	200	Expense	INR	6	19	19	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
1097	Expense - Healthcare	400	Expense	INR	4	19	19	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
1098	Expense - Travel	200	Expense	INR	6	19	19	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
1099	Expense - Food & Dining	200	Expense	INR	1	19	19	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
1100	Expense - Education	200	Expense	INR	8	19	19	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
1101	Expense - Entertainment	200	Expense	INR	5	19	19	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
1102	Expense - Utilities	200	Expense	INR	9	19	19	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
1103	Expense - Shopping	200	Expense	INR	7	19	19	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
1104	Expense - Utilities	200	Expense	INR	9	19	19	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
1105	Expense - Education	200	Expense	INR	8	19	19	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
1106	Expense - Miscellaneous	200	Expense	INR	10	19	19	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
1107	Expense - Food & Dining	200	Expense	INR	1	19	19	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
1108	Expense - Food & Dining	300	Expense	INR	1	19	19	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
1109	Expense - Healthcare	200	Expense	INR	4	19	19	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
1110	Expense - Travel	200	Expense	INR	6	19	19	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
1111	Expense - Housing	200	Expense	INR	3	19	19	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
1112	Expense - Shopping	200	Expense	INR	7	19	19	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
1113	Expense - Entertainment	200	Expense	INR	5	19	19	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
1114	Expense - Utilities	300	Expense	INR	9	19	19	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
1115	Expense - Travel	200	Expense	INR	6	19	19	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
1116	Expense - Miscellaneous	200	Expense	INR	10	19	19	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
1117	Expense - Transportation	200	Expense	INR	2	19	19	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
1118	Expense - Healthcare	200	Expense	INR	4	19	19	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
1119	Expense - Shopping	300	Expense	INR	7	19	19	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
1120	Expense - Housing	800	Expense	INR	3	19	19	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
1121	Expense - Entertainment	200	Expense	INR	5	19	19	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
1122	Expense - Healthcare	200	Expense	INR	4	19	19	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
1123	Expense - Travel	300	Expense	INR	6	19	19	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
1124	Expense - Housing	500	Expense	INR	3	19	19	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
1125	Expense - Transportation	200	Expense	INR	2	19	19	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
1126	Expense - Education	200	Expense	INR	8	19	19	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
1127	Expense - Housing	400	Expense	INR	3	19	19	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
1128	Expense - Transportation	400	Expense	INR	2	19	19	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
1129	Expense - Entertainment	200	Expense	INR	5	19	19	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
1130	Expense - Food & Dining	200	Expense	INR	1	19	19	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
1131	Expense - Travel	200	Expense	INR	6	19	19	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
1132	Expense - Shopping	200	Expense	INR	7	20	20	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
1133	Expense - Healthcare	200	Expense	INR	4	20	20	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
1134	Expense - Shopping	200	Expense	INR	7	20	20	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
1135	Expense - Miscellaneous	200	Expense	INR	10	20	20	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
1136	Expense - Utilities	200	Expense	INR	9	20	20	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
1137	Expense - Education	200	Expense	INR	8	20	20	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
1138	Expense - Food & Dining	400	Expense	INR	1	20	20	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
1139	Expense - Miscellaneous	200	Expense	INR	10	20	20	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
1140	Expense - Healthcare	200	Expense	INR	4	20	20	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
1141	Expense - Shopping	400	Expense	INR	7	20	20	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
1142	Expense - Travel	200	Expense	INR	6	20	20	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
1143	Expense - Healthcare	200	Expense	INR	4	20	20	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
1144	Expense - Travel	200	Expense	INR	6	20	20	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
1145	Expense - Utilities	200	Expense	INR	9	20	20	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
1146	Expense - Food & Dining	300	Expense	INR	1	20	20	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
1147	Expense - Transportation	200	Expense	INR	2	20	20	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
1148	Expense - Transportation	200	Expense	INR	2	20	20	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
1149	Expense - Miscellaneous	200	Expense	INR	10	20	20	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
1150	Expense - Entertainment	200	Expense	INR	5	20	20	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
1151	Expense - Food & Dining	300	Expense	INR	1	20	20	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
1152	Expense - Utilities	200	Expense	INR	9	20	20	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
1153	Expense - Entertainment	200	Expense	INR	5	20	20	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
1154	Expense - Housing	200	Expense	INR	3	20	20	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
1155	Expense - Education	200	Expense	INR	8	20	20	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
1156	Expense - Utilities	200	Expense	INR	9	20	20	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
1157	Expense - Entertainment	200	Expense	INR	5	20	20	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
1158	Expense - Shopping	200	Expense	INR	7	20	20	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
1159	Expense - Education	200	Expense	INR	8	20	20	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
1160	Expense - Utilities	200	Expense	INR	9	20	20	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
1161	Expense - Miscellaneous	200	Expense	INR	10	20	20	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
1162	Expense - Entertainment	200	Expense	INR	5	20	20	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
1163	Expense - Travel	200	Expense	INR	6	20	20	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
1164	Expense - Entertainment	200	Expense	INR	5	20	20	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
1165	Expense - Travel	200	Expense	INR	6	20	20	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
1166	Expense - Housing	200	Expense	INR	3	20	20	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
1167	Expense - Food & Dining	300	Expense	INR	1	20	20	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
1168	Expense - Transportation	200	Expense	INR	2	20	20	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
1169	Expense - Travel	200	Expense	INR	6	20	20	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
1170	Expense - Food & Dining	200	Expense	INR	1	20	20	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
1171	Expense - Education	200	Expense	INR	8	20	20	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
1172	Expense - Food & Dining	200	Expense	INR	1	20	20	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
1173	Expense - Healthcare	200	Expense	INR	4	20	20	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
1174	Expense - Housing	300	Expense	INR	3	20	20	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
1175	Expense - Transportation	200	Expense	INR	2	20	20	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
1176	Expense - Miscellaneous	200	Expense	INR	10	20	20	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
1177	Expense - Travel	200	Expense	INR	6	20	20	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
1178	Expense - Travel	200	Expense	INR	6	20	20	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
1179	Expense - Transportation	200	Expense	INR	2	20	20	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
1180	Expense - Travel	200	Expense	INR	6	20	20	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
1181	Expense - Utilities	200	Expense	INR	9	20	20	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
1182	Expense - Entertainment	200	Expense	INR	5	20	20	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
1183	Expense - Housing	200	Expense	INR	3	20	20	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
1184	Expense - Healthcare	200	Expense	INR	4	20	20	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
1185	Expense - Housing	500	Expense	INR	3	20	20	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
1186	Expense - Housing	600	Expense	INR	3	20	20	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
1187	Expense - Travel	200	Expense	INR	6	20	20	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
1188	Expense - Miscellaneous	200	Expense	INR	10	20	20	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
1189	Expense - Education	200	Expense	INR	8	20	20	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
1190	Expense - Entertainment	200	Expense	INR	5	20	20	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
1191	Expense - Healthcare	200	Expense	INR	4	20	20	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
1192	Expense - Utilities	200	Expense	INR	9	20	20	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
1193	Expense - Education	200	Expense	INR	8	20	20	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
1194	Expense - Miscellaneous	200	Expense	INR	10	20	20	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
1195	Expense - Healthcare	200	Expense	INR	4	20	20	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
1196	Expense - Shopping	200	Expense	INR	7	20	20	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
1197	Expense - Housing	1500	Expense	INR	3	20	20	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
1198	Expense - Shopping	200	Expense	INR	7	20	20	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
1199	Expense - Travel	200	Expense	INR	6	20	20	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
1200	Expense - Miscellaneous	200	Expense	INR	10	20	20	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
1201	Expense - Education	200	Expense	INR	8	20	20	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
1202	Expense - Healthcare	200	Expense	INR	4	20	20	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
1203	Expense - Travel	200	Expense	INR	6	20	20	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
1204	Expense - Housing	500	Expense	INR	3	21	21	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
1205	Expense - Food & Dining	200	Expense	INR	1	21	21	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
1206	Expense - Healthcare	300	Expense	INR	4	21	21	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
1207	Expense - Education	200	Expense	INR	8	21	21	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
1208	Expense - Miscellaneous	200	Expense	INR	10	21	21	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
1209	Expense - Entertainment	200	Expense	INR	5	21	21	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
1210	Expense - Healthcare	200	Expense	INR	4	21	21	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
1211	Expense - Shopping	200	Expense	INR	7	21	21	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
1212	Expense - Housing	200	Expense	INR	3	21	21	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
1213	Expense - Food & Dining	500	Expense	INR	1	21	21	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
1214	Expense - Entertainment	200	Expense	INR	5	21	21	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
1215	Expense - Utilities	400	Expense	INR	9	21	21	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
1216	Expense - Education	200	Expense	INR	8	21	21	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
1217	Expense - Healthcare	200	Expense	INR	4	21	21	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
1218	Expense - Shopping	200	Expense	INR	7	21	21	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
1219	Expense - Utilities	200	Expense	INR	9	21	21	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
1220	Expense - Education	200	Expense	INR	8	21	21	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
1221	Expense - Entertainment	200	Expense	INR	5	21	21	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
1222	Expense - Transportation	200	Expense	INR	2	21	21	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
1223	Expense - Education	200	Expense	INR	8	21	21	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
1224	Expense - Healthcare	200	Expense	INR	4	21	21	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
1225	Expense - Utilities	300	Expense	INR	9	21	21	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
1226	Expense - Food & Dining	200	Expense	INR	1	21	21	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
1227	Expense - Food & Dining	1100	Expense	INR	1	21	21	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
1228	Expense - Housing	1000	Expense	INR	3	21	21	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
1229	Expense - Housing	2100	Expense	INR	3	21	21	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
1230	Expense - Transportation	200	Expense	INR	2	21	21	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
1231	Expense - Utilities	200	Expense	INR	9	21	21	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
1232	Expense - Travel	200	Expense	INR	6	21	21	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
1233	Expense - Healthcare	200	Expense	INR	4	21	21	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
1234	Expense - Shopping	200	Expense	INR	7	21	21	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
1235	Expense - Housing	200	Expense	INR	3	21	21	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
1236	Expense - Travel	200	Expense	INR	6	21	21	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
1237	Expense - Entertainment	200	Expense	INR	5	21	21	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
1238	Expense - Travel	200	Expense	INR	6	21	21	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
1239	Expense - Travel	200	Expense	INR	6	21	21	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
1240	Expense - Entertainment	200	Expense	INR	5	21	21	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
1241	Expense - Entertainment	200	Expense	INR	5	21	21	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
1242	Expense - Food & Dining	200	Expense	INR	1	21	21	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
1243	Expense - Transportation	200	Expense	INR	2	21	21	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
1244	Expense - Miscellaneous	200	Expense	INR	10	21	21	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
1245	Expense - Utilities	200	Expense	INR	9	21	21	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
1246	Expense - Entertainment	200	Expense	INR	5	21	21	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
1247	Expense - Food & Dining	500	Expense	INR	1	21	21	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
1248	Expense - Healthcare	200	Expense	INR	4	21	21	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
1249	Expense - Entertainment	200	Expense	INR	5	21	21	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
1250	Expense - Housing	800	Expense	INR	3	21	21	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
1251	Expense - Miscellaneous	200	Expense	INR	10	21	21	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
1252	Expense - Shopping	200	Expense	INR	7	21	21	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
1253	Expense - Transportation	200	Expense	INR	2	21	21	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
1254	Expense - Travel	200	Expense	INR	6	21	21	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
1255	Expense - Education	200	Expense	INR	8	21	21	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
1256	Expense - Food & Dining	200	Expense	INR	1	21	21	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
1257	Expense - Shopping	200	Expense	INR	7	21	21	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
1258	Expense - Education	200	Expense	INR	8	21	21	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
1259	Expense - Education	200	Expense	INR	8	21	21	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
1260	Expense - Shopping	200	Expense	INR	7	21	21	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
1261	Expense - Miscellaneous	200	Expense	INR	10	21	21	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
1262	Expense - Food & Dining	500	Expense	INR	1	21	21	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
1263	Expense - Utilities	200	Expense	INR	9	21	21	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
1264	Expense - Food & Dining	200	Expense	INR	1	21	21	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
1265	Expense - Miscellaneous	200	Expense	INR	10	21	21	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
1266	Expense - Transportation	200	Expense	INR	2	21	21	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
1267	Expense - Food & Dining	200	Expense	INR	1	21	21	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
1268	Expense - Housing	700	Expense	INR	3	21	21	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
1269	Expense - Travel	200	Expense	INR	6	21	21	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
1270	Expense - Healthcare	200	Expense	INR	4	21	21	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
1271	Expense - Transportation	200	Expense	INR	2	21	21	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
1272	Expense - Healthcare	200	Expense	INR	4	21	21	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
1273	Expense - Shopping	200	Expense	INR	7	21	21	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
1274	Expense - Education	200	Expense	INR	8	21	21	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
1275	Expense - Education	200	Expense	INR	8	21	21	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
1276	Expense - Shopping	200	Expense	INR	7	22	22	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
1277	Expense - Education	400	Expense	INR	8	22	22	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
1278	Expense - Shopping	200	Expense	INR	7	22	22	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
1279	Expense - Utilities	200	Expense	INR	9	22	22	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
1280	Expense - Travel	200	Expense	INR	6	22	22	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
1281	Expense - Travel	200	Expense	INR	6	22	22	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
1282	Expense - Education	200	Expense	INR	8	22	22	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
1283	Expense - Miscellaneous	200	Expense	INR	10	22	22	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
1284	Expense - Housing	400	Expense	INR	3	22	22	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
1285	Expense - Healthcare	200	Expense	INR	4	22	22	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
1286	Expense - Housing	400	Expense	INR	3	22	22	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
1287	Expense - Housing	300	Expense	INR	3	22	22	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
1288	Expense - Transportation	200	Expense	INR	2	22	22	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
1289	Expense - Transportation	200	Expense	INR	2	22	22	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
1290	Expense - Food & Dining	1800	Expense	INR	1	22	22	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
1291	Expense - Education	200	Expense	INR	8	22	22	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
1292	Expense - Education	200	Expense	INR	8	22	22	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
1293	Expense - Travel	200	Expense	INR	6	22	22	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
1294	Expense - Shopping	700	Expense	INR	7	22	22	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
1295	Expense - Miscellaneous	200	Expense	INR	10	22	22	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
1296	Expense - Shopping	300	Expense	INR	7	22	22	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
1297	Expense - Travel	200	Expense	INR	6	22	22	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
1298	Expense - Utilities	200	Expense	INR	9	22	22	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
1299	Expense - Entertainment	200	Expense	INR	5	22	22	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
1300	Expense - Utilities	300	Expense	INR	9	22	22	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
1301	Expense - Education	200	Expense	INR	8	22	22	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
1302	Expense - Utilities	200	Expense	INR	9	22	22	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
1303	Expense - Food & Dining	200	Expense	INR	1	22	22	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
1304	Expense - Travel	200	Expense	INR	6	22	22	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
1305	Expense - Miscellaneous	200	Expense	INR	10	22	22	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
1306	Expense - Entertainment	200	Expense	INR	5	22	22	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
1307	Expense - Food & Dining	200	Expense	INR	1	22	22	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
1308	Expense - Education	200	Expense	INR	8	22	22	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
1309	Expense - Food & Dining	200	Expense	INR	1	22	22	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
1310	Expense - Travel	200	Expense	INR	6	22	22	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
1311	Expense - Entertainment	200	Expense	INR	5	22	22	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
1312	Expense - Transportation	200	Expense	INR	2	22	22	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
1313	Expense - Transportation	200	Expense	INR	2	22	22	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
1314	Expense - Food & Dining	700	Expense	INR	1	22	22	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
1315	Expense - Miscellaneous	200	Expense	INR	10	22	22	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
1316	Expense - Food & Dining	200	Expense	INR	1	22	22	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
1317	Expense - Housing	300	Expense	INR	3	22	22	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
1318	Expense - Miscellaneous	200	Expense	INR	10	22	22	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
1319	Expense - Miscellaneous	200	Expense	INR	10	22	22	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
1320	Expense - Utilities	200	Expense	INR	9	22	22	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
1321	Expense - Transportation	200	Expense	INR	2	22	22	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
1322	Expense - Housing	1300	Expense	INR	3	22	22	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
1323	Expense - Travel	200	Expense	INR	6	22	22	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
1324	Expense - Healthcare	200	Expense	INR	4	22	22	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
1325	Expense - Transportation	200	Expense	INR	2	22	22	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
1326	Expense - Healthcare	200	Expense	INR	4	22	22	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
1327	Expense - Transportation	400	Expense	INR	2	22	22	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
1328	Expense - Shopping	300	Expense	INR	7	22	22	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
1329	Expense - Shopping	500	Expense	INR	7	22	22	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
1330	Expense - Miscellaneous	200	Expense	INR	10	22	22	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
1331	Expense - Utilities	200	Expense	INR	9	22	22	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
1332	Expense - Food & Dining	2000	Expense	INR	1	22	22	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
1333	Expense - Miscellaneous	200	Expense	INR	10	22	22	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
1334	Expense - Transportation	500	Expense	INR	2	22	22	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
1335	Expense - Miscellaneous	200	Expense	INR	10	22	22	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
1336	Expense - Utilities	200	Expense	INR	9	22	22	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
1337	Expense - Housing	2500	Expense	INR	3	22	22	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
1338	Expense - Miscellaneous	200	Expense	INR	10	23	23	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
1339	Expense - Miscellaneous	200	Expense	INR	10	23	23	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
1340	Expense - Education	200	Expense	INR	8	23	23	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
1341	Expense - Education	200	Expense	INR	8	23	23	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
1342	Expense - Healthcare	200	Expense	INR	4	23	23	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
1343	Expense - Shopping	200	Expense	INR	7	23	23	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
1344	Expense - Education	200	Expense	INR	8	23	23	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
1345	Expense - Food & Dining	200	Expense	INR	1	23	23	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
1346	Expense - Utilities	300	Expense	INR	9	23	23	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
1347	Expense - Miscellaneous	200	Expense	INR	10	23	23	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
1348	Expense - Healthcare	200	Expense	INR	4	23	23	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
1349	Expense - Food & Dining	1700	Expense	INR	1	23	23	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
1350	Expense - Shopping	300	Expense	INR	7	23	23	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
1351	Expense - Entertainment	200	Expense	INR	5	23	23	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
1352	Expense - Healthcare	200	Expense	INR	4	23	23	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
1353	Expense - Entertainment	200	Expense	INR	5	23	23	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
1354	Expense - Miscellaneous	200	Expense	INR	10	23	23	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
1355	Expense - Housing	200	Expense	INR	3	23	23	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
1356	Expense - Housing	1100	Expense	INR	3	23	23	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
1357	Expense - Travel	200	Expense	INR	6	23	23	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
1358	Expense - Healthcare	400	Expense	INR	4	23	23	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
1359	Expense - Shopping	200	Expense	INR	7	23	23	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
1360	Expense - Transportation	200	Expense	INR	2	23	23	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
1361	Expense - Shopping	200	Expense	INR	7	23	23	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
1362	Expense - Education	200	Expense	INR	8	23	23	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
1363	Expense - Entertainment	200	Expense	INR	5	23	23	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
1364	Expense - Housing	2900	Expense	INR	3	23	23	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
1365	Expense - Education	200	Expense	INR	8	23	23	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
1366	Expense - Miscellaneous	200	Expense	INR	10	23	23	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
1367	Expense - Travel	200	Expense	INR	6	23	23	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
1368	Expense - Food & Dining	300	Expense	INR	1	23	23	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
1369	Expense - Miscellaneous	200	Expense	INR	10	23	23	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
1370	Expense - Shopping	300	Expense	INR	7	23	23	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
1371	Expense - Healthcare	200	Expense	INR	4	23	23	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
1372	Expense - Housing	200	Expense	INR	3	23	23	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
1373	Expense - Education	200	Expense	INR	8	23	23	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
1374	Expense - Transportation	200	Expense	INR	2	23	23	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
1375	Expense - Utilities	600	Expense	INR	9	23	23	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
1376	Expense - Shopping	300	Expense	INR	7	23	23	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
1377	Expense - Housing	2900	Expense	INR	3	23	23	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
1378	Expense - Transportation	200	Expense	INR	2	23	23	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
1379	Expense - Utilities	200	Expense	INR	9	23	23	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
1380	Expense - Miscellaneous	200	Expense	INR	10	23	23	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
1381	Expense - Shopping	600	Expense	INR	7	23	23	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
1382	Expense - Entertainment	200	Expense	INR	5	23	23	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
1383	Expense - Healthcare	200	Expense	INR	4	24	24	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
1384	Expense - Housing	200	Expense	INR	3	24	24	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
1385	Expense - Food & Dining	300	Expense	INR	1	24	24	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
1386	Expense - Miscellaneous	200	Expense	INR	10	24	24	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
1387	Expense - Shopping	200	Expense	INR	7	24	24	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
1388	Expense - Housing	400	Expense	INR	3	24	24	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
1389	Expense - Miscellaneous	200	Expense	INR	10	24	24	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
1390	Expense - Shopping	300	Expense	INR	7	24	24	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
1391	Expense - Transportation	300	Expense	INR	2	24	24	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
1392	Expense - Education	200	Expense	INR	8	24	24	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
1393	Expense - Shopping	200	Expense	INR	7	24	24	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
1394	Expense - Miscellaneous	200	Expense	INR	10	24	24	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
1395	Expense - Travel	200	Expense	INR	6	24	24	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
1396	Expense - Transportation	200	Expense	INR	2	24	24	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
1397	Expense - Shopping	200	Expense	INR	7	24	24	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
1398	Expense - Education	200	Expense	INR	8	24	24	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
1399	Expense - Utilities	200	Expense	INR	9	24	24	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
1400	Expense - Entertainment	200	Expense	INR	5	24	24	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
1401	Expense - Entertainment	200	Expense	INR	5	24	24	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
1402	Expense - Food & Dining	200	Expense	INR	1	24	24	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
1403	Expense - Utilities	200	Expense	INR	9	24	24	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
1404	Expense - Healthcare	200	Expense	INR	4	24	24	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
1405	Expense - Utilities	200	Expense	INR	9	24	24	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
1406	Expense - Housing	200	Expense	INR	3	24	24	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
1407	Expense - Housing	600	Expense	INR	3	24	24	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
1408	Expense - Utilities	200	Expense	INR	9	24	24	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
1409	Expense - Utilities	200	Expense	INR	9	24	24	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
1410	Expense - Utilities	200	Expense	INR	9	24	24	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
1411	Expense - Food & Dining	200	Expense	INR	1	24	24	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
1412	Expense - Housing	400	Expense	INR	3	24	24	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
1413	Expense - Travel	200	Expense	INR	6	24	24	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
1414	Expense - Healthcare	200	Expense	INR	4	24	24	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
1415	Expense - Shopping	200	Expense	INR	7	24	24	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
1416	Expense - Healthcare	200	Expense	INR	4	24	24	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
1417	Expense - Transportation	200	Expense	INR	2	24	24	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
1418	Expense - Housing	700	Expense	INR	3	24	24	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
1419	Expense - Housing	200	Expense	INR	3	24	24	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
1420	Expense - Utilities	200	Expense	INR	9	24	24	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
1421	Expense - Miscellaneous	200	Expense	INR	10	24	24	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
1422	Expense - Food & Dining	200	Expense	INR	1	24	24	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
1423	Expense - Education	200	Expense	INR	8	24	24	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
1424	Expense - Travel	200	Expense	INR	6	25	25	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
1425	Expense - Education	200	Expense	INR	8	25	25	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
1426	Expense - Travel	200	Expense	INR	6	25	25	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
1427	Expense - Food & Dining	200	Expense	INR	1	25	25	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
1428	Expense - Housing	500	Expense	INR	3	25	25	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
1429	Expense - Shopping	200	Expense	INR	7	25	25	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
1430	Expense - Education	300	Expense	INR	8	25	25	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
1431	Expense - Utilities	200	Expense	INR	9	25	25	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
1432	Expense - Utilities	200	Expense	INR	9	25	25	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
1433	Expense - Utilities	200	Expense	INR	9	25	25	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
1434	Expense - Healthcare	300	Expense	INR	4	25	25	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
1435	Expense - Miscellaneous	200	Expense	INR	10	25	25	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
1436	Expense - Utilities	200	Expense	INR	9	25	25	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
1437	Expense - Entertainment	200	Expense	INR	5	25	25	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
1438	Expense - Healthcare	200	Expense	INR	4	25	25	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
1439	Expense - Miscellaneous	200	Expense	INR	10	25	25	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
1440	Expense - Shopping	300	Expense	INR	7	25	25	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
1441	Expense - Food & Dining	2200	Expense	INR	1	25	25	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
1442	Expense - Travel	200	Expense	INR	6	25	25	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
1443	Expense - Housing	700	Expense	INR	3	25	25	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
1444	Expense - Entertainment	200	Expense	INR	5	25	25	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
1445	Expense - Utilities	200	Expense	INR	9	25	25	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
1446	Expense - Healthcare	400	Expense	INR	4	25	25	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
1447	Expense - Healthcare	600	Expense	INR	4	25	25	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
1448	Expense - Transportation	200	Expense	INR	2	25	25	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
1449	Expense - Utilities	200	Expense	INR	9	25	25	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
1450	Expense - Travel	200	Expense	INR	6	25	25	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
1451	Expense - Transportation	200	Expense	INR	2	25	25	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
1452	Expense - Healthcare	200	Expense	INR	4	25	25	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
1453	Expense - Travel	200	Expense	INR	6	25	25	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
1454	Expense - Housing	800	Expense	INR	3	25	25	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
1455	Expense - Healthcare	200	Expense	INR	4	25	25	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
1456	Expense - Education	400	Expense	INR	8	25	25	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
1457	Expense - Entertainment	200	Expense	INR	5	25	25	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
1458	Expense - Shopping	200	Expense	INR	7	25	25	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
1459	Expense - Entertainment	200	Expense	INR	5	25	25	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
1460	Expense - Entertainment	500	Expense	INR	5	25	25	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
1461	Expense - Food & Dining	200	Expense	INR	1	25	25	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
1462	Expense - Travel	200	Expense	INR	6	25	25	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
1463	Expense - Travel	200	Expense	INR	6	25	25	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
1464	Expense - Shopping	300	Expense	INR	7	25	25	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
1465	Expense - Food & Dining	700	Expense	INR	1	25	25	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
1466	Expense - Food & Dining	200	Expense	INR	1	25	25	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
1467	Expense - Education	200	Expense	INR	8	25	25	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
1468	Expense - Healthcare	200	Expense	INR	4	25	25	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
1469	Expense - Shopping	200	Expense	INR	7	25	25	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
1470	Expense - Healthcare	200	Expense	INR	4	25	25	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
1471	Expense - Travel	200	Expense	INR	6	25	25	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
1472	Expense - Travel	200	Expense	INR	6	25	25	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
1473	Expense - Miscellaneous	200	Expense	INR	10	25	25	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
1474	Expense - Entertainment	200	Expense	INR	5	25	25	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
1475	Expense - Education	200	Expense	INR	8	25	25	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
1476	Expense - Transportation	200	Expense	INR	2	25	25	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
1477	Expense - Transportation	200	Expense	INR	2	25	25	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
1478	Expense - Transportation	300	Expense	INR	2	25	25	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
1479	Expense - Shopping	300	Expense	INR	7	26	26	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
1480	Expense - Shopping	200	Expense	INR	7	26	26	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
1481	Expense - Housing	1100	Expense	INR	3	26	26	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
1482	Expense - Entertainment	200	Expense	INR	5	26	26	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
1483	Expense - Education	200	Expense	INR	8	26	26	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
1484	Expense - Shopping	300	Expense	INR	7	26	26	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
1485	Expense - Healthcare	200	Expense	INR	4	26	26	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
1486	Expense - Travel	200	Expense	INR	6	26	26	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
1487	Expense - Travel	200	Expense	INR	6	26	26	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
1488	Expense - Healthcare	200	Expense	INR	4	26	26	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
1489	Expense - Travel	200	Expense	INR	6	26	26	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
1490	Expense - Shopping	200	Expense	INR	7	26	26	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
1491	Expense - Healthcare	200	Expense	INR	4	26	26	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
1492	Expense - Entertainment	200	Expense	INR	5	26	26	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
1493	Expense - Utilities	200	Expense	INR	9	26	26	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
1494	Expense - Housing	300	Expense	INR	3	26	26	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
1495	Expense - Healthcare	200	Expense	INR	4	26	26	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
1496	Expense - Food & Dining	200	Expense	INR	1	26	26	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
1497	Expense - Transportation	900	Expense	INR	2	26	26	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
1498	Expense - Miscellaneous	200	Expense	INR	10	26	26	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
1499	Expense - Utilities	400	Expense	INR	9	26	26	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
1500	Expense - Entertainment	200	Expense	INR	5	26	26	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
1501	Expense - Education	200	Expense	INR	8	26	26	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
1502	Expense - Transportation	200	Expense	INR	2	26	26	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
1503	Expense - Transportation	200	Expense	INR	2	26	26	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
1504	Expense - Miscellaneous	200	Expense	INR	10	26	26	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
1505	Expense - Healthcare	200	Expense	INR	4	26	26	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
1506	Expense - Food & Dining	300	Expense	INR	1	26	26	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
1507	Expense - Education	200	Expense	INR	8	26	26	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
1508	Expense - Utilities	200	Expense	INR	9	26	26	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
1509	Expense - Miscellaneous	200	Expense	INR	10	26	26	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
1510	Expense - Miscellaneous	200	Expense	INR	10	26	26	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
1511	Expense - Utilities	300	Expense	INR	9	26	26	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
1512	Expense - Housing	200	Expense	INR	3	26	26	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
1513	Expense - Housing	500	Expense	INR	3	26	26	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
1514	Expense - Housing	700	Expense	INR	3	26	26	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
1515	Expense - Education	200	Expense	INR	8	26	26	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
1516	Expense - Shopping	800	Expense	INR	7	26	26	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
1517	Expense - Miscellaneous	200	Expense	INR	10	26	26	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
1518	Expense - Shopping	200	Expense	INR	7	26	26	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
1519	Expense - Travel	200	Expense	INR	6	26	26	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
1520	Expense - Miscellaneous	200	Expense	INR	10	26	26	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
1521	Expense - Transportation	300	Expense	INR	2	26	26	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
1522	Expense - Housing	200	Expense	INR	3	26	26	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
1523	Expense - Education	200	Expense	INR	8	26	26	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
1524	Expense - Miscellaneous	200	Expense	INR	10	26	26	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
1525	Expense - Entertainment	200	Expense	INR	5	26	26	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
1526	Expense - Transportation	200	Expense	INR	2	26	26	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
1527	Expense - Entertainment	500	Expense	INR	5	26	26	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
1528	Expense - Healthcare	200	Expense	INR	4	26	26	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
1529	Expense - Healthcare	200	Expense	INR	4	26	26	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
1530	Expense - Transportation	200	Expense	INR	2	26	26	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
1531	Expense - Transportation	200	Expense	INR	2	26	26	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
1532	Expense - Miscellaneous	200	Expense	INR	10	26	26	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
1533	Expense - Shopping	700	Expense	INR	7	26	26	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
1534	Expense - Healthcare	200	Expense	INR	4	26	26	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
1535	Expense - Utilities	200	Expense	INR	9	26	26	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
1536	Expense - Miscellaneous	200	Expense	INR	10	26	26	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
1537	Expense - Miscellaneous	200	Expense	INR	10	26	26	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
1538	Expense - Entertainment	200	Expense	INR	5	26	26	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
1539	Expense - Healthcare	300	Expense	INR	4	27	27	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
1540	Expense - Travel	200	Expense	INR	6	27	27	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
1541	Expense - Utilities	200	Expense	INR	9	27	27	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
1542	Expense - Miscellaneous	200	Expense	INR	10	27	27	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
1543	Expense - Travel	200	Expense	INR	6	27	27	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
1544	Expense - Education	200	Expense	INR	8	27	27	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
1545	Expense - Transportation	200	Expense	INR	2	27	27	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
1546	Expense - Miscellaneous	200	Expense	INR	10	27	27	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
1547	Expense - Food & Dining	200	Expense	INR	1	27	27	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
1548	Expense - Transportation	200	Expense	INR	2	27	27	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
1549	Expense - Utilities	200	Expense	INR	9	27	27	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
1550	Expense - Travel	200	Expense	INR	6	27	27	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
1551	Expense - Travel	200	Expense	INR	6	27	27	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
1552	Expense - Education	200	Expense	INR	8	27	27	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
1553	Expense - Entertainment	200	Expense	INR	5	27	27	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
1554	Expense - Utilities	200	Expense	INR	9	27	27	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
1555	Expense - Miscellaneous	200	Expense	INR	10	27	27	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
1556	Expense - Transportation	200	Expense	INR	2	27	27	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
1557	Expense - Food & Dining	200	Expense	INR	1	27	27	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
1558	Expense - Housing	300	Expense	INR	3	27	27	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
1559	Expense - Travel	200	Expense	INR	6	27	27	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
1560	Expense - Food & Dining	200	Expense	INR	1	27	27	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
1561	Expense - Miscellaneous	200	Expense	INR	10	27	27	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
1562	Expense - Healthcare	200	Expense	INR	4	27	27	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
1563	Expense - Entertainment	200	Expense	INR	5	27	27	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
1564	Expense - Healthcare	300	Expense	INR	4	27	27	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
1565	Expense - Shopping	200	Expense	INR	7	27	27	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
1566	Expense - Travel	200	Expense	INR	6	27	27	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
1567	Expense - Healthcare	200	Expense	INR	4	27	27	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
1568	Expense - Education	200	Expense	INR	8	27	27	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
1569	Expense - Entertainment	200	Expense	INR	5	27	27	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
1570	Expense - Transportation	600	Expense	INR	2	27	27	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
1571	Expense - Education	200	Expense	INR	8	27	27	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
1572	Expense - Transportation	200	Expense	INR	2	27	27	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
1573	Expense - Miscellaneous	200	Expense	INR	10	27	27	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
1574	Expense - Travel	200	Expense	INR	6	27	27	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
1575	Expense - Entertainment	200	Expense	INR	5	27	27	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
1576	Expense - Miscellaneous	200	Expense	INR	10	27	27	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
1577	Expense - Shopping	600	Expense	INR	7	27	27	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
1578	Expense - Utilities	200	Expense	INR	9	27	27	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
1579	Expense - Entertainment	200	Expense	INR	5	27	27	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
1580	Expense - Education	200	Expense	INR	8	27	27	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
1581	Expense - Travel	200	Expense	INR	6	27	27	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
1582	Expense - Miscellaneous	200	Expense	INR	10	27	27	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
1583	Expense - Entertainment	200	Expense	INR	5	27	27	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
1584	Expense - Food & Dining	300	Expense	INR	1	27	27	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
1585	Expense - Miscellaneous	200	Expense	INR	10	27	27	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
1586	Expense - Utilities	200	Expense	INR	9	27	27	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
1587	Expense - Healthcare	200	Expense	INR	4	27	27	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
1588	Expense - Utilities	200	Expense	INR	9	27	27	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
1589	Expense - Shopping	200	Expense	INR	7	27	27	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
1590	Expense - Miscellaneous	200	Expense	INR	10	27	27	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
1591	Expense - Transportation	300	Expense	INR	2	27	27	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
1592	Expense - Transportation	200	Expense	INR	2	27	27	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
1593	Expense - Housing	500	Expense	INR	3	27	27	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
1594	Expense - Travel	200	Expense	INR	6	27	27	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
1595	Expense - Transportation	500	Expense	INR	2	27	27	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
1596	Expense - Miscellaneous	200	Expense	INR	10	27	27	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
1597	Expense - Food & Dining	1600	Expense	INR	1	27	27	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
1598	Expense - Miscellaneous	200	Expense	INR	10	27	27	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
1599	Expense - Housing	300	Expense	INR	3	27	27	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
1600	Expense - Education	200	Expense	INR	8	27	27	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
1601	Expense - Transportation	200	Expense	INR	2	27	27	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
1602	Expense - Entertainment	200	Expense	INR	5	27	27	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
1603	Expense - Miscellaneous	200	Expense	INR	10	27	27	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
1604	Expense - Transportation	200	Expense	INR	2	27	27	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
1605	Expense - Utilities	200	Expense	INR	9	27	27	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
1606	Expense - Entertainment	300	Expense	INR	5	27	27	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
1607	Expense - Utilities	400	Expense	INR	9	27	27	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
1608	Expense - Transportation	200	Expense	INR	2	27	27	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
1609	Expense - Utilities	300	Expense	INR	9	28	28	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
1610	Expense - Shopping	200	Expense	INR	7	28	28	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
1611	Expense - Healthcare	200	Expense	INR	4	28	28	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
1612	Expense - Transportation	400	Expense	INR	2	28	28	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
1613	Expense - Housing	200	Expense	INR	3	28	28	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
1614	Expense - Healthcare	200	Expense	INR	4	28	28	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
1615	Expense - Housing	500	Expense	INR	3	28	28	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
1616	Expense - Shopping	200	Expense	INR	7	28	28	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
1617	Expense - Education	200	Expense	INR	8	28	28	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
1618	Expense - Education	200	Expense	INR	8	28	28	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
1619	Expense - Transportation	1700	Expense	INR	2	28	28	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
1620	Expense - Shopping	200	Expense	INR	7	28	28	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
1621	Expense - Transportation	1000	Expense	INR	2	28	28	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
1622	Expense - Food & Dining	200	Expense	INR	1	28	28	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
1623	Expense - Travel	200	Expense	INR	6	28	28	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
1624	Expense - Travel	200	Expense	INR	6	28	28	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
1625	Expense - Shopping	200	Expense	INR	7	28	28	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
1626	Expense - Utilities	200	Expense	INR	9	28	28	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
1627	Expense - Education	200	Expense	INR	8	28	28	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
1628	Expense - Entertainment	200	Expense	INR	5	28	28	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
1629	Expense - Shopping	500	Expense	INR	7	28	28	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
1630	Expense - Travel	300	Expense	INR	6	28	28	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
1631	Expense - Shopping	200	Expense	INR	7	28	28	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
1632	Expense - Utilities	200	Expense	INR	9	28	28	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
1633	Expense - Food & Dining	300	Expense	INR	1	28	28	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
1634	Expense - Miscellaneous	200	Expense	INR	10	28	28	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
1635	Expense - Transportation	400	Expense	INR	2	28	28	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
1636	Expense - Education	200	Expense	INR	8	28	28	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
1637	Expense - Transportation	800	Expense	INR	2	28	28	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
1638	Expense - Healthcare	200	Expense	INR	4	28	28	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
1639	Expense - Healthcare	400	Expense	INR	4	28	28	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
1640	Expense - Entertainment	200	Expense	INR	5	28	28	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
1641	Expense - Miscellaneous	200	Expense	INR	10	28	28	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
1642	Expense - Education	200	Expense	INR	8	28	28	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
1643	Expense - Utilities	200	Expense	INR	9	28	28	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
1644	Expense - Healthcare	300	Expense	INR	4	28	28	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
1645	Expense - Education	200	Expense	INR	8	28	28	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
1646	Expense - Utilities	200	Expense	INR	9	28	28	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
1647	Expense - Housing	700	Expense	INR	3	28	28	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
1648	Expense - Shopping	200	Expense	INR	7	28	28	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
1649	Expense - Healthcare	200	Expense	INR	4	28	28	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
1650	Expense - Travel	200	Expense	INR	6	28	28	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
1651	Expense - Healthcare	200	Expense	INR	4	28	28	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
1652	Expense - Travel	200	Expense	INR	6	28	28	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
1653	Expense - Utilities	200	Expense	INR	9	28	28	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
1654	Expense - Shopping	300	Expense	INR	7	28	28	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
1655	Expense - Housing	400	Expense	INR	3	28	28	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
1656	Expense - Transportation	200	Expense	INR	2	28	28	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
1657	Expense - Shopping	200	Expense	INR	7	28	28	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
1658	Expense - Housing	700	Expense	INR	3	28	28	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
1659	Expense - Transportation	400	Expense	INR	2	28	28	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
1660	Expense - Education	200	Expense	INR	8	28	28	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
1661	Expense - Food & Dining	200	Expense	INR	1	28	28	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
1662	Expense - Shopping	700	Expense	INR	7	28	28	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
1663	Expense - Healthcare	200	Expense	INR	4	28	28	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
1664	Expense - Food & Dining	600	Expense	INR	1	28	28	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
1665	Expense - Housing	600	Expense	INR	3	28	28	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
1666	Expense - Shopping	200	Expense	INR	7	28	28	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
1667	Expense - Transportation	200	Expense	INR	2	28	28	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
1668	Expense - Healthcare	200	Expense	INR	4	28	28	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
1669	Expense - Education	200	Expense	INR	8	28	28	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
1670	Expense - Travel	200	Expense	INR	6	28	28	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
1671	Expense - Education	200	Expense	INR	8	28	28	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
1672	Expense - Miscellaneous	200	Expense	INR	10	28	28	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
1673	Expense - Education	200	Expense	INR	8	28	28	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
1674	Expense - Travel	200	Expense	INR	6	28	28	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
1675	Expense - Entertainment	200	Expense	INR	5	28	28	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
1676	Expense - Transportation	200	Expense	INR	2	28	28	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
1677	Expense - Housing	600	Expense	INR	3	28	28	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
1678	Expense - Entertainment	200	Expense	INR	5	28	28	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
1679	Expense - Travel	200	Expense	INR	6	28	28	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
1680	Expense - Healthcare	200	Expense	INR	4	29	29	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
1681	Expense - Travel	300	Expense	INR	6	29	29	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
1682	Expense - Food & Dining	400	Expense	INR	1	29	29	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
1683	Expense - Food & Dining	1700	Expense	INR	1	29	29	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
1684	Expense - Shopping	200	Expense	INR	7	29	29	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
1685	Expense - Miscellaneous	200	Expense	INR	10	29	29	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
1686	Expense - Education	200	Expense	INR	8	29	29	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
1687	Expense - Education	200	Expense	INR	8	29	29	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
1688	Expense - Shopping	200	Expense	INR	7	29	29	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
1689	Expense - Transportation	200	Expense	INR	2	29	29	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
1690	Expense - Housing	200	Expense	INR	3	29	29	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
1691	Expense - Food & Dining	300	Expense	INR	1	29	29	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
1692	Expense - Healthcare	200	Expense	INR	4	29	29	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
1693	Expense - Food & Dining	2000	Expense	INR	1	29	29	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
1694	Expense - Travel	200	Expense	INR	6	29	29	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
1695	Expense - Shopping	200	Expense	INR	7	29	29	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
1696	Expense - Healthcare	200	Expense	INR	4	29	29	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
1697	Expense - Shopping	300	Expense	INR	7	29	29	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
1698	Expense - Utilities	200	Expense	INR	9	29	29	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
1699	Expense - Travel	200	Expense	INR	6	29	29	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
1700	Expense - Housing	1400	Expense	INR	3	29	29	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
1701	Expense - Healthcare	200	Expense	INR	4	29	29	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
1702	Expense - Entertainment	200	Expense	INR	5	29	29	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
1703	Expense - Utilities	200	Expense	INR	9	29	29	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
1704	Expense - Miscellaneous	200	Expense	INR	10	29	29	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
1705	Expense - Transportation	200	Expense	INR	2	29	29	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
1706	Expense - Entertainment	200	Expense	INR	5	29	29	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
1707	Expense - Entertainment	200	Expense	INR	5	29	29	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
1708	Expense - Utilities	200	Expense	INR	9	29	29	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
1709	Expense - Education	300	Expense	INR	8	29	29	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
1710	Expense - Healthcare	200	Expense	INR	4	29	29	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
1711	Expense - Healthcare	200	Expense	INR	4	29	29	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
1712	Expense - Utilities	200	Expense	INR	9	29	29	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
1713	Expense - Entertainment	300	Expense	INR	5	29	29	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
1714	Expense - Utilities	400	Expense	INR	9	29	29	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
1715	Expense - Education	200	Expense	INR	8	29	29	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
1716	Expense - Food & Dining	700	Expense	INR	1	29	29	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
1717	Expense - Transportation	200	Expense	INR	2	29	29	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
1718	Expense - Food & Dining	200	Expense	INR	1	29	29	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
1719	Expense - Miscellaneous	200	Expense	INR	10	29	29	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
1720	Expense - Entertainment	200	Expense	INR	5	29	29	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
1721	Expense - Travel	200	Expense	INR	6	29	29	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
1722	Expense - Travel	200	Expense	INR	6	29	29	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
1723	Expense - Housing	3000	Expense	INR	3	29	29	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
1724	Expense - Utilities	200	Expense	INR	9	29	29	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
1725	Expense - Shopping	200	Expense	INR	7	29	29	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
1726	Expense - Education	200	Expense	INR	8	29	29	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
1727	Expense - Transportation	200	Expense	INR	2	29	29	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
1728	Expense - Shopping	200	Expense	INR	7	29	29	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
1729	Expense - Housing	200	Expense	INR	3	29	29	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
1730	Expense - Shopping	200	Expense	INR	7	29	29	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
1731	Expense - Transportation	200	Expense	INR	2	29	29	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
1732	Expense - Travel	200	Expense	INR	6	29	29	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
1733	Expense - Food & Dining	200	Expense	INR	1	29	29	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
1734	Expense - Miscellaneous	200	Expense	INR	10	29	29	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
1735	Expense - Transportation	200	Expense	INR	2	29	29	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
1736	Expense - Food & Dining	900	Expense	INR	1	29	29	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
1737	Expense - Housing	700	Expense	INR	3	29	29	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
1738	Expense - Travel	200	Expense	INR	6	29	29	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
1739	Expense - Miscellaneous	200	Expense	INR	10	29	29	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
1740	Expense - Food & Dining	300	Expense	INR	1	29	29	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
1741	Expense - Shopping	200	Expense	INR	7	29	29	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
1742	Expense - Miscellaneous	200	Expense	INR	10	29	29	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
1743	Expense - Food & Dining	200	Expense	INR	1	29	29	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
1744	Expense - Healthcare	200	Expense	INR	4	29	29	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
1745	Expense - Healthcare	200	Expense	INR	4	29	29	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
1746	Expense - Housing	700	Expense	INR	3	29	29	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
1747	Expense - Housing	1500	Expense	INR	3	29	29	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
1748	Expense - Travel	200	Expense	INR	6	29	29	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
1749	Expense - Healthcare	200	Expense	INR	4	29	29	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
1750	Expense - Food & Dining	300	Expense	INR	1	29	29	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
1751	Expense - Education	200	Expense	INR	8	29	29	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
1752	Expense - Travel	200	Expense	INR	6	29	29	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
1753	Expense - Transportation	300	Expense	INR	2	29	29	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
1754	Expense - Food & Dining	700	Expense	INR	1	29	29	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
1755	Expense - Entertainment	200	Expense	INR	5	29	29	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
1756	Expense - Travel	300	Expense	INR	6	29	29	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
1757	Expense - Education	200	Expense	INR	8	29	29	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
1758	Expense - Shopping	200	Expense	INR	7	29	29	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
1759	Expense - Utilities	800	Expense	INR	9	29	29	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
1760	Expense - Housing	500	Expense	INR	3	29	29	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
1761	Expense - Food & Dining	800	Expense	INR	1	29	29	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
1762	Expense - Shopping	200	Expense	INR	7	30	30	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
1763	Expense - Utilities	200	Expense	INR	9	30	30	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
1764	Expense - Education	200	Expense	INR	8	30	30	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
1765	Expense - Food & Dining	200	Expense	INR	1	30	30	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
1766	Expense - Miscellaneous	200	Expense	INR	10	30	30	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
1767	Expense - Food & Dining	200	Expense	INR	1	30	30	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
1768	Expense - Education	200	Expense	INR	8	30	30	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
1769	Expense - Shopping	200	Expense	INR	7	30	30	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
1770	Expense - Transportation	200	Expense	INR	2	30	30	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
1771	Expense - Food & Dining	200	Expense	INR	1	30	30	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
1772	Expense - Food & Dining	400	Expense	INR	1	30	30	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
1773	Expense - Miscellaneous	200	Expense	INR	10	30	30	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
1774	Expense - Entertainment	200	Expense	INR	5	30	30	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
1775	Expense - Miscellaneous	200	Expense	INR	10	30	30	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
1776	Expense - Healthcare	200	Expense	INR	4	30	30	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
1777	Expense - Transportation	200	Expense	INR	2	30	30	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
1778	Expense - Utilities	200	Expense	INR	9	30	30	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
1779	Expense - Healthcare	200	Expense	INR	4	30	30	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
1780	Expense - Housing	1300	Expense	INR	3	30	30	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
1781	Expense - Shopping	200	Expense	INR	7	30	30	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
1782	Expense - Healthcare	200	Expense	INR	4	30	30	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
1783	Expense - Food & Dining	700	Expense	INR	1	30	30	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
1784	Expense - Entertainment	200	Expense	INR	5	30	30	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
1785	Expense - Utilities	200	Expense	INR	9	30	30	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
1786	Expense - Housing	500	Expense	INR	3	30	30	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
1787	Expense - Entertainment	200	Expense	INR	5	30	30	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
1788	Expense - Miscellaneous	200	Expense	INR	10	30	30	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
1789	Expense - Travel	200	Expense	INR	6	30	30	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
1790	Expense - Travel	200	Expense	INR	6	30	30	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
1791	Expense - Utilities	200	Expense	INR	9	30	30	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
1792	Expense - Entertainment	200	Expense	INR	5	30	30	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
1793	Expense - Healthcare	200	Expense	INR	4	30	30	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
1794	Expense - Utilities	200	Expense	INR	9	30	30	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
1795	Expense - Housing	200	Expense	INR	3	30	30	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
1796	Expense - Healthcare	200	Expense	INR	4	30	30	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
1797	Expense - Miscellaneous	200	Expense	INR	10	30	30	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
1798	Expense - Travel	200	Expense	INR	6	30	30	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
1799	Expense - Healthcare	200	Expense	INR	4	30	30	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
1800	Expense - Entertainment	200	Expense	INR	5	31	31	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
1801	Expense - Miscellaneous	200	Expense	INR	10	31	31	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
1802	Expense - Housing	200	Expense	INR	3	31	31	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
1803	Expense - Transportation	200	Expense	INR	2	31	31	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
1804	Expense - Food & Dining	300	Expense	INR	1	31	31	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
1805	Expense - Travel	200	Expense	INR	6	31	31	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
1806	Expense - Food & Dining	200	Expense	INR	1	31	31	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
1807	Expense - Housing	300	Expense	INR	3	31	31	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
1808	Expense - Miscellaneous	200	Expense	INR	10	31	31	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
1809	Expense - Utilities	200	Expense	INR	9	31	31	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
1810	Expense - Housing	200	Expense	INR	3	31	31	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
1811	Expense - Travel	200	Expense	INR	6	31	31	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
1812	Expense - Housing	200	Expense	INR	3	31	31	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
1813	Expense - Food & Dining	200	Expense	INR	1	31	31	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
1814	Expense - Travel	200	Expense	INR	6	31	31	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
1815	Expense - Shopping	300	Expense	INR	7	31	31	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
1816	Expense - Utilities	200	Expense	INR	9	31	31	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
1817	Expense - Miscellaneous	200	Expense	INR	10	31	31	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
1818	Expense - Food & Dining	400	Expense	INR	1	31	31	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
1819	Expense - Transportation	200	Expense	INR	2	31	31	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
1820	Expense - Miscellaneous	200	Expense	INR	10	31	31	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
1821	Expense - Shopping	200	Expense	INR	7	31	31	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
1822	Expense - Housing	300	Expense	INR	3	31	31	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
1823	Expense - Housing	200	Expense	INR	3	31	31	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
1824	Expense - Healthcare	200	Expense	INR	4	31	31	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
1825	Expense - Entertainment	200	Expense	INR	5	31	31	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
1826	Expense - Shopping	200	Expense	INR	7	31	31	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
1827	Expense - Housing	200	Expense	INR	3	31	31	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
1828	Expense - Entertainment	200	Expense	INR	5	31	31	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
1829	Expense - Healthcare	200	Expense	INR	4	31	31	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
1830	Expense - Transportation	200	Expense	INR	2	31	31	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
1831	Expense - Food & Dining	300	Expense	INR	1	31	31	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
1832	Expense - Miscellaneous	200	Expense	INR	10	31	31	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
1833	Expense - Healthcare	200	Expense	INR	4	31	31	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
1834	Expense - Travel	200	Expense	INR	6	31	31	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
1835	Expense - Utilities	200	Expense	INR	9	31	31	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
1836	Expense - Travel	200	Expense	INR	6	31	31	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
1837	Expense - Travel	200	Expense	INR	6	31	31	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
1838	Expense - Miscellaneous	200	Expense	INR	10	31	31	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
1839	Expense - Food & Dining	900	Expense	INR	1	31	31	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
1840	Expense - Shopping	200	Expense	INR	7	31	31	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
1841	Expense - Housing	200	Expense	INR	3	31	31	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
1842	Expense - Housing	1000	Expense	INR	3	31	31	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
1843	Expense - Miscellaneous	200	Expense	INR	10	31	31	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
1844	Expense - Entertainment	200	Expense	INR	5	31	31	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
1845	Expense - Miscellaneous	200	Expense	INR	10	31	31	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
1846	Expense - Miscellaneous	200	Expense	INR	10	32	32	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
1847	Expense - Miscellaneous	200	Expense	INR	10	32	32	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
1848	Expense - Education	200	Expense	INR	8	32	32	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
1849	Expense - Utilities	200	Expense	INR	9	32	32	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
1850	Expense - Utilities	200	Expense	INR	9	32	32	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
1851	Expense - Education	200	Expense	INR	8	32	32	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
1852	Expense - Shopping	200	Expense	INR	7	32	32	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
1853	Expense - Miscellaneous	200	Expense	INR	10	32	32	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
1854	Expense - Miscellaneous	200	Expense	INR	10	32	32	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
1855	Expense - Shopping	200	Expense	INR	7	32	32	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
1856	Expense - Education	200	Expense	INR	8	32	32	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
1857	Expense - Transportation	200	Expense	INR	2	32	32	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
1858	Expense - Travel	200	Expense	INR	6	32	32	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
1859	Expense - Entertainment	200	Expense	INR	5	32	32	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
1860	Expense - Miscellaneous	200	Expense	INR	10	32	32	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
1861	Expense - Transportation	200	Expense	INR	2	32	32	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
1862	Expense - Healthcare	200	Expense	INR	4	32	32	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
1863	Expense - Travel	200	Expense	INR	6	32	32	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
1864	Expense - Utilities	300	Expense	INR	9	32	32	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
1865	Expense - Education	200	Expense	INR	8	32	32	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
1866	Expense - Miscellaneous	200	Expense	INR	10	32	32	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
1867	Expense - Transportation	200	Expense	INR	2	32	32	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
1868	Expense - Travel	200	Expense	INR	6	32	32	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
1869	Expense - Education	200	Expense	INR	8	32	32	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
1870	Expense - Education	200	Expense	INR	8	32	32	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
1871	Expense - Shopping	200	Expense	INR	7	32	32	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
1872	Expense - Entertainment	200	Expense	INR	5	32	32	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
1873	Expense - Food & Dining	1000	Expense	INR	1	32	32	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
1874	Expense - Utilities	200	Expense	INR	9	32	32	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
1875	Expense - Healthcare	200	Expense	INR	4	32	32	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
1876	Expense - Healthcare	200	Expense	INR	4	32	32	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
1877	Expense - Shopping	200	Expense	INR	7	32	32	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
1878	Expense - Food & Dining	200	Expense	INR	1	32	32	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
1879	Expense - Food & Dining	400	Expense	INR	1	32	32	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
1880	Expense - Shopping	200	Expense	INR	7	32	32	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
1881	Expense - Transportation	200	Expense	INR	2	32	32	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
1882	Expense - Shopping	200	Expense	INR	7	32	32	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
1883	Expense - Housing	400	Expense	INR	3	32	32	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
1884	Expense - Transportation	200	Expense	INR	2	32	32	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
1885	Expense - Transportation	200	Expense	INR	2	32	32	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
1886	Expense - Entertainment	200	Expense	INR	5	32	32	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
1887	Expense - Shopping	200	Expense	INR	7	32	32	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
1888	Expense - Food & Dining	300	Expense	INR	1	32	32	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
1889	Expense - Entertainment	200	Expense	INR	5	32	32	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
1890	Expense - Travel	200	Expense	INR	6	32	32	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
1891	Expense - Miscellaneous	200	Expense	INR	10	32	32	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
1892	Expense - Shopping	400	Expense	INR	7	32	32	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
1893	Expense - Entertainment	200	Expense	INR	5	32	32	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
1894	Expense - Entertainment	200	Expense	INR	5	32	32	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
1895	Expense - Entertainment	200	Expense	INR	5	32	32	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
1896	Expense - Utilities	300	Expense	INR	9	32	32	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
1897	Expense - Healthcare	200	Expense	INR	4	32	32	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
1898	Expense - Education	200	Expense	INR	8	32	32	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
1899	Expense - Travel	200	Expense	INR	6	32	32	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
1900	Expense - Travel	200	Expense	INR	6	32	32	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
1901	Expense - Housing	200	Expense	INR	3	32	32	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
1902	Expense - Education	200	Expense	INR	8	32	32	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
1903	Expense - Education	200	Expense	INR	8	32	32	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
1904	Expense - Utilities	200	Expense	INR	9	33	33	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
1905	Expense - Miscellaneous	200	Expense	INR	10	33	33	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
1906	Expense - Entertainment	200	Expense	INR	5	33	33	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
1907	Expense - Education	200	Expense	INR	8	33	33	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
1908	Expense - Travel	200	Expense	INR	6	33	33	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
1909	Expense - Utilities	200	Expense	INR	9	33	33	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
1910	Expense - Food & Dining	300	Expense	INR	1	33	33	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
1911	Expense - Entertainment	500	Expense	INR	5	33	33	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
1912	Expense - Transportation	200	Expense	INR	2	33	33	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
1913	Expense - Miscellaneous	200	Expense	INR	10	33	33	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
1914	Expense - Transportation	1000	Expense	INR	2	33	33	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
1915	Expense - Travel	200	Expense	INR	6	33	33	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
1916	Expense - Utilities	300	Expense	INR	9	33	33	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
1917	Expense - Housing	200	Expense	INR	3	33	33	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
1918	Expense - Miscellaneous	200	Expense	INR	10	33	33	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
1919	Expense - Education	200	Expense	INR	8	33	33	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
1920	Expense - Travel	200	Expense	INR	6	33	33	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
1921	Expense - Shopping	500	Expense	INR	7	33	33	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
1922	Expense - Healthcare	200	Expense	INR	4	33	33	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
1923	Expense - Education	200	Expense	INR	8	33	33	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
1924	Expense - Travel	400	Expense	INR	6	33	33	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
1925	Expense - Entertainment	200	Expense	INR	5	33	33	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
1926	Expense - Housing	1000	Expense	INR	3	33	33	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
1927	Expense - Utilities	200	Expense	INR	9	33	33	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
1928	Expense - Shopping	200	Expense	INR	7	33	33	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
1929	Expense - Entertainment	200	Expense	INR	5	33	33	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
1930	Expense - Education	500	Expense	INR	8	33	33	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
1931	Expense - Healthcare	200	Expense	INR	4	33	33	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
1932	Expense - Food & Dining	400	Expense	INR	1	33	33	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
1933	Expense - Utilities	400	Expense	INR	9	33	33	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
1934	Expense - Miscellaneous	200	Expense	INR	10	33	33	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
1935	Expense - Shopping	200	Expense	INR	7	33	33	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
1936	Expense - Transportation	200	Expense	INR	2	33	33	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
1937	Expense - Housing	2300	Expense	INR	3	33	33	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
1938	Expense - Travel	200	Expense	INR	6	33	33	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
1939	Expense - Healthcare	200	Expense	INR	4	33	33	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
1940	Expense - Miscellaneous	200	Expense	INR	10	33	33	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
1941	Expense - Food & Dining	400	Expense	INR	1	33	33	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
1942	Expense - Healthcare	200	Expense	INR	4	33	33	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
1943	Expense - Travel	200	Expense	INR	6	33	33	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
1944	Expense - Housing	400	Expense	INR	3	33	33	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
1945	Expense - Food & Dining	700	Expense	INR	1	33	33	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
1946	Expense - Housing	1100	Expense	INR	3	33	33	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
1947	Expense - Travel	200	Expense	INR	6	33	33	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
1948	Expense - Housing	200	Expense	INR	3	33	33	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
1949	Expense - Entertainment	200	Expense	INR	5	33	33	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
1950	Expense - Entertainment	200	Expense	INR	5	33	33	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
1951	Expense - Food & Dining	800	Expense	INR	1	33	33	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
1952	Expense - Healthcare	200	Expense	INR	4	33	33	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
1953	Expense - Education	200	Expense	INR	8	33	33	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
1954	Expense - Travel	200	Expense	INR	6	33	33	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
1955	Expense - Transportation	200	Expense	INR	2	33	33	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
1956	Expense - Education	200	Expense	INR	8	33	33	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
1957	Expense - Education	200	Expense	INR	8	34	34	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
1958	Expense - Utilities	200	Expense	INR	9	34	34	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
1959	Expense - Housing	200	Expense	INR	3	34	34	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
1960	Expense - Shopping	200	Expense	INR	7	34	34	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
1961	Expense - Shopping	200	Expense	INR	7	34	34	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
1962	Expense - Miscellaneous	200	Expense	INR	10	34	34	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
1963	Expense - Travel	200	Expense	INR	6	34	34	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
1964	Expense - Utilities	200	Expense	INR	9	34	34	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
1965	Expense - Transportation	200	Expense	INR	2	34	34	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
1966	Expense - Travel	200	Expense	INR	6	34	34	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
1967	Expense - Housing	200	Expense	INR	3	34	34	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
1968	Expense - Miscellaneous	200	Expense	INR	10	34	34	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
1969	Expense - Entertainment	200	Expense	INR	5	34	34	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
1970	Expense - Transportation	200	Expense	INR	2	34	34	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
1971	Expense - Entertainment	200	Expense	INR	5	34	34	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
1972	Expense - Utilities	200	Expense	INR	9	34	34	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
1973	Expense - Entertainment	200	Expense	INR	5	34	34	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
1974	Expense - Transportation	200	Expense	INR	2	34	34	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
1975	Expense - Miscellaneous	200	Expense	INR	10	34	34	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
1976	Expense - Shopping	200	Expense	INR	7	34	34	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
1977	Expense - Travel	200	Expense	INR	6	34	34	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
1978	Expense - Entertainment	200	Expense	INR	5	34	34	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
1979	Expense - Shopping	200	Expense	INR	7	34	34	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
1980	Expense - Healthcare	200	Expense	INR	4	34	34	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
1981	Expense - Transportation	200	Expense	INR	2	34	34	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
1982	Expense - Food & Dining	300	Expense	INR	1	34	34	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
1983	Expense - Transportation	200	Expense	INR	2	34	34	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
1984	Expense - Miscellaneous	200	Expense	INR	10	34	34	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
1985	Expense - Travel	200	Expense	INR	6	34	34	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
1986	Expense - Housing	200	Expense	INR	3	34	34	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
1987	Expense - Entertainment	200	Expense	INR	5	34	34	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
1988	Expense - Miscellaneous	200	Expense	INR	10	34	34	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
1989	Expense - Food & Dining	200	Expense	INR	1	34	34	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
1990	Expense - Transportation	200	Expense	INR	2	34	34	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
1991	Expense - Entertainment	200	Expense	INR	5	34	34	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
1992	Expense - Healthcare	200	Expense	INR	4	34	34	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
1993	Expense - Education	200	Expense	INR	8	34	34	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
1994	Expense - Food & Dining	500	Expense	INR	1	34	34	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
1995	Expense - Travel	200	Expense	INR	6	34	34	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
1996	Expense - Healthcare	200	Expense	INR	4	34	34	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
1997	Expense - Housing	300	Expense	INR	3	34	34	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
1998	Expense - Healthcare	200	Expense	INR	4	34	34	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
1999	Expense - Entertainment	200	Expense	INR	5	34	34	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
2000	Expense - Travel	200	Expense	INR	6	34	34	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
2001	Expense - Food & Dining	300	Expense	INR	1	34	34	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
2002	Expense - Miscellaneous	200	Expense	INR	10	34	34	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
2003	Expense - Miscellaneous	200	Expense	INR	10	35	35	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
2004	Expense - Travel	200	Expense	INR	6	35	35	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
2005	Expense - Education	200	Expense	INR	8	35	35	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
2006	Expense - Education	200	Expense	INR	8	35	35	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
2007	Expense - Shopping	200	Expense	INR	7	35	35	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
2008	Expense - Healthcare	200	Expense	INR	4	35	35	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
2009	Expense - Healthcare	200	Expense	INR	4	35	35	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
2010	Expense - Healthcare	300	Expense	INR	4	35	35	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
2011	Expense - Entertainment	200	Expense	INR	5	35	35	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
2012	Expense - Shopping	200	Expense	INR	7	35	35	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
2013	Expense - Miscellaneous	200	Expense	INR	10	35	35	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
2014	Expense - Healthcare	300	Expense	INR	4	35	35	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
2015	Expense - Miscellaneous	200	Expense	INR	10	35	35	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
2016	Expense - Utilities	200	Expense	INR	9	35	35	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
2017	Expense - Shopping	200	Expense	INR	7	35	35	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
2018	Expense - Housing	200	Expense	INR	3	35	35	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
2019	Expense - Travel	200	Expense	INR	6	35	35	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
2020	Expense - Healthcare	200	Expense	INR	4	35	35	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
2021	Expense - Healthcare	200	Expense	INR	4	35	35	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
2022	Expense - Miscellaneous	200	Expense	INR	10	35	35	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
2023	Expense - Miscellaneous	200	Expense	INR	10	35	35	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
2024	Expense - Food & Dining	200	Expense	INR	1	35	35	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
2025	Expense - Housing	200	Expense	INR	3	35	35	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
2026	Expense - Transportation	200	Expense	INR	2	35	35	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
2027	Expense - Housing	200	Expense	INR	3	35	35	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
2028	Expense - Entertainment	200	Expense	INR	5	35	35	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
2029	Expense - Utilities	200	Expense	INR	9	35	35	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
2030	Expense - Housing	500	Expense	INR	3	35	35	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
2031	Expense - Travel	200	Expense	INR	6	35	35	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
2032	Expense - Utilities	200	Expense	INR	9	35	35	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
2033	Expense - Miscellaneous	200	Expense	INR	10	35	35	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
2034	Expense - Miscellaneous	200	Expense	INR	10	35	35	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
2035	Expense - Travel	200	Expense	INR	6	35	35	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
2036	Expense - Utilities	200	Expense	INR	9	35	35	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
2037	Expense - Shopping	200	Expense	INR	7	35	35	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
2038	Expense - Transportation	200	Expense	INR	2	35	35	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
2039	Expense - Shopping	200	Expense	INR	7	35	35	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
2040	Expense - Utilities	200	Expense	INR	9	35	35	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
2041	Expense - Miscellaneous	200	Expense	INR	10	35	35	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
2042	Expense - Shopping	300	Expense	INR	7	35	35	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
2043	Expense - Housing	400	Expense	INR	3	35	35	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
2044	Expense - Travel	200	Expense	INR	6	35	35	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
2045	Expense - Healthcare	200	Expense	INR	4	35	35	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
2046	Expense - Shopping	200	Expense	INR	7	35	35	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
2047	Expense - Transportation	200	Expense	INR	2	35	35	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
2048	Expense - Education	200	Expense	INR	8	35	35	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
2049	Expense - Travel	200	Expense	INR	6	35	35	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
2050	Expense - Utilities	200	Expense	INR	9	35	35	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
2051	Expense - Food & Dining	1000	Expense	INR	1	35	35	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
2052	Expense - Utilities	200	Expense	INR	9	35	35	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
2053	Expense - Housing	200	Expense	INR	3	35	35	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
2054	Expense - Housing	200	Expense	INR	3	35	35	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
2055	Expense - Education	200	Expense	INR	8	35	35	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
2056	Expense - Education	200	Expense	INR	8	35	35	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
2057	Expense - Food & Dining	200	Expense	INR	1	35	35	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
2058	Expense - Miscellaneous	200	Expense	INR	10	35	35	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
2059	Expense - Transportation	300	Expense	INR	2	35	35	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
2060	Expense - Healthcare	200	Expense	INR	4	35	35	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
2061	Expense - Education	200	Expense	INR	8	35	35	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
2062	Expense - Entertainment	200	Expense	INR	5	35	35	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
2063	Expense - Food & Dining	200	Expense	INR	1	36	36	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
2064	Expense - Shopping	200	Expense	INR	7	36	36	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
2065	Expense - Utilities	500	Expense	INR	9	36	36	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
2066	Expense - Healthcare	200	Expense	INR	4	36	36	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
2067	Expense - Food & Dining	700	Expense	INR	1	36	36	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
2068	Expense - Travel	200	Expense	INR	6	36	36	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
2069	Expense - Utilities	200	Expense	INR	9	36	36	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
2070	Expense - Housing	700	Expense	INR	3	36	36	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
2071	Expense - Education	200	Expense	INR	8	36	36	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
2072	Expense - Education	300	Expense	INR	8	36	36	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
2073	Expense - Utilities	200	Expense	INR	9	36	36	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
2074	Expense - Shopping	400	Expense	INR	7	36	36	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
2075	Expense - Entertainment	200	Expense	INR	5	36	36	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
2076	Expense - Housing	700	Expense	INR	3	36	36	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
2077	Expense - Miscellaneous	200	Expense	INR	10	36	36	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
2078	Expense - Transportation	200	Expense	INR	2	36	36	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
2079	Expense - Miscellaneous	200	Expense	INR	10	36	36	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
2080	Expense - Education	200	Expense	INR	8	36	36	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
2081	Expense - Food & Dining	300	Expense	INR	1	36	36	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
2082	Expense - Shopping	200	Expense	INR	7	36	36	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
2083	Expense - Housing	500	Expense	INR	3	36	36	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
2084	Expense - Utilities	200	Expense	INR	9	36	36	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
2085	Expense - Education	200	Expense	INR	8	36	36	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
2086	Expense - Education	200	Expense	INR	8	36	36	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
2087	Expense - Utilities	300	Expense	INR	9	36	36	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
2088	Expense - Healthcare	200	Expense	INR	4	36	36	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
2089	Expense - Utilities	200	Expense	INR	9	36	36	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
2090	Expense - Education	200	Expense	INR	8	36	36	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
2091	Expense - Food & Dining	1600	Expense	INR	1	36	36	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
2092	Expense - Miscellaneous	200	Expense	INR	10	36	36	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
2093	Expense - Housing	1000	Expense	INR	3	36	36	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
2094	Expense - Travel	200	Expense	INR	6	36	36	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
2095	Expense - Healthcare	200	Expense	INR	4	36	36	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
2096	Expense - Miscellaneous	200	Expense	INR	10	36	36	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
2097	Expense - Housing	700	Expense	INR	3	36	36	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
2098	Expense - Education	200	Expense	INR	8	36	36	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
2099	Expense - Utilities	400	Expense	INR	9	36	36	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
2100	Expense - Healthcare	200	Expense	INR	4	36	36	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
2101	Expense - Shopping	600	Expense	INR	7	36	36	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
2102	Expense - Travel	200	Expense	INR	6	36	36	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
2103	Expense - Entertainment	200	Expense	INR	5	36	36	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
2104	Expense - Transportation	200	Expense	INR	2	36	36	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
2105	Expense - Healthcare	200	Expense	INR	4	36	36	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
2106	Expense - Shopping	200	Expense	INR	7	36	36	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
2107	Expense - Transportation	200	Expense	INR	2	36	36	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
2108	Expense - Food & Dining	200	Expense	INR	1	36	36	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
2109	Expense - Utilities	200	Expense	INR	9	36	36	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
2110	Expense - Travel	200	Expense	INR	6	36	36	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
2111	Expense - Healthcare	200	Expense	INR	4	36	36	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
2112	Expense - Food & Dining	200	Expense	INR	1	36	36	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
2113	Expense - Miscellaneous	200	Expense	INR	10	36	36	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
2114	Expense - Healthcare	200	Expense	INR	4	36	36	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
2115	Expense - Shopping	200	Expense	INR	7	36	36	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
2116	Expense - Education	200	Expense	INR	8	36	36	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
2117	Expense - Housing	300	Expense	INR	3	36	36	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
2118	Expense - Utilities	200	Expense	INR	9	37	37	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
2119	Expense - Food & Dining	400	Expense	INR	1	37	37	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
2120	Expense - Transportation	200	Expense	INR	2	37	37	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
2121	Expense - Food & Dining	400	Expense	INR	1	37	37	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
2122	Expense - Shopping	400	Expense	INR	7	37	37	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
2123	Expense - Transportation	200	Expense	INR	2	37	37	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
2124	Expense - Miscellaneous	200	Expense	INR	10	37	37	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
2125	Expense - Miscellaneous	200	Expense	INR	10	37	37	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
2126	Expense - Shopping	200	Expense	INR	7	37	37	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
2127	Expense - Travel	200	Expense	INR	6	37	37	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
2128	Expense - Education	200	Expense	INR	8	37	37	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
2129	Expense - Housing	300	Expense	INR	3	37	37	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
2130	Expense - Healthcare	200	Expense	INR	4	37	37	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
2131	Expense - Housing	400	Expense	INR	3	37	37	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
2132	Expense - Education	200	Expense	INR	8	37	37	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
2133	Expense - Transportation	200	Expense	INR	2	37	37	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
2134	Expense - Education	200	Expense	INR	8	37	37	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
2135	Expense - Healthcare	300	Expense	INR	4	37	37	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
2136	Expense - Shopping	200	Expense	INR	7	37	37	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
2137	Expense - Food & Dining	200	Expense	INR	1	37	37	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
2138	Expense - Transportation	200	Expense	INR	2	37	37	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
2139	Expense - Education	200	Expense	INR	8	37	37	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
2140	Expense - Housing	200	Expense	INR	3	37	37	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
2141	Expense - Travel	200	Expense	INR	6	37	37	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
2142	Expense - Entertainment	200	Expense	INR	5	37	37	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
2143	Expense - Transportation	200	Expense	INR	2	37	37	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
2144	Expense - Entertainment	200	Expense	INR	5	37	37	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
2145	Expense - Food & Dining	200	Expense	INR	1	37	37	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
2146	Expense - Miscellaneous	200	Expense	INR	10	37	37	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
2147	Expense - Entertainment	200	Expense	INR	5	37	37	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
2148	Expense - Travel	200	Expense	INR	6	37	37	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
2149	Expense - Travel	300	Expense	INR	6	37	37	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
2150	Expense - Entertainment	200	Expense	INR	5	37	37	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
2151	Expense - Housing	600	Expense	INR	3	37	37	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
2152	Expense - Housing	1400	Expense	INR	3	37	37	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
2153	Expense - Food & Dining	200	Expense	INR	1	37	37	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
2154	Expense - Utilities	200	Expense	INR	9	37	37	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
2155	Expense - Miscellaneous	200	Expense	INR	10	37	37	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
2156	Expense - Healthcare	200	Expense	INR	4	37	37	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
2157	Expense - Food & Dining	200	Expense	INR	1	37	37	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
2158	Expense - Entertainment	200	Expense	INR	5	37	37	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
2159	Expense - Travel	200	Expense	INR	6	37	37	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
2160	Expense - Education	200	Expense	INR	8	37	37	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
2161	Expense - Shopping	200	Expense	INR	7	37	37	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
2162	Expense - Utilities	200	Expense	INR	9	37	37	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
2163	Expense - Miscellaneous	200	Expense	INR	10	37	37	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
2164	Expense - Utilities	200	Expense	INR	9	37	37	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
2165	Expense - Utilities	200	Expense	INR	9	37	37	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
2166	Expense - Travel	200	Expense	INR	6	37	37	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
2167	Expense - Utilities	200	Expense	INR	9	37	37	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
2168	Expense - Utilities	600	Expense	INR	9	37	37	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
2169	Expense - Shopping	200	Expense	INR	7	37	37	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
2170	Expense - Miscellaneous	200	Expense	INR	10	37	37	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
2171	Expense - Miscellaneous	200	Expense	INR	10	37	37	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
2172	Expense - Shopping	200	Expense	INR	7	37	37	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
2173	Expense - Travel	200	Expense	INR	6	37	37	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
2174	Expense - Education	200	Expense	INR	8	37	37	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
2175	Expense - Housing	200	Expense	INR	3	37	37	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
2176	Expense - Housing	200	Expense	INR	3	37	37	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
2177	Expense - Travel	200	Expense	INR	6	37	37	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
2178	Expense - Housing	200	Expense	INR	3	37	37	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
2179	Expense - Miscellaneous	200	Expense	INR	10	37	37	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
2180	Expense - Food & Dining	600	Expense	INR	1	37	37	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
2181	Expense - Miscellaneous	200	Expense	INR	10	37	37	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
2182	Expense - Healthcare	200	Expense	INR	4	37	37	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
2183	Expense - Entertainment	200	Expense	INR	5	37	37	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
2184	Expense - Healthcare	200	Expense	INR	4	37	37	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
2185	Expense - Entertainment	400	Expense	INR	5	37	37	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
2186	Expense - Utilities	200	Expense	INR	9	37	37	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
2187	Expense - Education	200	Expense	INR	8	37	37	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
2188	Expense - Housing	200	Expense	INR	3	38	38	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
2189	Expense - Travel	200	Expense	INR	6	38	38	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
2190	Expense - Food & Dining	200	Expense	INR	1	38	38	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
2191	Expense - Education	200	Expense	INR	8	38	38	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
2192	Expense - Food & Dining	200	Expense	INR	1	38	38	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
2193	Expense - Entertainment	200	Expense	INR	5	38	38	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
2194	Expense - Utilities	200	Expense	INR	9	38	38	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
2195	Expense - Shopping	200	Expense	INR	7	38	38	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
2196	Expense - Transportation	200	Expense	INR	2	38	38	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
2197	Expense - Entertainment	200	Expense	INR	5	38	38	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
2198	Expense - Utilities	200	Expense	INR	9	38	38	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
2199	Expense - Shopping	400	Expense	INR	7	38	38	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
2200	Expense - Utilities	200	Expense	INR	9	38	38	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
2201	Expense - Education	200	Expense	INR	8	38	38	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
2202	Expense - Entertainment	200	Expense	INR	5	38	38	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
2203	Expense - Shopping	200	Expense	INR	7	38	38	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
2204	Expense - Healthcare	200	Expense	INR	4	38	38	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
2205	Expense - Healthcare	200	Expense	INR	4	38	38	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
2206	Expense - Education	200	Expense	INR	8	38	38	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
2207	Expense - Transportation	200	Expense	INR	2	38	38	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
2208	Expense - Miscellaneous	200	Expense	INR	10	38	38	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
2209	Expense - Housing	200	Expense	INR	3	38	38	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
2210	Expense - Entertainment	200	Expense	INR	5	38	38	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
2211	Expense - Housing	200	Expense	INR	3	38	38	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
2212	Expense - Healthcare	200	Expense	INR	4	38	38	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
2213	Expense - Transportation	200	Expense	INR	2	38	38	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
2214	Expense - Housing	200	Expense	INR	3	38	38	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
2215	Expense - Healthcare	200	Expense	INR	4	38	38	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
2216	Expense - Travel	200	Expense	INR	6	38	38	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
2217	Expense - Miscellaneous	200	Expense	INR	10	38	38	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
2218	Expense - Healthcare	200	Expense	INR	4	38	38	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
2219	Expense - Food & Dining	500	Expense	INR	1	38	38	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
2220	Expense - Miscellaneous	200	Expense	INR	10	38	38	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
2221	Expense - Healthcare	200	Expense	INR	4	38	38	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
2222	Expense - Utilities	400	Expense	INR	9	38	38	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
2223	Expense - Food & Dining	200	Expense	INR	1	38	38	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
2224	Expense - Food & Dining	300	Expense	INR	1	38	38	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
2225	Expense - Housing	200	Expense	INR	3	38	38	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
2226	Expense - Entertainment	200	Expense	INR	5	38	38	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
2227	Expense - Shopping	200	Expense	INR	7	38	38	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
2228	Expense - Shopping	200	Expense	INR	7	38	38	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
2229	Expense - Housing	400	Expense	INR	3	38	38	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
2230	Expense - Entertainment	200	Expense	INR	5	38	38	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
2231	Expense - Utilities	200	Expense	INR	9	38	38	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
2232	Expense - Travel	200	Expense	INR	6	38	38	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
2233	Expense - Shopping	200	Expense	INR	7	38	38	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
2234	Expense - Miscellaneous	200	Expense	INR	10	38	38	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
2235	Expense - Shopping	200	Expense	INR	7	38	38	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
2236	Expense - Housing	600	Expense	INR	3	38	38	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
2237	Expense - Education	200	Expense	INR	8	38	38	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
2238	Expense - Housing	500	Expense	INR	3	38	38	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
2239	Expense - Miscellaneous	200	Expense	INR	10	38	38	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
2240	Expense - Healthcare	200	Expense	INR	4	38	38	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
2241	Expense - Shopping	200	Expense	INR	7	38	38	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
2242	Expense - Utilities	200	Expense	INR	9	38	38	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
2243	Expense - Shopping	200	Expense	INR	7	38	38	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
2244	Expense - Travel	200	Expense	INR	6	38	38	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
2245	Expense - Miscellaneous	200	Expense	INR	10	38	38	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
2246	Expense - Miscellaneous	200	Expense	INR	10	39	39	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
2247	Expense - Miscellaneous	200	Expense	INR	10	39	39	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
2248	Expense - Healthcare	200	Expense	INR	4	39	39	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
2249	Expense - Food & Dining	400	Expense	INR	1	39	39	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
2250	Expense - Miscellaneous	200	Expense	INR	10	39	39	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
2251	Expense - Housing	300	Expense	INR	3	39	39	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
2252	Expense - Shopping	200	Expense	INR	7	39	39	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
2253	Expense - Transportation	700	Expense	INR	2	39	39	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
2254	Expense - Utilities	200	Expense	INR	9	39	39	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
2255	Expense - Travel	200	Expense	INR	6	39	39	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
2256	Expense - Utilities	200	Expense	INR	9	39	39	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
2257	Expense - Education	200	Expense	INR	8	39	39	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
2258	Expense - Entertainment	200	Expense	INR	5	39	39	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
2259	Expense - Travel	200	Expense	INR	6	39	39	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
2260	Expense - Transportation	200	Expense	INR	2	39	39	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
2261	Expense - Miscellaneous	200	Expense	INR	10	39	39	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
2262	Expense - Transportation	200	Expense	INR	2	39	39	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
2263	Expense - Food & Dining	200	Expense	INR	1	39	39	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
2264	Expense - Transportation	300	Expense	INR	2	39	39	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
2265	Expense - Education	200	Expense	INR	8	39	39	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
2266	Expense - Transportation	200	Expense	INR	2	39	39	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
2267	Expense - Travel	200	Expense	INR	6	39	39	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
2268	Expense - Education	200	Expense	INR	8	39	39	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
2269	Expense - Shopping	200	Expense	INR	7	39	39	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
2270	Expense - Travel	200	Expense	INR	6	39	39	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
2271	Expense - Entertainment	200	Expense	INR	5	39	39	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
2272	Expense - Food & Dining	400	Expense	INR	1	39	39	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
2273	Expense - Healthcare	200	Expense	INR	4	39	39	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
2274	Expense - Entertainment	200	Expense	INR	5	39	39	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
2275	Expense - Food & Dining	200	Expense	INR	1	39	39	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
2276	Expense - Food & Dining	300	Expense	INR	1	39	39	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
2277	Expense - Transportation	200	Expense	INR	2	39	39	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
2278	Expense - Healthcare	200	Expense	INR	4	39	39	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
2279	Expense - Housing	200	Expense	INR	3	39	39	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
2280	Expense - Miscellaneous	200	Expense	INR	10	39	39	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
2281	Expense - Utilities	200	Expense	INR	9	39	39	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
2282	Expense - Travel	200	Expense	INR	6	39	39	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
2283	Expense - Shopping	200	Expense	INR	7	39	39	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
2284	Expense - Utilities	200	Expense	INR	9	39	39	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
2285	Expense - Transportation	200	Expense	INR	2	39	39	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
2286	Expense - Travel	200	Expense	INR	6	39	39	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
2287	Expense - Travel	200	Expense	INR	6	39	39	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
2288	Expense - Education	300	Expense	INR	8	39	39	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
2289	Expense - Food & Dining	200	Expense	INR	1	39	39	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
2290	Expense - Housing	200	Expense	INR	3	39	39	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
2291	Expense - Shopping	200	Expense	INR	7	39	39	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
2292	Expense - Food & Dining	200	Expense	INR	1	39	39	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
2293	Expense - Healthcare	200	Expense	INR	4	39	39	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
2294	Expense - Food & Dining	1300	Expense	INR	1	39	39	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
2295	Expense - Entertainment	200	Expense	INR	5	39	39	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
2296	Expense - Healthcare	200	Expense	INR	4	39	39	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
2297	Expense - Entertainment	200	Expense	INR	5	39	39	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
2298	Expense - Transportation	200	Expense	INR	2	39	39	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
2299	Expense - Food & Dining	200	Expense	INR	1	39	39	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
2300	Expense - Food & Dining	300	Expense	INR	1	39	39	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
2301	Expense - Food & Dining	600	Expense	INR	1	39	39	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
2302	Expense - Education	200	Expense	INR	8	39	39	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
2303	Expense - Housing	600	Expense	INR	3	39	39	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
2304	Expense - Transportation	200	Expense	INR	2	39	39	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
2305	Expense - Healthcare	200	Expense	INR	4	39	39	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
2306	Expense - Healthcare	200	Expense	INR	4	39	39	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
2307	Expense - Transportation	200	Expense	INR	2	40	40	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
2308	Expense - Miscellaneous	200	Expense	INR	10	40	40	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
2309	Expense - Food & Dining	600	Expense	INR	1	40	40	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
2310	Expense - Housing	3000	Expense	INR	3	40	40	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
2311	Expense - Food & Dining	200	Expense	INR	1	40	40	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
2312	Expense - Food & Dining	300	Expense	INR	1	40	40	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
2313	Expense - Education	200	Expense	INR	8	40	40	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
2314	Expense - Education	200	Expense	INR	8	40	40	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
2315	Expense - Utilities	200	Expense	INR	9	40	40	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
2316	Expense - Travel	200	Expense	INR	6	40	40	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
2317	Expense - Miscellaneous	200	Expense	INR	10	40	40	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
2318	Expense - Utilities	200	Expense	INR	9	40	40	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
2319	Expense - Transportation	200	Expense	INR	2	40	40	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
2320	Expense - Food & Dining	200	Expense	INR	1	40	40	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
2321	Expense - Food & Dining	300	Expense	INR	1	40	40	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
2322	Expense - Shopping	200	Expense	INR	7	40	40	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
2323	Expense - Miscellaneous	200	Expense	INR	10	40	40	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
2324	Expense - Food & Dining	300	Expense	INR	1	40	40	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
2325	Expense - Utilities	400	Expense	INR	9	40	40	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
2326	Expense - Housing	200	Expense	INR	3	40	40	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
2327	Expense - Education	200	Expense	INR	8	40	40	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
2328	Expense - Housing	2100	Expense	INR	3	40	40	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
2329	Expense - Travel	200	Expense	INR	6	40	40	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
2330	Expense - Transportation	200	Expense	INR	2	40	40	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
2331	Expense - Shopping	600	Expense	INR	7	40	40	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
2332	Expense - Education	200	Expense	INR	8	40	40	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
2333	Expense - Transportation	200	Expense	INR	2	40	40	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
2334	Expense - Shopping	400	Expense	INR	7	40	40	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
2335	Expense - Education	200	Expense	INR	8	40	40	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
2336	Expense - Utilities	200	Expense	INR	9	40	40	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
2337	Expense - Education	200	Expense	INR	8	40	40	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
2338	Expense - Shopping	400	Expense	INR	7	40	40	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
2339	Expense - Travel	200	Expense	INR	6	40	40	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
2340	Expense - Shopping	200	Expense	INR	7	40	40	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
2341	Expense - Housing	200	Expense	INR	3	40	40	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
2342	Expense - Entertainment	200	Expense	INR	5	40	40	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
2343	Expense - Housing	300	Expense	INR	3	40	40	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
2344	Expense - Transportation	200	Expense	INR	2	40	40	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
2345	Expense - Utilities	200	Expense	INR	9	40	40	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
2346	Expense - Miscellaneous	200	Expense	INR	10	40	40	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
2347	Expense - Housing	900	Expense	INR	3	40	40	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
2348	Expense - Healthcare	200	Expense	INR	4	40	40	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
2349	Expense - Travel	200	Expense	INR	6	40	40	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
2350	Expense - Miscellaneous	200	Expense	INR	10	40	40	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
2351	Expense - Entertainment	200	Expense	INR	5	40	40	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
2352	Expense - Housing	200	Expense	INR	3	40	40	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
2353	Expense - Transportation	300	Expense	INR	2	40	40	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
2354	Expense - Transportation	200	Expense	INR	2	41	41	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
2355	Expense - Transportation	200	Expense	INR	2	41	41	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
2356	Expense - Housing	200	Expense	INR	3	41	41	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
2357	Expense - Miscellaneous	200	Expense	INR	10	41	41	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
2358	Expense - Entertainment	200	Expense	INR	5	41	41	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
2359	Expense - Utilities	200	Expense	INR	9	41	41	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
2360	Expense - Entertainment	200	Expense	INR	5	41	41	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
2361	Expense - Miscellaneous	200	Expense	INR	10	41	41	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
2362	Expense - Entertainment	200	Expense	INR	5	41	41	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
2363	Expense - Healthcare	200	Expense	INR	4	41	41	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
2364	Expense - Travel	200	Expense	INR	6	41	41	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
2365	Expense - Education	200	Expense	INR	8	41	41	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
2366	Expense - Healthcare	200	Expense	INR	4	41	41	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
2367	Expense - Housing	200	Expense	INR	3	41	41	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
2368	Expense - Miscellaneous	200	Expense	INR	10	41	41	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
2369	Expense - Utilities	200	Expense	INR	9	41	41	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
2370	Expense - Food & Dining	300	Expense	INR	1	41	41	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
2371	Expense - Travel	200	Expense	INR	6	41	41	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
2372	Expense - Travel	200	Expense	INR	6	41	41	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
2373	Expense - Entertainment	200	Expense	INR	5	41	41	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
2374	Expense - Healthcare	200	Expense	INR	4	41	41	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
2375	Expense - Healthcare	200	Expense	INR	4	41	41	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
2376	Expense - Housing	200	Expense	INR	3	41	41	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
2377	Expense - Healthcare	200	Expense	INR	4	41	41	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
2378	Expense - Transportation	200	Expense	INR	2	41	41	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
2379	Expense - Miscellaneous	200	Expense	INR	10	41	41	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
2380	Expense - Shopping	200	Expense	INR	7	41	41	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
2381	Expense - Miscellaneous	200	Expense	INR	10	41	41	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
2382	Expense - Entertainment	200	Expense	INR	5	41	41	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
2383	Expense - Education	200	Expense	INR	8	41	41	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
2384	Expense - Transportation	200	Expense	INR	2	41	41	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
2385	Expense - Utilities	200	Expense	INR	9	41	41	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
2386	Expense - Healthcare	200	Expense	INR	4	41	41	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
2387	Expense - Shopping	400	Expense	INR	7	41	41	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
2388	Expense - Education	200	Expense	INR	8	41	41	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
2389	Expense - Utilities	200	Expense	INR	9	41	41	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
2390	Expense - Education	200	Expense	INR	8	41	41	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
2391	Expense - Miscellaneous	200	Expense	INR	10	41	41	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
2392	Expense - Housing	200	Expense	INR	3	41	41	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
2393	Expense - Entertainment	200	Expense	INR	5	41	41	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
2394	Expense - Miscellaneous	200	Expense	INR	10	41	41	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
2395	Expense - Travel	200	Expense	INR	6	41	41	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
2396	Expense - Education	200	Expense	INR	8	41	41	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
2397	Expense - Entertainment	200	Expense	INR	5	41	41	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
2398	Expense - Food & Dining	300	Expense	INR	1	42	42	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
2399	Expense - Utilities	200	Expense	INR	9	42	42	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
2400	Expense - Housing	400	Expense	INR	3	42	42	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
2401	Expense - Food & Dining	400	Expense	INR	1	42	42	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
2402	Expense - Travel	200	Expense	INR	6	42	42	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
2403	Expense - Education	200	Expense	INR	8	42	42	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
2404	Expense - Shopping	300	Expense	INR	7	42	42	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
2405	Expense - Transportation	200	Expense	INR	2	42	42	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
2406	Expense - Housing	2000	Expense	INR	3	42	42	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
2407	Expense - Miscellaneous	200	Expense	INR	10	42	42	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
2408	Expense - Shopping	200	Expense	INR	7	42	42	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
2409	Expense - Travel	200	Expense	INR	6	42	42	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
2410	Expense - Miscellaneous	200	Expense	INR	10	42	42	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
2411	Expense - Miscellaneous	200	Expense	INR	10	42	42	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
2412	Expense - Food & Dining	300	Expense	INR	1	42	42	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
2413	Expense - Transportation	300	Expense	INR	2	42	42	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
2414	Expense - Education	200	Expense	INR	8	42	42	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
2415	Expense - Shopping	200	Expense	INR	7	42	42	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
2416	Expense - Housing	300	Expense	INR	3	42	42	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
2417	Expense - Education	300	Expense	INR	8	42	42	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
2418	Expense - Travel	200	Expense	INR	6	42	42	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
2419	Expense - Miscellaneous	200	Expense	INR	10	42	42	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
2420	Expense - Entertainment	200	Expense	INR	5	42	42	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
2421	Expense - Travel	200	Expense	INR	6	42	42	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
2422	Expense - Housing	400	Expense	INR	3	42	42	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
2423	Expense - Education	200	Expense	INR	8	42	42	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
2424	Expense - Housing	200	Expense	INR	3	42	42	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
2425	Expense - Miscellaneous	200	Expense	INR	10	42	42	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
2426	Expense - Transportation	400	Expense	INR	2	42	42	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
2427	Expense - Transportation	200	Expense	INR	2	42	42	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
2428	Expense - Food & Dining	200	Expense	INR	1	42	42	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
2429	Expense - Entertainment	400	Expense	INR	5	42	42	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
2430	Expense - Entertainment	200	Expense	INR	5	42	42	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
2431	Expense - Transportation	200	Expense	INR	2	42	42	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
2432	Expense - Entertainment	200	Expense	INR	5	42	42	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
2433	Expense - Food & Dining	500	Expense	INR	1	42	42	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
2434	Expense - Education	200	Expense	INR	8	42	42	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
2435	Expense - Transportation	200	Expense	INR	2	42	42	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
2436	Expense - Education	200	Expense	INR	8	42	42	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
2437	Expense - Miscellaneous	200	Expense	INR	10	42	42	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
2438	Expense - Food & Dining	700	Expense	INR	1	42	42	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
2439	Expense - Entertainment	200	Expense	INR	5	42	42	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
2440	Expense - Travel	200	Expense	INR	6	42	42	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
2441	Expense - Education	200	Expense	INR	8	42	42	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
2442	Expense - Food & Dining	2100	Expense	INR	1	42	42	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
2443	Expense - Transportation	400	Expense	INR	2	42	42	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
2444	Expense - Housing	2200	Expense	INR	3	42	42	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
2445	Expense - Education	200	Expense	INR	8	42	42	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
2446	Expense - Education	200	Expense	INR	8	42	42	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
2447	Expense - Utilities	800	Expense	INR	9	42	42	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
2448	Expense - Education	200	Expense	INR	8	43	43	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
2449	Expense - Food & Dining	800	Expense	INR	1	43	43	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
2450	Expense - Education	200	Expense	INR	8	43	43	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
2451	Expense - Education	200	Expense	INR	8	43	43	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
2452	Expense - Travel	300	Expense	INR	6	43	43	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
2453	Expense - Miscellaneous	200	Expense	INR	10	43	43	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
2454	Expense - Shopping	800	Expense	INR	7	43	43	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
2455	Expense - Shopping	200	Expense	INR	7	43	43	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
2456	Expense - Housing	700	Expense	INR	3	43	43	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
2457	Expense - Miscellaneous	200	Expense	INR	10	43	43	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
2458	Expense - Food & Dining	700	Expense	INR	1	43	43	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
2459	Expense - Miscellaneous	200	Expense	INR	10	43	43	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
2460	Expense - Entertainment	200	Expense	INR	5	43	43	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
2461	Expense - Miscellaneous	200	Expense	INR	10	43	43	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
2462	Expense - Education	200	Expense	INR	8	43	43	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
2463	Expense - Transportation	200	Expense	INR	2	43	43	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
2464	Expense - Miscellaneous	200	Expense	INR	10	43	43	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
2465	Expense - Food & Dining	700	Expense	INR	1	43	43	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
2466	Expense - Transportation	400	Expense	INR	2	43	43	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
2467	Expense - Utilities	300	Expense	INR	9	43	43	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
2468	Expense - Food & Dining	200	Expense	INR	1	43	43	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
2998	Salary Income	12500	Income	INR	11	13	13	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
2469	Expense - Travel	200	Expense	INR	6	43	43	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
2470	Expense - Healthcare	200	Expense	INR	4	43	43	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
2471	Expense - Miscellaneous	200	Expense	INR	10	43	43	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
2472	Expense - Shopping	400	Expense	INR	7	43	43	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
2473	Expense - Entertainment	400	Expense	INR	5	43	43	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
2474	Expense - Healthcare	500	Expense	INR	4	43	43	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
2475	Expense - Education	200	Expense	INR	8	43	43	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
2476	Expense - Transportation	200	Expense	INR	2	43	43	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
2477	Expense - Entertainment	200	Expense	INR	5	43	43	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
2478	Expense - Travel	200	Expense	INR	6	43	43	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
2479	Expense - Housing	600	Expense	INR	3	43	43	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
2480	Expense - Shopping	200	Expense	INR	7	43	43	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
2481	Expense - Utilities	200	Expense	INR	9	43	43	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
2482	Expense - Education	200	Expense	INR	8	43	43	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
2483	Expense - Food & Dining	500	Expense	INR	1	43	43	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
2484	Expense - Food & Dining	1700	Expense	INR	1	43	43	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
2485	Expense - Miscellaneous	200	Expense	INR	10	43	43	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
2486	Expense - Travel	200	Expense	INR	6	43	43	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
2487	Expense - Utilities	200	Expense	INR	9	43	43	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
2488	Expense - Food & Dining	600	Expense	INR	1	43	43	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
2489	Expense - Shopping	200	Expense	INR	7	43	43	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
2490	Expense - Food & Dining	200	Expense	INR	1	43	43	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
2491	Expense - Transportation	300	Expense	INR	2	43	43	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
2492	Expense - Food & Dining	200	Expense	INR	1	43	43	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
2493	Expense - Education	200	Expense	INR	8	43	43	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
2494	Expense - Housing	900	Expense	INR	3	43	43	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
2495	Expense - Shopping	800	Expense	INR	7	43	43	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
2496	Expense - Education	200	Expense	INR	8	43	43	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
2497	Expense - Education	200	Expense	INR	8	43	43	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
2498	Expense - Food & Dining	1100	Expense	INR	1	43	43	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
2499	Expense - Education	200	Expense	INR	8	43	43	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
2500	Expense - Utilities	200	Expense	INR	9	43	43	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
2501	Expense - Utilities	200	Expense	INR	9	43	43	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
2502	Expense - Travel	200	Expense	INR	6	43	43	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
2503	Expense - Healthcare	200	Expense	INR	4	43	43	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
2504	Expense - Healthcare	200	Expense	INR	4	43	43	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
2505	Expense - Food & Dining	700	Expense	INR	1	43	43	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
2506	Expense - Travel	200	Expense	INR	6	43	43	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
2507	Expense - Food & Dining	400	Expense	INR	1	43	43	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
2508	Expense - Entertainment	200	Expense	INR	5	43	43	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
2509	Expense - Utilities	200	Expense	INR	9	44	44	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
2510	Expense - Food & Dining	400	Expense	INR	1	44	44	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
2511	Expense - Transportation	200	Expense	INR	2	44	44	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
2512	Expense - Transportation	200	Expense	INR	2	44	44	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
2513	Expense - Housing	2200	Expense	INR	3	44	44	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
2514	Expense - Education	200	Expense	INR	8	44	44	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
2515	Expense - Travel	200	Expense	INR	6	44	44	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
2516	Expense - Utilities	200	Expense	INR	9	44	44	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
2517	Expense - Miscellaneous	200	Expense	INR	10	44	44	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
2518	Expense - Travel	200	Expense	INR	6	44	44	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
2519	Expense - Housing	200	Expense	INR	3	44	44	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
2520	Expense - Travel	200	Expense	INR	6	44	44	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
2521	Expense - Healthcare	200	Expense	INR	4	44	44	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
2522	Expense - Education	200	Expense	INR	8	44	44	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
2523	Expense - Food & Dining	500	Expense	INR	1	44	44	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
2524	Expense - Healthcare	200	Expense	INR	4	44	44	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
2525	Expense - Miscellaneous	200	Expense	INR	10	44	44	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
2526	Expense - Housing	300	Expense	INR	3	44	44	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
2527	Expense - Travel	200	Expense	INR	6	44	44	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
2528	Expense - Entertainment	200	Expense	INR	5	44	44	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
2529	Expense - Food & Dining	500	Expense	INR	1	44	44	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
2530	Expense - Healthcare	200	Expense	INR	4	44	44	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
2531	Expense - Housing	1000	Expense	INR	3	44	44	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
2532	Expense - Miscellaneous	200	Expense	INR	10	44	44	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
2533	Expense - Shopping	200	Expense	INR	7	44	44	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
2534	Expense - Entertainment	200	Expense	INR	5	44	44	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
2535	Expense - Travel	200	Expense	INR	6	44	44	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
2536	Expense - Entertainment	200	Expense	INR	5	44	44	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
2537	Expense - Food & Dining	200	Expense	INR	1	44	44	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
2538	Expense - Transportation	600	Expense	INR	2	44	44	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
2539	Expense - Education	200	Expense	INR	8	44	44	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
2540	Expense - Entertainment	200	Expense	INR	5	44	44	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
2541	Expense - Transportation	400	Expense	INR	2	44	44	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
2542	Expense - Miscellaneous	200	Expense	INR	10	44	44	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
2543	Expense - Shopping	200	Expense	INR	7	44	44	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
2544	Expense - Utilities	300	Expense	INR	9	44	44	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
2545	Expense - Food & Dining	200	Expense	INR	1	44	44	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
2546	Expense - Food & Dining	700	Expense	INR	1	44	44	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
2547	Expense - Utilities	300	Expense	INR	9	44	44	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
2548	Expense - Transportation	300	Expense	INR	2	44	44	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
2549	Expense - Education	200	Expense	INR	8	44	44	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
2550	Expense - Travel	200	Expense	INR	6	44	44	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
2551	Expense - Entertainment	200	Expense	INR	5	44	44	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
2552	Expense - Travel	200	Expense	INR	6	44	44	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
2553	Expense - Utilities	400	Expense	INR	9	44	44	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
2554	Expense - Housing	500	Expense	INR	3	44	44	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
2555	Expense - Transportation	200	Expense	INR	2	44	44	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
2556	Expense - Housing	900	Expense	INR	3	44	44	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
2557	Expense - Transportation	700	Expense	INR	2	44	44	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
2558	Expense - Food & Dining	2000	Expense	INR	1	44	44	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
2559	Expense - Food & Dining	700	Expense	INR	1	44	44	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
2560	Expense - Healthcare	600	Expense	INR	4	44	44	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
2561	Expense - Utilities	200	Expense	INR	9	45	45	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
2562	Expense - Utilities	200	Expense	INR	9	45	45	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
2563	Expense - Utilities	200	Expense	INR	9	45	45	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
2564	Expense - Housing	500	Expense	INR	3	45	45	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
2565	Expense - Transportation	200	Expense	INR	2	45	45	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
2566	Expense - Travel	200	Expense	INR	6	45	45	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
2567	Expense - Transportation	200	Expense	INR	2	45	45	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
2568	Expense - Utilities	200	Expense	INR	9	45	45	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
2569	Expense - Transportation	200	Expense	INR	2	45	45	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
2570	Expense - Education	200	Expense	INR	8	45	45	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
2571	Expense - Food & Dining	200	Expense	INR	1	45	45	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
2572	Expense - Entertainment	200	Expense	INR	5	45	45	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
2573	Expense - Education	200	Expense	INR	8	45	45	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
2574	Expense - Food & Dining	900	Expense	INR	1	45	45	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
2575	Expense - Entertainment	200	Expense	INR	5	45	45	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
2576	Expense - Transportation	200	Expense	INR	2	45	45	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
2577	Expense - Miscellaneous	200	Expense	INR	10	45	45	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
2578	Expense - Entertainment	200	Expense	INR	5	45	45	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
2579	Expense - Food & Dining	400	Expense	INR	1	45	45	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
2580	Expense - Housing	200	Expense	INR	3	45	45	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
2581	Expense - Housing	800	Expense	INR	3	45	45	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
2582	Expense - Housing	200	Expense	INR	3	45	45	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
2583	Expense - Entertainment	200	Expense	INR	5	45	45	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
2584	Expense - Transportation	200	Expense	INR	2	45	45	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
2585	Expense - Food & Dining	300	Expense	INR	1	45	45	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
2586	Expense - Housing	200	Expense	INR	3	45	45	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
2587	Expense - Travel	200	Expense	INR	6	45	45	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
2588	Expense - Miscellaneous	200	Expense	INR	10	45	45	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
2589	Expense - Travel	200	Expense	INR	6	45	45	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
2590	Expense - Travel	200	Expense	INR	6	45	45	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
2591	Expense - Utilities	200	Expense	INR	9	45	45	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
2592	Expense - Transportation	200	Expense	INR	2	45	45	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
2593	Expense - Food & Dining	1100	Expense	INR	1	45	45	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
2594	Expense - Housing	300	Expense	INR	3	45	45	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
2595	Expense - Travel	200	Expense	INR	6	45	45	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
2596	Expense - Transportation	300	Expense	INR	2	45	45	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
2597	Expense - Food & Dining	200	Expense	INR	1	45	45	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
2598	Expense - Entertainment	200	Expense	INR	5	45	45	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
2599	Expense - Housing	600	Expense	INR	3	45	45	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
2600	Expense - Travel	300	Expense	INR	6	45	45	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
2601	Expense - Housing	800	Expense	INR	3	45	45	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
2602	Expense - Travel	200	Expense	INR	6	45	45	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
2603	Expense - Education	200	Expense	INR	8	45	45	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
2604	Expense - Healthcare	200	Expense	INR	4	45	45	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
2605	Expense - Travel	200	Expense	INR	6	45	45	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
2606	Expense - Utilities	200	Expense	INR	9	45	45	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
2607	Expense - Travel	200	Expense	INR	6	45	45	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
2608	Expense - Education	200	Expense	INR	8	45	45	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
2609	Expense - Entertainment	200	Expense	INR	5	45	45	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
2610	Expense - Transportation	200	Expense	INR	2	45	45	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
2611	Expense - Education	200	Expense	INR	8	45	45	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
2612	Expense - Entertainment	200	Expense	INR	5	45	45	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
2613	Expense - Food & Dining	200	Expense	INR	1	45	45	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
2614	Expense - Miscellaneous	200	Expense	INR	10	45	45	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
2615	Expense - Food & Dining	1500	Expense	INR	1	45	45	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
2616	Expense - Miscellaneous	200	Expense	INR	10	45	45	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
2617	Expense - Miscellaneous	200	Expense	INR	10	45	45	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
2618	Expense - Utilities	200	Expense	INR	9	45	45	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
2619	Expense - Education	200	Expense	INR	8	45	45	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
2620	Expense - Travel	200	Expense	INR	6	45	45	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
2621	Expense - Utilities	200	Expense	INR	9	45	45	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
2622	Expense - Entertainment	200	Expense	INR	5	45	45	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
2623	Expense - Miscellaneous	200	Expense	INR	10	45	45	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
2624	Expense - Healthcare	200	Expense	INR	4	45	45	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
2625	Expense - Transportation	200	Expense	INR	2	45	45	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
2626	Expense - Food & Dining	2000	Expense	INR	1	45	45	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
2627	Expense - Travel	200	Expense	INR	6	45	45	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
2628	Expense - Shopping	500	Expense	INR	7	45	45	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
2629	Expense - Miscellaneous	200	Expense	INR	10	45	45	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
2630	Expense - Miscellaneous	200	Expense	INR	10	45	45	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
2631	Expense - Shopping	200	Expense	INR	7	45	45	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
2632	Expense - Education	400	Expense	INR	8	45	45	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
2633	Expense - Food & Dining	200	Expense	INR	1	45	45	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
2634	Expense - Healthcare	200	Expense	INR	4	45	45	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
2635	Expense - Food & Dining	200	Expense	INR	1	45	45	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
2636	Expense - Healthcare	200	Expense	INR	4	45	45	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
2637	Expense - Shopping	200	Expense	INR	7	45	45	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
2638	Expense - Utilities	200	Expense	INR	9	46	46	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
2639	Expense - Food & Dining	400	Expense	INR	1	46	46	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
2640	Expense - Housing	200	Expense	INR	3	46	46	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
2641	Expense - Entertainment	200	Expense	INR	5	46	46	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
2642	Expense - Food & Dining	200	Expense	INR	1	46	46	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
2643	Expense - Utilities	200	Expense	INR	9	46	46	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
2644	Expense - Entertainment	200	Expense	INR	5	46	46	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
2645	Expense - Food & Dining	200	Expense	INR	1	46	46	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
2646	Expense - Miscellaneous	200	Expense	INR	10	46	46	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
2647	Expense - Healthcare	200	Expense	INR	4	46	46	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
2648	Expense - Transportation	400	Expense	INR	2	46	46	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
2649	Expense - Miscellaneous	200	Expense	INR	10	46	46	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
2650	Expense - Entertainment	200	Expense	INR	5	46	46	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
2651	Expense - Shopping	200	Expense	INR	7	46	46	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
2652	Expense - Shopping	200	Expense	INR	7	46	46	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
2653	Expense - Travel	200	Expense	INR	6	46	46	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
2654	Expense - Travel	200	Expense	INR	6	46	46	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
2655	Expense - Transportation	200	Expense	INR	2	46	46	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
2656	Expense - Shopping	400	Expense	INR	7	46	46	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
2657	Expense - Utilities	200	Expense	INR	9	46	46	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
2658	Expense - Healthcare	200	Expense	INR	4	46	46	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
2659	Expense - Travel	200	Expense	INR	6	46	46	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
2660	Expense - Housing	200	Expense	INR	3	46	46	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
2661	Expense - Travel	200	Expense	INR	6	46	46	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
2662	Expense - Miscellaneous	200	Expense	INR	10	46	46	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
2663	Expense - Utilities	200	Expense	INR	9	46	46	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
2664	Expense - Shopping	200	Expense	INR	7	46	46	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
2665	Expense - Shopping	200	Expense	INR	7	46	46	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
2666	Expense - Entertainment	200	Expense	INR	5	46	46	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
2667	Expense - Education	200	Expense	INR	8	46	46	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
2668	Expense - Transportation	200	Expense	INR	2	46	46	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
2669	Expense - Housing	500	Expense	INR	3	46	46	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
2670	Expense - Utilities	200	Expense	INR	9	46	46	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
2671	Expense - Education	200	Expense	INR	8	46	46	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
2672	Expense - Education	200	Expense	INR	8	46	46	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
2673	Expense - Education	200	Expense	INR	8	46	46	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
2674	Expense - Food & Dining	200	Expense	INR	1	46	46	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
2675	Expense - Healthcare	200	Expense	INR	4	46	46	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
2676	Expense - Travel	200	Expense	INR	6	46	46	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
2677	Expense - Entertainment	200	Expense	INR	5	46	46	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
2678	Expense - Shopping	200	Expense	INR	7	46	46	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
2679	Expense - Utilities	200	Expense	INR	9	46	46	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
2680	Expense - Travel	200	Expense	INR	6	46	46	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
2681	Expense - Education	200	Expense	INR	8	46	46	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
2682	Expense - Shopping	200	Expense	INR	7	46	46	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
2683	Expense - Housing	600	Expense	INR	3	46	46	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
2684	Expense - Entertainment	200	Expense	INR	5	46	46	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
2685	Expense - Miscellaneous	200	Expense	INR	10	46	46	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
2686	Expense - Healthcare	200	Expense	INR	4	46	46	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
2687	Expense - Food & Dining	200	Expense	INR	1	46	46	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
2688	Expense - Housing	400	Expense	INR	3	46	46	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
2689	Expense - Education	200	Expense	INR	8	46	46	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
2690	Expense - Transportation	200	Expense	INR	2	46	46	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
2691	Expense - Healthcare	200	Expense	INR	4	46	46	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
2692	Expense - Healthcare	200	Expense	INR	4	46	46	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
2693	Expense - Food & Dining	500	Expense	INR	1	46	46	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
2694	Expense - Education	400	Expense	INR	8	46	46	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
2695	Expense - Housing	400	Expense	INR	3	46	46	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
2696	Expense - Shopping	200	Expense	INR	7	46	46	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
2697	Expense - Entertainment	200	Expense	INR	5	46	46	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
2698	Expense - Miscellaneous	200	Expense	INR	10	46	46	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
2699	Expense - Transportation	500	Expense	INR	2	46	46	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
2700	Expense - Shopping	200	Expense	INR	7	46	46	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
2701	Expense - Transportation	200	Expense	INR	2	46	46	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
2702	Expense - Healthcare	200	Expense	INR	4	46	46	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
2703	Expense - Utilities	200	Expense	INR	9	46	46	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
2704	Expense - Housing	1000	Expense	INR	3	46	46	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
2705	Expense - Transportation	200	Expense	INR	2	47	47	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
2706	Expense - Entertainment	200	Expense	INR	5	47	47	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
2707	Expense - Housing	200	Expense	INR	3	47	47	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
2708	Expense - Transportation	200	Expense	INR	2	47	47	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
2709	Expense - Education	200	Expense	INR	8	47	47	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
2710	Expense - Healthcare	200	Expense	INR	4	47	47	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
2711	Expense - Miscellaneous	200	Expense	INR	10	47	47	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
2712	Expense - Utilities	300	Expense	INR	9	47	47	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
2713	Expense - Food & Dining	400	Expense	INR	1	47	47	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
2714	Expense - Education	200	Expense	INR	8	47	47	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
2715	Expense - Utilities	200	Expense	INR	9	47	47	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
2716	Expense - Miscellaneous	200	Expense	INR	10	47	47	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
2717	Expense - Healthcare	200	Expense	INR	4	47	47	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
2718	Expense - Transportation	200	Expense	INR	2	47	47	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
2719	Expense - Travel	200	Expense	INR	6	47	47	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
2720	Expense - Shopping	200	Expense	INR	7	47	47	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
2721	Expense - Transportation	200	Expense	INR	2	47	47	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
2722	Expense - Entertainment	200	Expense	INR	5	47	47	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
2723	Expense - Shopping	200	Expense	INR	7	47	47	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
2724	Expense - Shopping	200	Expense	INR	7	47	47	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
2725	Expense - Miscellaneous	200	Expense	INR	10	47	47	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
2726	Expense - Travel	200	Expense	INR	6	47	47	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
2727	Expense - Travel	200	Expense	INR	6	47	47	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
2728	Expense - Shopping	200	Expense	INR	7	47	47	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
2729	Expense - Transportation	200	Expense	INR	2	47	47	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
2730	Expense - Education	200	Expense	INR	8	47	47	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
2731	Expense - Transportation	400	Expense	INR	2	47	47	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
2732	Expense - Shopping	200	Expense	INR	7	47	47	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
2733	Expense - Utilities	200	Expense	INR	9	47	47	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
2734	Expense - Healthcare	200	Expense	INR	4	47	47	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
2735	Expense - Miscellaneous	200	Expense	INR	10	47	47	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
2736	Expense - Housing	400	Expense	INR	3	47	47	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
2737	Expense - Transportation	200	Expense	INR	2	47	47	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
2738	Expense - Miscellaneous	200	Expense	INR	10	47	47	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
2739	Expense - Utilities	400	Expense	INR	9	47	47	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
2740	Expense - Healthcare	200	Expense	INR	4	47	47	2025-11-03 00:00:00	2025-12-03 20:23:56.23761	\N
2741	Expense - Shopping	300	Expense	INR	7	47	47	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
2742	Expense - Travel	200	Expense	INR	6	47	47	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
2743	Expense - Utilities	200	Expense	INR	9	47	47	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
2744	Expense - Housing	200	Expense	INR	3	47	47	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
2745	Expense - Food & Dining	200	Expense	INR	1	47	47	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
2746	Expense - Transportation	200	Expense	INR	2	47	47	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
2747	Expense - Utilities	200	Expense	INR	9	47	47	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
2748	Expense - Entertainment	200	Expense	INR	5	47	47	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
2749	Expense - Entertainment	200	Expense	INR	5	47	47	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
2750	Expense - Travel	200	Expense	INR	6	47	47	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
2751	Expense - Entertainment	200	Expense	INR	5	47	47	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
2752	Expense - Food & Dining	200	Expense	INR	1	47	47	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
2753	Expense - Utilities	200	Expense	INR	9	47	47	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
2754	Expense - Entertainment	200	Expense	INR	5	47	47	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
2755	Expense - Entertainment	200	Expense	INR	5	47	47	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
2756	Expense - Utilities	200	Expense	INR	9	47	47	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
2757	Expense - Miscellaneous	200	Expense	INR	10	47	47	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
2758	Expense - Food & Dining	300	Expense	INR	1	47	47	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
2759	Expense - Healthcare	200	Expense	INR	4	47	47	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
2760	Expense - Transportation	200	Expense	INR	2	47	47	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
2761	Expense - Transportation	200	Expense	INR	2	47	47	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
2762	Expense - Utilities	200	Expense	INR	9	47	47	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
2763	Expense - Transportation	400	Expense	INR	2	47	47	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
2764	Expense - Healthcare	200	Expense	INR	4	47	47	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
2765	Expense - Utilities	200	Expense	INR	9	47	47	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
2766	Expense - Housing	300	Expense	INR	3	47	47	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
2767	Expense - Miscellaneous	200	Expense	INR	10	47	47	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
2768	Expense - Transportation	300	Expense	INR	2	47	47	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
2769	Expense - Entertainment	200	Expense	INR	5	47	47	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
2770	Expense - Travel	200	Expense	INR	6	47	47	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
2771	Expense - Education	200	Expense	INR	8	47	47	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
2772	Expense - Miscellaneous	200	Expense	INR	10	47	47	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
2773	Expense - Entertainment	200	Expense	INR	5	47	47	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
2774	Expense - Healthcare	200	Expense	INR	4	47	47	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
2775	Expense - Miscellaneous	200	Expense	INR	10	47	47	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
2776	Expense - Utilities	200	Expense	INR	9	47	47	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
2777	Expense - Housing	200	Expense	INR	3	47	47	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
2778	Expense - Education	200	Expense	INR	8	47	47	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
2779	Expense - Healthcare	200	Expense	INR	4	47	47	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
2780	Expense - Food & Dining	200	Expense	INR	1	47	47	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
2781	Expense - Transportation	200	Expense	INR	2	47	47	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
2782	Expense - Education	200	Expense	INR	8	47	47	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
2783	Expense - Shopping	200	Expense	INR	7	47	47	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
2784	Expense - Miscellaneous	200	Expense	INR	10	47	47	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
2785	Expense - Entertainment	200	Expense	INR	5	47	47	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
2786	Expense - Housing	1100	Expense	INR	3	47	47	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
2787	Expense - Shopping	200	Expense	INR	7	47	47	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
2788	Expense - Travel	200	Expense	INR	6	48	48	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
2789	Expense - Healthcare	200	Expense	INR	4	48	48	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
2790	Expense - Miscellaneous	200	Expense	INR	10	48	48	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
2791	Expense - Entertainment	200	Expense	INR	5	48	48	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
2792	Expense - Healthcare	200	Expense	INR	4	48	48	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
2793	Expense - Transportation	200	Expense	INR	2	48	48	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
2794	Expense - Travel	200	Expense	INR	6	48	48	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
2795	Expense - Entertainment	200	Expense	INR	5	48	48	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
2796	Expense - Travel	200	Expense	INR	6	48	48	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
2797	Expense - Food & Dining	1500	Expense	INR	1	48	48	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
2798	Expense - Travel	200	Expense	INR	6	48	48	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
2799	Expense - Miscellaneous	200	Expense	INR	10	48	48	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
2800	Expense - Education	200	Expense	INR	8	48	48	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
2801	Expense - Housing	900	Expense	INR	3	48	48	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
2802	Expense - Housing	2800	Expense	INR	3	48	48	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
2803	Expense - Food & Dining	800	Expense	INR	1	48	48	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
2804	Expense - Miscellaneous	200	Expense	INR	10	48	48	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
2805	Expense - Entertainment	200	Expense	INR	5	48	48	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
2806	Expense - Housing	2200	Expense	INR	3	48	48	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
2807	Expense - Transportation	400	Expense	INR	2	48	48	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
2808	Expense - Food & Dining	1500	Expense	INR	1	48	48	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
2809	Expense - Housing	300	Expense	INR	3	48	48	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
2810	Expense - Travel	200	Expense	INR	6	48	48	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
2811	Expense - Food & Dining	700	Expense	INR	1	48	48	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
2812	Expense - Education	200	Expense	INR	8	48	48	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
2813	Expense - Miscellaneous	200	Expense	INR	10	48	48	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
2814	Expense - Utilities	200	Expense	INR	9	48	48	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
2815	Expense - Food & Dining	300	Expense	INR	1	48	48	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
2816	Expense - Shopping	300	Expense	INR	7	48	48	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
2817	Expense - Utilities	200	Expense	INR	9	48	48	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
2818	Expense - Transportation	200	Expense	INR	2	48	48	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
2819	Expense - Travel	200	Expense	INR	6	48	48	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
2820	Expense - Entertainment	200	Expense	INR	5	48	48	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
2821	Expense - Food & Dining	300	Expense	INR	1	48	48	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
2822	Expense - Entertainment	200	Expense	INR	5	48	48	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
2823	Expense - Miscellaneous	200	Expense	INR	10	48	48	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
2824	Expense - Housing	2800	Expense	INR	3	48	48	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
2825	Expense - Education	500	Expense	INR	8	48	48	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
2826	Expense - Miscellaneous	200	Expense	INR	10	48	48	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
2827	Expense - Utilities	300	Expense	INR	9	48	48	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
2828	Expense - Utilities	200	Expense	INR	9	48	48	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
2829	Expense - Education	300	Expense	INR	8	48	48	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
2830	Expense - Healthcare	200	Expense	INR	4	48	48	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
2831	Expense - Transportation	200	Expense	INR	2	48	48	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
2832	Expense - Shopping	800	Expense	INR	7	48	48	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
2833	Expense - Healthcare	200	Expense	INR	4	48	48	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
2834	Expense - Shopping	200	Expense	INR	7	48	48	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
2835	Expense - Housing	1000	Expense	INR	3	48	48	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
2836	Expense - Healthcare	200	Expense	INR	4	48	48	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
2837	Expense - Utilities	500	Expense	INR	9	48	48	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
2838	Expense - Miscellaneous	200	Expense	INR	10	48	48	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
2839	Expense - Shopping	200	Expense	INR	7	48	48	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
2840	Expense - Healthcare	200	Expense	INR	4	48	48	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
2841	Expense - Housing	200	Expense	INR	3	48	48	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
2842	Expense - Entertainment	400	Expense	INR	5	48	48	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
2843	Expense - Education	200	Expense	INR	8	48	48	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
2844	Expense - Travel	200	Expense	INR	6	48	48	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
2845	Expense - Healthcare	200	Expense	INR	4	48	48	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
2846	Expense - Healthcare	200	Expense	INR	4	48	48	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
2847	Expense - Shopping	200	Expense	INR	7	48	48	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
2848	Expense - Transportation	200	Expense	INR	2	48	48	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
2849	Expense - Housing	400	Expense	INR	3	48	48	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
2850	Expense - Healthcare	200	Expense	INR	4	48	48	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
2851	Expense - Entertainment	500	Expense	INR	5	48	48	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
2852	Expense - Shopping	200	Expense	INR	7	49	49	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
2853	Expense - Food & Dining	200	Expense	INR	1	49	49	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
2854	Expense - Miscellaneous	200	Expense	INR	10	49	49	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
2855	Expense - Food & Dining	600	Expense	INR	1	49	49	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
2856	Expense - Education	200	Expense	INR	8	49	49	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
2857	Expense - Education	200	Expense	INR	8	49	49	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
2858	Expense - Entertainment	200	Expense	INR	5	49	49	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
2859	Expense - Utilities	200	Expense	INR	9	49	49	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
2860	Expense - Food & Dining	200	Expense	INR	1	49	49	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
2861	Expense - Entertainment	200	Expense	INR	5	49	49	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
2862	Expense - Food & Dining	200	Expense	INR	1	49	49	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
2863	Expense - Entertainment	200	Expense	INR	5	49	49	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
2864	Expense - Miscellaneous	200	Expense	INR	10	49	49	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
2865	Expense - Miscellaneous	200	Expense	INR	10	49	49	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
2866	Expense - Shopping	200	Expense	INR	7	49	49	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
2867	Expense - Miscellaneous	200	Expense	INR	10	49	49	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
2868	Expense - Housing	400	Expense	INR	3	49	49	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
2869	Expense - Transportation	200	Expense	INR	2	49	49	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
2870	Expense - Travel	200	Expense	INR	6	49	49	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
2871	Expense - Shopping	200	Expense	INR	7	49	49	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
2872	Expense - Housing	500	Expense	INR	3	49	49	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
2873	Expense - Housing	200	Expense	INR	3	49	49	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
2874	Expense - Entertainment	200	Expense	INR	5	49	49	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
2875	Expense - Travel	200	Expense	INR	6	49	49	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
2876	Expense - Utilities	200	Expense	INR	9	49	49	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
2877	Expense - Entertainment	200	Expense	INR	5	49	49	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
2878	Expense - Education	200	Expense	INR	8	49	49	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
2879	Expense - Food & Dining	200	Expense	INR	1	49	49	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
2880	Expense - Education	200	Expense	INR	8	49	49	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
2881	Expense - Entertainment	200	Expense	INR	5	49	49	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
2882	Expense - Utilities	200	Expense	INR	9	49	49	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
2883	Expense - Utilities	600	Expense	INR	9	49	49	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
2884	Expense - Miscellaneous	200	Expense	INR	10	49	49	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
2885	Expense - Food & Dining	200	Expense	INR	1	49	49	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
2886	Expense - Shopping	200	Expense	INR	7	49	49	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
2887	Expense - Shopping	200	Expense	INR	7	49	49	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
2888	Expense - Shopping	200	Expense	INR	7	49	49	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
2889	Expense - Education	200	Expense	INR	8	49	49	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
2890	Expense - Food & Dining	700	Expense	INR	1	49	49	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
2891	Expense - Healthcare	200	Expense	INR	4	49	49	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
2892	Expense - Miscellaneous	200	Expense	INR	10	49	49	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
2893	Expense - Healthcare	200	Expense	INR	4	49	49	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
2894	Expense - Food & Dining	300	Expense	INR	1	49	49	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
2895	Expense - Housing	200	Expense	INR	3	49	49	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
2896	Expense - Healthcare	200	Expense	INR	4	49	49	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
2897	Expense - Utilities	200	Expense	INR	9	49	49	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
2898	Expense - Utilities	200	Expense	INR	9	49	49	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
2899	Expense - Utilities	200	Expense	INR	9	49	49	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
2900	Expense - Food & Dining	400	Expense	INR	1	49	49	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
2901	Expense - Utilities	200	Expense	INR	9	49	49	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
2902	Expense - Entertainment	200	Expense	INR	5	49	49	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
2903	Expense - Utilities	200	Expense	INR	9	49	49	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
2904	Expense - Food & Dining	200	Expense	INR	1	49	49	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
2905	Expense - Utilities	300	Expense	INR	9	49	49	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
2906	Expense - Food & Dining	200	Expense	INR	1	49	49	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
2907	Expense - Education	200	Expense	INR	8	49	49	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
2908	Expense - Transportation	200	Expense	INR	2	49	49	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
2909	Expense - Healthcare	200	Expense	INR	4	49	49	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
2910	Expense - Education	200	Expense	INR	8	49	49	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
2911	Expense - Education	200	Expense	INR	8	49	49	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
2912	Expense - Housing	300	Expense	INR	3	49	49	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
2913	Expense - Miscellaneous	200	Expense	INR	10	49	49	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
2914	Expense - Travel	200	Expense	INR	6	49	49	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
2915	Expense - Travel	200	Expense	INR	6	49	49	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
2916	Expense - Miscellaneous	200	Expense	INR	10	49	49	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
2917	Expense - Food & Dining	300	Expense	INR	1	49	49	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
2918	Expense - Travel	200	Expense	INR	6	49	49	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
2919	Expense - Travel	200	Expense	INR	6	49	49	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
2920	Expense - Healthcare	200	Expense	INR	4	49	49	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
2921	Expense - Education	200	Expense	INR	8	49	49	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
2922	Expense - Utilities	200	Expense	INR	9	49	49	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
2923	Salary Income	18100	Income	INR	11	1	1	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
2924	Salary Income	19400	Income	INR	11	1	1	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
2925	Salary Income	13000	Income	INR	11	1	1	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
2926	Salary Income	12900	Income	INR	11	1	1	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
2927	Salary Income	12800	Income	INR	11	1	1	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
2928	Salary Income	19500	Income	INR	11	1	1	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
2929	Salary Income	18500	Income	INR	11	1	1	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
2930	Salary Income	16400	Income	INR	11	2	2	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
2931	Salary Income	16100	Income	INR	11	2	2	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
2932	Salary Income	17300	Income	INR	11	2	2	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
2933	Salary Income	17300	Income	INR	11	2	2	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
2934	Salary Income	16100	Income	INR	11	2	2	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
2935	Salary Income	16500	Income	INR	11	2	2	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
2936	Salary Income	24300	Income	INR	11	2	2	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
2937	Salary Income	25700	Income	INR	11	2	2	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
2938	Salary Income	8600	Income	INR	11	3	3	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
2939	Salary Income	8600	Income	INR	11	3	3	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
2940	Salary Income	8200	Income	INR	11	3	3	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
2941	Salary Income	24400	Income	INR	11	3	3	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
2942	Salary Income	12400	Income	INR	11	3	3	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
2943	Salary Income	12200	Income	INR	11	3	3	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
2944	Salary Income	36100	Income	INR	11	4	4	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
2945	Salary Income	12400	Income	INR	11	4	4	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
2946	Salary Income	12500	Income	INR	11	4	4	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
2947	Salary Income	12900	Income	INR	11	4	4	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
2948	Salary Income	18600	Income	INR	11	4	4	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
2949	Salary Income	18800	Income	INR	11	4	4	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
2950	Salary Income	36300	Income	INR	11	5	5	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
2951	Salary Income	12100	Income	INR	11	5	5	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
2952	Salary Income	12700	Income	INR	11	5	5	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
2953	Salary Income	12900	Income	INR	11	5	5	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
2954	Salary Income	36300	Income	INR	11	5	5	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
2955	Salary Income	8000	Income	INR	11	6	6	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
2956	Salary Income	8500	Income	INR	11	6	6	2025-09-30 00:00:00	2025-12-03 20:23:56.23761	\N
2957	Salary Income	8400	Income	INR	11	6	6	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
2958	Salary Income	8100	Income	INR	11	6	6	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
2959	Salary Income	8400	Income	INR	11	6	6	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
2960	Salary Income	8200	Income	INR	11	6	6	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
2961	Salary Income	24100	Income	INR	11	6	6	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
2962	Salary Income	37500	Income	INR	11	7	7	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
2963	Salary Income	38200	Income	INR	11	7	7	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
2964	Salary Income	19200	Income	INR	11	7	7	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
2965	Salary Income	18600	Income	INR	11	7	7	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
2966	Salary Income	48900	Income	INR	11	8	8	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
2967	Salary Income	50200	Income	INR	11	8	8	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
2968	Salary Income	50700	Income	INR	11	8	8	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
2969	Salary Income	12100	Income	INR	11	9	9	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
2970	Salary Income	12400	Income	INR	11	9	9	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
2971	Salary Income	12100	Income	INR	11	9	9	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
2972	Salary Income	12000	Income	INR	11	9	9	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
2973	Salary Income	12200	Income	INR	11	9	9	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
2974	Salary Income	12200	Income	INR	11	9	9	2025-10-28 00:00:00	2025-12-03 20:23:56.23761	\N
2975	Salary Income	12900	Income	INR	11	9	9	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
2976	Salary Income	12600	Income	INR	11	9	9	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
2977	Salary Income	12600	Income	INR	11	9	9	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
2978	Salary Income	25000	Income	INR	11	10	10	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
2979	Salary Income	24400	Income	INR	11	10	10	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
2980	Salary Income	8100	Income	INR	11	10	10	2025-11-24 00:00:00	2025-12-03 20:23:56.23761	\N
2981	Salary Income	8100	Income	INR	11	10	10	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
2982	Salary Income	8200	Income	INR	11	10	10	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
2983	Salary Income	19100	Income	INR	11	11	11	2025-09-26 00:00:00	2025-12-03 20:23:56.23761	\N
2984	Salary Income	18600	Income	INR	11	11	11	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
2985	Salary Income	12400	Income	INR	11	11	11	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
2986	Salary Income	12900	Income	INR	11	11	11	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
2987	Salary Income	12400	Income	INR	11	11	11	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
2988	Salary Income	12500	Income	INR	11	11	11	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
2989	Salary Income	12300	Income	INR	11	11	11	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
2990	Salary Income	12200	Income	INR	11	11	11	2025-11-25 00:00:00	2025-12-03 20:23:56.23761	\N
2991	Salary Income	25900	Income	INR	11	12	12	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
2992	Salary Income	8100	Income	INR	11	12	12	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
2993	Salary Income	8400	Income	INR	11	12	12	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
2994	Salary Income	8500	Income	INR	11	12	12	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
2995	Salary Income	25300	Income	INR	11	12	12	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
2996	Salary Income	37800	Income	INR	11	13	13	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
2997	Salary Income	12100	Income	INR	11	13	13	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
2999	Salary Income	12200	Income	INR	11	13	13	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
3000	Salary Income	36700	Income	INR	11	13	13	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
3001	Salary Income	12700	Income	INR	11	14	14	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
3002	Salary Income	12300	Income	INR	11	14	14	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
3003	Salary Income	12900	Income	INR	11	14	14	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
3004	Salary Income	18000	Income	INR	11	14	14	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
3005	Salary Income	19300	Income	INR	11	14	14	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
3006	Salary Income	38400	Income	INR	11	14	14	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
3007	Salary Income	25600	Income	INR	11	15	15	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
3008	Salary Income	25500	Income	INR	11	15	15	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
3009	Salary Income	17000	Income	INR	11	15	15	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
3010	Salary Income	16100	Income	INR	11	15	15	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
3011	Salary Income	16500	Income	INR	11	15	15	2025-10-10 00:00:00	2025-12-03 20:23:56.23761	\N
3012	Salary Income	50200	Income	INR	11	15	15	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
3013	Salary Income	25800	Income	INR	11	16	16	2025-09-28 00:00:00	2025-12-03 20:23:56.23761	\N
3014	Salary Income	25300	Income	INR	11	16	16	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
3015	Salary Income	24800	Income	INR	11	16	16	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
3016	Salary Income	25000	Income	INR	11	16	16	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
3017	Salary Income	51000	Income	INR	11	16	16	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
3018	Salary Income	25300	Income	INR	11	17	17	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
3019	Salary Income	8200	Income	INR	11	17	17	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
3020	Salary Income	8400	Income	INR	11	17	17	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
3021	Salary Income	8400	Income	INR	11	17	17	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
3022	Salary Income	12400	Income	INR	11	17	17	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
3023	Salary Income	12700	Income	INR	11	17	17	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
3024	Salary Income	17100	Income	INR	11	18	18	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
3025	Salary Income	16200	Income	INR	11	18	18	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
3026	Salary Income	17300	Income	INR	11	18	18	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
3027	Salary Income	24200	Income	INR	11	18	18	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
3028	Salary Income	25000	Income	INR	11	18	18	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
3029	Salary Income	25800	Income	INR	11	18	18	2025-11-20 00:00:00	2025-12-03 20:23:56.23761	\N
3030	Salary Income	25100	Income	INR	11	18	18	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
3031	Salary Income	49000	Income	INR	11	19	19	2025-09-12 00:00:00	2025-12-03 20:23:56.23761	\N
3032	Salary Income	25100	Income	INR	11	19	19	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
3033	Salary Income	25500	Income	INR	11	19	19	2025-10-26 00:00:00	2025-12-03 20:23:56.23761	\N
3034	Salary Income	16500	Income	INR	11	19	19	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
3035	Salary Income	16900	Income	INR	11	19	19	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
3036	Salary Income	17200	Income	INR	11	19	19	2025-11-28 00:00:00	2025-12-03 20:23:56.23761	\N
3037	Salary Income	8100	Income	INR	11	20	20	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
3038	Salary Income	8400	Income	INR	11	20	20	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
3039	Salary Income	8400	Income	INR	11	20	20	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
3040	Salary Income	12000	Income	INR	11	20	20	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
3041	Salary Income	12700	Income	INR	11	20	20	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
3042	Salary Income	12600	Income	INR	11	20	20	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
3043	Salary Income	12700	Income	INR	11	20	20	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
3044	Salary Income	12900	Income	INR	11	21	21	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
3045	Salary Income	12900	Income	INR	11	21	21	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
3046	Salary Income	12400	Income	INR	11	21	21	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
3047	Salary Income	12800	Income	INR	11	21	21	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
3048	Salary Income	12600	Income	INR	11	21	21	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
3049	Salary Income	12500	Income	INR	11	21	21	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
3050	Salary Income	19400	Income	INR	11	21	21	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
3051	Salary Income	19400	Income	INR	11	21	21	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
3052	Salary Income	16500	Income	INR	11	22	22	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
3053	Salary Income	17000	Income	INR	11	22	22	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
3054	Salary Income	16900	Income	INR	11	22	22	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
3055	Salary Income	16900	Income	INR	11	22	22	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
3056	Salary Income	17000	Income	INR	11	22	22	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
3057	Salary Income	17000	Income	INR	11	22	22	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
3058	Salary Income	49400	Income	INR	11	22	22	2025-11-27 00:00:00	2025-12-03 20:23:56.23761	\N
3059	Salary Income	51100	Income	INR	11	23	23	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
3060	Salary Income	51000	Income	INR	11	23	23	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
3061	Salary Income	17100	Income	INR	11	23	23	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
3062	Salary Income	16400	Income	INR	11	23	23	2025-11-15 00:00:00	2025-12-03 20:23:56.23761	\N
3063	Salary Income	17200	Income	INR	11	23	23	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
3064	Salary Income	12600	Income	INR	11	24	24	2025-09-15 00:00:00	2025-12-03 20:23:56.23761	\N
3065	Salary Income	12100	Income	INR	11	24	24	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
3066	Salary Income	12700	Income	INR	11	24	24	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
3067	Salary Income	12900	Income	INR	11	24	24	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
3068	Salary Income	25300	Income	INR	11	24	24	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
3069	Salary Income	16600	Income	INR	11	25	25	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
3070	Salary Income	16000	Income	INR	11	25	25	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
3071	Salary Income	16300	Income	INR	11	25	25	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
3072	Salary Income	25200	Income	INR	11	25	25	2025-10-17 00:00:00	2025-12-03 20:23:56.23761	\N
3073	Salary Income	25200	Income	INR	11	25	25	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
3074	Salary Income	24800	Income	INR	11	25	25	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
3075	Salary Income	24000	Income	INR	11	25	25	2025-11-30 00:00:00	2025-12-03 20:23:56.23761	\N
3076	Salary Income	49800	Income	INR	11	26	26	2025-09-06 00:00:00	2025-12-03 20:23:56.23761	\N
3077	Salary Income	24700	Income	INR	11	26	26	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
3078	Salary Income	24000	Income	INR	11	26	26	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
3079	Salary Income	17000	Income	INR	11	26	26	2025-11-06 00:00:00	2025-12-03 20:23:56.23761	\N
3080	Salary Income	16600	Income	INR	11	26	26	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
3081	Salary Income	16800	Income	INR	11	26	26	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
3082	Salary Income	18700	Income	INR	11	27	27	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
3083	Salary Income	18500	Income	INR	11	27	27	2025-09-01 00:00:00	2025-12-03 20:23:56.23761	\N
3084	Salary Income	36300	Income	INR	11	27	27	2025-10-25 00:00:00	2025-12-03 20:23:56.23761	\N
3085	Salary Income	18500	Income	INR	11	27	27	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
3086	Salary Income	18100	Income	INR	11	27	27	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
3087	Salary Income	16500	Income	INR	11	28	28	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
3088	Salary Income	16100	Income	INR	11	28	28	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
3089	Salary Income	16200	Income	INR	11	28	28	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
3090	Salary Income	16700	Income	INR	11	28	28	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
3091	Salary Income	17200	Income	INR	11	28	28	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
3092	Salary Income	17100	Income	INR	11	28	28	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
3093	Salary Income	50000	Income	INR	11	28	28	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
3094	Salary Income	16300	Income	INR	11	29	29	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
3095	Salary Income	17000	Income	INR	11	29	29	2025-09-04 00:00:00	2025-12-03 20:23:56.23761	\N
3096	Salary Income	16800	Income	INR	11	29	29	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
3097	Salary Income	16800	Income	INR	11	29	29	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
3098	Salary Income	17000	Income	INR	11	29	29	2025-10-14 00:00:00	2025-12-03 20:23:56.23761	\N
3099	Salary Income	16600	Income	INR	11	29	29	2025-10-06 00:00:00	2025-12-03 20:23:56.23761	\N
3100	Salary Income	25500	Income	INR	11	29	29	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
3101	Salary Income	25900	Income	INR	11	29	29	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
3102	Salary Income	24600	Income	INR	11	30	30	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
3103	Salary Income	8400	Income	INR	11	30	30	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
3104	Salary Income	8200	Income	INR	11	30	30	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
3105	Salary Income	8300	Income	INR	11	30	30	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
3106	Salary Income	12600	Income	INR	11	30	30	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
3107	Salary Income	12900	Income	INR	11	30	30	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
3108	Salary Income	8100	Income	INR	11	31	31	2025-09-18 00:00:00	2025-12-03 20:23:56.23761	\N
3109	Salary Income	8300	Income	INR	11	31	31	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
3110	Salary Income	8500	Income	INR	11	31	31	2025-09-21 00:00:00	2025-12-03 20:23:56.23761	\N
3111	Salary Income	12600	Income	INR	11	31	31	2025-10-27 00:00:00	2025-12-03 20:23:56.23761	\N
3112	Salary Income	12900	Income	INR	11	31	31	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
3113	Salary Income	25100	Income	INR	11	31	31	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
3114	Salary Income	24800	Income	INR	11	32	32	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
3115	Salary Income	24300	Income	INR	11	32	32	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
3116	Salary Income	12700	Income	INR	11	32	32	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
3117	Salary Income	12500	Income	INR	11	32	32	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
3118	Salary Income	51900	Income	INR	11	33	33	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
3119	Salary Income	24500	Income	INR	11	33	33	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
3120	Salary Income	24400	Income	INR	11	33	33	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
3121	Salary Income	16600	Income	INR	11	33	33	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
3122	Salary Income	16000	Income	INR	11	33	33	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
3123	Salary Income	16600	Income	INR	11	33	33	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
3124	Salary Income	12600	Income	INR	11	34	34	2025-09-25 00:00:00	2025-12-03 20:23:56.23761	\N
3125	Salary Income	12800	Income	INR	11	34	34	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
3126	Salary Income	8300	Income	INR	11	34	34	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
3127	Salary Income	8000	Income	INR	11	34	34	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
3128	Salary Income	8200	Income	INR	11	34	34	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
3129	Salary Income	25900	Income	INR	11	34	34	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
3130	Salary Income	24400	Income	INR	11	35	35	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
3131	Salary Income	26000	Income	INR	11	35	35	2025-10-30 00:00:00	2025-12-03 20:23:56.23761	\N
3132	Salary Income	8400	Income	INR	11	35	35	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
3133	Salary Income	8300	Income	INR	11	35	35	2025-11-08 00:00:00	2025-12-03 20:23:56.23761	\N
3134	Salary Income	8200	Income	INR	11	35	35	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
3135	Salary Income	36700	Income	INR	11	36	36	2025-09-23 00:00:00	2025-12-03 20:23:56.23761	\N
3136	Salary Income	13000	Income	INR	11	36	36	2025-10-13 00:00:00	2025-12-03 20:23:56.23761	\N
3137	Salary Income	12600	Income	INR	11	36	36	2025-10-12 00:00:00	2025-12-03 20:23:56.23761	\N
3138	Salary Income	12800	Income	INR	11	36	36	2025-10-02 00:00:00	2025-12-03 20:23:56.23761	\N
3139	Salary Income	12600	Income	INR	11	36	36	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
3140	Salary Income	12300	Income	INR	11	36	36	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
3141	Salary Income	13000	Income	INR	11	36	36	2025-11-13 00:00:00	2025-12-03 20:23:56.23761	\N
3142	Salary Income	19100	Income	INR	11	37	37	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
3143	Salary Income	18800	Income	INR	11	37	37	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
3144	Salary Income	36500	Income	INR	11	37	37	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
3145	Salary Income	18700	Income	INR	11	37	37	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
3146	Salary Income	18100	Income	INR	11	37	37	2025-11-10 00:00:00	2025-12-03 20:23:56.23761	\N
3147	Salary Income	12400	Income	INR	11	38	38	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
3148	Salary Income	12900	Income	INR	11	38	38	2025-09-11 00:00:00	2025-12-03 20:23:56.23761	\N
3149	Salary Income	24100	Income	INR	11	38	38	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
3150	Salary Income	25800	Income	INR	11	38	38	2025-11-17 00:00:00	2025-12-03 20:23:56.23761	\N
3151	Salary Income	18500	Income	INR	11	39	39	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
3152	Salary Income	19000	Income	INR	11	39	39	2025-09-14 00:00:00	2025-12-03 20:23:56.23761	\N
3153	Salary Income	38400	Income	INR	11	39	39	2025-10-01 00:00:00	2025-12-03 20:23:56.23761	\N
3154	Salary Income	12600	Income	INR	11	39	39	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
3155	Salary Income	12500	Income	INR	11	39	39	2025-11-29 00:00:00	2025-12-03 20:23:56.23761	\N
3156	Salary Income	12400	Income	INR	11	39	39	2025-11-18 00:00:00	2025-12-03 20:23:56.23761	\N
3157	Salary Income	36400	Income	INR	11	40	40	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
3158	Salary Income	36800	Income	INR	11	40	40	2025-10-22 00:00:00	2025-12-03 20:23:56.23761	\N
3159	Salary Income	19300	Income	INR	11	40	40	2025-11-22 00:00:00	2025-12-03 20:23:56.23761	\N
3160	Salary Income	19400	Income	INR	11	40	40	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
3161	Salary Income	25300	Income	INR	11	41	41	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
3162	Salary Income	24500	Income	INR	11	41	41	2025-10-23 00:00:00	2025-12-03 20:23:56.23761	\N
3163	Salary Income	8500	Income	INR	11	41	41	2025-11-21 00:00:00	2025-12-03 20:23:56.23761	\N
3164	Salary Income	8300	Income	INR	11	41	41	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
3165	Salary Income	8700	Income	INR	11	41	41	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
3166	Salary Income	16700	Income	INR	11	42	42	2025-09-29 00:00:00	2025-12-03 20:23:56.23761	\N
3167	Salary Income	17000	Income	INR	11	42	42	2025-09-07 00:00:00	2025-12-03 20:23:56.23761	\N
3168	Salary Income	16600	Income	INR	11	42	42	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
3169	Salary Income	16900	Income	INR	11	42	42	2025-10-15 00:00:00	2025-12-03 20:23:56.23761	\N
3170	Salary Income	16200	Income	INR	11	42	42	2025-10-16 00:00:00	2025-12-03 20:23:56.23761	\N
3171	Salary Income	16500	Income	INR	11	42	42	2025-10-21 00:00:00	2025-12-03 20:23:56.23761	\N
3172	Salary Income	16200	Income	INR	11	42	42	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
3173	Salary Income	16500	Income	INR	11	42	42	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
3174	Salary Income	16300	Income	INR	11	42	42	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
3175	Salary Income	49600	Income	INR	11	43	43	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
3176	Salary Income	50300	Income	INR	11	43	43	2025-10-05 00:00:00	2025-12-03 20:23:56.23761	\N
3177	Salary Income	25800	Income	INR	11	43	43	2025-11-12 00:00:00	2025-12-03 20:23:56.23761	\N
3178	Salary Income	25900	Income	INR	11	43	43	2025-11-05 00:00:00	2025-12-03 20:23:56.23761	\N
3179	Salary Income	17300	Income	INR	11	44	44	2025-09-19 00:00:00	2025-12-03 20:23:56.23761	\N
3180	Salary Income	16300	Income	INR	11	44	44	2025-09-09 00:00:00	2025-12-03 20:23:56.23761	\N
3181	Salary Income	16300	Income	INR	11	44	44	2025-09-24 00:00:00	2025-12-03 20:23:56.23761	\N
3182	Salary Income	51200	Income	INR	11	44	44	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
3183	Salary Income	25700	Income	INR	11	44	44	2025-11-04 00:00:00	2025-12-03 20:23:56.23761	\N
3184	Salary Income	24600	Income	INR	11	44	44	2025-11-14 00:00:00	2025-12-03 20:23:56.23761	\N
3185	Salary Income	19400	Income	INR	11	45	45	2025-09-05 00:00:00	2025-12-03 20:23:56.23761	\N
3186	Salary Income	19500	Income	INR	11	45	45	2025-09-13 00:00:00	2025-12-03 20:23:56.23761	\N
3187	Salary Income	12800	Income	INR	11	45	45	2025-10-24 00:00:00	2025-12-03 20:23:56.23761	\N
3188	Salary Income	12000	Income	INR	11	45	45	2025-10-09 00:00:00	2025-12-03 20:23:56.23761	\N
3189	Salary Income	12600	Income	INR	11	45	45	2025-10-20 00:00:00	2025-12-03 20:23:56.23761	\N
3190	Salary Income	18300	Income	INR	11	45	45	2025-11-16 00:00:00	2025-12-03 20:23:56.23761	\N
3191	Salary Income	18200	Income	INR	11	45	45	2025-11-07 00:00:00	2025-12-03 20:23:56.23761	\N
3192	Salary Income	8300	Income	INR	11	46	46	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
3193	Salary Income	8100	Income	INR	11	46	46	2025-09-03 00:00:00	2025-12-03 20:23:56.23761	\N
3194	Salary Income	8200	Income	INR	11	46	46	2025-09-17 00:00:00	2025-12-03 20:23:56.23761	\N
3195	Salary Income	12700	Income	INR	11	46	46	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
3196	Salary Income	12600	Income	INR	11	46	46	2025-10-11 00:00:00	2025-12-03 20:23:56.23761	\N
3197	Salary Income	12100	Income	INR	11	46	46	2025-11-11 00:00:00	2025-12-03 20:23:56.23761	\N
3198	Salary Income	12300	Income	INR	11	46	46	2025-11-19 00:00:00	2025-12-03 20:23:56.23761	\N
3199	Salary Income	12900	Income	INR	11	47	47	2025-09-10 00:00:00	2025-12-03 20:23:56.23761	\N
3200	Salary Income	12300	Income	INR	11	47	47	2025-09-16 00:00:00	2025-12-03 20:23:56.23761	\N
3201	Salary Income	8000	Income	INR	11	47	47	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
3202	Salary Income	8100	Income	INR	11	47	47	2025-10-19 00:00:00	2025-12-03 20:23:56.23761	\N
3203	Salary Income	8600	Income	INR	11	47	47	2025-10-07 00:00:00	2025-12-03 20:23:56.23761	\N
3204	Salary Income	25400	Income	INR	11	47	47	2025-11-09 00:00:00	2025-12-03 20:23:56.23761	\N
3205	Salary Income	50000	Income	INR	11	48	48	2025-09-08 00:00:00	2025-12-03 20:23:56.23761	\N
3206	Salary Income	24200	Income	INR	11	48	48	2025-10-31 00:00:00	2025-12-03 20:23:56.23761	\N
3207	Salary Income	24900	Income	INR	11	48	48	2025-10-18 00:00:00	2025-12-03 20:23:56.23761	\N
3208	Salary Income	50200	Income	INR	11	48	48	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
3209	Salary Income	12800	Income	INR	11	49	49	2025-09-22 00:00:00	2025-12-03 20:23:56.23761	\N
3210	Salary Income	12700	Income	INR	11	49	49	2025-09-20 00:00:00	2025-12-03 20:23:56.23761	\N
3211	Salary Income	8500	Income	INR	11	49	49	2025-10-29 00:00:00	2025-12-03 20:23:56.23761	\N
3212	Salary Income	8100	Income	INR	11	49	49	2025-10-03 00:00:00	2025-12-03 20:23:56.23761	\N
3213	Salary Income	8400	Income	INR	11	49	49	2025-10-08 00:00:00	2025-12-03 20:23:56.23761	\N
3214	Salary Income	24900	Income	INR	11	49	49	2025-11-02 00:00:00	2025-12-03 20:23:56.23761	\N
3215	Salary Income	32500	Income	INR	11	50	50	2025-09-27 00:00:00	2025-12-03 20:23:56.23761	\N
3216	Salary Income	30000	Income	INR	11	50	50	2025-09-02 00:00:00	2025-12-03 20:23:56.23761	\N
3217	Salary Income	63600	Income	INR	11	50	50	2025-10-04 00:00:00	2025-12-03 20:23:56.23761	\N
3218	Salary Income	21100	Income	INR	11	50	50	2025-11-26 00:00:00	2025-12-03 20:23:56.23761	\N
3219	Salary Income	21600	Income	INR	11	50	50	2025-11-23 00:00:00	2025-12-03 20:23:56.23761	\N
3220	Salary Income	20200	Income	INR	11	50	50	2025-11-01 00:00:00	2025-12-03 20:23:56.23761	\N
3221	Expense - Entertainment	200	Expense	INR	5	1	1	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3222	Expense - Housing	200	Expense	INR	3	1	1	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3223	Expense - Transportation	700	Expense	INR	2	1	1	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3224	Expense - Travel	200	Expense	INR	6	1	1	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3225	Expense - Food & Dining	400	Expense	INR	1	1	1	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3226	Expense - Shopping	200	Expense	INR	7	1	1	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3227	Expense - Utilities	200	Expense	INR	9	1	1	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3228	Expense - Healthcare	200	Expense	INR	4	1	1	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3229	Expense - Utilities	200	Expense	INR	9	1	1	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3230	Expense - Miscellaneous	200	Expense	INR	10	1	1	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3231	Expense - Education	200	Expense	INR	8	1	1	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3232	Expense - Travel	200	Expense	INR	6	1	1	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3233	Expense - Utilities	400	Expense	INR	9	1	1	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3234	Expense - Transportation	300	Expense	INR	2	1	1	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3235	Expense - Miscellaneous	200	Expense	INR	10	1	1	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3236	Expense - Miscellaneous	200	Expense	INR	10	1	1	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3237	Expense - Food & Dining	300	Expense	INR	1	1	1	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3238	Expense - Utilities	200	Expense	INR	9	1	1	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3239	Expense - Food & Dining	500	Expense	INR	1	1	1	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3240	Expense - Education	200	Expense	INR	8	1	1	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3241	Expense - Entertainment	200	Expense	INR	5	1	1	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3242	Expense - Transportation	200	Expense	INR	2	2	2	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3243	Expense - Education	200	Expense	INR	8	2	2	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3244	Expense - Travel	200	Expense	INR	6	2	2	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3245	Expense - Food & Dining	200	Expense	INR	1	2	2	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3246	Expense - Healthcare	200	Expense	INR	4	2	2	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3247	Expense - Utilities	200	Expense	INR	9	2	2	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3248	Expense - Food & Dining	200	Expense	INR	1	2	2	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3249	Expense - Miscellaneous	200	Expense	INR	10	2	2	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3250	Expense - Transportation	300	Expense	INR	2	2	2	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3251	Expense - Shopping	200	Expense	INR	7	2	2	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3252	Expense - Travel	200	Expense	INR	6	2	2	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3253	Expense - Education	200	Expense	INR	8	2	2	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3254	Expense - Utilities	200	Expense	INR	9	2	2	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3255	Expense - Entertainment	200	Expense	INR	5	2	2	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3256	Expense - Education	200	Expense	INR	8	2	2	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3257	Expense - Entertainment	200	Expense	INR	5	2	2	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3258	Expense - Shopping	500	Expense	INR	7	2	2	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3259	Expense - Shopping	300	Expense	INR	7	2	2	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3260	Expense - Education	400	Expense	INR	8	2	2	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3261	Expense - Healthcare	200	Expense	INR	4	2	2	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3262	Expense - Healthcare	200	Expense	INR	4	2	2	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3263	Expense - Transportation	200	Expense	INR	2	2	2	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3264	Expense - Healthcare	200	Expense	INR	4	2	2	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3265	Expense - Utilities	300	Expense	INR	9	2	2	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3266	Expense - Transportation	200	Expense	INR	2	2	2	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3267	Expense - Travel	200	Expense	INR	6	2	2	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3268	Expense - Transportation	200	Expense	INR	2	2	2	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3269	Expense - Housing	1200	Expense	INR	3	2	2	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3270	Expense - Miscellaneous	200	Expense	INR	10	2	2	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3271	Expense - Food & Dining	1800	Expense	INR	1	2	2	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3272	Expense - Entertainment	200	Expense	INR	5	2	2	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3273	Expense - Entertainment	200	Expense	INR	5	2	2	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3274	Expense - Utilities	200	Expense	INR	9	2	2	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3275	Expense - Housing	400	Expense	INR	3	2	2	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3276	Expense - Utilities	200	Expense	INR	9	2	2	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3277	Expense - Miscellaneous	200	Expense	INR	10	2	2	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3278	Expense - Education	200	Expense	INR	8	2	2	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3279	Expense - Transportation	800	Expense	INR	2	2	2	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3280	Expense - Housing	200	Expense	INR	3	2	2	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3281	Expense - Transportation	400	Expense	INR	2	2	2	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3282	Expense - Education	400	Expense	INR	8	2	2	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3283	Expense - Shopping	200	Expense	INR	7	3	3	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3284	Expense - Food & Dining	200	Expense	INR	1	3	3	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3285	Expense - Shopping	200	Expense	INR	7	4	4	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3286	Expense - Food & Dining	200	Expense	INR	1	4	4	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3287	Expense - Travel	200	Expense	INR	6	4	4	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3288	Expense - Miscellaneous	200	Expense	INR	10	4	4	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3289	Expense - Food & Dining	400	Expense	INR	1	4	4	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3290	Expense - Healthcare	200	Expense	INR	4	4	4	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3291	Expense - Miscellaneous	200	Expense	INR	10	4	4	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3292	Expense - Housing	300	Expense	INR	3	4	4	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3293	Expense - Transportation	200	Expense	INR	2	4	4	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3294	Expense - Food & Dining	200	Expense	INR	1	4	4	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3295	Expense - Miscellaneous	200	Expense	INR	10	4	4	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3296	Expense - Travel	200	Expense	INR	6	4	4	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3297	Expense - Travel	200	Expense	INR	6	4	4	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3298	Expense - Food & Dining	200	Expense	INR	1	4	4	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3299	Expense - Healthcare	200	Expense	INR	4	5	5	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3300	Expense - Housing	400	Expense	INR	3	5	5	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3301	Expense - Food & Dining	200	Expense	INR	1	5	5	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3302	Expense - Housing	600	Expense	INR	3	5	5	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3303	Expense - Transportation	500	Expense	INR	2	5	5	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3304	Expense - Travel	200	Expense	INR	6	5	5	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3305	Expense - Healthcare	200	Expense	INR	4	5	5	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3306	Expense - Education	200	Expense	INR	8	5	5	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3307	Expense - Education	200	Expense	INR	8	5	5	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3308	Expense - Housing	500	Expense	INR	3	5	5	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3309	Expense - Entertainment	200	Expense	INR	5	5	5	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3310	Expense - Healthcare	200	Expense	INR	4	5	5	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3311	Expense - Housing	500	Expense	INR	3	5	5	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3312	Expense - Miscellaneous	200	Expense	INR	10	5	5	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3313	Expense - Food & Dining	400	Expense	INR	1	5	5	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3314	Expense - Utilities	200	Expense	INR	9	5	5	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3315	Expense - Transportation	200	Expense	INR	2	5	5	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3316	Expense - Travel	200	Expense	INR	6	5	5	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3317	Expense - Entertainment	200	Expense	INR	5	6	6	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3318	Expense - Miscellaneous	200	Expense	INR	10	6	6	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3319	Expense - Education	200	Expense	INR	8	6	6	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3320	Expense - Healthcare	300	Expense	INR	4	6	6	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3321	Expense - Utilities	200	Expense	INR	9	6	6	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3322	Expense - Housing	1300	Expense	INR	3	6	6	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3323	Expense - Transportation	200	Expense	INR	2	6	6	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3324	Expense - Healthcare	200	Expense	INR	4	7	7	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3325	Expense - Transportation	200	Expense	INR	2	7	7	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3326	Expense - Housing	200	Expense	INR	3	7	7	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3327	Expense - Utilities	400	Expense	INR	9	7	7	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3328	Expense - Travel	200	Expense	INR	6	7	7	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3329	Expense - Education	200	Expense	INR	8	7	7	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3330	Expense - Food & Dining	1300	Expense	INR	1	7	7	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3331	Expense - Education	200	Expense	INR	8	7	7	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3332	Expense - Shopping	300	Expense	INR	7	7	7	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3333	Expense - Food & Dining	400	Expense	INR	1	7	7	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3334	Expense - Shopping	200	Expense	INR	7	7	7	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3335	Expense - Transportation	200	Expense	INR	2	7	7	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3336	Expense - Transportation	200	Expense	INR	2	7	7	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3337	Expense - Transportation	200	Expense	INR	2	7	7	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3338	Expense - Education	500	Expense	INR	8	8	8	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3339	Expense - Travel	200	Expense	INR	6	8	8	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3340	Expense - Shopping	200	Expense	INR	7	8	8	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3341	Expense - Miscellaneous	200	Expense	INR	10	8	8	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3342	Expense - Education	400	Expense	INR	8	8	8	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3343	Expense - Utilities	200	Expense	INR	9	8	8	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3344	Expense - Shopping	200	Expense	INR	7	8	8	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3345	Expense - Healthcare	200	Expense	INR	4	8	8	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3346	Expense - Education	200	Expense	INR	8	8	8	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3347	Expense - Food & Dining	800	Expense	INR	1	8	8	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3348	Expense - Food & Dining	400	Expense	INR	1	8	8	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3349	Expense - Food & Dining	500	Expense	INR	1	8	8	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3350	Expense - Utilities	200	Expense	INR	9	8	8	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3351	Expense - Travel	200	Expense	INR	6	8	8	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3352	Expense - Food & Dining	200	Expense	INR	1	8	8	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3353	Expense - Education	200	Expense	INR	8	8	8	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3354	Expense - Education	200	Expense	INR	8	8	8	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3355	Expense - Miscellaneous	200	Expense	INR	10	8	8	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3356	Expense - Transportation	200	Expense	INR	2	8	8	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3357	Expense - Travel	200	Expense	INR	6	8	8	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3358	Expense - Education	200	Expense	INR	8	8	8	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3359	Expense - Transportation	600	Expense	INR	2	8	8	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3360	Expense - Healthcare	600	Expense	INR	4	8	8	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3361	Expense - Food & Dining	300	Expense	INR	1	8	8	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3362	Expense - Utilities	200	Expense	INR	9	8	8	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3363	Expense - Healthcare	200	Expense	INR	4	8	8	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3364	Expense - Travel	200	Expense	INR	6	8	8	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3365	Expense - Utilities	200	Expense	INR	9	8	8	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3366	Expense - Miscellaneous	200	Expense	INR	10	8	8	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3367	Expense - Miscellaneous	200	Expense	INR	10	8	8	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3368	Expense - Housing	400	Expense	INR	3	8	8	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3369	Expense - Healthcare	200	Expense	INR	4	8	8	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3370	Expense - Housing	1500	Expense	INR	3	9	9	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3371	Expense - Shopping	200	Expense	INR	7	9	9	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3372	Expense - Shopping	400	Expense	INR	7	9	9	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3373	Expense - Utilities	200	Expense	INR	9	9	9	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3374	Expense - Entertainment	200	Expense	INR	5	9	9	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3375	Expense - Transportation	200	Expense	INR	2	9	9	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3376	Expense - Food & Dining	400	Expense	INR	1	9	9	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3377	Expense - Entertainment	300	Expense	INR	5	9	9	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3378	Expense - Miscellaneous	200	Expense	INR	10	9	9	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3379	Expense - Transportation	200	Expense	INR	2	9	9	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3380	Expense - Utilities	600	Expense	INR	9	9	9	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3381	Expense - Food & Dining	200	Expense	INR	1	9	9	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3382	Expense - Miscellaneous	200	Expense	INR	10	9	9	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3383	Expense - Shopping	200	Expense	INR	7	9	9	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3384	Expense - Entertainment	200	Expense	INR	5	9	9	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3385	Expense - Food & Dining	300	Expense	INR	1	9	9	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3386	Expense - Food & Dining	200	Expense	INR	1	9	9	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3387	Expense - Food & Dining	200	Expense	INR	1	9	9	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3388	Expense - Transportation	300	Expense	INR	2	9	9	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3389	Expense - Shopping	200	Expense	INR	7	9	9	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3390	Expense - Travel	200	Expense	INR	6	9	9	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3391	Expense - Food & Dining	200	Expense	INR	1	9	9	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3392	Expense - Entertainment	300	Expense	INR	5	9	9	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3393	Expense - Food & Dining	1100	Expense	INR	1	10	10	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3394	Expense - Miscellaneous	200	Expense	INR	10	10	10	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3395	Expense - Utilities	300	Expense	INR	9	10	10	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3396	Expense - Shopping	200	Expense	INR	7	10	10	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3397	Expense - Transportation	200	Expense	INR	2	10	10	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3398	Expense - Healthcare	200	Expense	INR	4	11	11	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3399	Expense - Transportation	200	Expense	INR	2	11	11	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3400	Expense - Education	200	Expense	INR	8	11	11	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3401	Expense - Healthcare	200	Expense	INR	4	11	11	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3402	Expense - Education	200	Expense	INR	8	11	11	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3403	Expense - Utilities	200	Expense	INR	9	11	11	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3404	Expense - Utilities	200	Expense	INR	9	11	11	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3405	Expense - Entertainment	200	Expense	INR	5	11	11	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3406	Expense - Shopping	200	Expense	INR	7	11	11	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3407	Expense - Entertainment	200	Expense	INR	5	11	11	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3408	Expense - Travel	200	Expense	INR	6	11	11	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3409	Expense - Housing	300	Expense	INR	3	11	11	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3410	Expense - Travel	200	Expense	INR	6	11	11	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3411	Expense - Food & Dining	1300	Expense	INR	1	11	11	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3412	Expense - Transportation	200	Expense	INR	2	11	11	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3413	Expense - Education	200	Expense	INR	8	11	11	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3414	Expense - Utilities	200	Expense	INR	9	11	11	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3415	Expense - Housing	1000	Expense	INR	3	11	11	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3416	Expense - Housing	300	Expense	INR	3	11	11	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3417	Expense - Utilities	200	Expense	INR	9	12	12	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3418	Expense - Travel	200	Expense	INR	6	12	12	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3419	Expense - Shopping	200	Expense	INR	7	12	12	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3420	Expense - Entertainment	200	Expense	INR	5	12	12	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3421	Expense - Shopping	200	Expense	INR	7	12	12	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3422	Expense - Food & Dining	500	Expense	INR	1	13	13	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3423	Expense - Food & Dining	200	Expense	INR	1	13	13	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3424	Expense - Food & Dining	600	Expense	INR	1	13	13	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3425	Expense - Education	200	Expense	INR	8	13	13	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3426	Expense - Miscellaneous	200	Expense	INR	10	13	13	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3427	Expense - Shopping	400	Expense	INR	7	13	13	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3428	Expense - Miscellaneous	200	Expense	INR	10	13	13	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3429	Expense - Shopping	200	Expense	INR	7	13	13	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3430	Expense - Food & Dining	200	Expense	INR	1	13	13	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3431	Expense - Shopping	200	Expense	INR	7	13	13	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3432	Expense - Entertainment	200	Expense	INR	5	13	13	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3433	Expense - Utilities	200	Expense	INR	9	13	13	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3434	Expense - Travel	200	Expense	INR	6	13	13	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3435	Expense - Food & Dining	700	Expense	INR	1	13	13	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3436	Expense - Shopping	600	Expense	INR	7	13	13	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3437	Expense - Shopping	200	Expense	INR	7	13	13	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3438	Expense - Housing	300	Expense	INR	3	13	13	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3439	Expense - Food & Dining	300	Expense	INR	1	13	13	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3440	Expense - Utilities	200	Expense	INR	9	13	13	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3441	Expense - Education	200	Expense	INR	8	13	13	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3442	Expense - Food & Dining	200	Expense	INR	1	13	13	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3443	Expense - Travel	200	Expense	INR	6	13	13	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3444	Expense - Shopping	500	Expense	INR	7	14	14	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3445	Expense - Housing	1700	Expense	INR	3	14	14	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3446	Expense - Miscellaneous	200	Expense	INR	10	14	14	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3447	Expense - Miscellaneous	200	Expense	INR	10	14	14	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3448	Expense - Food & Dining	1000	Expense	INR	1	14	14	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3449	Expense - Food & Dining	300	Expense	INR	1	14	14	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3450	Expense - Utilities	200	Expense	INR	9	14	14	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3451	Expense - Housing	1000	Expense	INR	3	14	14	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3452	Expense - Travel	200	Expense	INR	6	14	14	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3453	Expense - Entertainment	200	Expense	INR	5	14	14	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3454	Expense - Entertainment	200	Expense	INR	5	14	14	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3455	Expense - Entertainment	200	Expense	INR	5	14	14	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3456	Expense - Transportation	500	Expense	INR	2	15	15	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3457	Expense - Shopping	200	Expense	INR	7	15	15	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3458	Expense - Miscellaneous	200	Expense	INR	10	15	15	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3459	Expense - Transportation	300	Expense	INR	2	15	15	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3460	Expense - Transportation	200	Expense	INR	2	15	15	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3461	Expense - Entertainment	200	Expense	INR	5	15	15	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3462	Expense - Housing	400	Expense	INR	3	15	15	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3463	Expense - Food & Dining	1400	Expense	INR	1	15	15	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3464	Expense - Healthcare	200	Expense	INR	4	15	15	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3465	Expense - Miscellaneous	200	Expense	INR	10	15	15	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3466	Expense - Healthcare	200	Expense	INR	4	15	15	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3467	Expense - Travel	200	Expense	INR	6	15	15	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3468	Expense - Education	200	Expense	INR	8	15	15	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3469	Expense - Travel	200	Expense	INR	6	15	15	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3470	Expense - Education	200	Expense	INR	8	15	15	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3471	Expense - Healthcare	200	Expense	INR	4	15	15	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3472	Expense - Travel	200	Expense	INR	6	15	15	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3473	Expense - Shopping	200	Expense	INR	7	15	15	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3474	Expense - Education	200	Expense	INR	8	15	15	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3475	Expense - Travel	300	Expense	INR	6	15	15	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3476	Expense - Shopping	200	Expense	INR	7	15	15	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3477	Expense - Housing	1100	Expense	INR	3	15	15	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3478	Expense - Housing	600	Expense	INR	3	15	15	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3479	Expense - Healthcare	200	Expense	INR	4	15	15	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3480	Expense - Miscellaneous	200	Expense	INR	10	15	15	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3481	Expense - Housing	400	Expense	INR	3	15	15	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3482	Expense - Shopping	200	Expense	INR	7	15	15	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3483	Expense - Healthcare	200	Expense	INR	4	15	15	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3484	Expense - Food & Dining	200	Expense	INR	1	15	15	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3485	Expense - Education	200	Expense	INR	8	15	15	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3486	Expense - Entertainment	200	Expense	INR	5	15	15	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3487	Expense - Utilities	500	Expense	INR	9	15	15	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3488	Expense - Transportation	200	Expense	INR	2	16	16	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3489	Expense - Miscellaneous	200	Expense	INR	10	16	16	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3490	Expense - Entertainment	200	Expense	INR	5	16	16	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3491	Expense - Entertainment	400	Expense	INR	5	16	16	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3492	Expense - Education	200	Expense	INR	8	16	16	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3493	Expense - Utilities	500	Expense	INR	9	16	16	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3494	Expense - Healthcare	200	Expense	INR	4	16	16	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3495	Expense - Education	200	Expense	INR	8	16	16	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3496	Expense - Transportation	200	Expense	INR	2	16	16	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3497	Expense - Transportation	200	Expense	INR	2	16	16	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3498	Expense - Utilities	300	Expense	INR	9	16	16	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3499	Expense - Education	200	Expense	INR	8	16	16	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3500	Expense - Education	200	Expense	INR	8	16	16	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3501	Expense - Miscellaneous	200	Expense	INR	10	16	16	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3502	Expense - Shopping	200	Expense	INR	7	16	16	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3503	Expense - Utilities	200	Expense	INR	9	16	16	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3504	Expense - Shopping	200	Expense	INR	7	16	16	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3505	Expense - Miscellaneous	200	Expense	INR	10	16	16	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3506	Expense - Travel	200	Expense	INR	6	16	16	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3507	Expense - Travel	200	Expense	INR	6	16	16	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3508	Expense - Travel	200	Expense	INR	6	16	16	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3509	Expense - Miscellaneous	200	Expense	INR	10	16	16	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3510	Expense - Travel	200	Expense	INR	6	16	16	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3511	Expense - Miscellaneous	200	Expense	INR	10	16	16	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3512	Expense - Utilities	200	Expense	INR	9	16	16	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3513	Expense - Transportation	200	Expense	INR	2	16	16	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3514	Expense - Education	200	Expense	INR	8	16	16	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3515	Expense - Travel	200	Expense	INR	6	16	16	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3516	Expense - Food & Dining	200	Expense	INR	1	16	16	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3517	Expense - Healthcare	200	Expense	INR	4	16	16	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3518	Expense - Miscellaneous	200	Expense	INR	10	16	16	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3519	Expense - Miscellaneous	200	Expense	INR	10	16	16	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3520	Expense - Entertainment	500	Expense	INR	5	16	16	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3521	Expense - Utilities	700	Expense	INR	9	16	16	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3522	Expense - Education	200	Expense	INR	8	16	16	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3523	Expense - Miscellaneous	200	Expense	INR	10	17	17	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3524	Expense - Travel	200	Expense	INR	6	17	17	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3525	Expense - Healthcare	200	Expense	INR	4	17	17	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3526	Expense - Housing	200	Expense	INR	3	17	17	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3527	Expense - Utilities	400	Expense	INR	9	17	17	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3528	Expense - Utilities	200	Expense	INR	9	17	17	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3529	Expense - Education	200	Expense	INR	8	17	17	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3530	Expense - Shopping	200	Expense	INR	7	18	18	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3531	Expense - Shopping	200	Expense	INR	7	18	18	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3532	Expense - Shopping	200	Expense	INR	7	18	18	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3533	Expense - Healthcare	200	Expense	INR	4	18	18	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3534	Expense - Education	200	Expense	INR	8	18	18	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3535	Expense - Entertainment	200	Expense	INR	5	18	18	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3536	Expense - Utilities	300	Expense	INR	9	18	18	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3537	Expense - Education	200	Expense	INR	8	18	18	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3538	Expense - Housing	400	Expense	INR	3	18	18	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3539	Expense - Healthcare	200	Expense	INR	4	18	18	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3540	Expense - Food & Dining	700	Expense	INR	1	18	18	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3541	Expense - Utilities	400	Expense	INR	9	18	18	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3542	Expense - Transportation	300	Expense	INR	2	18	18	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3543	Expense - Food & Dining	800	Expense	INR	1	18	18	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3544	Expense - Shopping	200	Expense	INR	7	18	18	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3545	Expense - Education	200	Expense	INR	8	18	18	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3546	Expense - Healthcare	500	Expense	INR	4	18	18	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3547	Expense - Entertainment	200	Expense	INR	5	18	18	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3548	Expense - Miscellaneous	200	Expense	INR	10	18	18	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3549	Expense - Utilities	200	Expense	INR	9	18	18	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3550	Expense - Education	200	Expense	INR	8	18	18	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3551	Expense - Travel	200	Expense	INR	6	18	18	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3552	Expense - Housing	2600	Expense	INR	3	18	18	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3553	Expense - Education	200	Expense	INR	8	18	18	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3554	Expense - Shopping	300	Expense	INR	7	18	18	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3555	Expense - Utilities	200	Expense	INR	9	18	18	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3556	Expense - Transportation	200	Expense	INR	2	18	18	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3557	Expense - Shopping	400	Expense	INR	7	18	18	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3558	Expense - Entertainment	200	Expense	INR	5	18	18	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3559	Expense - Travel	200	Expense	INR	6	18	18	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3560	Expense - Travel	200	Expense	INR	6	18	18	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3561	Expense - Transportation	200	Expense	INR	2	18	18	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3562	Expense - Healthcare	200	Expense	INR	4	18	18	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3563	Expense - Miscellaneous	200	Expense	INR	10	18	18	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3564	Expense - Utilities	300	Expense	INR	9	19	19	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3565	Expense - Entertainment	200	Expense	INR	5	19	19	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3566	Expense - Utilities	300	Expense	INR	9	19	19	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3567	Expense - Education	200	Expense	INR	8	19	19	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3568	Expense - Transportation	200	Expense	INR	2	19	19	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3569	Expense - Travel	200	Expense	INR	6	19	19	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3570	Expense - Transportation	900	Expense	INR	2	19	19	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3571	Expense - Travel	200	Expense	INR	6	19	19	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3572	Expense - Shopping	700	Expense	INR	7	19	19	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3573	Expense - Food & Dining	500	Expense	INR	1	19	19	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3574	Expense - Healthcare	200	Expense	INR	4	19	19	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3575	Expense - Utilities	200	Expense	INR	9	19	19	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3576	Expense - Shopping	400	Expense	INR	7	19	19	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3577	Expense - Healthcare	400	Expense	INR	4	19	19	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3578	Expense - Housing	200	Expense	INR	3	19	19	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3579	Expense - Transportation	400	Expense	INR	2	19	19	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3580	Expense - Education	200	Expense	INR	8	19	19	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3581	Expense - Housing	300	Expense	INR	3	19	19	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3582	Expense - Travel	200	Expense	INR	6	19	19	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3583	Expense - Housing	300	Expense	INR	3	19	19	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3584	Expense - Miscellaneous	200	Expense	INR	10	19	19	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3585	Expense - Utilities	200	Expense	INR	9	19	19	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3586	Expense - Shopping	300	Expense	INR	7	19	19	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3587	Expense - Education	200	Expense	INR	8	19	19	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3588	Expense - Education	200	Expense	INR	8	19	19	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3589	Expense - Healthcare	200	Expense	INR	4	19	19	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3590	Expense - Healthcare	200	Expense	INR	4	19	19	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3591	Expense - Miscellaneous	200	Expense	INR	10	19	19	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3592	Expense - Education	200	Expense	INR	8	19	19	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3593	Expense - Shopping	200	Expense	INR	7	19	19	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3594	Expense - Transportation	200	Expense	INR	2	19	19	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3595	Expense - Utilities	300	Expense	INR	9	20	20	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3596	Expense - Housing	200	Expense	INR	3	20	20	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3597	Expense - Transportation	200	Expense	INR	2	20	20	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3598	Expense - Transportation	200	Expense	INR	2	20	20	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3599	Expense - Food & Dining	200	Expense	INR	1	20	20	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3600	Expense - Shopping	200	Expense	INR	7	20	20	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3601	Expense - Shopping	200	Expense	INR	7	21	21	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3602	Expense - Transportation	600	Expense	INR	2	21	21	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3603	Expense - Utilities	200	Expense	INR	9	21	21	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3604	Expense - Transportation	200	Expense	INR	2	21	21	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3605	Expense - Education	300	Expense	INR	8	21	21	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3606	Expense - Shopping	200	Expense	INR	7	21	21	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3607	Expense - Housing	500	Expense	INR	3	21	21	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3608	Expense - Healthcare	200	Expense	INR	4	21	21	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3609	Expense - Education	200	Expense	INR	8	21	21	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3610	Expense - Miscellaneous	200	Expense	INR	10	21	21	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3611	Expense - Transportation	200	Expense	INR	2	21	21	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3612	Expense - Shopping	200	Expense	INR	7	21	21	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3613	Expense - Entertainment	200	Expense	INR	5	21	21	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3614	Expense - Food & Dining	200	Expense	INR	1	21	21	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3615	Expense - Entertainment	200	Expense	INR	5	21	21	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3616	Expense - Entertainment	200	Expense	INR	5	21	21	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3617	Expense - Education	300	Expense	INR	8	21	21	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3618	Expense - Miscellaneous	200	Expense	INR	10	22	22	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3619	Expense - Entertainment	500	Expense	INR	5	22	22	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3620	Expense - Education	200	Expense	INR	8	22	22	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3621	Expense - Travel	200	Expense	INR	6	22	22	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3622	Expense - Education	200	Expense	INR	8	22	22	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3623	Expense - Food & Dining	1600	Expense	INR	1	22	22	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3624	Expense - Healthcare	400	Expense	INR	4	22	22	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3625	Expense - Shopping	200	Expense	INR	7	22	22	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3626	Expense - Education	200	Expense	INR	8	22	22	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3627	Expense - Entertainment	200	Expense	INR	5	22	22	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3628	Expense - Entertainment	200	Expense	INR	5	22	22	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3629	Expense - Entertainment	200	Expense	INR	5	22	22	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3630	Expense - Shopping	200	Expense	INR	7	22	22	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3631	Expense - Transportation	200	Expense	INR	2	22	22	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3632	Expense - Shopping	400	Expense	INR	7	22	22	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3633	Expense - Transportation	200	Expense	INR	2	22	22	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3634	Expense - Miscellaneous	200	Expense	INR	10	22	22	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3635	Expense - Healthcare	200	Expense	INR	4	22	22	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3636	Expense - Transportation	200	Expense	INR	2	22	22	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3637	Expense - Shopping	700	Expense	INR	7	22	22	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3638	Expense - Education	200	Expense	INR	8	22	22	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3639	Expense - Shopping	200	Expense	INR	7	22	22	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3640	Expense - Food & Dining	1700	Expense	INR	1	22	22	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3641	Expense - Housing	200	Expense	INR	3	22	22	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3642	Expense - Travel	200	Expense	INR	6	22	22	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3643	Expense - Transportation	200	Expense	INR	2	22	22	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3644	Expense - Miscellaneous	200	Expense	INR	10	22	22	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3645	Expense - Education	200	Expense	INR	8	22	22	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3646	Expense - Shopping	600	Expense	INR	7	22	22	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3647	Expense - Utilities	200	Expense	INR	9	22	22	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3648	Expense - Transportation	200	Expense	INR	2	22	22	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3649	Expense - Entertainment	200	Expense	INR	5	22	22	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3650	Expense - Miscellaneous	200	Expense	INR	10	22	22	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3651	Expense - Entertainment	200	Expense	INR	5	22	22	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3652	Expense - Education	200	Expense	INR	8	22	22	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3653	Expense - Miscellaneous	200	Expense	INR	10	22	22	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3654	Expense - Housing	300	Expense	INR	3	22	22	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3655	Expense - Food & Dining	300	Expense	INR	1	22	22	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3656	Expense - Travel	200	Expense	INR	6	22	22	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3657	Expense - Entertainment	200	Expense	INR	5	22	22	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3658	Expense - Travel	200	Expense	INR	6	22	22	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3659	Expense - Utilities	200	Expense	INR	9	22	22	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3660	Expense - Utilities	200	Expense	INR	9	22	22	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3661	Expense - Transportation	200	Expense	INR	2	23	23	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3662	Expense - Miscellaneous	200	Expense	INR	10	23	23	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3663	Expense - Utilities	200	Expense	INR	9	23	23	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3664	Expense - Utilities	300	Expense	INR	9	23	23	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3665	Expense - Healthcare	200	Expense	INR	4	23	23	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3666	Expense - Transportation	200	Expense	INR	2	23	23	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3667	Expense - Shopping	200	Expense	INR	7	23	23	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3668	Expense - Entertainment	200	Expense	INR	5	23	23	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3669	Expense - Entertainment	200	Expense	INR	5	23	23	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3670	Expense - Food & Dining	200	Expense	INR	1	23	23	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3671	Expense - Shopping	400	Expense	INR	7	23	23	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3672	Expense - Entertainment	200	Expense	INR	5	23	23	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3673	Expense - Travel	200	Expense	INR	6	23	23	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3674	Expense - Housing	1500	Expense	INR	3	23	23	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3675	Expense - Travel	400	Expense	INR	6	23	23	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3676	Expense - Housing	1100	Expense	INR	3	23	23	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3677	Expense - Shopping	200	Expense	INR	7	23	23	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3678	Expense - Education	400	Expense	INR	8	23	23	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3679	Expense - Transportation	200	Expense	INR	2	23	23	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3680	Expense - Utilities	300	Expense	INR	9	23	23	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3681	Expense - Utilities	200	Expense	INR	9	23	23	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3682	Expense - Miscellaneous	200	Expense	INR	10	23	23	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3683	Expense - Education	200	Expense	INR	8	23	23	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3684	Expense - Shopping	200	Expense	INR	7	23	23	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3685	Expense - Housing	800	Expense	INR	3	23	23	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3686	Expense - Transportation	200	Expense	INR	2	23	23	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3687	Expense - Food & Dining	200	Expense	INR	1	23	23	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3688	Expense - Miscellaneous	200	Expense	INR	10	23	23	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3689	Expense - Utilities	200	Expense	INR	9	23	23	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3690	Expense - Shopping	200	Expense	INR	7	23	23	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3691	Expense - Travel	200	Expense	INR	6	23	23	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3692	Expense - Utilities	200	Expense	INR	9	23	23	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3693	Expense - Housing	1000	Expense	INR	3	23	23	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3694	Expense - Housing	1400	Expense	INR	3	23	23	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3695	Expense - Housing	200	Expense	INR	3	23	23	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3696	Expense - Travel	200	Expense	INR	6	23	23	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3697	Expense - Education	200	Expense	INR	8	23	23	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3698	Expense - Travel	200	Expense	INR	6	23	23	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3699	Expense - Transportation	300	Expense	INR	2	23	23	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3700	Expense - Healthcare	200	Expense	INR	4	23	23	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3701	Expense - Healthcare	200	Expense	INR	4	23	23	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3702	Expense - Travel	200	Expense	INR	6	25	25	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3703	Expense - Education	200	Expense	INR	8	25	25	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3704	Expense - Entertainment	200	Expense	INR	5	25	25	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3705	Expense - Travel	200	Expense	INR	6	25	25	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3706	Expense - Miscellaneous	200	Expense	INR	10	25	25	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3707	Expense - Transportation	300	Expense	INR	2	25	25	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3708	Expense - Travel	200	Expense	INR	6	25	25	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3709	Expense - Food & Dining	1500	Expense	INR	1	25	25	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3710	Expense - Entertainment	200	Expense	INR	5	25	25	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3711	Expense - Miscellaneous	200	Expense	INR	10	25	25	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3712	Expense - Entertainment	200	Expense	INR	5	25	25	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3713	Expense - Healthcare	200	Expense	INR	4	25	25	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3714	Expense - Food & Dining	600	Expense	INR	1	25	25	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3715	Expense - Shopping	800	Expense	INR	7	25	25	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3716	Expense - Entertainment	200	Expense	INR	5	25	25	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3717	Expense - Housing	200	Expense	INR	3	25	25	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3718	Expense - Utilities	200	Expense	INR	9	25	25	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3719	Expense - Housing	1700	Expense	INR	3	25	25	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3720	Expense - Entertainment	200	Expense	INR	5	25	25	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3721	Expense - Food & Dining	300	Expense	INR	1	25	25	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3722	Expense - Transportation	200	Expense	INR	2	25	25	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3723	Expense - Housing	300	Expense	INR	3	25	25	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3724	Expense - Travel	200	Expense	INR	6	25	25	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3725	Expense - Transportation	900	Expense	INR	2	25	25	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3726	Expense - Utilities	500	Expense	INR	9	25	25	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3727	Expense - Travel	200	Expense	INR	6	25	25	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3728	Expense - Entertainment	200	Expense	INR	5	25	25	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3729	Expense - Travel	200	Expense	INR	6	25	25	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3730	Expense - Miscellaneous	200	Expense	INR	10	25	25	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3731	Expense - Education	200	Expense	INR	8	26	26	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3732	Expense - Miscellaneous	200	Expense	INR	10	26	26	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3733	Expense - Food & Dining	300	Expense	INR	1	26	26	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3734	Expense - Education	200	Expense	INR	8	26	26	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3735	Expense - Entertainment	200	Expense	INR	5	26	26	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3736	Expense - Food & Dining	400	Expense	INR	1	26	26	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3737	Expense - Transportation	300	Expense	INR	2	26	26	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3738	Expense - Shopping	600	Expense	INR	7	26	26	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3739	Expense - Housing	400	Expense	INR	3	26	26	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3740	Expense - Utilities	300	Expense	INR	9	26	26	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3741	Expense - Education	200	Expense	INR	8	26	26	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3742	Expense - Entertainment	200	Expense	INR	5	26	26	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3743	Expense - Entertainment	200	Expense	INR	5	26	26	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3744	Expense - Entertainment	200	Expense	INR	5	26	26	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3745	Expense - Healthcare	200	Expense	INR	4	26	26	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3746	Expense - Healthcare	200	Expense	INR	4	26	26	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3747	Expense - Transportation	700	Expense	INR	2	26	26	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3748	Expense - Food & Dining	200	Expense	INR	1	26	26	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3749	Expense - Utilities	600	Expense	INR	9	26	26	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3750	Expense - Education	200	Expense	INR	8	26	26	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3751	Expense - Shopping	300	Expense	INR	7	26	26	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3752	Expense - Utilities	200	Expense	INR	9	26	26	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3753	Expense - Travel	200	Expense	INR	6	26	26	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3754	Expense - Travel	200	Expense	INR	6	26	26	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3755	Expense - Housing	500	Expense	INR	3	26	26	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3756	Expense - Travel	200	Expense	INR	6	26	26	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3757	Expense - Healthcare	200	Expense	INR	4	26	26	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3758	Expense - Transportation	200	Expense	INR	2	26	26	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3759	Expense - Transportation	200	Expense	INR	2	26	26	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3760	Expense - Transportation	400	Expense	INR	2	26	26	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3761	Expense - Shopping	300	Expense	INR	7	26	26	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3762	Expense - Entertainment	400	Expense	INR	5	26	26	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3763	Expense - Housing	200	Expense	INR	3	26	26	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3764	Expense - Food & Dining	1700	Expense	INR	1	26	26	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3765	Expense - Utilities	200	Expense	INR	9	26	26	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3766	Expense - Miscellaneous	200	Expense	INR	10	26	26	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3767	Expense - Food & Dining	300	Expense	INR	1	26	26	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3768	Expense - Food & Dining	200	Expense	INR	1	26	26	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3769	Expense - Transportation	200	Expense	INR	2	26	26	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3770	Expense - Food & Dining	800	Expense	INR	1	26	26	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3771	Expense - Travel	200	Expense	INR	6	26	26	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3772	Expense - Housing	700	Expense	INR	3	26	26	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3773	Expense - Housing	600	Expense	INR	3	27	27	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3774	Expense - Entertainment	200	Expense	INR	5	27	27	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3775	Expense - Healthcare	200	Expense	INR	4	27	27	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3776	Expense - Shopping	200	Expense	INR	7	27	27	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3777	Expense - Shopping	200	Expense	INR	7	27	27	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3778	Expense - Food & Dining	200	Expense	INR	1	27	27	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3779	Expense - Education	200	Expense	INR	8	27	27	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3780	Expense - Housing	300	Expense	INR	3	27	27	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3781	Expense - Miscellaneous	200	Expense	INR	10	27	27	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3782	Expense - Transportation	400	Expense	INR	2	27	27	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3783	Expense - Food & Dining	1000	Expense	INR	1	27	27	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3784	Expense - Entertainment	200	Expense	INR	5	27	27	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3785	Expense - Travel	200	Expense	INR	6	27	27	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3786	Expense - Shopping	200	Expense	INR	7	27	27	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3787	Expense - Education	200	Expense	INR	8	27	27	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3788	Expense - Housing	800	Expense	INR	3	27	27	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3789	Expense - Food & Dining	200	Expense	INR	1	27	27	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3790	Expense - Shopping	400	Expense	INR	7	27	27	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3791	Expense - Shopping	200	Expense	INR	7	27	27	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3792	Expense - Transportation	600	Expense	INR	2	27	27	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3793	Expense - Food & Dining	500	Expense	INR	1	27	27	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3794	Expense - Healthcare	200	Expense	INR	4	27	27	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3795	Expense - Shopping	200	Expense	INR	7	28	28	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3796	Expense - Housing	200	Expense	INR	3	28	28	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3797	Expense - Shopping	200	Expense	INR	7	28	28	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3798	Expense - Education	200	Expense	INR	8	28	28	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3799	Expense - Entertainment	200	Expense	INR	5	28	28	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3800	Expense - Healthcare	200	Expense	INR	4	28	28	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3801	Expense - Healthcare	200	Expense	INR	4	28	28	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3802	Expense - Healthcare	200	Expense	INR	4	28	28	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3803	Expense - Travel	300	Expense	INR	6	28	28	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3804	Expense - Food & Dining	500	Expense	INR	1	28	28	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3805	Expense - Education	200	Expense	INR	8	28	28	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3806	Expense - Housing	2700	Expense	INR	3	28	28	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3807	Expense - Food & Dining	500	Expense	INR	1	28	28	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3808	Expense - Shopping	200	Expense	INR	7	28	28	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3809	Expense - Housing	2600	Expense	INR	3	28	28	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3810	Expense - Education	200	Expense	INR	8	28	28	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3811	Expense - Transportation	200	Expense	INR	2	28	28	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3812	Expense - Utilities	200	Expense	INR	9	28	28	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3813	Expense - Entertainment	200	Expense	INR	5	28	28	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3814	Expense - Healthcare	200	Expense	INR	4	28	28	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3815	Expense - Shopping	300	Expense	INR	7	28	28	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3816	Expense - Miscellaneous	200	Expense	INR	10	28	28	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3817	Expense - Shopping	200	Expense	INR	7	28	28	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3818	Expense - Utilities	200	Expense	INR	9	28	28	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3819	Expense - Housing	900	Expense	INR	3	28	28	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3820	Expense - Travel	200	Expense	INR	6	28	28	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3821	Expense - Utilities	200	Expense	INR	9	28	28	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3822	Expense - Shopping	700	Expense	INR	7	28	28	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3823	Expense - Shopping	200	Expense	INR	7	28	28	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3824	Expense - Entertainment	200	Expense	INR	5	28	28	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3825	Expense - Education	200	Expense	INR	8	28	28	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3826	Expense - Shopping	200	Expense	INR	7	28	28	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3827	Expense - Utilities	500	Expense	INR	9	28	28	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3828	Expense - Healthcare	200	Expense	INR	4	29	29	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3829	Expense - Transportation	200	Expense	INR	2	29	29	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3830	Expense - Miscellaneous	200	Expense	INR	10	29	29	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3831	Expense - Healthcare	200	Expense	INR	4	29	29	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3832	Expense - Food & Dining	800	Expense	INR	1	29	29	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3833	Expense - Healthcare	200	Expense	INR	4	29	29	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3834	Expense - Travel	200	Expense	INR	6	29	29	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3835	Expense - Transportation	300	Expense	INR	2	29	29	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3836	Expense - Food & Dining	400	Expense	INR	1	29	29	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3837	Expense - Utilities	200	Expense	INR	9	29	29	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3838	Expense - Housing	500	Expense	INR	3	29	29	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3839	Expense - Shopping	500	Expense	INR	7	29	29	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3840	Expense - Utilities	200	Expense	INR	9	29	29	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3841	Expense - Travel	200	Expense	INR	6	29	29	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3842	Expense - Food & Dining	200	Expense	INR	1	29	29	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3843	Expense - Transportation	200	Expense	INR	2	29	29	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3844	Expense - Housing	800	Expense	INR	3	29	29	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3845	Expense - Food & Dining	200	Expense	INR	1	29	29	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3846	Expense - Miscellaneous	200	Expense	INR	10	29	29	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3847	Expense - Entertainment	200	Expense	INR	5	29	29	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3848	Expense - Miscellaneous	200	Expense	INR	10	29	29	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3849	Expense - Healthcare	200	Expense	INR	4	29	29	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3850	Expense - Shopping	200	Expense	INR	7	29	29	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3851	Expense - Healthcare	400	Expense	INR	4	29	29	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3852	Expense - Education	200	Expense	INR	8	29	29	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3853	Expense - Housing	300	Expense	INR	3	29	29	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3854	Expense - Utilities	200	Expense	INR	9	29	29	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3855	Expense - Entertainment	200	Expense	INR	5	30	30	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3856	Expense - Housing	200	Expense	INR	3	30	30	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3857	Expense - Utilities	200	Expense	INR	9	30	30	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3858	Expense - Entertainment	200	Expense	INR	5	30	30	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3859	Expense - Food & Dining	400	Expense	INR	1	30	30	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3860	Expense - Transportation	200	Expense	INR	2	31	31	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3861	Expense - Miscellaneous	200	Expense	INR	10	31	31	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3862	Expense - Entertainment	200	Expense	INR	5	31	31	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3863	Expense - Housing	600	Expense	INR	3	31	31	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3864	Expense - Food & Dining	200	Expense	INR	1	32	32	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3865	Expense - Healthcare	200	Expense	INR	4	32	32	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3866	Expense - Travel	200	Expense	INR	6	32	32	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3867	Expense - Education	200	Expense	INR	8	32	32	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3868	Expense - Housing	1100	Expense	INR	3	32	32	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3869	Expense - Shopping	200	Expense	INR	7	32	32	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3870	Expense - Travel	200	Expense	INR	6	32	32	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3871	Expense - Miscellaneous	200	Expense	INR	10	32	32	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3872	Expense - Entertainment	200	Expense	INR	5	32	32	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3873	Expense - Utilities	200	Expense	INR	9	33	33	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3874	Expense - Entertainment	200	Expense	INR	5	33	33	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3875	Expense - Housing	400	Expense	INR	3	33	33	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3876	Expense - Utilities	200	Expense	INR	9	33	33	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3877	Expense - Transportation	200	Expense	INR	2	33	33	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3878	Expense - Utilities	300	Expense	INR	9	33	33	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3879	Expense - Miscellaneous	200	Expense	INR	10	33	33	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3880	Expense - Housing	600	Expense	INR	3	33	33	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3881	Expense - Shopping	200	Expense	INR	7	33	33	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3882	Expense - Healthcare	200	Expense	INR	4	33	33	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3883	Expense - Food & Dining	400	Expense	INR	1	33	33	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3884	Expense - Entertainment	200	Expense	INR	5	33	33	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3885	Expense - Entertainment	200	Expense	INR	5	33	33	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3886	Expense - Healthcare	200	Expense	INR	4	33	33	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3887	Expense - Food & Dining	200	Expense	INR	1	33	33	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3888	Expense - Education	200	Expense	INR	8	33	33	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3889	Expense - Housing	400	Expense	INR	3	33	33	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3890	Expense - Transportation	200	Expense	INR	2	33	33	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3891	Expense - Transportation	600	Expense	INR	2	33	33	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3892	Expense - Travel	200	Expense	INR	6	33	33	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3893	Expense - Utilities	200	Expense	INR	9	33	33	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3894	Expense - Miscellaneous	200	Expense	INR	10	33	33	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3895	Expense - Entertainment	200	Expense	INR	5	33	33	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3896	Expense - Healthcare	200	Expense	INR	4	33	33	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3897	Expense - Utilities	200	Expense	INR	9	33	33	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3898	Expense - Healthcare	200	Expense	INR	4	33	33	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3899	Expense - Miscellaneous	200	Expense	INR	10	33	33	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3900	Expense - Travel	200	Expense	INR	6	33	33	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3901	Expense - Food & Dining	200	Expense	INR	1	33	33	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3902	Expense - Shopping	200	Expense	INR	7	33	33	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3903	Expense - Utilities	200	Expense	INR	9	33	33	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3904	Expense - Entertainment	200	Expense	INR	5	33	33	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3905	Expense - Miscellaneous	200	Expense	INR	10	33	33	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3906	Expense - Healthcare	200	Expense	INR	4	33	33	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3907	Expense - Education	200	Expense	INR	8	33	33	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3908	Expense - Shopping	200	Expense	INR	7	33	33	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3909	Expense - Healthcare	500	Expense	INR	4	33	33	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3910	Expense - Transportation	200	Expense	INR	2	33	33	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3911	Expense - Food & Dining	500	Expense	INR	1	33	33	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3912	Expense - Food & Dining	700	Expense	INR	1	33	33	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3913	Expense - Transportation	200	Expense	INR	2	33	33	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3914	Expense - Food & Dining	200	Expense	INR	1	34	34	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3915	Expense - Food & Dining	200	Expense	INR	1	34	34	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3916	Expense - Healthcare	200	Expense	INR	4	35	35	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3917	Expense - Housing	400	Expense	INR	3	35	35	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3918	Expense - Food & Dining	200	Expense	INR	1	35	35	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3919	Expense - Miscellaneous	200	Expense	INR	10	35	35	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3920	Expense - Food & Dining	200	Expense	INR	1	35	35	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3921	Expense - Housing	200	Expense	INR	3	35	35	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3922	Expense - Housing	200	Expense	INR	3	35	35	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3923	Expense - Shopping	200	Expense	INR	7	36	36	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3924	Expense - Healthcare	200	Expense	INR	4	36	36	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3925	Expense - Travel	300	Expense	INR	6	36	36	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3926	Expense - Healthcare	200	Expense	INR	4	36	36	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3927	Expense - Shopping	200	Expense	INR	7	36	36	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3928	Expense - Miscellaneous	200	Expense	INR	10	36	36	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3929	Expense - Shopping	200	Expense	INR	7	36	36	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3930	Expense - Transportation	200	Expense	INR	2	36	36	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3931	Expense - Education	200	Expense	INR	8	36	36	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3932	Expense - Travel	200	Expense	INR	6	36	36	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3933	Expense - Utilities	200	Expense	INR	9	36	36	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3934	Expense - Entertainment	200	Expense	INR	5	36	36	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3935	Expense - Travel	300	Expense	INR	6	36	36	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3936	Expense - Utilities	200	Expense	INR	9	36	36	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3937	Expense - Food & Dining	200	Expense	INR	1	36	36	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3938	Expense - Travel	200	Expense	INR	6	36	36	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3939	Expense - Healthcare	400	Expense	INR	4	36	36	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3940	Expense - Housing	800	Expense	INR	3	37	37	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3941	Expense - Travel	300	Expense	INR	6	37	37	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3942	Expense - Entertainment	200	Expense	INR	5	37	37	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3943	Expense - Travel	200	Expense	INR	6	37	37	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3944	Expense - Shopping	200	Expense	INR	7	37	37	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3945	Expense - Entertainment	400	Expense	INR	5	37	37	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3946	Expense - Utilities	200	Expense	INR	9	37	37	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3947	Expense - Utilities	200	Expense	INR	9	37	37	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3948	Expense - Healthcare	200	Expense	INR	4	37	37	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3949	Expense - Travel	200	Expense	INR	6	37	37	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3950	Expense - Housing	3600	Expense	INR	3	37	37	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3951	Expense - Education	200	Expense	INR	8	37	37	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3952	Expense - Transportation	600	Expense	INR	2	37	37	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3953	Expense - Entertainment	200	Expense	INR	5	37	37	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3954	Expense - Travel	200	Expense	INR	6	37	37	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3955	Expense - Healthcare	300	Expense	INR	4	37	37	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3956	Expense - Housing	600	Expense	INR	3	38	38	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3957	Expense - Food & Dining	200	Expense	INR	1	38	38	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3958	Expense - Transportation	200	Expense	INR	2	39	39	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3959	Expense - Travel	200	Expense	INR	6	39	39	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3960	Expense - Shopping	400	Expense	INR	7	39	39	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3961	Expense - Transportation	200	Expense	INR	2	39	39	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3962	Expense - Healthcare	200	Expense	INR	4	39	39	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3963	Expense - Housing	900	Expense	INR	3	39	39	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3964	Expense - Miscellaneous	200	Expense	INR	10	39	39	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3965	Expense - Transportation	200	Expense	INR	2	39	39	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3966	Expense - Education	200	Expense	INR	8	39	39	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3967	Expense - Entertainment	200	Expense	INR	5	39	39	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3968	Expense - Shopping	200	Expense	INR	7	39	39	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3969	Expense - Travel	200	Expense	INR	6	39	39	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3970	Expense - Travel	200	Expense	INR	6	39	39	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3971	Expense - Transportation	700	Expense	INR	2	39	39	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3972	Expense - Entertainment	200	Expense	INR	5	39	39	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3973	Expense - Travel	200	Expense	INR	6	39	39	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
3974	Expense - Housing	2000	Expense	INR	3	39	39	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3975	Expense - Education	200	Expense	INR	8	39	39	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3976	Expense - Utilities	400	Expense	INR	9	39	39	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3977	Expense - Healthcare	200	Expense	INR	4	39	39	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3978	Expense - Shopping	200	Expense	INR	7	39	39	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3979	Expense - Travel	200	Expense	INR	6	39	39	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
3980	Expense - Housing	600	Expense	INR	3	39	39	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3981	Expense - Shopping	200	Expense	INR	7	39	39	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3982	Expense - Housing	300	Expense	INR	3	39	39	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3983	Expense - Housing	600	Expense	INR	3	40	40	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3984	Expense - Travel	200	Expense	INR	6	40	40	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3985	Expense - Shopping	200	Expense	INR	7	40	40	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3986	Expense - Healthcare	200	Expense	INR	4	40	40	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3987	Expense - Miscellaneous	200	Expense	INR	10	40	40	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3988	Expense - Education	200	Expense	INR	8	40	40	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3989	Expense - Education	400	Expense	INR	8	40	40	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3990	Expense - Education	200	Expense	INR	8	40	40	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
3991	Expense - Utilities	400	Expense	INR	9	40	40	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3992	Expense - Food & Dining	500	Expense	INR	1	40	40	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
3993	Expense - Food & Dining	800	Expense	INR	1	40	40	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
3994	Expense - Entertainment	300	Expense	INR	5	40	40	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
3995	Expense - Food & Dining	200	Expense	INR	1	40	40	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
3996	Expense - Food & Dining	200	Expense	INR	1	40	40	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
3997	Expense - Transportation	200	Expense	INR	2	40	40	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
3998	Expense - Housing	700	Expense	INR	3	40	40	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
3999	Expense - Travel	200	Expense	INR	6	42	42	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
4000	Expense - Healthcare	200	Expense	INR	4	42	42	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
4001	Expense - Travel	200	Expense	INR	6	42	42	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4002	Expense - Education	200	Expense	INR	8	42	42	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
4003	Expense - Education	200	Expense	INR	8	42	42	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
4004	Expense - Entertainment	200	Expense	INR	5	42	42	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
4005	Expense - Housing	600	Expense	INR	3	42	42	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
4006	Expense - Miscellaneous	200	Expense	INR	10	42	42	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4007	Expense - Entertainment	200	Expense	INR	5	42	42	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
4008	Expense - Entertainment	200	Expense	INR	5	42	42	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
4009	Expense - Housing	300	Expense	INR	3	42	42	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4010	Expense - Education	200	Expense	INR	8	42	42	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4011	Expense - Healthcare	500	Expense	INR	4	42	42	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
4012	Expense - Miscellaneous	200	Expense	INR	10	42	42	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4013	Expense - Healthcare	300	Expense	INR	4	42	42	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
4014	Expense - Travel	200	Expense	INR	6	42	42	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
4015	Expense - Food & Dining	700	Expense	INR	1	42	42	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4016	Expense - Utilities	700	Expense	INR	9	42	42	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4017	Expense - Miscellaneous	200	Expense	INR	10	42	42	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
4018	Expense - Healthcare	200	Expense	INR	4	42	42	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
4019	Expense - Education	200	Expense	INR	8	42	42	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
4020	Expense - Food & Dining	1900	Expense	INR	1	42	42	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
4021	Expense - Healthcare	200	Expense	INR	4	42	42	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
4022	Expense - Utilities	200	Expense	INR	9	42	42	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
4023	Expense - Transportation	200	Expense	INR	2	42	42	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4024	Expense - Healthcare	200	Expense	INR	4	42	42	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
4025	Expense - Utilities	200	Expense	INR	9	42	42	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4026	Expense - Travel	400	Expense	INR	6	42	42	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
4027	Expense - Education	200	Expense	INR	8	43	43	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
4028	Expense - Travel	400	Expense	INR	6	43	43	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
4029	Expense - Shopping	600	Expense	INR	7	43	43	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
4030	Expense - Shopping	200	Expense	INR	7	43	43	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
4031	Expense - Education	200	Expense	INR	8	43	43	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
4032	Expense - Healthcare	200	Expense	INR	4	43	43	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
4033	Expense - Entertainment	200	Expense	INR	5	43	43	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4034	Expense - Food & Dining	600	Expense	INR	1	43	43	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
4035	Expense - Healthcare	200	Expense	INR	4	43	43	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
4036	Expense - Miscellaneous	200	Expense	INR	10	43	43	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4037	Expense - Housing	400	Expense	INR	3	43	43	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4038	Expense - Travel	200	Expense	INR	6	43	43	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4039	Expense - Housing	1700	Expense	INR	3	43	43	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4040	Expense - Housing	200	Expense	INR	3	43	43	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
4041	Expense - Food & Dining	200	Expense	INR	1	43	43	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
4042	Expense - Healthcare	400	Expense	INR	4	43	43	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4043	Expense - Housing	200	Expense	INR	3	43	43	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
4044	Expense - Food & Dining	200	Expense	INR	1	43	43	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
4045	Expense - Food & Dining	700	Expense	INR	1	43	43	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
4046	Expense - Travel	200	Expense	INR	6	43	43	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
4047	Expense - Travel	200	Expense	INR	6	43	43	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4048	Expense - Housing	1000	Expense	INR	3	43	43	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4049	Expense - Healthcare	200	Expense	INR	4	43	43	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4050	Expense - Miscellaneous	200	Expense	INR	10	43	43	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4051	Expense - Travel	200	Expense	INR	6	43	43	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4052	Expense - Food & Dining	1200	Expense	INR	1	43	43	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
4053	Expense - Utilities	200	Expense	INR	9	43	43	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
4054	Expense - Education	400	Expense	INR	8	43	43	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
4055	Expense - Healthcare	200	Expense	INR	4	43	43	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4056	Expense - Miscellaneous	200	Expense	INR	10	43	43	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4057	Expense - Transportation	200	Expense	INR	2	43	43	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4058	Expense - Housing	800	Expense	INR	3	43	43	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
4059	Expense - Food & Dining	400	Expense	INR	1	43	43	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
4060	Expense - Utilities	700	Expense	INR	9	43	43	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4061	Expense - Education	500	Expense	INR	8	43	43	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4062	Expense - Healthcare	200	Expense	INR	4	43	43	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
4063	Expense - Healthcare	200	Expense	INR	4	43	43	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
4064	Expense - Travel	200	Expense	INR	6	43	43	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
4065	Expense - Shopping	700	Expense	INR	7	43	43	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4066	Expense - Transportation	200	Expense	INR	2	43	43	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
4067	Expense - Housing	200	Expense	INR	3	44	44	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
4068	Expense - Miscellaneous	200	Expense	INR	10	44	44	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
4069	Expense - Healthcare	200	Expense	INR	4	44	44	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4070	Expense - Travel	200	Expense	INR	6	44	44	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4071	Expense - Utilities	200	Expense	INR	9	44	44	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
4072	Expense - Housing	2000	Expense	INR	3	44	44	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
4073	Expense - Utilities	200	Expense	INR	9	44	44	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
4074	Expense - Education	200	Expense	INR	8	44	44	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
4075	Expense - Miscellaneous	200	Expense	INR	10	44	44	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4076	Expense - Education	200	Expense	INR	8	44	44	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4077	Expense - Travel	200	Expense	INR	6	44	44	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
4078	Expense - Entertainment	200	Expense	INR	5	44	44	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
4079	Expense - Transportation	700	Expense	INR	2	44	44	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
4080	Expense - Miscellaneous	200	Expense	INR	10	44	44	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4081	Expense - Miscellaneous	200	Expense	INR	10	44	44	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
4082	Expense - Food & Dining	200	Expense	INR	1	44	44	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
4083	Expense - Entertainment	200	Expense	INR	5	44	44	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
4084	Expense - Housing	1100	Expense	INR	3	44	44	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4085	Expense - Utilities	200	Expense	INR	9	44	44	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
4086	Expense - Entertainment	200	Expense	INR	5	44	44	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
4087	Expense - Utilities	200	Expense	INR	9	44	44	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4088	Expense - Food & Dining	300	Expense	INR	1	44	44	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4089	Expense - Miscellaneous	200	Expense	INR	10	44	44	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
4090	Expense - Housing	600	Expense	INR	3	44	44	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
4091	Expense - Shopping	200	Expense	INR	7	44	44	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4092	Expense - Food & Dining	300	Expense	INR	1	44	44	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4093	Expense - Food & Dining	200	Expense	INR	1	44	44	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
4094	Expense - Housing	2800	Expense	INR	3	44	44	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4095	Expense - Healthcare	200	Expense	INR	4	44	44	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4096	Expense - Utilities	300	Expense	INR	9	44	44	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4097	Expense - Utilities	200	Expense	INR	9	44	44	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
4098	Expense - Entertainment	200	Expense	INR	5	44	44	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
4099	Expense - Education	200	Expense	INR	8	44	44	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
4100	Expense - Shopping	200	Expense	INR	7	44	44	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
4101	Expense - Housing	300	Expense	INR	3	44	44	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4102	Expense - Food & Dining	300	Expense	INR	1	44	44	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
4103	Expense - Miscellaneous	200	Expense	INR	10	44	44	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4104	Expense - Housing	300	Expense	INR	3	44	44	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4105	Expense - Transportation	200	Expense	INR	2	44	44	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4106	Expense - Transportation	300	Expense	INR	2	44	44	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
4107	Expense - Travel	200	Expense	INR	6	44	44	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
4108	Expense - Healthcare	200	Expense	INR	4	44	44	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
4109	Expense - Travel	200	Expense	INR	6	44	44	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
4110	Expense - Miscellaneous	200	Expense	INR	10	45	45	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
4111	Expense - Miscellaneous	200	Expense	INR	10	45	45	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
4112	Expense - Miscellaneous	200	Expense	INR	10	45	45	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
4113	Expense - Entertainment	200	Expense	INR	5	45	45	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
4114	Expense - Education	200	Expense	INR	8	45	45	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
4115	Expense - Education	200	Expense	INR	8	45	45	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
4116	Expense - Healthcare	200	Expense	INR	4	45	45	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
4117	Expense - Entertainment	200	Expense	INR	5	45	45	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
4118	Expense - Miscellaneous	200	Expense	INR	10	45	45	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4119	Expense - Miscellaneous	200	Expense	INR	10	45	45	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
4120	Expense - Healthcare	200	Expense	INR	4	45	45	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
4121	Expense - Entertainment	200	Expense	INR	5	45	45	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
4122	Expense - Shopping	200	Expense	INR	7	45	45	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
4123	Expense - Transportation	200	Expense	INR	2	45	45	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
4124	Expense - Miscellaneous	200	Expense	INR	10	45	45	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
4125	Expense - Healthcare	200	Expense	INR	4	45	45	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4126	Expense - Miscellaneous	200	Expense	INR	10	45	45	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
4127	Expense - Housing	200	Expense	INR	3	45	45	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
4128	Expense - Food & Dining	2700	Expense	INR	1	45	45	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4129	Expense - Miscellaneous	200	Expense	INR	10	45	45	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4130	Expense - Food & Dining	200	Expense	INR	1	45	45	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
4131	Expense - Healthcare	200	Expense	INR	4	46	46	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4132	Expense - Travel	200	Expense	INR	6	48	48	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
4133	Expense - Miscellaneous	200	Expense	INR	10	48	48	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
4134	Expense - Miscellaneous	200	Expense	INR	10	48	48	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
4135	Expense - Travel	200	Expense	INR	6	48	48	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
4136	Expense - Utilities	200	Expense	INR	9	48	48	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
4137	Expense - Transportation	200	Expense	INR	2	48	48	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4138	Expense - Food & Dining	600	Expense	INR	1	48	48	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4139	Expense - Food & Dining	200	Expense	INR	1	48	48	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4140	Expense - Food & Dining	2000	Expense	INR	1	48	48	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
4141	Expense - Miscellaneous	200	Expense	INR	10	48	48	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
4142	Expense - Entertainment	400	Expense	INR	5	48	48	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4143	Expense - Entertainment	200	Expense	INR	5	48	48	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
4144	Expense - Shopping	200	Expense	INR	7	48	48	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
4145	Expense - Miscellaneous	200	Expense	INR	10	48	48	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
4146	Expense - Entertainment	300	Expense	INR	5	48	48	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
4147	Expense - Entertainment	200	Expense	INR	5	48	48	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4148	Expense - Entertainment	200	Expense	INR	5	48	48	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4149	Expense - Housing	1600	Expense	INR	3	48	48	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4150	Expense - Travel	200	Expense	INR	6	48	48	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4151	Expense - Utilities	300	Expense	INR	9	48	48	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4152	Expense - Education	200	Expense	INR	8	48	48	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4153	Expense - Shopping	200	Expense	INR	7	48	48	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
4154	Expense - Housing	1000	Expense	INR	3	48	48	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4155	Expense - Miscellaneous	200	Expense	INR	10	48	48	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4156	Expense - Shopping	700	Expense	INR	7	48	48	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
4157	Expense - Miscellaneous	200	Expense	INR	10	48	48	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
4158	Expense - Shopping	200	Expense	INR	7	48	48	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
4159	Expense - Utilities	200	Expense	INR	9	48	48	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
4160	Expense - Utilities	200	Expense	INR	9	48	48	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
4161	Expense - Housing	200	Expense	INR	3	48	48	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4162	Expense - Entertainment	200	Expense	INR	5	48	48	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
4163	Expense - Utilities	200	Expense	INR	9	48	48	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4164	Expense - Transportation	400	Expense	INR	2	48	48	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4165	Expense - Housing	1500	Expense	INR	3	48	48	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4166	Expense - Housing	200	Expense	INR	3	48	48	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
4167	Expense - Utilities	700	Expense	INR	9	48	48	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
4168	Expense - Healthcare	200	Expense	INR	4	48	48	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
4169	Expense - Shopping	200	Expense	INR	7	48	48	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4170	Expense - Travel	200	Expense	INR	6	48	48	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4171	Expense - Entertainment	200	Expense	INR	5	49	49	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4172	Expense - Utilities	200	Expense	INR	9	49	49	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
4173	Expense - Travel	200	Expense	INR	6	49	49	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4174	Expense - Transportation	200	Expense	INR	2	49	49	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
4175	Expense - Travel	200	Expense	INR	6	49	49	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
4176	Expense - Utilities	200	Expense	INR	9	49	49	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
4177	Salary Income	12600	Income	INR	11	1	1	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
4178	Salary Income	17300	Income	INR	11	2	2	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
4179	Salary Income	16800	Income	INR	11	2	2	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4180	Salary Income	8300	Income	INR	11	3	3	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
4181	Salary Income	12200	Income	INR	11	4	4	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4182	Salary Income	8300	Income	INR	11	6	6	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
4183	Salary Income	8500	Income	INR	11	6	6	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
4184	Salary Income	12600	Income	INR	11	9	9	2025-12-10 00:00:00	2025-12-10 17:57:56.172765	\N
4185	Salary Income	12900	Income	INR	11	9	9	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4186	Salary Income	12400	Income	INR	11	9	9	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
4187	Salary Income	12700	Income	INR	11	10	10	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
4188	Salary Income	12600	Income	INR	11	14	14	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
4189	Salary Income	17000	Income	INR	11	16	16	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
4190	Salary Income	48600	Income	INR	11	18	18	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
4191	Salary Income	50100	Income	INR	11	19	19	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
4192	Salary Income	24800	Income	INR	11	20	20	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4193	Salary Income	16000	Income	INR	11	25	25	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4194	Salary Income	17300	Income	INR	11	28	28	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
4195	Salary Income	8500	Income	INR	11	32	32	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4196	Salary Income	8600	Income	INR	11	32	32	2025-12-03 00:00:00	2025-12-10 17:57:56.172765	\N
4197	Salary Income	8600	Income	INR	11	32	32	2025-12-08 00:00:00	2025-12-10 17:57:56.172765	\N
4198	Salary Income	48500	Income	INR	11	33	33	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
4199	Salary Income	12600	Income	INR	11	34	34	2025-12-05 00:00:00	2025-12-10 17:57:56.172765	\N
4200	Salary Income	12400	Income	INR	11	34	34	2025-12-07 00:00:00	2025-12-10 17:57:56.172765	\N
4201	Salary Income	8200	Income	INR	11	38	38	2025-12-04 00:00:00	2025-12-10 17:57:56.172765	\N
4202	Salary Income	12600	Income	INR	11	39	39	2025-12-06 00:00:00	2025-12-10 17:57:56.172765	\N
4203	Salary Income	26000	Income	INR	11	41	41	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
4204	Salary Income	17000	Income	INR	11	44	44	2025-12-02 00:00:00	2025-12-10 17:57:56.172765	\N
4205	Salary Income	12200	Income	INR	11	45	45	2025-12-01 00:00:00	2025-12-10 17:57:56.172765	\N
4206	Salary Income	13000	Income	INR	11	45	45	2025-12-09 00:00:00	2025-12-10 17:57:56.172765	\N
\.


--
-- TOC entry 5003 (class 0 OID 18328)
-- Dependencies: 226
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, full_name, email, phone, password, role_id, is_active, created_at, updated_at) FROM stdin;
1	Irshad Ahmad	irshad_ahmad@hotmail.com	9090909090	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	1	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
2	Umair Ahmed	umair_ahmed@hotmail.com	8989898989	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	2	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
3	Rifa Ahmed	rifa_ahmed@hotmail.com	8888888888	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	2	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
4	John Doe	john.doe@example.com	1234567890	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	1	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
5	Jane Doe	jane.doe@example.com	1234567891	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	2	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
6	Bob Smith	bob.smith@example.com	1234567892	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	3	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
7	Alice Johnson	alice.johnson@example.com	1234567893	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	1	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
8	Charlie Brown	charlie.brown@example.com	1234567894	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	2	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
9	David Jones	david.jones@example.com	1234567895	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	3	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
10	Emily Williams	emily.williams@example.com	1234567896	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	1	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
11	Frank Lee	frank.lee@example.com	1234567897	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	2	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
12	George Miller	george.miller@example.com	1234567898	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	3	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
13	Harry White	harry.white@example.com	1234567899	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	1	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
14	Karen Johnson	karen.johnson@example.com	1234567900	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	2	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
15	Lisa Brown	lisa.brown@example.com	1234567901	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	3	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
16	Mike Davis	mike.davis@example.com	1234567902	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	1	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
17	Nancy Smith	nancy.smith@example.com	1234567903	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	2	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
18	Oliver Jones	oliver.jones@example.com	1234567904	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	3	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
19	Peter Johnson	peter.johnson@example.com	1234567905	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	1	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
20	Sarah Lee	sarah.lee@example.com	1234567906	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	2	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
21	Thomas Brown	thomas.brown@example.com	1234567907	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	3	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
22	Victoria Smith	victoria.smith@example.com	1234567908	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	1	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
23	William Jones	william.jones@example.com	1234567909	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	2	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
24	Zachary White	zachary.white@example.com	1234567910	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	3	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
25	Amy Johnson	amy.johnson@example.com	1234567911	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	1	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
26	Brian Brown	brian.brown@example.com	1234567912	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	2	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
27	Carol Jones	carol.jones@example.com	1234567913	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	3	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
28	Daniel Smith	daniel.smith@example.com	1234567914	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	1	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
29	Elizabeth Lee	elizabeth.lee@example.com	1234567915	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	2	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
30	Franklin Jones	franklin.jones@example.com	1234567916	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	3	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
31	George Williams	george.williams@example.com	1234567917	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	1	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
32	Helen Brown	helen.brown@example.com	1234567918	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	2	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
33	Isaac Johnson	isaac.johnson@example.com	1234567919	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	3	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
34	James Smith	james.smith@example.com	1234567920	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	1	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
35	Julie Jones	julie.jones@example.com	1234567921	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	2	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
36	Katherine Lee	katherine.lee@example.com	1234567922	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	3	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
37	Linda Johnson	linda.johnson@example.com	1234567923	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	1	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
38	Margaret Brown	margaret.brown@example.com	1234567924	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	2	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
39	Matthew Smith	matthew.smith@example.com	1234567925	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	3	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
40	Nicholas Jones	nicholas.jones@example.com	1234567926	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	1	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
41	Olivia Lee	olivia.lee@example.com	1234567927	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	2	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
42	Patrick Johnson	patrick.johnson@example.com	1234567928	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	3	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
43	Rachel Smith	rachel.smith@example.com	1234567929	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	1	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
44	Robert Jones	robert.jones@example.com	1234567930	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	2	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
45	Samuel Brown	samuel.brown@example.com	1234567931	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	3	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
46	Sophia Johnson	sophia.johnson@example.com	1234567932	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	1	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
47	Thomas Smith	thomas.smith@example.com	1234567933	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	2	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
48	Victoria Jones	victoria.jones@example.com	1234567934	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	3	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
49	William Brown	william.brown@example.com	1234567935	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	1	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
50	Zachary Johnson	zachary.johnson@example.com	1234567936	$2b$12$2qhRbSal4lQeQXagJStDiuiPGoyxNCVinnnZHpe91vymsp9Imsvhu	2	t	2025-11-22 09:29:08.012651	2025-11-22 09:29:08.012651
\.


--
-- TOC entry 5026 (class 0 OID 0)
-- Dependencies: 227
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_id_seq', 50, true);


--
-- TOC entry 5027 (class 0 OID 0)
-- Dependencies: 221
-- Name: audit_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.audit_logs_id_seq', 1, false);


--
-- TOC entry 5028 (class 0 OID 0)
-- Dependencies: 229
-- Name: budgets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.budgets_id_seq', 33, true);


--
-- TOC entry 5029 (class 0 OID 0)
-- Dependencies: 231
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 11, true);


--
-- TOC entry 5030 (class 0 OID 0)
-- Dependencies: 223
-- Name: feedbacks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.feedbacks_id_seq', 43, true);


--
-- TOC entry 5031 (class 0 OID 0)
-- Dependencies: 217
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 3, true);


--
-- TOC entry 5032 (class 0 OID 0)
-- Dependencies: 219
-- Name: tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tokens_id_seq', 1, false);


--
-- TOC entry 5033 (class 0 OID 0)
-- Dependencies: 233
-- Name: transactions_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq1', 4206, true);


--
-- TOC entry 5034 (class 0 OID 0)
-- Dependencies: 225
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 52, true);


--
-- TOC entry 4832 (class 2606 OID 18423)
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- TOC entry 4822 (class 2606 OID 16563)
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 4834 (class 2606 OID 18478)
-- Name: budgets budgets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.budgets
    ADD CONSTRAINT budgets_pkey PRIMARY KEY (id);


--
-- TOC entry 4836 (class 2606 OID 18508)
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- TOC entry 4838 (class 2606 OID 18506)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4840 (class 2606 OID 18510)
-- Name: categories categories_short_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_short_name_key UNIQUE (short_name);


--
-- TOC entry 4824 (class 2606 OID 18293)
-- Name: feedbacks feedbacks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedbacks_pkey PRIMARY KEY (id);


--
-- TOC entry 4816 (class 2606 OID 16500)
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- TOC entry 4818 (class 2606 OID 16498)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4820 (class 2606 OID 16548)
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 4842 (class 2606 OID 18555)
-- Name: transactions transactions_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey1 PRIMARY KEY (id);


--
-- TOC entry 4826 (class 2606 OID 18340)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4828 (class 2606 OID 18342)
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- TOC entry 4830 (class 2606 OID 18338)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4844 (class 2606 OID 18424)
-- Name: accounts accounts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4845 (class 2606 OID 18479)
-- Name: budgets budgets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.budgets
    ADD CONSTRAINT budgets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4843 (class 2606 OID 18343)
-- Name: users fk_role; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- TOC entry 4846 (class 2606 OID 18561)
-- Name: transactions transactions_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- TOC entry 4847 (class 2606 OID 18556)
-- Name: transactions transactions_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- TOC entry 4848 (class 2606 OID 18566)
-- Name: transactions transactions_user_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_fkey1 FOREIGN KEY (user_id) REFERENCES public.users(id);


-- Completed on 2026-03-08 14:43:19

--
-- PostgreSQL database dump complete
--

