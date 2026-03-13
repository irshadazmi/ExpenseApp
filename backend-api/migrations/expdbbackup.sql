--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2026-03-12 12:07:23

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
1	Monthly Total Budget	40000	INR	Monthly	2026-02-01 00:00:00	\N	1	1	\N	t	2026-03-08 15:53:36.533215	\N
2	Food & Dining Budget	8800	INR	Monthly	2026-02-01 00:00:00	\N	1	1	1	t	2026-03-08 15:53:36.533215	\N
3	Transportation Budget	4000	INR	Monthly	2026-02-01 00:00:00	\N	1	1	2	t	2026-03-08 15:53:36.533215	\N
4	Housing Budget	12000	INR	Monthly	2026-02-01 00:00:00	\N	1	1	3	t	2026-03-08 15:53:36.533215	\N
5	Healthcare Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	1	4	t	2026-03-08 15:53:36.533215	\N
6	Entertainment Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	1	5	t	2026-03-08 15:53:36.533215	\N
7	Travel Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	1	6	t	2026-03-08 15:53:36.533215	\N
8	Shopping Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	1	7	t	2026-03-08 15:53:36.533215	\N
9	Education Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	1	8	t	2026-03-08 15:53:36.533215	\N
10	Utilities Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	1	9	t	2026-03-08 15:53:36.533215	\N
11	Miscellaneous Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	1	10	t	2026-03-08 15:53:36.533215	\N
12	Monthly Total Budget	20000	INR	Monthly	2026-02-01 00:00:00	\N	1	2	\N	t	2026-03-08 15:53:36.533215	\N
13	Food & Dining Budget	4400	INR	Monthly	2026-02-01 00:00:00	\N	1	2	1	t	2026-03-08 15:53:36.533215	\N
14	Transportation Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	2	2	t	2026-03-08 15:53:36.533215	\N
15	Housing Budget	6000	INR	Monthly	2026-02-01 00:00:00	\N	1	2	3	t	2026-03-08 15:53:36.533215	\N
16	Healthcare Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	2	4	t	2026-03-08 15:53:36.533215	\N
17	Entertainment Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	2	5	t	2026-03-08 15:53:36.533215	\N
18	Travel Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	2	6	t	2026-03-08 15:53:36.533215	\N
19	Shopping Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	2	7	t	2026-03-08 15:53:36.533215	\N
20	Education Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	2	8	t	2026-03-08 15:53:36.533215	\N
21	Utilities Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	2	9	t	2026-03-08 15:53:36.533215	\N
22	Miscellaneous Budget	400	INR	Monthly	2026-02-01 00:00:00	\N	1	2	10	t	2026-03-08 15:53:36.533215	\N
23	Monthly Total Budget	30000	INR	Monthly	2026-02-01 00:00:00	\N	1	3	\N	t	2026-03-08 15:53:36.533215	\N
24	Food & Dining Budget	6600	INR	Monthly	2026-02-01 00:00:00	\N	1	3	1	t	2026-03-08 15:53:36.533215	\N
25	Transportation Budget	3000	INR	Monthly	2026-02-01 00:00:00	\N	1	3	2	t	2026-03-08 15:53:36.533215	\N
26	Housing Budget	9000	INR	Monthly	2026-02-01 00:00:00	\N	1	3	3	t	2026-03-08 15:53:36.533215	\N
27	Healthcare Budget	1800	INR	Monthly	2026-02-01 00:00:00	\N	1	3	4	t	2026-03-08 15:53:36.533215	\N
28	Entertainment Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	3	5	t	2026-03-08 15:53:36.533215	\N
29	Travel Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	3	6	t	2026-03-08 15:53:36.533215	\N
30	Shopping Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	3	7	t	2026-03-08 15:53:36.533215	\N
31	Education Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	3	8	t	2026-03-08 15:53:36.533215	\N
32	Utilities Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	3	9	t	2026-03-08 15:53:36.533215	\N
33	Miscellaneous Budget	600	INR	Monthly	2026-02-01 00:00:00	\N	1	3	10	t	2026-03-08 15:53:36.533215	\N
34	Monthly Total Budget	20000	INR	Monthly	2026-02-01 00:00:00	\N	1	4	\N	t	2026-03-08 15:53:36.533215	\N
35	Food & Dining Budget	4400	INR	Monthly	2026-02-01 00:00:00	\N	1	4	1	t	2026-03-08 15:53:36.533215	\N
36	Transportation Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	4	2	t	2026-03-08 15:53:36.533215	\N
37	Housing Budget	6000	INR	Monthly	2026-02-01 00:00:00	\N	1	4	3	t	2026-03-08 15:53:36.533215	\N
38	Healthcare Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	4	4	t	2026-03-08 15:53:36.533215	\N
39	Entertainment Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	4	5	t	2026-03-08 15:53:36.533215	\N
40	Travel Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	4	6	t	2026-03-08 15:53:36.533215	\N
41	Shopping Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	4	7	t	2026-03-08 15:53:36.533215	\N
42	Education Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	4	8	t	2026-03-08 15:53:36.533215	\N
43	Utilities Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	4	9	t	2026-03-08 15:53:36.533215	\N
44	Miscellaneous Budget	400	INR	Monthly	2026-02-01 00:00:00	\N	1	4	10	t	2026-03-08 15:53:36.533215	\N
45	Monthly Total Budget	40000	INR	Monthly	2026-02-01 00:00:00	\N	1	5	\N	t	2026-03-08 15:53:36.533215	\N
46	Food & Dining Budget	8800	INR	Monthly	2026-02-01 00:00:00	\N	1	5	1	t	2026-03-08 15:53:36.533215	\N
47	Transportation Budget	4000	INR	Monthly	2026-02-01 00:00:00	\N	1	5	2	t	2026-03-08 15:53:36.533215	\N
48	Housing Budget	12000	INR	Monthly	2026-02-01 00:00:00	\N	1	5	3	t	2026-03-08 15:53:36.533215	\N
49	Healthcare Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	5	4	t	2026-03-08 15:53:36.533215	\N
50	Entertainment Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	5	5	t	2026-03-08 15:53:36.533215	\N
51	Travel Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	5	6	t	2026-03-08 15:53:36.533215	\N
52	Shopping Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	5	7	t	2026-03-08 15:53:36.533215	\N
53	Education Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	5	8	t	2026-03-08 15:53:36.533215	\N
54	Utilities Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	5	9	t	2026-03-08 15:53:36.533215	\N
55	Miscellaneous Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	5	10	t	2026-03-08 15:53:36.533215	\N
56	Monthly Total Budget	30000	INR	Monthly	2026-02-01 00:00:00	\N	1	6	\N	t	2026-03-08 15:53:36.533215	\N
57	Food & Dining Budget	6600	INR	Monthly	2026-02-01 00:00:00	\N	1	6	1	t	2026-03-08 15:53:36.533215	\N
58	Transportation Budget	3000	INR	Monthly	2026-02-01 00:00:00	\N	1	6	2	t	2026-03-08 15:53:36.533215	\N
59	Housing Budget	9000	INR	Monthly	2026-02-01 00:00:00	\N	1	6	3	t	2026-03-08 15:53:36.533215	\N
60	Healthcare Budget	1800	INR	Monthly	2026-02-01 00:00:00	\N	1	6	4	t	2026-03-08 15:53:36.533215	\N
61	Entertainment Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	6	5	t	2026-03-08 15:53:36.533215	\N
62	Travel Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	6	6	t	2026-03-08 15:53:36.533215	\N
63	Shopping Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	6	7	t	2026-03-08 15:53:36.533215	\N
64	Education Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	6	8	t	2026-03-08 15:53:36.533215	\N
65	Utilities Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	6	9	t	2026-03-08 15:53:36.533215	\N
66	Miscellaneous Budget	600	INR	Monthly	2026-02-01 00:00:00	\N	1	6	10	t	2026-03-08 15:53:36.533215	\N
67	Monthly Total Budget	20000	INR	Monthly	2026-02-01 00:00:00	\N	1	7	\N	t	2026-03-08 15:53:36.533215	\N
68	Food & Dining Budget	4400	INR	Monthly	2026-02-01 00:00:00	\N	1	7	1	t	2026-03-08 15:53:36.533215	\N
69	Transportation Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	7	2	t	2026-03-08 15:53:36.533215	\N
70	Housing Budget	6000	INR	Monthly	2026-02-01 00:00:00	\N	1	7	3	t	2026-03-08 15:53:36.533215	\N
71	Healthcare Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	7	4	t	2026-03-08 15:53:36.533215	\N
72	Entertainment Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	7	5	t	2026-03-08 15:53:36.533215	\N
73	Travel Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	7	6	t	2026-03-08 15:53:36.533215	\N
74	Shopping Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	7	7	t	2026-03-08 15:53:36.533215	\N
75	Education Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	7	8	t	2026-03-08 15:53:36.533215	\N
76	Utilities Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	7	9	t	2026-03-08 15:53:36.533215	\N
77	Miscellaneous Budget	400	INR	Monthly	2026-02-01 00:00:00	\N	1	7	10	t	2026-03-08 15:53:36.533215	\N
78	Monthly Total Budget	40000	INR	Monthly	2026-02-01 00:00:00	\N	1	8	\N	t	2026-03-08 15:53:36.533215	\N
79	Food & Dining Budget	8800	INR	Monthly	2026-02-01 00:00:00	\N	1	8	1	t	2026-03-08 15:53:36.533215	\N
80	Transportation Budget	4000	INR	Monthly	2026-02-01 00:00:00	\N	1	8	2	t	2026-03-08 15:53:36.533215	\N
81	Housing Budget	12000	INR	Monthly	2026-02-01 00:00:00	\N	1	8	3	t	2026-03-08 15:53:36.533215	\N
82	Healthcare Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	8	4	t	2026-03-08 15:53:36.533215	\N
83	Entertainment Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	8	5	t	2026-03-08 15:53:36.533215	\N
84	Travel Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	8	6	t	2026-03-08 15:53:36.533215	\N
85	Shopping Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	8	7	t	2026-03-08 15:53:36.533215	\N
86	Education Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	8	8	t	2026-03-08 15:53:36.533215	\N
87	Utilities Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	8	9	t	2026-03-08 15:53:36.533215	\N
88	Miscellaneous Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	8	10	t	2026-03-08 15:53:36.533215	\N
89	Monthly Total Budget	40000	INR	Monthly	2026-02-01 00:00:00	\N	1	9	\N	t	2026-03-08 15:53:36.533215	\N
90	Food & Dining Budget	8800	INR	Monthly	2026-02-01 00:00:00	\N	1	9	1	t	2026-03-08 15:53:36.533215	\N
91	Transportation Budget	4000	INR	Monthly	2026-02-01 00:00:00	\N	1	9	2	t	2026-03-08 15:53:36.533215	\N
92	Housing Budget	12000	INR	Monthly	2026-02-01 00:00:00	\N	1	9	3	t	2026-03-08 15:53:36.533215	\N
93	Healthcare Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	9	4	t	2026-03-08 15:53:36.533215	\N
94	Entertainment Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	9	5	t	2026-03-08 15:53:36.533215	\N
95	Travel Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	9	6	t	2026-03-08 15:53:36.533215	\N
96	Shopping Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	9	7	t	2026-03-08 15:53:36.533215	\N
97	Education Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	9	8	t	2026-03-08 15:53:36.533215	\N
98	Utilities Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	9	9	t	2026-03-08 15:53:36.533215	\N
99	Miscellaneous Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	9	10	t	2026-03-08 15:53:36.533215	\N
100	Monthly Total Budget	20000	INR	Monthly	2026-02-01 00:00:00	\N	1	10	\N	t	2026-03-08 15:53:36.533215	\N
101	Food & Dining Budget	4400	INR	Monthly	2026-02-01 00:00:00	\N	1	10	1	t	2026-03-08 15:53:36.533215	\N
102	Transportation Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	10	2	t	2026-03-08 15:53:36.533215	\N
103	Housing Budget	6000	INR	Monthly	2026-02-01 00:00:00	\N	1	10	3	t	2026-03-08 15:53:36.533215	\N
104	Healthcare Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	10	4	t	2026-03-08 15:53:36.533215	\N
105	Entertainment Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	10	5	t	2026-03-08 15:53:36.533215	\N
106	Travel Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	10	6	t	2026-03-08 15:53:36.533215	\N
107	Shopping Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	10	7	t	2026-03-08 15:53:36.533215	\N
108	Education Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	10	8	t	2026-03-08 15:53:36.533215	\N
109	Utilities Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	10	9	t	2026-03-08 15:53:36.533215	\N
110	Miscellaneous Budget	400	INR	Monthly	2026-02-01 00:00:00	\N	1	10	10	t	2026-03-08 15:53:36.533215	\N
111	Monthly Total Budget	40000	INR	Monthly	2026-02-01 00:00:00	\N	1	11	\N	t	2026-03-08 15:53:36.533215	\N
112	Food & Dining Budget	8800	INR	Monthly	2026-02-01 00:00:00	\N	1	11	1	t	2026-03-08 15:53:36.533215	\N
113	Transportation Budget	4000	INR	Monthly	2026-02-01 00:00:00	\N	1	11	2	t	2026-03-08 15:53:36.533215	\N
114	Housing Budget	12000	INR	Monthly	2026-02-01 00:00:00	\N	1	11	3	t	2026-03-08 15:53:36.533215	\N
115	Healthcare Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	11	4	t	2026-03-08 15:53:36.533215	\N
116	Entertainment Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	11	5	t	2026-03-08 15:53:36.533215	\N
117	Travel Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	11	6	t	2026-03-08 15:53:36.533215	\N
118	Shopping Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	11	7	t	2026-03-08 15:53:36.533215	\N
119	Education Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	11	8	t	2026-03-08 15:53:36.533215	\N
120	Utilities Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	11	9	t	2026-03-08 15:53:36.533215	\N
121	Miscellaneous Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	11	10	t	2026-03-08 15:53:36.533215	\N
122	Monthly Total Budget	30000	INR	Monthly	2026-02-01 00:00:00	\N	1	12	\N	t	2026-03-08 15:53:36.533215	\N
123	Food & Dining Budget	6600	INR	Monthly	2026-02-01 00:00:00	\N	1	12	1	t	2026-03-08 15:53:36.533215	\N
124	Transportation Budget	3000	INR	Monthly	2026-02-01 00:00:00	\N	1	12	2	t	2026-03-08 15:53:36.533215	\N
125	Housing Budget	9000	INR	Monthly	2026-02-01 00:00:00	\N	1	12	3	t	2026-03-08 15:53:36.533215	\N
126	Healthcare Budget	1800	INR	Monthly	2026-02-01 00:00:00	\N	1	12	4	t	2026-03-08 15:53:36.533215	\N
127	Entertainment Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	12	5	t	2026-03-08 15:53:36.533215	\N
128	Travel Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	12	6	t	2026-03-08 15:53:36.533215	\N
129	Shopping Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	12	7	t	2026-03-08 15:53:36.533215	\N
130	Education Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	12	8	t	2026-03-08 15:53:36.533215	\N
131	Utilities Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	12	9	t	2026-03-08 15:53:36.533215	\N
132	Miscellaneous Budget	600	INR	Monthly	2026-02-01 00:00:00	\N	1	12	10	t	2026-03-08 15:53:36.533215	\N
133	Monthly Total Budget	20000	INR	Monthly	2026-02-01 00:00:00	\N	1	13	\N	t	2026-03-08 15:53:36.533215	\N
134	Food & Dining Budget	4400	INR	Monthly	2026-02-01 00:00:00	\N	1	13	1	t	2026-03-08 15:53:36.533215	\N
135	Transportation Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	13	2	t	2026-03-08 15:53:36.533215	\N
136	Housing Budget	6000	INR	Monthly	2026-02-01 00:00:00	\N	1	13	3	t	2026-03-08 15:53:36.533215	\N
137	Healthcare Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	13	4	t	2026-03-08 15:53:36.533215	\N
138	Entertainment Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	13	5	t	2026-03-08 15:53:36.533215	\N
139	Travel Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	13	6	t	2026-03-08 15:53:36.533215	\N
140	Shopping Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	13	7	t	2026-03-08 15:53:36.533215	\N
141	Education Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	13	8	t	2026-03-08 15:53:36.533215	\N
142	Utilities Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	13	9	t	2026-03-08 15:53:36.533215	\N
143	Miscellaneous Budget	400	INR	Monthly	2026-02-01 00:00:00	\N	1	13	10	t	2026-03-08 15:53:36.533215	\N
144	Monthly Total Budget	40000	INR	Monthly	2026-02-01 00:00:00	\N	1	14	\N	t	2026-03-08 15:53:36.533215	\N
145	Food & Dining Budget	8800	INR	Monthly	2026-02-01 00:00:00	\N	1	14	1	t	2026-03-08 15:53:36.533215	\N
146	Transportation Budget	4000	INR	Monthly	2026-02-01 00:00:00	\N	1	14	2	t	2026-03-08 15:53:36.533215	\N
147	Housing Budget	12000	INR	Monthly	2026-02-01 00:00:00	\N	1	14	3	t	2026-03-08 15:53:36.533215	\N
148	Healthcare Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	14	4	t	2026-03-08 15:53:36.533215	\N
149	Entertainment Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	14	5	t	2026-03-08 15:53:36.533215	\N
150	Travel Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	14	6	t	2026-03-08 15:53:36.533215	\N
151	Shopping Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	14	7	t	2026-03-08 15:53:36.533215	\N
152	Education Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	14	8	t	2026-03-08 15:53:36.533215	\N
153	Utilities Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	14	9	t	2026-03-08 15:53:36.533215	\N
154	Miscellaneous Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	14	10	t	2026-03-08 15:53:36.533215	\N
155	Monthly Total Budget	40000	INR	Monthly	2026-02-01 00:00:00	\N	1	15	\N	t	2026-03-08 15:53:36.533215	\N
156	Food & Dining Budget	8800	INR	Monthly	2026-02-01 00:00:00	\N	1	15	1	t	2026-03-08 15:53:36.533215	\N
157	Transportation Budget	4000	INR	Monthly	2026-02-01 00:00:00	\N	1	15	2	t	2026-03-08 15:53:36.533215	\N
158	Housing Budget	12000	INR	Monthly	2026-02-01 00:00:00	\N	1	15	3	t	2026-03-08 15:53:36.533215	\N
159	Healthcare Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	15	4	t	2026-03-08 15:53:36.533215	\N
160	Entertainment Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	15	5	t	2026-03-08 15:53:36.533215	\N
161	Travel Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	15	6	t	2026-03-08 15:53:36.533215	\N
162	Shopping Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	15	7	t	2026-03-08 15:53:36.533215	\N
163	Education Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	15	8	t	2026-03-08 15:53:36.533215	\N
164	Utilities Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	15	9	t	2026-03-08 15:53:36.533215	\N
165	Miscellaneous Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	15	10	t	2026-03-08 15:53:36.533215	\N
166	Monthly Total Budget	40000	INR	Monthly	2026-02-01 00:00:00	\N	1	16	\N	t	2026-03-08 15:53:36.533215	\N
167	Food & Dining Budget	8800	INR	Monthly	2026-02-01 00:00:00	\N	1	16	1	t	2026-03-08 15:53:36.533215	\N
168	Transportation Budget	4000	INR	Monthly	2026-02-01 00:00:00	\N	1	16	2	t	2026-03-08 15:53:36.533215	\N
169	Housing Budget	12000	INR	Monthly	2026-02-01 00:00:00	\N	1	16	3	t	2026-03-08 15:53:36.533215	\N
170	Healthcare Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	16	4	t	2026-03-08 15:53:36.533215	\N
171	Entertainment Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	16	5	t	2026-03-08 15:53:36.533215	\N
172	Travel Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	16	6	t	2026-03-08 15:53:36.533215	\N
173	Shopping Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	16	7	t	2026-03-08 15:53:36.533215	\N
174	Education Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	16	8	t	2026-03-08 15:53:36.533215	\N
175	Utilities Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	16	9	t	2026-03-08 15:53:36.533215	\N
176	Miscellaneous Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	16	10	t	2026-03-08 15:53:36.533215	\N
177	Monthly Total Budget	30000	INR	Monthly	2026-02-01 00:00:00	\N	1	17	\N	t	2026-03-08 15:53:36.533215	\N
178	Food & Dining Budget	6600	INR	Monthly	2026-02-01 00:00:00	\N	1	17	1	t	2026-03-08 15:53:36.533215	\N
179	Transportation Budget	3000	INR	Monthly	2026-02-01 00:00:00	\N	1	17	2	t	2026-03-08 15:53:36.533215	\N
180	Housing Budget	9000	INR	Monthly	2026-02-01 00:00:00	\N	1	17	3	t	2026-03-08 15:53:36.533215	\N
181	Healthcare Budget	1800	INR	Monthly	2026-02-01 00:00:00	\N	1	17	4	t	2026-03-08 15:53:36.533215	\N
182	Entertainment Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	17	5	t	2026-03-08 15:53:36.533215	\N
183	Travel Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	17	6	t	2026-03-08 15:53:36.533215	\N
184	Shopping Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	17	7	t	2026-03-08 15:53:36.533215	\N
185	Education Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	17	8	t	2026-03-08 15:53:36.533215	\N
186	Utilities Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	17	9	t	2026-03-08 15:53:36.533215	\N
187	Miscellaneous Budget	600	INR	Monthly	2026-02-01 00:00:00	\N	1	17	10	t	2026-03-08 15:53:36.533215	\N
188	Monthly Total Budget	20000	INR	Monthly	2026-02-01 00:00:00	\N	1	18	\N	t	2026-03-08 15:53:36.533215	\N
189	Food & Dining Budget	4400	INR	Monthly	2026-02-01 00:00:00	\N	1	18	1	t	2026-03-08 15:53:36.533215	\N
190	Transportation Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	18	2	t	2026-03-08 15:53:36.533215	\N
191	Housing Budget	6000	INR	Monthly	2026-02-01 00:00:00	\N	1	18	3	t	2026-03-08 15:53:36.533215	\N
192	Healthcare Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	18	4	t	2026-03-08 15:53:36.533215	\N
193	Entertainment Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	18	5	t	2026-03-08 15:53:36.533215	\N
194	Travel Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	18	6	t	2026-03-08 15:53:36.533215	\N
195	Shopping Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	18	7	t	2026-03-08 15:53:36.533215	\N
196	Education Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	18	8	t	2026-03-08 15:53:36.533215	\N
197	Utilities Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	18	9	t	2026-03-08 15:53:36.533215	\N
198	Miscellaneous Budget	400	INR	Monthly	2026-02-01 00:00:00	\N	1	18	10	t	2026-03-08 15:53:36.533215	\N
199	Monthly Total Budget	20000	INR	Monthly	2026-02-01 00:00:00	\N	1	19	\N	t	2026-03-08 15:53:36.533215	\N
200	Food & Dining Budget	4400	INR	Monthly	2026-02-01 00:00:00	\N	1	19	1	t	2026-03-08 15:53:36.533215	\N
201	Transportation Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	19	2	t	2026-03-08 15:53:36.533215	\N
202	Housing Budget	6000	INR	Monthly	2026-02-01 00:00:00	\N	1	19	3	t	2026-03-08 15:53:36.533215	\N
203	Healthcare Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	19	4	t	2026-03-08 15:53:36.533215	\N
204	Entertainment Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	19	5	t	2026-03-08 15:53:36.533215	\N
205	Travel Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	19	6	t	2026-03-08 15:53:36.533215	\N
206	Shopping Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	19	7	t	2026-03-08 15:53:36.533215	\N
207	Education Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	19	8	t	2026-03-08 15:53:36.533215	\N
208	Utilities Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	19	9	t	2026-03-08 15:53:36.533215	\N
209	Miscellaneous Budget	400	INR	Monthly	2026-02-01 00:00:00	\N	1	19	10	t	2026-03-08 15:53:36.533215	\N
210	Monthly Total Budget	20000	INR	Monthly	2026-02-01 00:00:00	\N	1	20	\N	t	2026-03-08 15:53:36.533215	\N
211	Food & Dining Budget	4400	INR	Monthly	2026-02-01 00:00:00	\N	1	20	1	t	2026-03-08 15:53:36.533215	\N
212	Transportation Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	20	2	t	2026-03-08 15:53:36.533215	\N
213	Housing Budget	6000	INR	Monthly	2026-02-01 00:00:00	\N	1	20	3	t	2026-03-08 15:53:36.533215	\N
214	Healthcare Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	20	4	t	2026-03-08 15:53:36.533215	\N
215	Entertainment Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	20	5	t	2026-03-08 15:53:36.533215	\N
216	Travel Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	20	6	t	2026-03-08 15:53:36.533215	\N
217	Shopping Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	20	7	t	2026-03-08 15:53:36.533215	\N
218	Education Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	20	8	t	2026-03-08 15:53:36.533215	\N
219	Utilities Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	20	9	t	2026-03-08 15:53:36.533215	\N
220	Miscellaneous Budget	400	INR	Monthly	2026-02-01 00:00:00	\N	1	20	10	t	2026-03-08 15:53:36.533215	\N
221	Monthly Total Budget	30000	INR	Monthly	2026-02-01 00:00:00	\N	1	21	\N	t	2026-03-08 15:53:36.533215	\N
222	Food & Dining Budget	6600	INR	Monthly	2026-02-01 00:00:00	\N	1	21	1	t	2026-03-08 15:53:36.533215	\N
223	Transportation Budget	3000	INR	Monthly	2026-02-01 00:00:00	\N	1	21	2	t	2026-03-08 15:53:36.533215	\N
224	Housing Budget	9000	INR	Monthly	2026-02-01 00:00:00	\N	1	21	3	t	2026-03-08 15:53:36.533215	\N
225	Healthcare Budget	1800	INR	Monthly	2026-02-01 00:00:00	\N	1	21	4	t	2026-03-08 15:53:36.533215	\N
226	Entertainment Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	21	5	t	2026-03-08 15:53:36.533215	\N
227	Travel Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	21	6	t	2026-03-08 15:53:36.533215	\N
228	Shopping Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	21	7	t	2026-03-08 15:53:36.533215	\N
229	Education Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	21	8	t	2026-03-08 15:53:36.533215	\N
230	Utilities Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	21	9	t	2026-03-08 15:53:36.533215	\N
231	Miscellaneous Budget	600	INR	Monthly	2026-02-01 00:00:00	\N	1	21	10	t	2026-03-08 15:53:36.533215	\N
232	Monthly Total Budget	20000	INR	Monthly	2026-02-01 00:00:00	\N	1	22	\N	t	2026-03-08 15:53:36.533215	\N
233	Food & Dining Budget	4400	INR	Monthly	2026-02-01 00:00:00	\N	1	22	1	t	2026-03-08 15:53:36.533215	\N
234	Transportation Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	22	2	t	2026-03-08 15:53:36.533215	\N
235	Housing Budget	6000	INR	Monthly	2026-02-01 00:00:00	\N	1	22	3	t	2026-03-08 15:53:36.533215	\N
236	Healthcare Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	22	4	t	2026-03-08 15:53:36.533215	\N
237	Entertainment Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	22	5	t	2026-03-08 15:53:36.533215	\N
238	Travel Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	22	6	t	2026-03-08 15:53:36.533215	\N
239	Shopping Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	22	7	t	2026-03-08 15:53:36.533215	\N
240	Education Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	22	8	t	2026-03-08 15:53:36.533215	\N
241	Utilities Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	22	9	t	2026-03-08 15:53:36.533215	\N
242	Miscellaneous Budget	400	INR	Monthly	2026-02-01 00:00:00	\N	1	22	10	t	2026-03-08 15:53:36.533215	\N
243	Monthly Total Budget	40000	INR	Monthly	2026-02-01 00:00:00	\N	1	23	\N	t	2026-03-08 15:53:36.533215	\N
244	Food & Dining Budget	8800	INR	Monthly	2026-02-01 00:00:00	\N	1	23	1	t	2026-03-08 15:53:36.533215	\N
245	Transportation Budget	4000	INR	Monthly	2026-02-01 00:00:00	\N	1	23	2	t	2026-03-08 15:53:36.533215	\N
246	Housing Budget	12000	INR	Monthly	2026-02-01 00:00:00	\N	1	23	3	t	2026-03-08 15:53:36.533215	\N
247	Healthcare Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	23	4	t	2026-03-08 15:53:36.533215	\N
248	Entertainment Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	23	5	t	2026-03-08 15:53:36.533215	\N
249	Travel Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	23	6	t	2026-03-08 15:53:36.533215	\N
250	Shopping Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	23	7	t	2026-03-08 15:53:36.533215	\N
251	Education Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	23	8	t	2026-03-08 15:53:36.533215	\N
252	Utilities Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	23	9	t	2026-03-08 15:53:36.533215	\N
253	Miscellaneous Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	23	10	t	2026-03-08 15:53:36.533215	\N
254	Monthly Total Budget	40000	INR	Monthly	2026-02-01 00:00:00	\N	1	24	\N	t	2026-03-08 15:53:36.533215	\N
255	Food & Dining Budget	8800	INR	Monthly	2026-02-01 00:00:00	\N	1	24	1	t	2026-03-08 15:53:36.533215	\N
256	Transportation Budget	4000	INR	Monthly	2026-02-01 00:00:00	\N	1	24	2	t	2026-03-08 15:53:36.533215	\N
257	Housing Budget	12000	INR	Monthly	2026-02-01 00:00:00	\N	1	24	3	t	2026-03-08 15:53:36.533215	\N
258	Healthcare Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	24	4	t	2026-03-08 15:53:36.533215	\N
259	Entertainment Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	24	5	t	2026-03-08 15:53:36.533215	\N
260	Travel Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	24	6	t	2026-03-08 15:53:36.533215	\N
261	Shopping Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	24	7	t	2026-03-08 15:53:36.533215	\N
262	Education Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	24	8	t	2026-03-08 15:53:36.533215	\N
263	Utilities Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	24	9	t	2026-03-08 15:53:36.533215	\N
264	Miscellaneous Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	24	10	t	2026-03-08 15:53:36.533215	\N
265	Monthly Total Budget	40000	INR	Monthly	2026-02-01 00:00:00	\N	1	25	\N	t	2026-03-08 15:53:36.533215	\N
266	Food & Dining Budget	8800	INR	Monthly	2026-02-01 00:00:00	\N	1	25	1	t	2026-03-08 15:53:36.533215	\N
267	Transportation Budget	4000	INR	Monthly	2026-02-01 00:00:00	\N	1	25	2	t	2026-03-08 15:53:36.533215	\N
268	Housing Budget	12000	INR	Monthly	2026-02-01 00:00:00	\N	1	25	3	t	2026-03-08 15:53:36.533215	\N
269	Healthcare Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	25	4	t	2026-03-08 15:53:36.533215	\N
270	Entertainment Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	25	5	t	2026-03-08 15:53:36.533215	\N
271	Travel Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	25	6	t	2026-03-08 15:53:36.533215	\N
272	Shopping Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	25	7	t	2026-03-08 15:53:36.533215	\N
273	Education Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	25	8	t	2026-03-08 15:53:36.533215	\N
274	Utilities Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	25	9	t	2026-03-08 15:53:36.533215	\N
275	Miscellaneous Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	25	10	t	2026-03-08 15:53:36.533215	\N
276	Monthly Total Budget	20000	INR	Monthly	2026-02-01 00:00:00	\N	1	26	\N	t	2026-03-08 15:53:36.533215	\N
277	Food & Dining Budget	4400	INR	Monthly	2026-02-01 00:00:00	\N	1	26	1	t	2026-03-08 15:53:36.533215	\N
278	Transportation Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	26	2	t	2026-03-08 15:53:36.533215	\N
279	Housing Budget	6000	INR	Monthly	2026-02-01 00:00:00	\N	1	26	3	t	2026-03-08 15:53:36.533215	\N
280	Healthcare Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	26	4	t	2026-03-08 15:53:36.533215	\N
281	Entertainment Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	26	5	t	2026-03-08 15:53:36.533215	\N
282	Travel Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	26	6	t	2026-03-08 15:53:36.533215	\N
283	Shopping Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	26	7	t	2026-03-08 15:53:36.533215	\N
284	Education Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	26	8	t	2026-03-08 15:53:36.533215	\N
285	Utilities Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	26	9	t	2026-03-08 15:53:36.533215	\N
286	Miscellaneous Budget	400	INR	Monthly	2026-02-01 00:00:00	\N	1	26	10	t	2026-03-08 15:53:36.533215	\N
287	Monthly Total Budget	30000	INR	Monthly	2026-02-01 00:00:00	\N	1	27	\N	t	2026-03-08 15:53:36.533215	\N
288	Food & Dining Budget	6600	INR	Monthly	2026-02-01 00:00:00	\N	1	27	1	t	2026-03-08 15:53:36.533215	\N
289	Transportation Budget	3000	INR	Monthly	2026-02-01 00:00:00	\N	1	27	2	t	2026-03-08 15:53:36.533215	\N
290	Housing Budget	9000	INR	Monthly	2026-02-01 00:00:00	\N	1	27	3	t	2026-03-08 15:53:36.533215	\N
291	Healthcare Budget	1800	INR	Monthly	2026-02-01 00:00:00	\N	1	27	4	t	2026-03-08 15:53:36.533215	\N
292	Entertainment Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	27	5	t	2026-03-08 15:53:36.533215	\N
293	Travel Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	27	6	t	2026-03-08 15:53:36.533215	\N
294	Shopping Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	27	7	t	2026-03-08 15:53:36.533215	\N
295	Education Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	27	8	t	2026-03-08 15:53:36.533215	\N
296	Utilities Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	27	9	t	2026-03-08 15:53:36.533215	\N
297	Miscellaneous Budget	600	INR	Monthly	2026-02-01 00:00:00	\N	1	27	10	t	2026-03-08 15:53:36.533215	\N
298	Monthly Total Budget	40000	INR	Monthly	2026-02-01 00:00:00	\N	1	28	\N	t	2026-03-08 15:53:36.533215	\N
299	Food & Dining Budget	8800	INR	Monthly	2026-02-01 00:00:00	\N	1	28	1	t	2026-03-08 15:53:36.533215	\N
300	Transportation Budget	4000	INR	Monthly	2026-02-01 00:00:00	\N	1	28	2	t	2026-03-08 15:53:36.533215	\N
301	Housing Budget	12000	INR	Monthly	2026-02-01 00:00:00	\N	1	28	3	t	2026-03-08 15:53:36.533215	\N
302	Healthcare Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	28	4	t	2026-03-08 15:53:36.533215	\N
303	Entertainment Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	28	5	t	2026-03-08 15:53:36.533215	\N
304	Travel Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	28	6	t	2026-03-08 15:53:36.533215	\N
305	Shopping Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	28	7	t	2026-03-08 15:53:36.533215	\N
306	Education Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	28	8	t	2026-03-08 15:53:36.533215	\N
307	Utilities Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	28	9	t	2026-03-08 15:53:36.533215	\N
308	Miscellaneous Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	28	10	t	2026-03-08 15:53:36.533215	\N
309	Monthly Total Budget	30000	INR	Monthly	2026-02-01 00:00:00	\N	1	29	\N	t	2026-03-08 15:53:36.533215	\N
310	Food & Dining Budget	6600	INR	Monthly	2026-02-01 00:00:00	\N	1	29	1	t	2026-03-08 15:53:36.533215	\N
311	Transportation Budget	3000	INR	Monthly	2026-02-01 00:00:00	\N	1	29	2	t	2026-03-08 15:53:36.533215	\N
312	Housing Budget	9000	INR	Monthly	2026-02-01 00:00:00	\N	1	29	3	t	2026-03-08 15:53:36.533215	\N
313	Healthcare Budget	1800	INR	Monthly	2026-02-01 00:00:00	\N	1	29	4	t	2026-03-08 15:53:36.533215	\N
314	Entertainment Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	29	5	t	2026-03-08 15:53:36.533215	\N
315	Travel Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	29	6	t	2026-03-08 15:53:36.533215	\N
316	Shopping Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	29	7	t	2026-03-08 15:53:36.533215	\N
317	Education Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	29	8	t	2026-03-08 15:53:36.533215	\N
318	Utilities Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	29	9	t	2026-03-08 15:53:36.533215	\N
319	Miscellaneous Budget	600	INR	Monthly	2026-02-01 00:00:00	\N	1	29	10	t	2026-03-08 15:53:36.533215	\N
320	Monthly Total Budget	40000	INR	Monthly	2026-02-01 00:00:00	\N	1	30	\N	t	2026-03-08 15:53:36.533215	\N
321	Food & Dining Budget	8800	INR	Monthly	2026-02-01 00:00:00	\N	1	30	1	t	2026-03-08 15:53:36.533215	\N
322	Transportation Budget	4000	INR	Monthly	2026-02-01 00:00:00	\N	1	30	2	t	2026-03-08 15:53:36.533215	\N
323	Housing Budget	12000	INR	Monthly	2026-02-01 00:00:00	\N	1	30	3	t	2026-03-08 15:53:36.533215	\N
324	Healthcare Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	30	4	t	2026-03-08 15:53:36.533215	\N
325	Entertainment Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	30	5	t	2026-03-08 15:53:36.533215	\N
326	Travel Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	30	6	t	2026-03-08 15:53:36.533215	\N
327	Shopping Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	30	7	t	2026-03-08 15:53:36.533215	\N
328	Education Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	30	8	t	2026-03-08 15:53:36.533215	\N
329	Utilities Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	30	9	t	2026-03-08 15:53:36.533215	\N
330	Miscellaneous Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	30	10	t	2026-03-08 15:53:36.533215	\N
331	Monthly Total Budget	20000	INR	Monthly	2026-02-01 00:00:00	\N	1	31	\N	t	2026-03-08 15:53:36.533215	\N
332	Food & Dining Budget	4400	INR	Monthly	2026-02-01 00:00:00	\N	1	31	1	t	2026-03-08 15:53:36.533215	\N
333	Transportation Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	31	2	t	2026-03-08 15:53:36.533215	\N
334	Housing Budget	6000	INR	Monthly	2026-02-01 00:00:00	\N	1	31	3	t	2026-03-08 15:53:36.533215	\N
335	Healthcare Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	31	4	t	2026-03-08 15:53:36.533215	\N
336	Entertainment Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	31	5	t	2026-03-08 15:53:36.533215	\N
337	Travel Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	31	6	t	2026-03-08 15:53:36.533215	\N
338	Shopping Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	31	7	t	2026-03-08 15:53:36.533215	\N
339	Education Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	31	8	t	2026-03-08 15:53:36.533215	\N
340	Utilities Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	31	9	t	2026-03-08 15:53:36.533215	\N
341	Miscellaneous Budget	400	INR	Monthly	2026-02-01 00:00:00	\N	1	31	10	t	2026-03-08 15:53:36.533215	\N
342	Monthly Total Budget	20000	INR	Monthly	2026-02-01 00:00:00	\N	1	32	\N	t	2026-03-08 15:53:36.533215	\N
343	Food & Dining Budget	4400	INR	Monthly	2026-02-01 00:00:00	\N	1	32	1	t	2026-03-08 15:53:36.533215	\N
344	Transportation Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	32	2	t	2026-03-08 15:53:36.533215	\N
345	Housing Budget	6000	INR	Monthly	2026-02-01 00:00:00	\N	1	32	3	t	2026-03-08 15:53:36.533215	\N
346	Healthcare Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	32	4	t	2026-03-08 15:53:36.533215	\N
347	Entertainment Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	32	5	t	2026-03-08 15:53:36.533215	\N
348	Travel Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	32	6	t	2026-03-08 15:53:36.533215	\N
349	Shopping Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	32	7	t	2026-03-08 15:53:36.533215	\N
350	Education Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	32	8	t	2026-03-08 15:53:36.533215	\N
351	Utilities Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	32	9	t	2026-03-08 15:53:36.533215	\N
352	Miscellaneous Budget	400	INR	Monthly	2026-02-01 00:00:00	\N	1	32	10	t	2026-03-08 15:53:36.533215	\N
353	Monthly Total Budget	20000	INR	Monthly	2026-02-01 00:00:00	\N	1	33	\N	t	2026-03-08 15:53:36.533215	\N
354	Food & Dining Budget	4400	INR	Monthly	2026-02-01 00:00:00	\N	1	33	1	t	2026-03-08 15:53:36.533215	\N
355	Transportation Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	33	2	t	2026-03-08 15:53:36.533215	\N
356	Housing Budget	6000	INR	Monthly	2026-02-01 00:00:00	\N	1	33	3	t	2026-03-08 15:53:36.533215	\N
357	Healthcare Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	33	4	t	2026-03-08 15:53:36.533215	\N
358	Entertainment Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	33	5	t	2026-03-08 15:53:36.533215	\N
359	Travel Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	33	6	t	2026-03-08 15:53:36.533215	\N
360	Shopping Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	33	7	t	2026-03-08 15:53:36.533215	\N
361	Education Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	33	8	t	2026-03-08 15:53:36.533215	\N
362	Utilities Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	33	9	t	2026-03-08 15:53:36.533215	\N
363	Miscellaneous Budget	400	INR	Monthly	2026-02-01 00:00:00	\N	1	33	10	t	2026-03-08 15:53:36.533215	\N
364	Monthly Total Budget	30000	INR	Monthly	2026-02-01 00:00:00	\N	1	34	\N	t	2026-03-08 15:53:36.533215	\N
365	Food & Dining Budget	6600	INR	Monthly	2026-02-01 00:00:00	\N	1	34	1	t	2026-03-08 15:53:36.533215	\N
366	Transportation Budget	3000	INR	Monthly	2026-02-01 00:00:00	\N	1	34	2	t	2026-03-08 15:53:36.533215	\N
367	Housing Budget	9000	INR	Monthly	2026-02-01 00:00:00	\N	1	34	3	t	2026-03-08 15:53:36.533215	\N
368	Healthcare Budget	1800	INR	Monthly	2026-02-01 00:00:00	\N	1	34	4	t	2026-03-08 15:53:36.533215	\N
369	Entertainment Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	34	5	t	2026-03-08 15:53:36.533215	\N
370	Travel Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	34	6	t	2026-03-08 15:53:36.533215	\N
371	Shopping Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	34	7	t	2026-03-08 15:53:36.533215	\N
372	Education Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	34	8	t	2026-03-08 15:53:36.533215	\N
373	Utilities Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	34	9	t	2026-03-08 15:53:36.533215	\N
374	Miscellaneous Budget	600	INR	Monthly	2026-02-01 00:00:00	\N	1	34	10	t	2026-03-08 15:53:36.533215	\N
375	Monthly Total Budget	20000	INR	Monthly	2026-02-01 00:00:00	\N	1	35	\N	t	2026-03-08 15:53:36.533215	\N
376	Food & Dining Budget	4400	INR	Monthly	2026-02-01 00:00:00	\N	1	35	1	t	2026-03-08 15:53:36.533215	\N
377	Transportation Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	35	2	t	2026-03-08 15:53:36.533215	\N
378	Housing Budget	6000	INR	Monthly	2026-02-01 00:00:00	\N	1	35	3	t	2026-03-08 15:53:36.533215	\N
379	Healthcare Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	35	4	t	2026-03-08 15:53:36.533215	\N
380	Entertainment Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	35	5	t	2026-03-08 15:53:36.533215	\N
381	Travel Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	35	6	t	2026-03-08 15:53:36.533215	\N
382	Shopping Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	35	7	t	2026-03-08 15:53:36.533215	\N
383	Education Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	35	8	t	2026-03-08 15:53:36.533215	\N
384	Utilities Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	35	9	t	2026-03-08 15:53:36.533215	\N
385	Miscellaneous Budget	400	INR	Monthly	2026-02-01 00:00:00	\N	1	35	10	t	2026-03-08 15:53:36.533215	\N
386	Monthly Total Budget	20000	INR	Monthly	2026-02-01 00:00:00	\N	1	36	\N	t	2026-03-08 15:53:36.533215	\N
387	Food & Dining Budget	4400	INR	Monthly	2026-02-01 00:00:00	\N	1	36	1	t	2026-03-08 15:53:36.533215	\N
388	Transportation Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	36	2	t	2026-03-08 15:53:36.533215	\N
389	Housing Budget	6000	INR	Monthly	2026-02-01 00:00:00	\N	1	36	3	t	2026-03-08 15:53:36.533215	\N
390	Healthcare Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	36	4	t	2026-03-08 15:53:36.533215	\N
391	Entertainment Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	36	5	t	2026-03-08 15:53:36.533215	\N
392	Travel Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	36	6	t	2026-03-08 15:53:36.533215	\N
393	Shopping Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	36	7	t	2026-03-08 15:53:36.533215	\N
394	Education Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	36	8	t	2026-03-08 15:53:36.533215	\N
395	Utilities Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	36	9	t	2026-03-08 15:53:36.533215	\N
396	Miscellaneous Budget	400	INR	Monthly	2026-02-01 00:00:00	\N	1	36	10	t	2026-03-08 15:53:36.533215	\N
397	Monthly Total Budget	20000	INR	Monthly	2026-02-01 00:00:00	\N	1	37	\N	t	2026-03-08 15:53:36.533215	\N
398	Food & Dining Budget	4400	INR	Monthly	2026-02-01 00:00:00	\N	1	37	1	t	2026-03-08 15:53:36.533215	\N
399	Transportation Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	37	2	t	2026-03-08 15:53:36.533215	\N
400	Housing Budget	6000	INR	Monthly	2026-02-01 00:00:00	\N	1	37	3	t	2026-03-08 15:53:36.533215	\N
401	Healthcare Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	37	4	t	2026-03-08 15:53:36.533215	\N
402	Entertainment Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	37	5	t	2026-03-08 15:53:36.533215	\N
403	Travel Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	37	6	t	2026-03-08 15:53:36.533215	\N
404	Shopping Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	37	7	t	2026-03-08 15:53:36.533215	\N
405	Education Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	37	8	t	2026-03-08 15:53:36.533215	\N
406	Utilities Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	37	9	t	2026-03-08 15:53:36.533215	\N
407	Miscellaneous Budget	400	INR	Monthly	2026-02-01 00:00:00	\N	1	37	10	t	2026-03-08 15:53:36.533215	\N
408	Monthly Total Budget	30000	INR	Monthly	2026-02-01 00:00:00	\N	1	38	\N	t	2026-03-08 15:53:36.533215	\N
409	Food & Dining Budget	6600	INR	Monthly	2026-02-01 00:00:00	\N	1	38	1	t	2026-03-08 15:53:36.533215	\N
410	Transportation Budget	3000	INR	Monthly	2026-02-01 00:00:00	\N	1	38	2	t	2026-03-08 15:53:36.533215	\N
411	Housing Budget	9000	INR	Monthly	2026-02-01 00:00:00	\N	1	38	3	t	2026-03-08 15:53:36.533215	\N
412	Healthcare Budget	1800	INR	Monthly	2026-02-01 00:00:00	\N	1	38	4	t	2026-03-08 15:53:36.533215	\N
413	Entertainment Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	38	5	t	2026-03-08 15:53:36.533215	\N
414	Travel Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	38	6	t	2026-03-08 15:53:36.533215	\N
415	Shopping Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	38	7	t	2026-03-08 15:53:36.533215	\N
416	Education Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	38	8	t	2026-03-08 15:53:36.533215	\N
417	Utilities Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	38	9	t	2026-03-08 15:53:36.533215	\N
418	Miscellaneous Budget	600	INR	Monthly	2026-02-01 00:00:00	\N	1	38	10	t	2026-03-08 15:53:36.533215	\N
419	Monthly Total Budget	40000	INR	Monthly	2026-02-01 00:00:00	\N	1	39	\N	t	2026-03-08 15:53:36.533215	\N
420	Food & Dining Budget	8800	INR	Monthly	2026-02-01 00:00:00	\N	1	39	1	t	2026-03-08 15:53:36.533215	\N
421	Transportation Budget	4000	INR	Monthly	2026-02-01 00:00:00	\N	1	39	2	t	2026-03-08 15:53:36.533215	\N
422	Housing Budget	12000	INR	Monthly	2026-02-01 00:00:00	\N	1	39	3	t	2026-03-08 15:53:36.533215	\N
423	Healthcare Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	39	4	t	2026-03-08 15:53:36.533215	\N
424	Entertainment Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	39	5	t	2026-03-08 15:53:36.533215	\N
425	Travel Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	39	6	t	2026-03-08 15:53:36.533215	\N
426	Shopping Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	39	7	t	2026-03-08 15:53:36.533215	\N
427	Education Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	39	8	t	2026-03-08 15:53:36.533215	\N
428	Utilities Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	39	9	t	2026-03-08 15:53:36.533215	\N
429	Miscellaneous Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	39	10	t	2026-03-08 15:53:36.533215	\N
430	Monthly Total Budget	30000	INR	Monthly	2026-02-01 00:00:00	\N	1	40	\N	t	2026-03-08 15:53:36.533215	\N
431	Food & Dining Budget	6600	INR	Monthly	2026-02-01 00:00:00	\N	1	40	1	t	2026-03-08 15:53:36.533215	\N
432	Transportation Budget	3000	INR	Monthly	2026-02-01 00:00:00	\N	1	40	2	t	2026-03-08 15:53:36.533215	\N
433	Housing Budget	9000	INR	Monthly	2026-02-01 00:00:00	\N	1	40	3	t	2026-03-08 15:53:36.533215	\N
434	Healthcare Budget	1800	INR	Monthly	2026-02-01 00:00:00	\N	1	40	4	t	2026-03-08 15:53:36.533215	\N
435	Entertainment Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	40	5	t	2026-03-08 15:53:36.533215	\N
436	Travel Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	40	6	t	2026-03-08 15:53:36.533215	\N
437	Shopping Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	40	7	t	2026-03-08 15:53:36.533215	\N
438	Education Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	40	8	t	2026-03-08 15:53:36.533215	\N
439	Utilities Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	40	9	t	2026-03-08 15:53:36.533215	\N
440	Miscellaneous Budget	600	INR	Monthly	2026-02-01 00:00:00	\N	1	40	10	t	2026-03-08 15:53:36.533215	\N
441	Monthly Total Budget	20000	INR	Monthly	2026-02-01 00:00:00	\N	1	41	\N	t	2026-03-08 15:53:36.533215	\N
442	Food & Dining Budget	4400	INR	Monthly	2026-02-01 00:00:00	\N	1	41	1	t	2026-03-08 15:53:36.533215	\N
443	Transportation Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	41	2	t	2026-03-08 15:53:36.533215	\N
444	Housing Budget	6000	INR	Monthly	2026-02-01 00:00:00	\N	1	41	3	t	2026-03-08 15:53:36.533215	\N
445	Healthcare Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	41	4	t	2026-03-08 15:53:36.533215	\N
446	Entertainment Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	41	5	t	2026-03-08 15:53:36.533215	\N
447	Travel Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	41	6	t	2026-03-08 15:53:36.533215	\N
448	Shopping Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	41	7	t	2026-03-08 15:53:36.533215	\N
449	Education Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	41	8	t	2026-03-08 15:53:36.533215	\N
450	Utilities Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	41	9	t	2026-03-08 15:53:36.533215	\N
451	Miscellaneous Budget	400	INR	Monthly	2026-02-01 00:00:00	\N	1	41	10	t	2026-03-08 15:53:36.533215	\N
452	Monthly Total Budget	30000	INR	Monthly	2026-02-01 00:00:00	\N	1	42	\N	t	2026-03-08 15:53:36.533215	\N
453	Food & Dining Budget	6600	INR	Monthly	2026-02-01 00:00:00	\N	1	42	1	t	2026-03-08 15:53:36.533215	\N
454	Transportation Budget	3000	INR	Monthly	2026-02-01 00:00:00	\N	1	42	2	t	2026-03-08 15:53:36.533215	\N
455	Housing Budget	9000	INR	Monthly	2026-02-01 00:00:00	\N	1	42	3	t	2026-03-08 15:53:36.533215	\N
456	Healthcare Budget	1800	INR	Monthly	2026-02-01 00:00:00	\N	1	42	4	t	2026-03-08 15:53:36.533215	\N
457	Entertainment Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	42	5	t	2026-03-08 15:53:36.533215	\N
458	Travel Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	42	6	t	2026-03-08 15:53:36.533215	\N
459	Shopping Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	42	7	t	2026-03-08 15:53:36.533215	\N
460	Education Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	42	8	t	2026-03-08 15:53:36.533215	\N
461	Utilities Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	42	9	t	2026-03-08 15:53:36.533215	\N
462	Miscellaneous Budget	600	INR	Monthly	2026-02-01 00:00:00	\N	1	42	10	t	2026-03-08 15:53:36.533215	\N
463	Monthly Total Budget	30000	INR	Monthly	2026-02-01 00:00:00	\N	1	43	\N	t	2026-03-08 15:53:36.533215	\N
464	Food & Dining Budget	6600	INR	Monthly	2026-02-01 00:00:00	\N	1	43	1	t	2026-03-08 15:53:36.533215	\N
465	Transportation Budget	3000	INR	Monthly	2026-02-01 00:00:00	\N	1	43	2	t	2026-03-08 15:53:36.533215	\N
466	Housing Budget	9000	INR	Monthly	2026-02-01 00:00:00	\N	1	43	3	t	2026-03-08 15:53:36.533215	\N
467	Healthcare Budget	1800	INR	Monthly	2026-02-01 00:00:00	\N	1	43	4	t	2026-03-08 15:53:36.533215	\N
468	Entertainment Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	43	5	t	2026-03-08 15:53:36.533215	\N
469	Travel Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	43	6	t	2026-03-08 15:53:36.533215	\N
470	Shopping Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	43	7	t	2026-03-08 15:53:36.533215	\N
471	Education Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	43	8	t	2026-03-08 15:53:36.533215	\N
472	Utilities Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	43	9	t	2026-03-08 15:53:36.533215	\N
473	Miscellaneous Budget	600	INR	Monthly	2026-02-01 00:00:00	\N	1	43	10	t	2026-03-08 15:53:36.533215	\N
474	Monthly Total Budget	20000	INR	Monthly	2026-02-01 00:00:00	\N	1	44	\N	t	2026-03-08 15:53:36.533215	\N
475	Food & Dining Budget	4400	INR	Monthly	2026-02-01 00:00:00	\N	1	44	1	t	2026-03-08 15:53:36.533215	\N
476	Transportation Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	44	2	t	2026-03-08 15:53:36.533215	\N
477	Housing Budget	6000	INR	Monthly	2026-02-01 00:00:00	\N	1	44	3	t	2026-03-08 15:53:36.533215	\N
478	Healthcare Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	44	4	t	2026-03-08 15:53:36.533215	\N
479	Entertainment Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	44	5	t	2026-03-08 15:53:36.533215	\N
480	Travel Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	44	6	t	2026-03-08 15:53:36.533215	\N
481	Shopping Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	44	7	t	2026-03-08 15:53:36.533215	\N
482	Education Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	44	8	t	2026-03-08 15:53:36.533215	\N
483	Utilities Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	44	9	t	2026-03-08 15:53:36.533215	\N
484	Miscellaneous Budget	400	INR	Monthly	2026-02-01 00:00:00	\N	1	44	10	t	2026-03-08 15:53:36.533215	\N
485	Monthly Total Budget	20000	INR	Monthly	2026-02-01 00:00:00	\N	1	45	\N	t	2026-03-08 15:53:36.533215	\N
486	Food & Dining Budget	4400	INR	Monthly	2026-02-01 00:00:00	\N	1	45	1	t	2026-03-08 15:53:36.533215	\N
487	Transportation Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	45	2	t	2026-03-08 15:53:36.533215	\N
488	Housing Budget	6000	INR	Monthly	2026-02-01 00:00:00	\N	1	45	3	t	2026-03-08 15:53:36.533215	\N
489	Healthcare Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	45	4	t	2026-03-08 15:53:36.533215	\N
490	Entertainment Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	45	5	t	2026-03-08 15:53:36.533215	\N
491	Travel Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	45	6	t	2026-03-08 15:53:36.533215	\N
492	Shopping Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	45	7	t	2026-03-08 15:53:36.533215	\N
493	Education Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	45	8	t	2026-03-08 15:53:36.533215	\N
494	Utilities Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	45	9	t	2026-03-08 15:53:36.533215	\N
495	Miscellaneous Budget	400	INR	Monthly	2026-02-01 00:00:00	\N	1	45	10	t	2026-03-08 15:53:36.533215	\N
496	Monthly Total Budget	20000	INR	Monthly	2026-02-01 00:00:00	\N	1	46	\N	t	2026-03-08 15:53:36.533215	\N
497	Food & Dining Budget	4400	INR	Monthly	2026-02-01 00:00:00	\N	1	46	1	t	2026-03-08 15:53:36.533215	\N
498	Transportation Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	46	2	t	2026-03-08 15:53:36.533215	\N
499	Housing Budget	6000	INR	Monthly	2026-02-01 00:00:00	\N	1	46	3	t	2026-03-08 15:53:36.533215	\N
500	Healthcare Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	46	4	t	2026-03-08 15:53:36.533215	\N
501	Entertainment Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	46	5	t	2026-03-08 15:53:36.533215	\N
502	Travel Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	46	6	t	2026-03-08 15:53:36.533215	\N
503	Shopping Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	46	7	t	2026-03-08 15:53:36.533215	\N
504	Education Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	46	8	t	2026-03-08 15:53:36.533215	\N
505	Utilities Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	46	9	t	2026-03-08 15:53:36.533215	\N
506	Miscellaneous Budget	400	INR	Monthly	2026-02-01 00:00:00	\N	1	46	10	t	2026-03-08 15:53:36.533215	\N
507	Monthly Total Budget	40000	INR	Monthly	2026-02-01 00:00:00	\N	1	47	\N	t	2026-03-08 15:53:36.533215	\N
508	Food & Dining Budget	8800	INR	Monthly	2026-02-01 00:00:00	\N	1	47	1	t	2026-03-08 15:53:36.533215	\N
509	Transportation Budget	4000	INR	Monthly	2026-02-01 00:00:00	\N	1	47	2	t	2026-03-08 15:53:36.533215	\N
510	Housing Budget	12000	INR	Monthly	2026-02-01 00:00:00	\N	1	47	3	t	2026-03-08 15:53:36.533215	\N
511	Healthcare Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	47	4	t	2026-03-08 15:53:36.533215	\N
512	Entertainment Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	47	5	t	2026-03-08 15:53:36.533215	\N
513	Travel Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	47	6	t	2026-03-08 15:53:36.533215	\N
514	Shopping Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	47	7	t	2026-03-08 15:53:36.533215	\N
515	Education Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	47	8	t	2026-03-08 15:53:36.533215	\N
516	Utilities Budget	3200	INR	Monthly	2026-02-01 00:00:00	\N	1	47	9	t	2026-03-08 15:53:36.533215	\N
517	Miscellaneous Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	47	10	t	2026-03-08 15:53:36.533215	\N
518	Monthly Total Budget	30000	INR	Monthly	2026-02-01 00:00:00	\N	1	48	\N	t	2026-03-08 15:53:36.533215	\N
519	Food & Dining Budget	6600	INR	Monthly	2026-02-01 00:00:00	\N	1	48	1	t	2026-03-08 15:53:36.533215	\N
520	Transportation Budget	3000	INR	Monthly	2026-02-01 00:00:00	\N	1	48	2	t	2026-03-08 15:53:36.533215	\N
521	Housing Budget	9000	INR	Monthly	2026-02-01 00:00:00	\N	1	48	3	t	2026-03-08 15:53:36.533215	\N
522	Healthcare Budget	1800	INR	Monthly	2026-02-01 00:00:00	\N	1	48	4	t	2026-03-08 15:53:36.533215	\N
523	Entertainment Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	48	5	t	2026-03-08 15:53:36.533215	\N
524	Travel Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	48	6	t	2026-03-08 15:53:36.533215	\N
525	Shopping Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	48	7	t	2026-03-08 15:53:36.533215	\N
526	Education Budget	1500	INR	Monthly	2026-02-01 00:00:00	\N	1	48	8	t	2026-03-08 15:53:36.533215	\N
527	Utilities Budget	2400	INR	Monthly	2026-02-01 00:00:00	\N	1	48	9	t	2026-03-08 15:53:36.533215	\N
528	Miscellaneous Budget	600	INR	Monthly	2026-02-01 00:00:00	\N	1	48	10	t	2026-03-08 15:53:36.533215	\N
529	Monthly Total Budget	20000	INR	Monthly	2026-02-01 00:00:00	\N	1	49	\N	t	2026-03-08 15:53:36.533215	\N
530	Food & Dining Budget	4400	INR	Monthly	2026-02-01 00:00:00	\N	1	49	1	t	2026-03-08 15:53:36.533215	\N
531	Transportation Budget	2000	INR	Monthly	2026-02-01 00:00:00	\N	1	49	2	t	2026-03-08 15:53:36.533215	\N
532	Housing Budget	6000	INR	Monthly	2026-02-01 00:00:00	\N	1	49	3	t	2026-03-08 15:53:36.533215	\N
533	Healthcare Budget	1200	INR	Monthly	2026-02-01 00:00:00	\N	1	49	4	t	2026-03-08 15:53:36.533215	\N
534	Entertainment Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	49	5	t	2026-03-08 15:53:36.533215	\N
535	Travel Budget	800	INR	Monthly	2026-02-01 00:00:00	\N	1	49	6	t	2026-03-08 15:53:36.533215	\N
536	Shopping Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	49	7	t	2026-03-08 15:53:36.533215	\N
537	Education Budget	1000	INR	Monthly	2026-02-01 00:00:00	\N	1	49	8	t	2026-03-08 15:53:36.533215	\N
538	Utilities Budget	1600	INR	Monthly	2026-02-01 00:00:00	\N	1	49	9	t	2026-03-08 15:53:36.533215	\N
539	Miscellaneous Budget	400	INR	Monthly	2026-02-01 00:00:00	\N	1	49	10	t	2026-03-08 15:53:36.533215	\N
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
1	Expense - Food & Dining	600	Expense	INR	1	1	1	2026-02-20 00:00:00	2026-03-08 15:54:29.355547	\N
2	Expense - Education	200	Expense	INR	8	1	1	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
3	Expense - Housing	700	Expense	INR	3	1	1	2026-02-25 00:00:00	2026-03-08 15:54:29.355547	\N
4	Expense - Education	400	Expense	INR	8	1	1	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
5	Expense - Healthcare	200	Expense	INR	4	1	1	2026-02-11 00:00:00	2026-03-08 15:54:29.355547	\N
6	Expense - Healthcare	200	Expense	INR	4	1	1	2026-02-05 00:00:00	2026-03-08 15:54:29.355547	\N
7	Expense - Transportation	200	Expense	INR	2	3	3	2026-02-07 00:00:00	2026-03-08 15:54:29.355547	\N
8	Expense - Healthcare	200	Expense	INR	4	3	3	2026-03-04 00:00:00	2026-03-08 15:54:29.355547	\N
9	Expense - Utilities	200	Expense	INR	9	3	3	2026-02-16 00:00:00	2026-03-08 15:54:29.355547	\N
10	Expense - Transportation	200	Expense	INR	2	3	3	2026-03-06 00:00:00	2026-03-08 15:54:29.355547	\N
11	Expense - Travel	200	Expense	INR	6	3	3	2026-02-16 00:00:00	2026-03-08 15:54:29.355547	\N
12	Expense - Transportation	200	Expense	INR	2	3	3	2026-02-21 00:00:00	2026-03-08 15:54:29.355547	\N
13	Expense - Housing	900	Expense	INR	3	3	3	2026-02-14 00:00:00	2026-03-08 15:54:29.355547	\N
14	Expense - Miscellaneous	200	Expense	INR	10	3	3	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
15	Expense - Food & Dining	1300	Expense	INR	1	3	3	2026-03-03 00:00:00	2026-03-08 15:54:29.355547	\N
16	Expense - Entertainment	200	Expense	INR	5	3	3	2026-02-02 00:00:00	2026-03-08 15:54:29.355547	\N
17	Expense - Entertainment	200	Expense	INR	5	3	3	2026-02-15 00:00:00	2026-03-08 15:54:29.355547	\N
18	Expense - Utilities	200	Expense	INR	9	3	3	2026-02-01 00:00:00	2026-03-08 15:54:29.355547	\N
19	Expense - Housing	300	Expense	INR	3	3	3	2026-02-22 00:00:00	2026-03-08 15:54:29.355547	\N
20	Expense - Utilities	200	Expense	INR	9	3	3	2026-02-19 00:00:00	2026-03-08 15:54:29.355547	\N
21	Expense - Miscellaneous	200	Expense	INR	10	3	3	2026-02-26 00:00:00	2026-03-08 15:54:29.355547	\N
22	Expense - Education	300	Expense	INR	8	3	3	2026-03-08 00:00:00	2026-03-08 15:54:29.355547	\N
23	Expense - Education	200	Expense	INR	8	3	3	2026-03-03 00:00:00	2026-03-08 15:54:29.355547	\N
24	Expense - Transportation	200	Expense	INR	2	3	3	2026-02-08 00:00:00	2026-03-08 15:54:29.355547	\N
25	Expense - Shopping	200	Expense	INR	7	3	3	2026-03-03 00:00:00	2026-03-08 15:54:29.355547	\N
26	Expense - Shopping	200	Expense	INR	7	3	3	2026-02-15 00:00:00	2026-03-08 15:54:29.355547	\N
27	Expense - Food & Dining	200	Expense	INR	1	3	3	2026-02-23 00:00:00	2026-03-08 15:54:29.355547	\N
28	Expense - Shopping	200	Expense	INR	7	3	3	2026-02-11 00:00:00	2026-03-08 15:54:29.355547	\N
29	Expense - Food & Dining	200	Expense	INR	1	3	3	2026-02-23 00:00:00	2026-03-08 15:54:29.355547	\N
30	Expense - Travel	200	Expense	INR	6	3	3	2026-02-26 00:00:00	2026-03-08 15:54:29.355547	\N
31	Expense - Miscellaneous	200	Expense	INR	10	3	3	2026-02-20 00:00:00	2026-03-08 15:54:29.355547	\N
32	Expense - Food & Dining	400	Expense	INR	1	3	3	2026-03-02 00:00:00	2026-03-08 15:54:29.355547	\N
33	Expense - Healthcare	200	Expense	INR	4	3	3	2026-03-05 00:00:00	2026-03-08 15:54:29.355547	\N
34	Expense - Healthcare	200	Expense	INR	4	5	5	2026-02-27 00:00:00	2026-03-08 15:54:29.355547	\N
35	Expense - Food & Dining	400	Expense	INR	1	5	5	2026-02-08 00:00:00	2026-03-08 15:54:29.355547	\N
36	Expense - Healthcare	200	Expense	INR	4	5	5	2026-02-01 00:00:00	2026-03-08 15:54:29.355547	\N
37	Expense - Utilities	800	Expense	INR	9	5	5	2026-02-18 00:00:00	2026-03-08 15:54:29.355547	\N
38	Expense - Travel	200	Expense	INR	6	5	5	2026-02-26 00:00:00	2026-03-08 15:54:29.355547	\N
39	Expense - Travel	200	Expense	INR	6	5	5	2026-02-16 00:00:00	2026-03-08 15:54:29.355547	\N
40	Expense - Food & Dining	200	Expense	INR	1	5	5	2026-03-05 00:00:00	2026-03-08 15:54:29.355547	\N
41	Expense - Healthcare	300	Expense	INR	4	5	5	2026-02-17 00:00:00	2026-03-08 15:54:29.355547	\N
42	Expense - Housing	500	Expense	INR	3	5	5	2026-02-15 00:00:00	2026-03-08 15:54:29.355547	\N
43	Expense - Food & Dining	200	Expense	INR	1	5	5	2026-02-03 00:00:00	2026-03-08 15:54:29.355547	\N
44	Expense - Housing	900	Expense	INR	3	5	5	2026-02-10 00:00:00	2026-03-08 15:54:29.355547	\N
45	Expense - Transportation	600	Expense	INR	2	5	5	2026-02-23 00:00:00	2026-03-08 15:54:29.355547	\N
46	Expense - Travel	200	Expense	INR	6	5	5	2026-02-09 00:00:00	2026-03-08 15:54:29.355547	\N
47	Expense - Healthcare	200	Expense	INR	4	5	5	2026-03-07 00:00:00	2026-03-08 15:54:29.355547	\N
48	Expense - Education	200	Expense	INR	8	5	5	2026-03-08 00:00:00	2026-03-08 15:54:29.355547	\N
49	Expense - Education	300	Expense	INR	8	5	5	2026-02-10 00:00:00	2026-03-08 15:54:29.355547	\N
50	Expense - Housing	700	Expense	INR	3	5	5	2026-03-08 00:00:00	2026-03-08 15:54:29.355547	\N
51	Expense - Entertainment	200	Expense	INR	5	5	5	2026-02-01 00:00:00	2026-03-08 15:54:29.355547	\N
52	Expense - Healthcare	200	Expense	INR	4	5	5	2026-02-25 00:00:00	2026-03-08 15:54:29.355547	\N
53	Expense - Housing	600	Expense	INR	3	5	5	2026-03-02 00:00:00	2026-03-08 15:54:29.355547	\N
54	Expense - Miscellaneous	200	Expense	INR	10	5	5	2026-02-07 00:00:00	2026-03-08 15:54:29.355547	\N
55	Expense - Food & Dining	600	Expense	INR	1	5	5	2026-03-01 00:00:00	2026-03-08 15:54:29.355547	\N
56	Expense - Utilities	200	Expense	INR	9	5	5	2026-03-06 00:00:00	2026-03-08 15:54:29.355547	\N
57	Expense - Transportation	200	Expense	INR	2	5	5	2026-02-28 00:00:00	2026-03-08 15:54:29.355547	\N
58	Expense - Travel	200	Expense	INR	6	5	5	2026-02-26 00:00:00	2026-03-08 15:54:29.355547	\N
59	Expense - Entertainment	200	Expense	INR	5	5	5	2026-02-14 00:00:00	2026-03-08 15:54:29.355547	\N
60	Expense - Miscellaneous	200	Expense	INR	10	5	5	2026-02-28 00:00:00	2026-03-08 15:54:29.355547	\N
61	Expense - Education	200	Expense	INR	8	5	5	2026-02-15 00:00:00	2026-03-08 15:54:29.355547	\N
62	Expense - Healthcare	600	Expense	INR	4	5	5	2026-02-05 00:00:00	2026-03-08 15:54:29.355547	\N
63	Expense - Utilities	200	Expense	INR	9	5	5	2026-02-14 00:00:00	2026-03-08 15:54:29.355547	\N
64	Expense - Housing	1900	Expense	INR	3	6	6	2026-02-01 00:00:00	2026-03-08 15:54:29.355547	\N
65	Expense - Transportation	200	Expense	INR	2	6	6	2026-03-07 00:00:00	2026-03-08 15:54:29.355547	\N
66	Expense - Healthcare	200	Expense	INR	4	6	6	2026-02-22 00:00:00	2026-03-08 15:54:29.355547	\N
67	Expense - Transportation	200	Expense	INR	2	6	6	2026-02-20 00:00:00	2026-03-08 15:54:29.355547	\N
68	Expense - Housing	200	Expense	INR	3	6	6	2026-03-01 00:00:00	2026-03-08 15:54:29.355547	\N
69	Expense - Utilities	400	Expense	INR	9	6	6	2026-02-25 00:00:00	2026-03-08 15:54:29.355547	\N
70	Expense - Travel	200	Expense	INR	6	6	6	2026-02-15 00:00:00	2026-03-08 15:54:29.355547	\N
71	Expense - Education	200	Expense	INR	8	6	6	2026-02-24 00:00:00	2026-03-08 15:54:29.355547	\N
72	Expense - Food & Dining	1300	Expense	INR	1	6	6	2026-02-07 00:00:00	2026-03-08 15:54:29.355547	\N
73	Expense - Education	200	Expense	INR	8	6	6	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
74	Expense - Shopping	300	Expense	INR	7	6	6	2026-02-15 00:00:00	2026-03-08 15:54:29.355547	\N
75	Expense - Food & Dining	400	Expense	INR	1	6	6	2026-02-13 00:00:00	2026-03-08 15:54:29.355547	\N
76	Expense - Shopping	200	Expense	INR	7	6	6	2026-02-27 00:00:00	2026-03-08 15:54:29.355547	\N
77	Expense - Transportation	200	Expense	INR	2	6	6	2026-02-24 00:00:00	2026-03-08 15:54:29.355547	\N
78	Expense - Transportation	200	Expense	INR	2	6	6	2026-03-06 00:00:00	2026-03-08 15:54:29.355547	\N
79	Expense - Transportation	200	Expense	INR	2	6	6	2026-02-11 00:00:00	2026-03-08 15:54:29.355547	\N
80	Expense - Education	300	Expense	INR	8	6	6	2026-02-02 00:00:00	2026-03-08 15:54:29.355547	\N
81	Expense - Travel	200	Expense	INR	6	6	6	2026-02-27 00:00:00	2026-03-08 15:54:29.355547	\N
82	Expense - Shopping	200	Expense	INR	7	6	6	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
83	Expense - Miscellaneous	200	Expense	INR	10	6	6	2026-03-07 00:00:00	2026-03-08 15:54:29.355547	\N
84	Expense - Education	300	Expense	INR	8	6	6	2026-02-23 00:00:00	2026-03-08 15:54:29.355547	\N
85	Expense - Utilities	200	Expense	INR	9	6	6	2026-02-23 00:00:00	2026-03-08 15:54:29.355547	\N
86	Expense - Shopping	200	Expense	INR	7	6	6	2026-03-02 00:00:00	2026-03-08 15:54:29.355547	\N
87	Expense - Healthcare	200	Expense	INR	4	6	6	2026-02-28 00:00:00	2026-03-08 15:54:29.355547	\N
88	Expense - Education	200	Expense	INR	8	6	6	2026-02-21 00:00:00	2026-03-08 15:54:29.355547	\N
89	Expense - Food & Dining	600	Expense	INR	1	6	6	2026-02-23 00:00:00	2026-03-08 15:54:29.355547	\N
90	Expense - Food & Dining	300	Expense	INR	1	6	6	2026-02-16 00:00:00	2026-03-08 15:54:29.355547	\N
91	Expense - Food & Dining	300	Expense	INR	1	7	7	2026-02-13 00:00:00	2026-03-08 15:54:29.355547	\N
92	Expense - Utilities	200	Expense	INR	9	7	7	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
93	Expense - Travel	200	Expense	INR	6	7	7	2026-02-28 00:00:00	2026-03-08 15:54:29.355547	\N
94	Expense - Food & Dining	200	Expense	INR	1	9	9	2026-02-15 00:00:00	2026-03-08 15:54:29.355547	\N
95	Expense - Education	200	Expense	INR	8	9	9	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
96	Expense - Education	200	Expense	INR	8	9	9	2026-02-09 00:00:00	2026-03-08 15:54:29.355547	\N
97	Expense - Miscellaneous	200	Expense	INR	10	9	9	2026-02-15 00:00:00	2026-03-08 15:54:29.355547	\N
98	Expense - Transportation	200	Expense	INR	2	9	9	2026-02-08 00:00:00	2026-03-08 15:54:29.355547	\N
99	Expense - Travel	200	Expense	INR	6	9	9	2026-03-05 00:00:00	2026-03-08 15:54:29.355547	\N
100	Expense - Education	200	Expense	INR	8	9	9	2026-02-14 00:00:00	2026-03-08 15:54:29.355547	\N
101	Expense - Transportation	600	Expense	INR	2	9	9	2026-02-08 00:00:00	2026-03-08 15:54:29.355547	\N
102	Expense - Healthcare	600	Expense	INR	4	9	9	2026-03-05 00:00:00	2026-03-08 15:54:29.355547	\N
103	Expense - Food & Dining	300	Expense	INR	1	9	9	2026-02-17 00:00:00	2026-03-08 15:54:29.355547	\N
104	Expense - Utilities	200	Expense	INR	9	9	9	2026-03-08 00:00:00	2026-03-08 15:54:29.355547	\N
105	Expense - Healthcare	200	Expense	INR	4	9	9	2026-02-02 00:00:00	2026-03-08 15:54:29.355547	\N
106	Expense - Travel	200	Expense	INR	6	9	9	2026-02-19 00:00:00	2026-03-08 15:54:29.355547	\N
107	Expense - Utilities	200	Expense	INR	9	9	9	2026-02-05 00:00:00	2026-03-08 15:54:29.355547	\N
108	Expense - Miscellaneous	200	Expense	INR	10	9	9	2026-02-28 00:00:00	2026-03-08 15:54:29.355547	\N
109	Expense - Miscellaneous	200	Expense	INR	10	9	9	2026-02-07 00:00:00	2026-03-08 15:54:29.355547	\N
110	Expense - Housing	400	Expense	INR	3	9	9	2026-02-09 00:00:00	2026-03-08 15:54:29.355547	\N
111	Expense - Healthcare	200	Expense	INR	4	9	9	2026-03-02 00:00:00	2026-03-08 15:54:29.355547	\N
112	Expense - Housing	2000	Expense	INR	3	9	9	2026-02-23 00:00:00	2026-03-08 15:54:29.355547	\N
113	Expense - Shopping	300	Expense	INR	7	9	9	2026-03-04 00:00:00	2026-03-08 15:54:29.355547	\N
114	Expense - Shopping	500	Expense	INR	7	9	9	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
115	Expense - Utilities	200	Expense	INR	9	9	9	2026-03-05 00:00:00	2026-03-08 15:54:29.355547	\N
116	Expense - Food & Dining	200	Expense	INR	1	9	9	2026-02-21 00:00:00	2026-03-08 15:54:29.355547	\N
117	Expense - Travel	200	Expense	INR	6	9	9	2026-02-14 00:00:00	2026-03-08 15:54:29.355547	\N
118	Expense - Travel	200	Expense	INR	6	10	10	2026-02-09 00:00:00	2026-03-08 15:54:29.355547	\N
119	Expense - Utilities	200	Expense	INR	9	10	10	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
120	Expense - Shopping	200	Expense	INR	7	10	10	2026-02-08 00:00:00	2026-03-08 15:54:29.355547	\N
121	Expense - Transportation	200	Expense	INR	2	10	10	2026-03-08 00:00:00	2026-03-08 15:54:29.355547	\N
122	Expense - Travel	200	Expense	INR	6	10	10	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
123	Expense - Miscellaneous	200	Expense	INR	10	10	10	2026-02-14 00:00:00	2026-03-08 15:54:29.355547	\N
124	Expense - Shopping	200	Expense	INR	7	10	10	2026-02-10 00:00:00	2026-03-08 15:54:29.355547	\N
125	Expense - Entertainment	200	Expense	INR	5	10	10	2026-02-05 00:00:00	2026-03-08 15:54:29.355547	\N
126	Expense - Food & Dining	200	Expense	INR	1	10	10	2026-02-13 00:00:00	2026-03-08 15:54:29.355547	\N
127	Expense - Food & Dining	200	Expense	INR	1	10	10	2026-03-01 00:00:00	2026-03-08 15:54:29.355547	\N
128	Expense - Food & Dining	200	Expense	INR	1	10	10	2026-03-05 00:00:00	2026-03-08 15:54:29.355547	\N
129	Expense - Transportation	200	Expense	INR	2	10	10	2026-02-26 00:00:00	2026-03-08 15:54:29.355547	\N
130	Expense - Shopping	200	Expense	INR	7	11	11	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
131	Expense - Travel	200	Expense	INR	6	11	11	2026-03-07 00:00:00	2026-03-08 15:54:29.355547	\N
132	Expense - Food & Dining	300	Expense	INR	1	11	11	2026-02-13 00:00:00	2026-03-08 15:54:29.355547	\N
133	Expense - Entertainment	300	Expense	INR	5	11	11	2026-02-22 00:00:00	2026-03-08 15:54:29.355547	\N
134	Expense - Food & Dining	2200	Expense	INR	1	11	11	2026-02-25 00:00:00	2026-03-08 15:54:29.355547	\N
135	Expense - Miscellaneous	200	Expense	INR	10	11	11	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
136	Expense - Utilities	600	Expense	INR	9	11	11	2026-02-18 00:00:00	2026-03-08 15:54:29.355547	\N
137	Expense - Shopping	200	Expense	INR	7	11	11	2026-02-19 00:00:00	2026-03-08 15:54:29.355547	\N
138	Expense - Transportation	200	Expense	INR	2	11	11	2026-02-15 00:00:00	2026-03-08 15:54:29.355547	\N
139	Expense - Healthcare	200	Expense	INR	4	11	11	2026-02-13 00:00:00	2026-03-08 15:54:29.355547	\N
140	Expense - Transportation	200	Expense	INR	2	11	11	2026-02-16 00:00:00	2026-03-08 15:54:29.355547	\N
141	Expense - Education	200	Expense	INR	8	11	11	2026-02-13 00:00:00	2026-03-08 15:54:29.355547	\N
142	Expense - Healthcare	200	Expense	INR	4	11	11	2026-02-28 00:00:00	2026-03-08 15:54:29.355547	\N
143	Expense - Education	200	Expense	INR	8	11	11	2026-02-20 00:00:00	2026-03-08 15:54:29.355547	\N
144	Expense - Utilities	200	Expense	INR	9	11	11	2026-02-17 00:00:00	2026-03-08 15:54:29.355547	\N
145	Expense - Utilities	200	Expense	INR	9	11	11	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
146	Expense - Entertainment	200	Expense	INR	5	11	11	2026-03-05 00:00:00	2026-03-08 15:54:29.355547	\N
147	Expense - Shopping	200	Expense	INR	7	11	11	2026-03-02 00:00:00	2026-03-08 15:54:29.355547	\N
148	Expense - Entertainment	200	Expense	INR	5	11	11	2026-02-17 00:00:00	2026-03-08 15:54:29.355547	\N
149	Expense - Travel	200	Expense	INR	6	11	11	2026-02-25 00:00:00	2026-03-08 15:54:29.355547	\N
526	Salary Income	49700	Income	INR	11	16	16	2026-02-11 00:00:00	2026-03-08 15:54:29.355547	\N
150	Expense - Housing	400	Expense	INR	3	11	11	2026-02-16 00:00:00	2026-03-08 15:54:29.355547	\N
151	Expense - Travel	200	Expense	INR	6	11	11	2026-02-13 00:00:00	2026-03-08 15:54:29.355547	\N
152	Expense - Food & Dining	1700	Expense	INR	1	11	11	2026-03-01 00:00:00	2026-03-08 15:54:29.355547	\N
153	Expense - Transportation	300	Expense	INR	2	11	11	2026-03-06 00:00:00	2026-03-08 15:54:29.355547	\N
154	Expense - Education	200	Expense	INR	8	11	11	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
155	Expense - Utilities	200	Expense	INR	9	11	11	2026-02-20 00:00:00	2026-03-08 15:54:29.355547	\N
156	Expense - Housing	1300	Expense	INR	3	11	11	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
157	Expense - Housing	1300	Expense	INR	3	11	11	2026-02-09 00:00:00	2026-03-08 15:54:29.355547	\N
158	Expense - Utilities	200	Expense	INR	9	11	11	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
159	Expense - Travel	200	Expense	INR	6	11	11	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
160	Expense - Shopping	200	Expense	INR	7	13	13	2026-02-09 00:00:00	2026-03-08 15:54:29.355547	\N
161	Expense - Entertainment	200	Expense	INR	5	13	13	2026-03-03 00:00:00	2026-03-08 15:54:29.355547	\N
162	Expense - Shopping	200	Expense	INR	7	13	13	2026-03-07 00:00:00	2026-03-08 15:54:29.355547	\N
163	Expense - Food & Dining	300	Expense	INR	1	13	13	2026-02-01 00:00:00	2026-03-08 15:54:29.355547	\N
164	Expense - Food & Dining	200	Expense	INR	1	13	13	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
165	Expense - Food & Dining	400	Expense	INR	1	13	13	2026-02-03 00:00:00	2026-03-08 15:54:29.355547	\N
166	Expense - Education	200	Expense	INR	8	13	13	2026-03-03 00:00:00	2026-03-08 15:54:29.355547	\N
167	Expense - Miscellaneous	200	Expense	INR	10	13	13	2026-02-25 00:00:00	2026-03-08 15:54:29.355547	\N
168	Expense - Shopping	200	Expense	INR	7	13	13	2026-02-05 00:00:00	2026-03-08 15:54:29.355547	\N
169	Expense - Miscellaneous	200	Expense	INR	10	13	13	2026-02-08 00:00:00	2026-03-08 15:54:29.355547	\N
170	Expense - Shopping	200	Expense	INR	7	14	14	2026-02-05 00:00:00	2026-03-08 15:54:29.355547	\N
171	Expense - Food & Dining	200	Expense	INR	1	14	14	2026-03-08 00:00:00	2026-03-08 15:54:29.355547	\N
172	Expense - Shopping	800	Expense	INR	7	14	14	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
173	Expense - Housing	2200	Expense	INR	3	14	14	2026-02-14 00:00:00	2026-03-08 15:54:29.355547	\N
174	Expense - Utilities	200	Expense	INR	9	14	14	2026-03-08 00:00:00	2026-03-08 15:54:29.355547	\N
175	Expense - Utilities	200	Expense	INR	9	14	14	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
176	Expense - Food & Dining	800	Expense	INR	1	14	14	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
177	Expense - Entertainment	200	Expense	INR	5	14	14	2026-02-20 00:00:00	2026-03-08 15:54:29.355547	\N
178	Expense - Healthcare	200	Expense	INR	4	14	14	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
179	Expense - Housing	400	Expense	INR	3	14	14	2026-02-21 00:00:00	2026-03-08 15:54:29.355547	\N
180	Expense - Food & Dining	300	Expense	INR	1	14	14	2026-02-13 00:00:00	2026-03-08 15:54:29.355547	\N
181	Expense - Utilities	200	Expense	INR	9	14	14	2026-02-19 00:00:00	2026-03-08 15:54:29.355547	\N
182	Expense - Education	200	Expense	INR	8	14	14	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
183	Expense - Food & Dining	300	Expense	INR	1	14	14	2026-02-26 00:00:00	2026-03-08 15:54:29.355547	\N
184	Expense - Travel	200	Expense	INR	6	14	14	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
185	Expense - Shopping	700	Expense	INR	7	14	14	2026-02-27 00:00:00	2026-03-08 15:54:29.355547	\N
186	Expense - Housing	2200	Expense	INR	3	14	14	2026-02-02 00:00:00	2026-03-08 15:54:29.355547	\N
187	Expense - Miscellaneous	200	Expense	INR	10	14	14	2026-03-08 00:00:00	2026-03-08 15:54:29.355547	\N
188	Expense - Miscellaneous	200	Expense	INR	10	14	14	2026-02-21 00:00:00	2026-03-08 15:54:29.355547	\N
189	Expense - Food & Dining	1300	Expense	INR	1	14	14	2026-03-04 00:00:00	2026-03-08 15:54:29.355547	\N
190	Expense - Food & Dining	400	Expense	INR	1	14	14	2026-03-01 00:00:00	2026-03-08 15:54:29.355547	\N
191	Expense - Utilities	200	Expense	INR	9	17	17	2026-03-06 00:00:00	2026-03-08 15:54:29.355547	\N
192	Expense - Housing	1000	Expense	INR	3	17	17	2026-02-26 00:00:00	2026-03-08 15:54:29.355547	\N
193	Expense - Travel	200	Expense	INR	6	17	17	2026-02-23 00:00:00	2026-03-08 15:54:29.355547	\N
194	Expense - Entertainment	200	Expense	INR	5	17	17	2026-02-24 00:00:00	2026-03-08 15:54:29.355547	\N
195	Expense - Entertainment	200	Expense	INR	5	17	17	2026-02-23 00:00:00	2026-03-08 15:54:29.355547	\N
196	Expense - Entertainment	200	Expense	INR	5	17	17	2026-03-08 00:00:00	2026-03-08 15:54:29.355547	\N
197	Expense - Transportation	400	Expense	INR	2	17	17	2026-03-07 00:00:00	2026-03-08 15:54:29.355547	\N
198	Expense - Shopping	200	Expense	INR	7	17	17	2026-02-17 00:00:00	2026-03-08 15:54:29.355547	\N
199	Expense - Miscellaneous	200	Expense	INR	10	17	17	2026-02-09 00:00:00	2026-03-08 15:54:29.355547	\N
200	Expense - Transportation	200	Expense	INR	2	17	17	2026-02-25 00:00:00	2026-03-08 15:54:29.355547	\N
201	Expense - Food & Dining	200	Expense	INR	1	17	17	2026-02-20 00:00:00	2026-03-08 15:54:29.355547	\N
202	Expense - Entertainment	200	Expense	INR	5	17	17	2026-02-16 00:00:00	2026-03-08 15:54:29.355547	\N
203	Expense - Housing	300	Expense	INR	3	17	17	2026-03-08 00:00:00	2026-03-08 15:54:29.355547	\N
204	Expense - Food & Dining	1100	Expense	INR	1	17	17	2026-02-16 00:00:00	2026-03-08 15:54:29.355547	\N
205	Expense - Healthcare	200	Expense	INR	4	17	17	2026-02-15 00:00:00	2026-03-08 15:54:29.355547	\N
206	Expense - Miscellaneous	200	Expense	INR	10	17	17	2026-02-03 00:00:00	2026-03-08 15:54:29.355547	\N
207	Expense - Healthcare	200	Expense	INR	4	17	17	2026-02-05 00:00:00	2026-03-08 15:54:29.355547	\N
208	Expense - Travel	200	Expense	INR	6	17	17	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
209	Expense - Education	200	Expense	INR	8	17	17	2026-03-02 00:00:00	2026-03-08 15:54:29.355547	\N
210	Expense - Travel	200	Expense	INR	6	17	17	2026-03-07 00:00:00	2026-03-08 15:54:29.355547	\N
211	Expense - Education	200	Expense	INR	8	18	18	2026-02-13 00:00:00	2026-03-08 15:54:29.355547	\N
212	Expense - Healthcare	200	Expense	INR	4	18	18	2026-02-13 00:00:00	2026-03-08 15:54:29.355547	\N
213	Expense - Travel	200	Expense	INR	6	18	18	2026-02-11 00:00:00	2026-03-08 15:54:29.355547	\N
214	Expense - Shopping	200	Expense	INR	7	18	18	2026-03-05 00:00:00	2026-03-08 15:54:29.355547	\N
215	Expense - Education	200	Expense	INR	8	18	18	2026-02-01 00:00:00	2026-03-08 15:54:29.355547	\N
216	Expense - Travel	200	Expense	INR	6	18	18	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
217	Expense - Shopping	300	Expense	INR	7	18	18	2026-02-09 00:00:00	2026-03-08 15:54:29.355547	\N
218	Expense - Housing	1200	Expense	INR	3	18	18	2026-03-02 00:00:00	2026-03-08 15:54:29.355547	\N
219	Expense - Travel	200	Expense	INR	6	18	18	2026-02-09 00:00:00	2026-03-08 15:54:29.355547	\N
220	Expense - Healthcare	200	Expense	INR	4	18	18	2026-02-28 00:00:00	2026-03-08 15:54:29.355547	\N
221	Expense - Miscellaneous	200	Expense	INR	10	18	18	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
222	Expense - Housing	200	Expense	INR	3	18	18	2026-03-01 00:00:00	2026-03-08 15:54:29.355547	\N
223	Expense - Shopping	200	Expense	INR	7	18	18	2026-02-21 00:00:00	2026-03-08 15:54:29.355547	\N
224	Expense - Travel	200	Expense	INR	6	18	18	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
225	Expense - Transportation	200	Expense	INR	2	19	19	2026-02-13 00:00:00	2026-03-08 15:54:29.355547	\N
226	Expense - Education	200	Expense	INR	8	19	19	2026-02-05 00:00:00	2026-03-08 15:54:29.355547	\N
227	Expense - Entertainment	200	Expense	INR	5	19	19	2026-02-13 00:00:00	2026-03-08 15:54:29.355547	\N
228	Expense - Utilities	200	Expense	INR	9	20	20	2026-02-27 00:00:00	2026-03-08 15:54:29.355547	\N
229	Expense - Entertainment	200	Expense	INR	5	20	20	2026-02-07 00:00:00	2026-03-08 15:54:29.355547	\N
230	Expense - Healthcare	200	Expense	INR	4	20	20	2026-02-18 00:00:00	2026-03-08 15:54:29.355547	\N
231	Expense - Entertainment	200	Expense	INR	5	20	20	2026-02-13 00:00:00	2026-03-08 15:54:29.355547	\N
232	Expense - Entertainment	200	Expense	INR	5	20	20	2026-02-17 00:00:00	2026-03-08 15:54:29.355547	\N
233	Expense - Education	200	Expense	INR	8	20	20	2026-03-05 00:00:00	2026-03-08 15:54:29.355547	\N
234	Expense - Utilities	300	Expense	INR	9	20	20	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
235	Expense - Healthcare	200	Expense	INR	4	20	20	2026-02-26 00:00:00	2026-03-08 15:54:29.355547	\N
236	Expense - Education	200	Expense	INR	8	20	20	2026-03-05 00:00:00	2026-03-08 15:54:29.355547	\N
237	Expense - Transportation	200	Expense	INR	2	20	20	2026-02-02 00:00:00	2026-03-08 15:54:29.355547	\N
238	Expense - Transportation	200	Expense	INR	2	20	20	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
239	Expense - Utilities	200	Expense	INR	9	20	20	2026-02-09 00:00:00	2026-03-08 15:54:29.355547	\N
240	Expense - Education	200	Expense	INR	8	20	20	2026-02-05 00:00:00	2026-03-08 15:54:29.355547	\N
241	Expense - Education	200	Expense	INR	8	20	20	2026-03-06 00:00:00	2026-03-08 15:54:29.355547	\N
242	Expense - Miscellaneous	200	Expense	INR	10	20	20	2026-02-20 00:00:00	2026-03-08 15:54:29.355547	\N
243	Expense - Shopping	200	Expense	INR	7	20	20	2026-03-01 00:00:00	2026-03-08 15:54:29.355547	\N
244	Expense - Utilities	200	Expense	INR	9	20	20	2026-02-28 00:00:00	2026-03-08 15:54:29.355547	\N
245	Expense - Shopping	200	Expense	INR	7	20	20	2026-02-16 00:00:00	2026-03-08 15:54:29.355547	\N
246	Expense - Miscellaneous	200	Expense	INR	10	20	20	2026-02-13 00:00:00	2026-03-08 15:54:29.355547	\N
247	Expense - Travel	200	Expense	INR	6	20	20	2026-03-01 00:00:00	2026-03-08 15:54:29.355547	\N
248	Expense - Travel	200	Expense	INR	6	20	20	2026-02-20 00:00:00	2026-03-08 15:54:29.355547	\N
249	Expense - Travel	200	Expense	INR	6	20	20	2026-02-20 00:00:00	2026-03-08 15:54:29.355547	\N
250	Expense - Miscellaneous	200	Expense	INR	10	20	20	2026-02-18 00:00:00	2026-03-08 15:54:29.355547	\N
251	Expense - Travel	200	Expense	INR	6	20	20	2026-03-06 00:00:00	2026-03-08 15:54:29.355547	\N
252	Expense - Miscellaneous	200	Expense	INR	10	20	20	2026-02-24 00:00:00	2026-03-08 15:54:29.355547	\N
253	Expense - Utilities	200	Expense	INR	9	20	20	2026-02-21 00:00:00	2026-03-08 15:54:29.355547	\N
254	Expense - Transportation	200	Expense	INR	2	20	20	2026-03-06 00:00:00	2026-03-08 15:54:29.355547	\N
255	Expense - Education	200	Expense	INR	8	20	20	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
256	Expense - Travel	200	Expense	INR	6	21	21	2026-02-18 00:00:00	2026-03-08 15:54:29.355547	\N
257	Expense - Food & Dining	200	Expense	INR	1	21	21	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
258	Expense - Healthcare	200	Expense	INR	4	21	21	2026-03-04 00:00:00	2026-03-08 15:54:29.355547	\N
259	Expense - Miscellaneous	200	Expense	INR	10	21	21	2026-03-08 00:00:00	2026-03-08 15:54:29.355547	\N
260	Expense - Miscellaneous	200	Expense	INR	10	21	21	2026-02-15 00:00:00	2026-03-08 15:54:29.355547	\N
261	Expense - Entertainment	300	Expense	INR	5	21	21	2026-03-07 00:00:00	2026-03-08 15:54:29.355547	\N
262	Expense - Utilities	500	Expense	INR	9	21	21	2026-02-21 00:00:00	2026-03-08 15:54:29.355547	\N
263	Expense - Education	200	Expense	INR	8	21	21	2026-02-18 00:00:00	2026-03-08 15:54:29.355547	\N
264	Expense - Miscellaneous	200	Expense	INR	10	21	21	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
265	Expense - Travel	300	Expense	INR	6	21	21	2026-03-01 00:00:00	2026-03-08 15:54:29.355547	\N
266	Expense - Healthcare	200	Expense	INR	4	21	21	2026-02-16 00:00:00	2026-03-08 15:54:29.355547	\N
267	Expense - Housing	300	Expense	INR	3	21	21	2026-02-26 00:00:00	2026-03-08 15:54:29.355547	\N
268	Expense - Utilities	600	Expense	INR	9	21	21	2026-03-01 00:00:00	2026-03-08 15:54:29.355547	\N
269	Expense - Utilities	200	Expense	INR	9	21	21	2026-02-03 00:00:00	2026-03-08 15:54:29.355547	\N
270	Expense - Education	200	Expense	INR	8	21	21	2026-02-21 00:00:00	2026-03-08 15:54:29.355547	\N
271	Expense - Shopping	200	Expense	INR	7	21	21	2026-02-03 00:00:00	2026-03-08 15:54:29.355547	\N
272	Expense - Shopping	200	Expense	INR	7	21	21	2026-02-09 00:00:00	2026-03-08 15:54:29.355547	\N
273	Expense - Shopping	200	Expense	INR	7	22	22	2026-02-24 00:00:00	2026-03-08 15:54:29.355547	\N
274	Expense - Healthcare	200	Expense	INR	4	22	22	2026-03-01 00:00:00	2026-03-08 15:54:29.355547	\N
275	Expense - Education	200	Expense	INR	8	22	22	2026-02-05 00:00:00	2026-03-08 15:54:29.355547	\N
276	Expense - Entertainment	200	Expense	INR	5	22	22	2026-02-07 00:00:00	2026-03-08 15:54:29.355547	\N
277	Expense - Utilities	200	Expense	INR	9	22	22	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
278	Expense - Education	200	Expense	INR	8	22	22	2026-02-26 00:00:00	2026-03-08 15:54:29.355547	\N
279	Expense - Housing	200	Expense	INR	3	22	22	2026-02-21 00:00:00	2026-03-08 15:54:29.355547	\N
280	Expense - Healthcare	200	Expense	INR	4	23	23	2026-02-03 00:00:00	2026-03-08 15:54:29.355547	\N
281	Expense - Housing	900	Expense	INR	3	23	23	2026-02-24 00:00:00	2026-03-08 15:54:29.355547	\N
282	Expense - Food & Dining	200	Expense	INR	1	23	23	2026-02-09 00:00:00	2026-03-08 15:54:29.355547	\N
283	Expense - Transportation	200	Expense	INR	2	23	23	2026-02-19 00:00:00	2026-03-08 15:54:29.355547	\N
284	Expense - Food & Dining	300	Expense	INR	1	23	23	2026-02-07 00:00:00	2026-03-08 15:54:29.355547	\N
285	Expense - Transportation	300	Expense	INR	2	23	23	2026-02-02 00:00:00	2026-03-08 15:54:29.355547	\N
286	Expense - Entertainment	200	Expense	INR	5	23	23	2026-02-20 00:00:00	2026-03-08 15:54:29.355547	\N
287	Expense - Entertainment	200	Expense	INR	5	23	23	2026-03-08 00:00:00	2026-03-08 15:54:29.355547	\N
288	Expense - Food & Dining	1100	Expense	INR	1	23	23	2026-02-22 00:00:00	2026-03-08 15:54:29.355547	\N
289	Expense - Education	200	Expense	INR	8	23	23	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
290	Expense - Shopping	200	Expense	INR	7	23	23	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
291	Expense - Housing	700	Expense	INR	3	23	23	2026-02-23 00:00:00	2026-03-08 15:54:29.355547	\N
292	Expense - Housing	400	Expense	INR	3	23	23	2026-03-01 00:00:00	2026-03-08 15:54:29.355547	\N
293	Expense - Transportation	200	Expense	INR	2	23	23	2026-03-01 00:00:00	2026-03-08 15:54:29.355547	\N
294	Expense - Transportation	400	Expense	INR	2	23	23	2026-02-26 00:00:00	2026-03-08 15:54:29.355547	\N
295	Expense - Utilities	200	Expense	INR	9	23	23	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
296	Expense - Transportation	200	Expense	INR	2	25	25	2026-02-19 00:00:00	2026-03-08 15:54:29.355547	\N
297	Expense - Shopping	400	Expense	INR	7	25	25	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
298	Expense - Entertainment	200	Expense	INR	5	25	25	2026-03-04 00:00:00	2026-03-08 15:54:29.355547	\N
527	Salary Income	12100	Income	INR	11	17	17	2026-02-21 00:00:00	2026-03-08 15:54:29.355547	\N
299	Expense - Travel	200	Expense	INR	6	25	25	2026-03-07 00:00:00	2026-03-08 15:54:29.355547	\N
300	Expense - Housing	200	Expense	INR	3	26	26	2026-02-03 00:00:00	2026-03-08 15:54:29.355547	\N
301	Expense - Transportation	200	Expense	INR	2	26	26	2026-02-19 00:00:00	2026-03-08 15:54:29.355547	\N
302	Expense - Healthcare	200	Expense	INR	4	26	26	2026-02-16 00:00:00	2026-03-08 15:54:29.355547	\N
303	Expense - Miscellaneous	200	Expense	INR	10	26	26	2026-02-07 00:00:00	2026-03-08 15:54:29.355547	\N
304	Expense - Utilities	200	Expense	INR	9	26	26	2026-03-04 00:00:00	2026-03-08 15:54:29.355547	\N
305	Expense - Food & Dining	800	Expense	INR	1	26	26	2026-02-10 00:00:00	2026-03-08 15:54:29.355547	\N
306	Expense - Education	200	Expense	INR	8	26	26	2026-02-09 00:00:00	2026-03-08 15:54:29.355547	\N
307	Expense - Healthcare	200	Expense	INR	4	26	26	2026-02-19 00:00:00	2026-03-08 15:54:29.355547	\N
308	Expense - Food & Dining	900	Expense	INR	1	26	26	2026-02-22 00:00:00	2026-03-08 15:54:29.355547	\N
309	Expense - Food & Dining	200	Expense	INR	1	26	26	2026-02-19 00:00:00	2026-03-08 15:54:29.355547	\N
310	Expense - Transportation	400	Expense	INR	2	26	26	2026-02-19 00:00:00	2026-03-08 15:54:29.355547	\N
311	Expense - Travel	200	Expense	INR	6	26	26	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
312	Expense - Shopping	400	Expense	INR	7	26	26	2026-03-06 00:00:00	2026-03-08 15:54:29.355547	\N
313	Expense - Food & Dining	200	Expense	INR	1	26	26	2026-02-08 00:00:00	2026-03-08 15:54:29.355547	\N
314	Expense - Healthcare	200	Expense	INR	4	26	26	2026-02-02 00:00:00	2026-03-08 15:54:29.355547	\N
315	Expense - Utilities	200	Expense	INR	9	26	26	2026-02-03 00:00:00	2026-03-08 15:54:29.355547	\N
316	Expense - Shopping	200	Expense	INR	7	26	26	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
317	Expense - Healthcare	200	Expense	INR	4	26	26	2026-02-26 00:00:00	2026-03-08 15:54:29.355547	\N
318	Expense - Housing	200	Expense	INR	3	26	26	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
319	Expense - Transportation	200	Expense	INR	2	26	26	2026-02-18 00:00:00	2026-03-08 15:54:29.355547	\N
320	Expense - Education	200	Expense	INR	8	26	26	2026-02-13 00:00:00	2026-03-08 15:54:29.355547	\N
321	Expense - Housing	200	Expense	INR	3	26	26	2026-03-03 00:00:00	2026-03-08 15:54:29.355547	\N
322	Expense - Travel	200	Expense	INR	6	26	26	2026-02-22 00:00:00	2026-03-08 15:54:29.355547	\N
323	Expense - Housing	200	Expense	INR	3	26	26	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
324	Expense - Miscellaneous	200	Expense	INR	10	26	26	2026-03-02 00:00:00	2026-03-08 15:54:29.355547	\N
325	Expense - Utilities	200	Expense	INR	9	26	26	2026-03-02 00:00:00	2026-03-08 15:54:29.355547	\N
326	Expense - Shopping	200	Expense	INR	7	26	26	2026-03-05 00:00:00	2026-03-08 15:54:29.355547	\N
327	Expense - Education	200	Expense	INR	8	26	26	2026-03-05 00:00:00	2026-03-08 15:54:29.355547	\N
328	Expense - Education	200	Expense	INR	8	26	26	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
329	Expense - Healthcare	200	Expense	INR	4	27	27	2026-02-09 00:00:00	2026-03-08 15:54:29.355547	\N
330	Expense - Healthcare	200	Expense	INR	4	27	27	2026-02-25 00:00:00	2026-03-08 15:54:29.355547	\N
331	Expense - Miscellaneous	200	Expense	INR	10	27	27	2026-02-28 00:00:00	2026-03-08 15:54:29.355547	\N
332	Expense - Education	200	Expense	INR	8	27	27	2026-02-13 00:00:00	2026-03-08 15:54:29.355547	\N
333	Expense - Shopping	200	Expense	INR	7	27	27	2026-02-24 00:00:00	2026-03-08 15:54:29.355547	\N
334	Expense - Transportation	200	Expense	INR	2	27	27	2026-02-14 00:00:00	2026-03-08 15:54:29.355547	\N
335	Expense - Utilities	500	Expense	INR	9	27	27	2026-03-04 00:00:00	2026-03-08 15:54:29.355547	\N
336	Expense - Housing	200	Expense	INR	3	27	27	2026-03-04 00:00:00	2026-03-08 15:54:29.355547	\N
337	Expense - Transportation	200	Expense	INR	2	27	27	2026-02-11 00:00:00	2026-03-08 15:54:29.355547	\N
338	Expense - Transportation	300	Expense	INR	2	27	27	2026-02-14 00:00:00	2026-03-08 15:54:29.355547	\N
339	Expense - Travel	200	Expense	INR	6	27	27	2026-02-02 00:00:00	2026-03-08 15:54:29.355547	\N
340	Expense - Education	200	Expense	INR	8	27	27	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
341	Expense - Education	200	Expense	INR	8	27	27	2026-03-01 00:00:00	2026-03-08 15:54:29.355547	\N
342	Expense - Healthcare	200	Expense	INR	4	27	27	2026-03-04 00:00:00	2026-03-08 15:54:29.355547	\N
343	Expense - Transportation	200	Expense	INR	2	27	27	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
344	Expense - Education	300	Expense	INR	8	27	27	2026-02-01 00:00:00	2026-03-08 15:54:29.355547	\N
345	Expense - Shopping	200	Expense	INR	7	27	27	2026-02-18 00:00:00	2026-03-08 15:54:29.355547	\N
346	Expense - Housing	500	Expense	INR	3	27	27	2026-03-07 00:00:00	2026-03-08 15:54:29.355547	\N
347	Expense - Healthcare	200	Expense	INR	4	27	27	2026-02-01 00:00:00	2026-03-08 15:54:29.355547	\N
348	Expense - Education	200	Expense	INR	8	27	27	2026-02-09 00:00:00	2026-03-08 15:54:29.355547	\N
349	Expense - Miscellaneous	200	Expense	INR	10	27	27	2026-02-26 00:00:00	2026-03-08 15:54:29.355547	\N
350	Expense - Transportation	200	Expense	INR	2	28	28	2026-03-05 00:00:00	2026-03-08 15:54:29.355547	\N
351	Expense - Shopping	200	Expense	INR	7	28	28	2026-02-19 00:00:00	2026-03-08 15:54:29.355547	\N
352	Expense - Entertainment	200	Expense	INR	5	28	28	2026-02-20 00:00:00	2026-03-08 15:54:29.355547	\N
353	Expense - Food & Dining	200	Expense	INR	1	28	28	2026-02-09 00:00:00	2026-03-08 15:54:29.355547	\N
354	Expense - Entertainment	200	Expense	INR	5	28	28	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
355	Expense - Travel	200	Expense	INR	6	28	28	2026-02-01 00:00:00	2026-03-08 15:54:29.355547	\N
356	Expense - Education	400	Expense	INR	8	28	28	2026-02-02 00:00:00	2026-03-08 15:54:29.355547	\N
357	Expense - Miscellaneous	200	Expense	INR	10	28	28	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
358	Expense - Entertainment	500	Expense	INR	5	28	28	2026-02-11 00:00:00	2026-03-08 15:54:29.355547	\N
359	Expense - Education	200	Expense	INR	8	28	28	2026-02-27 00:00:00	2026-03-08 15:54:29.355547	\N
360	Expense - Travel	200	Expense	INR	6	28	28	2026-02-08 00:00:00	2026-03-08 15:54:29.355547	\N
361	Expense - Education	200	Expense	INR	8	28	28	2026-02-20 00:00:00	2026-03-08 15:54:29.355547	\N
362	Expense - Food & Dining	1600	Expense	INR	1	28	28	2026-02-23 00:00:00	2026-03-08 15:54:29.355547	\N
363	Expense - Healthcare	400	Expense	INR	4	28	28	2026-02-20 00:00:00	2026-03-08 15:54:29.355547	\N
364	Expense - Shopping	200	Expense	INR	7	28	28	2026-02-28 00:00:00	2026-03-08 15:54:29.355547	\N
365	Expense - Education	200	Expense	INR	8	28	28	2026-02-08 00:00:00	2026-03-08 15:54:29.355547	\N
366	Expense - Entertainment	200	Expense	INR	5	28	28	2026-02-09 00:00:00	2026-03-08 15:54:29.355547	\N
367	Expense - Entertainment	200	Expense	INR	5	28	28	2026-02-19 00:00:00	2026-03-08 15:54:29.355547	\N
368	Expense - Entertainment	200	Expense	INR	5	28	28	2026-02-01 00:00:00	2026-03-08 15:54:29.355547	\N
369	Expense - Shopping	200	Expense	INR	7	28	28	2026-02-16 00:00:00	2026-03-08 15:54:29.355547	\N
370	Expense - Transportation	200	Expense	INR	2	28	28	2026-02-18 00:00:00	2026-03-08 15:54:29.355547	\N
371	Expense - Shopping	400	Expense	INR	7	28	28	2026-02-15 00:00:00	2026-03-08 15:54:29.355547	\N
372	Expense - Transportation	200	Expense	INR	2	28	28	2026-03-07 00:00:00	2026-03-08 15:54:29.355547	\N
373	Expense - Miscellaneous	200	Expense	INR	10	28	28	2026-03-03 00:00:00	2026-03-08 15:54:29.355547	\N
374	Expense - Healthcare	200	Expense	INR	4	28	28	2026-02-07 00:00:00	2026-03-08 15:54:29.355547	\N
375	Expense - Transportation	200	Expense	INR	2	28	28	2026-02-20 00:00:00	2026-03-08 15:54:29.355547	\N
376	Expense - Shopping	700	Expense	INR	7	28	28	2026-02-01 00:00:00	2026-03-08 15:54:29.355547	\N
377	Expense - Education	200	Expense	INR	8	30	30	2026-02-27 00:00:00	2026-03-08 15:54:29.355547	\N
378	Expense - Shopping	200	Expense	INR	7	30	30	2026-02-27 00:00:00	2026-03-08 15:54:29.355547	\N
379	Expense - Food & Dining	1700	Expense	INR	1	30	30	2026-03-07 00:00:00	2026-03-08 15:54:29.355547	\N
380	Expense - Housing	200	Expense	INR	3	30	30	2026-02-01 00:00:00	2026-03-08 15:54:29.355547	\N
381	Expense - Travel	200	Expense	INR	6	30	30	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
382	Expense - Transportation	200	Expense	INR	2	30	30	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
383	Expense - Miscellaneous	200	Expense	INR	10	30	30	2026-02-01 00:00:00	2026-03-08 15:54:29.355547	\N
384	Expense - Education	200	Expense	INR	8	30	30	2026-02-09 00:00:00	2026-03-08 15:54:29.355547	\N
385	Expense - Shopping	200	Expense	INR	7	30	30	2026-03-02 00:00:00	2026-03-08 15:54:29.355547	\N
386	Expense - Shopping	200	Expense	INR	7	30	30	2026-02-20 00:00:00	2026-03-08 15:54:29.355547	\N
387	Expense - Miscellaneous	200	Expense	INR	10	30	30	2026-02-25 00:00:00	2026-03-08 15:54:29.355547	\N
388	Expense - Miscellaneous	200	Expense	INR	10	30	30	2026-02-10 00:00:00	2026-03-08 15:54:29.355547	\N
389	Expense - Food & Dining	400	Expense	INR	1	30	30	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
390	Expense - Travel	200	Expense	INR	6	30	30	2026-02-27 00:00:00	2026-03-08 15:54:29.355547	\N
391	Expense - Education	200	Expense	INR	8	30	30	2026-02-02 00:00:00	2026-03-08 15:54:29.355547	\N
392	Expense - Miscellaneous	200	Expense	INR	10	30	30	2026-03-04 00:00:00	2026-03-08 15:54:29.355547	\N
393	Expense - Housing	300	Expense	INR	3	30	30	2026-02-15 00:00:00	2026-03-08 15:54:29.355547	\N
394	Expense - Food & Dining	200	Expense	INR	1	33	33	2026-02-05 00:00:00	2026-03-08 15:54:29.355547	\N
395	Expense - Travel	200	Expense	INR	6	33	33	2026-02-19 00:00:00	2026-03-08 15:54:29.355547	\N
396	Expense - Entertainment	200	Expense	INR	5	33	33	2026-02-19 00:00:00	2026-03-08 15:54:29.355547	\N
397	Expense - Entertainment	200	Expense	INR	5	33	33	2026-03-07 00:00:00	2026-03-08 15:54:29.355547	\N
398	Expense - Healthcare	200	Expense	INR	4	33	33	2026-02-17 00:00:00	2026-03-08 15:54:29.355547	\N
399	Expense - Utilities	200	Expense	INR	9	33	33	2026-03-07 00:00:00	2026-03-08 15:54:29.355547	\N
400	Expense - Transportation	200	Expense	INR	2	33	33	2026-03-04 00:00:00	2026-03-08 15:54:29.355547	\N
401	Expense - Miscellaneous	200	Expense	INR	10	33	33	2026-02-14 00:00:00	2026-03-08 15:54:29.355547	\N
402	Expense - Utilities	200	Expense	INR	9	33	33	2026-02-01 00:00:00	2026-03-08 15:54:29.355547	\N
403	Expense - Utilities	200	Expense	INR	9	33	33	2026-03-01 00:00:00	2026-03-08 15:54:29.355547	\N
404	Expense - Healthcare	200	Expense	INR	4	33	33	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
405	Expense - Transportation	200	Expense	INR	2	35	35	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
406	Expense - Shopping	200	Expense	INR	7	42	42	2026-02-19 00:00:00	2026-03-08 15:54:29.355547	\N
407	Expense - Entertainment	200	Expense	INR	5	42	42	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
408	Expense - Entertainment	200	Expense	INR	5	42	42	2026-03-03 00:00:00	2026-03-08 15:54:29.355547	\N
409	Expense - Food & Dining	200	Expense	INR	1	42	42	2026-02-21 00:00:00	2026-03-08 15:54:29.355547	\N
410	Expense - Shopping	300	Expense	INR	7	42	42	2026-02-25 00:00:00	2026-03-08 15:54:29.355547	\N
411	Expense - Entertainment	200	Expense	INR	5	42	42	2026-02-07 00:00:00	2026-03-08 15:54:29.355547	\N
412	Expense - Travel	200	Expense	INR	6	42	42	2026-03-08 00:00:00	2026-03-08 15:54:29.355547	\N
413	Expense - Housing	1100	Expense	INR	3	42	42	2026-02-15 00:00:00	2026-03-08 15:54:29.355547	\N
414	Expense - Travel	300	Expense	INR	6	42	42	2026-02-24 00:00:00	2026-03-08 15:54:29.355547	\N
415	Expense - Housing	800	Expense	INR	3	42	42	2026-02-19 00:00:00	2026-03-08 15:54:29.355547	\N
416	Expense - Shopping	200	Expense	INR	7	42	42	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
417	Expense - Education	200	Expense	INR	8	42	42	2026-02-17 00:00:00	2026-03-08 15:54:29.355547	\N
418	Expense - Education	200	Expense	INR	8	42	42	2026-02-07 00:00:00	2026-03-08 15:54:29.355547	\N
419	Expense - Shopping	200	Expense	INR	7	42	42	2026-02-08 00:00:00	2026-03-08 15:54:29.355547	\N
420	Expense - Travel	200	Expense	INR	6	42	42	2026-02-22 00:00:00	2026-03-08 15:54:29.355547	\N
421	Expense - Miscellaneous	200	Expense	INR	10	42	42	2026-02-10 00:00:00	2026-03-08 15:54:29.355547	\N
422	Expense - Utilities	300	Expense	INR	9	42	42	2026-02-23 00:00:00	2026-03-08 15:54:29.355547	\N
423	Expense - Entertainment	200	Expense	INR	5	42	42	2026-02-23 00:00:00	2026-03-08 15:54:29.355547	\N
424	Expense - Utilities	200	Expense	INR	9	44	44	2026-03-03 00:00:00	2026-03-08 15:54:29.355547	\N
425	Expense - Transportation	200	Expense	INR	2	44	44	2026-02-22 00:00:00	2026-03-08 15:54:29.355547	\N
426	Expense - Miscellaneous	200	Expense	INR	10	44	44	2026-02-02 00:00:00	2026-03-08 15:54:29.355547	\N
427	Expense - Healthcare	200	Expense	INR	4	44	44	2026-03-05 00:00:00	2026-03-08 15:54:29.355547	\N
428	Expense - Travel	200	Expense	INR	6	44	44	2026-02-25 00:00:00	2026-03-08 15:54:29.355547	\N
429	Expense - Shopping	200	Expense	INR	7	44	44	2026-02-21 00:00:00	2026-03-08 15:54:29.355547	\N
430	Expense - Entertainment	200	Expense	INR	5	44	44	2026-03-08 00:00:00	2026-03-08 15:54:29.355547	\N
431	Expense - Education	200	Expense	INR	8	44	44	2026-02-16 00:00:00	2026-03-08 15:54:29.355547	\N
432	Expense - Education	200	Expense	INR	8	44	44	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
433	Expense - Housing	300	Expense	INR	3	44	44	2026-03-05 00:00:00	2026-03-08 15:54:29.355547	\N
434	Expense - Housing	200	Expense	INR	3	44	44	2026-02-02 00:00:00	2026-03-08 15:54:29.355547	\N
435	Expense - Miscellaneous	200	Expense	INR	10	44	44	2026-03-04 00:00:00	2026-03-08 15:54:29.355547	\N
436	Expense - Food & Dining	200	Expense	INR	1	44	44	2026-02-17 00:00:00	2026-03-08 15:54:29.355547	\N
437	Expense - Travel	200	Expense	INR	6	44	44	2026-02-23 00:00:00	2026-03-08 15:54:29.355547	\N
438	Expense - Entertainment	200	Expense	INR	5	45	45	2026-02-05 00:00:00	2026-03-08 15:54:29.355547	\N
439	Expense - Housing	600	Expense	INR	3	45	45	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
440	Expense - Healthcare	200	Expense	INR	4	45	45	2026-02-01 00:00:00	2026-03-08 15:54:29.355547	\N
441	Expense - Travel	200	Expense	INR	6	45	45	2026-02-14 00:00:00	2026-03-08 15:54:29.355547	\N
442	Expense - Education	200	Expense	INR	8	45	45	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
443	Expense - Entertainment	200	Expense	INR	5	45	45	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
444	Expense - Travel	200	Expense	INR	6	45	45	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
445	Expense - Miscellaneous	200	Expense	INR	10	45	45	2026-02-17 00:00:00	2026-03-08 15:54:29.355547	\N
446	Expense - Transportation	200	Expense	INR	2	45	45	2026-03-05 00:00:00	2026-03-08 15:54:29.355547	\N
447	Expense - Travel	200	Expense	INR	6	45	45	2026-02-21 00:00:00	2026-03-08 15:54:29.355547	\N
448	Expense - Food & Dining	700	Expense	INR	1	45	45	2026-03-03 00:00:00	2026-03-08 15:54:29.355547	\N
449	Expense - Entertainment	200	Expense	INR	5	45	45	2026-02-20 00:00:00	2026-03-08 15:54:29.355547	\N
450	Expense - Miscellaneous	200	Expense	INR	10	45	45	2026-03-04 00:00:00	2026-03-08 15:54:29.355547	\N
451	Expense - Entertainment	200	Expense	INR	5	45	45	2026-02-28 00:00:00	2026-03-08 15:54:29.355547	\N
452	Expense - Healthcare	200	Expense	INR	4	45	45	2026-02-28 00:00:00	2026-03-08 15:54:29.355547	\N
453	Expense - Healthcare	200	Expense	INR	4	45	45	2026-02-18 00:00:00	2026-03-08 15:54:29.355547	\N
454	Expense - Healthcare	200	Expense	INR	4	45	45	2026-02-19 00:00:00	2026-03-08 15:54:29.355547	\N
455	Expense - Shopping	200	Expense	INR	7	45	45	2026-02-11 00:00:00	2026-03-08 15:54:29.355547	\N
456	Expense - Entertainment	200	Expense	INR	5	45	45	2026-03-06 00:00:00	2026-03-08 15:54:29.355547	\N
457	Expense - Housing	900	Expense	INR	3	45	45	2026-02-21 00:00:00	2026-03-08 15:54:29.355547	\N
458	Expense - Entertainment	200	Expense	INR	5	45	45	2026-02-15 00:00:00	2026-03-08 15:54:29.355547	\N
459	Expense - Healthcare	200	Expense	INR	4	45	45	2026-02-03 00:00:00	2026-03-08 15:54:29.355547	\N
460	Expense - Food & Dining	900	Expense	INR	1	45	45	2026-02-01 00:00:00	2026-03-08 15:54:29.355547	\N
461	Expense - Education	200	Expense	INR	8	45	45	2026-02-19 00:00:00	2026-03-08 15:54:29.355547	\N
462	Expense - Education	200	Expense	INR	8	45	45	2026-02-05 00:00:00	2026-03-08 15:54:29.355547	\N
463	Expense - Transportation	500	Expense	INR	2	45	45	2026-02-13 00:00:00	2026-03-08 15:54:29.355547	\N
464	Expense - Utilities	300	Expense	INR	9	45	45	2026-02-08 00:00:00	2026-03-08 15:54:29.355547	\N
465	Expense - Travel	200	Expense	INR	6	49	49	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
466	Expense - Entertainment	200	Expense	INR	5	49	49	2026-02-17 00:00:00	2026-03-08 15:54:29.355547	\N
467	Expense - Travel	200	Expense	INR	6	49	49	2026-03-04 00:00:00	2026-03-08 15:54:29.355547	\N
468	Expense - Miscellaneous	200	Expense	INR	10	49	49	2026-02-03 00:00:00	2026-03-08 15:54:29.355547	\N
469	Expense - Education	200	Expense	INR	8	49	49	2026-02-10 00:00:00	2026-03-08 15:54:29.355547	\N
470	Expense - Miscellaneous	200	Expense	INR	10	49	49	2026-02-21 00:00:00	2026-03-08 15:54:29.355547	\N
471	Expense - Food & Dining	200	Expense	INR	1	49	49	2026-02-10 00:00:00	2026-03-08 15:54:29.355547	\N
472	Expense - Education	200	Expense	INR	8	49	49	2026-02-23 00:00:00	2026-03-08 15:54:29.355547	\N
473	Expense - Entertainment	200	Expense	INR	5	49	49	2026-02-11 00:00:00	2026-03-08 15:54:29.355547	\N
474	Expense - Food & Dining	200	Expense	INR	1	49	49	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
475	Expense - Utilities	200	Expense	INR	9	49	49	2026-03-03 00:00:00	2026-03-08 15:54:29.355547	\N
476	Expense - Housing	200	Expense	INR	3	49	49	2026-03-05 00:00:00	2026-03-08 15:54:29.355547	\N
477	Expense - Shopping	200	Expense	INR	7	49	49	2026-03-04 00:00:00	2026-03-08 15:54:29.355547	\N
478	Expense - Utilities	200	Expense	INR	9	49	49	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
479	Expense - Education	200	Expense	INR	8	49	49	2026-02-17 00:00:00	2026-03-08 15:54:29.355547	\N
480	Expense - Housing	600	Expense	INR	3	49	49	2026-02-18 00:00:00	2026-03-08 15:54:29.355547	\N
481	Expense - Entertainment	200	Expense	INR	5	49	49	2026-02-05 00:00:00	2026-03-08 15:54:29.355547	\N
482	Expense - Healthcare	200	Expense	INR	4	49	49	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
483	Expense - Healthcare	200	Expense	INR	4	49	49	2026-02-07 00:00:00	2026-03-08 15:54:29.355547	\N
484	Expense - Transportation	400	Expense	INR	2	49	49	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
485	Expense - Food & Dining	200	Expense	INR	1	49	49	2026-03-05 00:00:00	2026-03-08 15:54:29.355547	\N
486	Expense - Utilities	300	Expense	INR	9	49	49	2026-03-04 00:00:00	2026-03-08 15:54:29.355547	\N
487	Expense - Education	200	Expense	INR	8	49	49	2026-02-24 00:00:00	2026-03-08 15:54:29.355547	\N
488	Salary Income	17300	Income	INR	11	1	1	2026-02-23 00:00:00	2026-03-08 15:54:29.355547	\N
489	Salary Income	16100	Income	INR	11	1	1	2026-02-13 00:00:00	2026-03-08 15:54:29.355547	\N
490	Salary Income	17100	Income	INR	11	1	1	2026-02-25 00:00:00	2026-03-08 15:54:29.355547	\N
491	Salary Income	24700	Income	INR	11	2	2	2026-02-16 00:00:00	2026-03-08 15:54:29.355547	\N
492	Salary Income	18300	Income	INR	11	3	3	2026-02-19 00:00:00	2026-03-08 15:54:29.355547	\N
493	Salary Income	19500	Income	INR	11	3	3	2026-02-28 00:00:00	2026-03-08 15:54:29.355547	\N
494	Salary Income	8400	Income	INR	11	4	4	2026-02-26 00:00:00	2026-03-08 15:54:29.355547	\N
495	Salary Income	8300	Income	INR	11	4	4	2026-02-23 00:00:00	2026-03-08 15:54:29.355547	\N
496	Salary Income	8400	Income	INR	11	4	4	2026-02-11 00:00:00	2026-03-08 15:54:29.355547	\N
497	Salary Income	24700	Income	INR	11	5	5	2026-02-11 00:00:00	2026-03-08 15:54:29.355547	\N
498	Salary Income	25200	Income	INR	11	5	5	2026-02-05 00:00:00	2026-03-08 15:54:29.355547	\N
499	Salary Income	18400	Income	INR	11	6	6	2026-02-23 00:00:00	2026-03-08 15:54:29.355547	\N
500	Salary Income	18300	Income	INR	11	6	6	2026-02-22 00:00:00	2026-03-08 15:54:29.355547	\N
501	Salary Income	12100	Income	INR	11	7	7	2026-02-24 00:00:00	2026-03-08 15:54:29.355547	\N
502	Salary Income	12100	Income	INR	11	7	7	2026-02-15 00:00:00	2026-03-08 15:54:29.355547	\N
503	Salary Income	8500	Income	INR	11	7	7	2026-03-08 00:00:00	2026-03-08 15:54:29.355547	\N
504	Salary Income	16000	Income	INR	11	8	8	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
505	Salary Income	16300	Income	INR	11	8	8	2026-02-03 00:00:00	2026-03-08 15:54:29.355547	\N
506	Salary Income	17000	Income	INR	11	8	8	2026-02-07 00:00:00	2026-03-08 15:54:29.355547	\N
507	Salary Income	48200	Income	INR	11	9	9	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
508	Salary Income	8600	Income	INR	11	10	10	2026-02-14 00:00:00	2026-03-08 15:54:29.355547	\N
509	Salary Income	8300	Income	INR	11	10	10	2026-02-28 00:00:00	2026-03-08 15:54:29.355547	\N
510	Salary Income	8600	Income	INR	11	10	10	2026-02-11 00:00:00	2026-03-08 15:54:29.355547	\N
511	Salary Income	8400	Income	INR	11	10	10	2026-03-04 00:00:00	2026-03-08 15:54:29.355547	\N
512	Salary Income	17100	Income	INR	11	11	11	2026-02-08 00:00:00	2026-03-08 15:54:29.355547	\N
513	Salary Income	17000	Income	INR	11	11	11	2026-02-13 00:00:00	2026-03-08 15:54:29.355547	\N
514	Salary Income	16400	Income	INR	11	11	11	2026-02-01 00:00:00	2026-03-08 15:54:29.355547	\N
515	Salary Income	16300	Income	INR	11	11	11	2026-03-05 00:00:00	2026-03-08 15:54:29.355547	\N
516	Salary Income	19100	Income	INR	11	12	12	2026-02-09 00:00:00	2026-03-08 15:54:29.355547	\N
517	Salary Income	18900	Income	INR	11	12	12	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
518	Salary Income	12500	Income	INR	11	12	12	2026-03-01 00:00:00	2026-03-08 15:54:29.355547	\N
519	Salary Income	12000	Income	INR	11	13	13	2026-02-18 00:00:00	2026-03-08 15:54:29.355547	\N
520	Salary Income	12600	Income	INR	11	13	13	2026-02-07 00:00:00	2026-03-08 15:54:29.355547	\N
521	Salary Income	8000	Income	INR	11	13	13	2026-03-03 00:00:00	2026-03-08 15:54:29.355547	\N
522	Salary Income	24400	Income	INR	11	14	14	2026-02-09 00:00:00	2026-03-08 15:54:29.355547	\N
523	Salary Income	24600	Income	INR	11	14	14	2026-02-08 00:00:00	2026-03-08 15:54:29.355547	\N
524	Salary Income	16600	Income	INR	11	14	14	2026-03-07 00:00:00	2026-03-08 15:54:29.355547	\N
525	Salary Income	48000	Income	INR	11	15	15	2026-02-11 00:00:00	2026-03-08 15:54:29.355547	\N
528	Salary Income	12800	Income	INR	11	17	17	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
529	Salary Income	12300	Income	INR	11	17	17	2026-02-11 00:00:00	2026-03-08 15:54:29.355547	\N
530	Salary Income	37600	Income	INR	11	17	17	2026-03-05 00:00:00	2026-03-08 15:54:29.355547	\N
531	Salary Income	12600	Income	INR	11	18	18	2026-02-13 00:00:00	2026-03-08 15:54:29.355547	\N
532	Salary Income	12300	Income	INR	11	18	18	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
533	Salary Income	25600	Income	INR	11	19	19	2026-02-05 00:00:00	2026-03-08 15:54:29.355547	\N
534	Salary Income	8100	Income	INR	11	20	20	2026-02-24 00:00:00	2026-03-08 15:54:29.355547	\N
535	Salary Income	8100	Income	INR	11	20	20	2026-02-14 00:00:00	2026-03-08 15:54:29.355547	\N
536	Salary Income	8300	Income	INR	11	20	20	2026-02-13 00:00:00	2026-03-08 15:54:29.355547	\N
537	Salary Income	12700	Income	INR	11	21	21	2026-02-14 00:00:00	2026-03-08 15:54:29.355547	\N
538	Salary Income	12800	Income	INR	11	21	21	2026-02-08 00:00:00	2026-03-08 15:54:29.355547	\N
539	Salary Income	12800	Income	INR	11	21	21	2026-02-09 00:00:00	2026-03-08 15:54:29.355547	\N
540	Salary Income	12100	Income	INR	11	21	21	2026-03-01 00:00:00	2026-03-08 15:54:29.355547	\N
541	Salary Income	25700	Income	INR	11	22	22	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
542	Salary Income	8000	Income	INR	11	22	22	2026-03-06 00:00:00	2026-03-08 15:54:29.355547	\N
543	Salary Income	16200	Income	INR	11	23	23	2026-02-17 00:00:00	2026-03-08 15:54:29.355547	\N
544	Salary Income	17000	Income	INR	11	23	23	2026-02-06 00:00:00	2026-03-08 15:54:29.355547	\N
545	Salary Income	16800	Income	INR	11	23	23	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
546	Salary Income	25700	Income	INR	11	23	23	2026-03-01 00:00:00	2026-03-08 15:54:29.355547	\N
547	Salary Income	16200	Income	INR	11	24	24	2026-02-20 00:00:00	2026-03-08 15:54:29.355547	\N
548	Salary Income	16600	Income	INR	11	24	24	2026-02-16 00:00:00	2026-03-08 15:54:29.355547	\N
549	Salary Income	16500	Income	INR	11	24	24	2026-02-13 00:00:00	2026-03-08 15:54:29.355547	\N
550	Salary Income	49400	Income	INR	11	25	25	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
551	Salary Income	25100	Income	INR	11	26	26	2026-02-28 00:00:00	2026-03-08 15:54:29.355547	\N
552	Salary Income	24200	Income	INR	11	26	26	2026-03-07 00:00:00	2026-03-08 15:54:29.355547	\N
553	Salary Income	18700	Income	INR	11	27	27	2026-02-14 00:00:00	2026-03-08 15:54:29.355547	\N
554	Salary Income	18400	Income	INR	11	27	27	2026-02-19 00:00:00	2026-03-08 15:54:29.355547	\N
555	Salary Income	25500	Income	INR	11	28	28	2026-02-09 00:00:00	2026-03-08 15:54:29.355547	\N
556	Salary Income	25600	Income	INR	11	28	28	2026-02-18 00:00:00	2026-03-08 15:54:29.355547	\N
557	Salary Income	24000	Income	INR	11	28	28	2026-03-06 00:00:00	2026-03-08 15:54:29.355547	\N
558	Salary Income	24400	Income	INR	11	28	28	2026-03-07 00:00:00	2026-03-08 15:54:29.355547	\N
559	Salary Income	37400	Income	INR	11	29	29	2026-02-22 00:00:00	2026-03-08 15:54:29.355547	\N
560	Salary Income	12100	Income	INR	11	29	29	2026-03-02 00:00:00	2026-03-08 15:54:29.355547	\N
561	Salary Income	12300	Income	INR	11	29	29	2026-03-04 00:00:00	2026-03-08 15:54:29.355547	\N
562	Salary Income	50200	Income	INR	11	30	30	2026-02-14 00:00:00	2026-03-08 15:54:29.355547	\N
563	Salary Income	24900	Income	INR	11	31	31	2026-02-10 00:00:00	2026-03-08 15:54:29.355547	\N
564	Salary Income	12900	Income	INR	11	32	32	2026-02-01 00:00:00	2026-03-08 15:54:29.355547	\N
565	Salary Income	12100	Income	INR	11	32	32	2026-02-17 00:00:00	2026-03-08 15:54:29.355547	\N
566	Salary Income	8000	Income	INR	11	33	33	2026-02-10 00:00:00	2026-03-08 15:54:29.355547	\N
567	Salary Income	8600	Income	INR	11	33	33	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
568	Salary Income	8000	Income	INR	11	33	33	2026-02-23 00:00:00	2026-03-08 15:54:29.355547	\N
569	Salary Income	37600	Income	INR	11	34	34	2026-02-20 00:00:00	2026-03-08 15:54:29.355547	\N
570	Salary Income	8300	Income	INR	11	35	35	2026-02-07 00:00:00	2026-03-08 15:54:29.355547	\N
571	Salary Income	8600	Income	INR	11	35	35	2026-02-26 00:00:00	2026-03-08 15:54:29.355547	\N
572	Salary Income	8600	Income	INR	11	35	35	2026-02-14 00:00:00	2026-03-08 15:54:29.355547	\N
573	Salary Income	25700	Income	INR	11	36	36	2026-02-25 00:00:00	2026-03-08 15:54:29.355547	\N
574	Salary Income	24600	Income	INR	11	37	37	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
575	Salary Income	12500	Income	INR	11	38	38	2026-02-13 00:00:00	2026-03-08 15:54:29.355547	\N
576	Salary Income	12700	Income	INR	11	38	38	2026-02-22 00:00:00	2026-03-08 15:54:29.355547	\N
577	Salary Income	12600	Income	INR	11	38	38	2026-02-25 00:00:00	2026-03-08 15:54:29.355547	\N
578	Salary Income	12100	Income	INR	11	38	38	2026-03-03 00:00:00	2026-03-08 15:54:29.355547	\N
579	Salary Income	24100	Income	INR	11	39	39	2026-02-16 00:00:00	2026-03-08 15:54:29.355547	\N
580	Salary Income	25000	Income	INR	11	39	39	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
581	Salary Income	16100	Income	INR	11	39	39	2026-03-07 00:00:00	2026-03-08 15:54:29.355547	\N
582	Salary Income	18300	Income	INR	11	40	40	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
583	Salary Income	19200	Income	INR	11	40	40	2026-02-28 00:00:00	2026-03-08 15:54:29.355547	\N
584	Salary Income	24600	Income	INR	11	41	41	2026-02-24 00:00:00	2026-03-08 15:54:29.355547	\N
585	Salary Income	19000	Income	INR	11	42	42	2026-02-09 00:00:00	2026-03-08 15:54:29.355547	\N
586	Salary Income	18600	Income	INR	11	42	42	2026-02-11 00:00:00	2026-03-08 15:54:29.355547	\N
587	Salary Income	19400	Income	INR	11	42	42	2026-03-02 00:00:00	2026-03-08 15:54:29.355547	\N
588	Salary Income	18100	Income	INR	11	43	43	2026-02-18 00:00:00	2026-03-08 15:54:29.355547	\N
589	Salary Income	19200	Income	INR	11	43	43	2026-02-22 00:00:00	2026-03-08 15:54:29.355547	\N
590	Salary Income	12400	Income	INR	11	44	44	2026-02-25 00:00:00	2026-03-08 15:54:29.355547	\N
591	Salary Income	12200	Income	INR	11	44	44	2026-02-28 00:00:00	2026-03-08 15:54:29.355547	\N
592	Salary Income	25200	Income	INR	11	45	45	2026-02-01 00:00:00	2026-03-08 15:54:29.355547	\N
593	Salary Income	8200	Income	INR	11	45	45	2026-03-07 00:00:00	2026-03-08 15:54:29.355547	\N
594	Salary Income	12700	Income	INR	11	46	46	2026-02-10 00:00:00	2026-03-08 15:54:29.355547	\N
595	Salary Income	12700	Income	INR	11	46	46	2026-02-23 00:00:00	2026-03-08 15:54:29.355547	\N
596	Salary Income	24800	Income	INR	11	47	47	2026-02-26 00:00:00	2026-03-08 15:54:29.355547	\N
597	Salary Income	24900	Income	INR	11	47	47	2026-02-17 00:00:00	2026-03-08 15:54:29.355547	\N
598	Salary Income	18800	Income	INR	11	48	48	2026-02-04 00:00:00	2026-03-08 15:54:29.355547	\N
599	Salary Income	18900	Income	INR	11	48	48	2026-02-07 00:00:00	2026-03-08 15:54:29.355547	\N
600	Salary Income	12100	Income	INR	11	49	49	2026-02-01 00:00:00	2026-03-08 15:54:29.355547	\N
601	Salary Income	12300	Income	INR	11	49	49	2026-02-12 00:00:00	2026-03-08 15:54:29.355547	\N
602	Salary Income	25900	Income	INR	11	49	49	2026-03-02 00:00:00	2026-03-08 15:54:29.355547	\N
603	Salary Income	21600	Income	INR	11	50	50	2026-02-08 00:00:00	2026-03-08 15:54:29.355547	\N
604	Salary Income	20500	Income	INR	11	50	50	2026-02-03 00:00:00	2026-03-08 15:54:29.355547	\N
605	Salary Income	20800	Income	INR	11	50	50	2026-02-10 00:00:00	2026-03-08 15:54:29.355547	\N
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

SELECT pg_catalog.setval('public.budgets_id_seq', 539, true);


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

SELECT pg_catalog.setval('public.transactions_id_seq1', 605, true);


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


-- Completed on 2026-03-12 12:07:24

--
-- PostgreSQL database dump complete
--

