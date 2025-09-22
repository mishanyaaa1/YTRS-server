--
-- PostgreSQL database cluster dump
--

-- Started on 2025-09-14 03:47:05

\restrict 8jme4BCSxc1HtxCKso00t7p204pE3f5O9ZGm6tmv9puSiCTX1gdgaPHvcaQRr2g

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:gsvRGYOiNAEEUrpQFVjRHA==$XL8pLow3kVeUH2pDwS5DvEJqwMH5f26OHMaZ5N2Y4Xk=:g89gC9gpUyFZ/ANIGVLXOeeuoNm82xM5YmzQvFQNeDM=';

--
-- User Configurations
--








\unrestrict 8jme4BCSxc1HtxCKso00t7p204pE3f5O9ZGm6tmv9puSiCTX1gdgaPHvcaQRr2g

--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

\restrict yNYb7vhqX3M67JFab2M9XzN3AJ9vp7X3mU1yJcr1WmxoQbPMEhKapujSS2mvJCK

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

-- Started on 2025-09-14 03:47:05

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

-- Completed on 2025-09-14 03:47:05

--
-- PostgreSQL database dump complete
--

\unrestrict yNYb7vhqX3M67JFab2M9XzN3AJ9vp7X3mU1yJcr1WmxoQbPMEhKapujSS2mvJCK

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

\restrict QUALN2aaKP4a2wL5eSoaA8rwTX5RLDPUvjrVRxNiGYfTIGQ9mbzlJK8bTG3kdDY

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

-- Started on 2025-09-14 03:47:05

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

-- Completed on 2025-09-14 03:47:06

--
-- PostgreSQL database dump complete
--

\unrestrict QUALN2aaKP4a2wL5eSoaA8rwTX5RLDPUvjrVRxNiGYfTIGQ9mbzlJK8bTG3kdDY

--
-- Database "ytorsweb" dump
--

--
-- PostgreSQL database dump
--

\restrict btHtLfaKMNqNjehGM7b0O85jb8RInYbSu3d4pZZBYP24wYA0e3KLxNl56Nwbe9i

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

-- Started on 2025-09-14 03:47:06

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

--
-- TOC entry 5123 (class 1262 OID 16388)
-- Name: ytorsweb; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE ytorsweb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


ALTER DATABASE ytorsweb OWNER TO postgres;

\unrestrict btHtLfaKMNqNjehGM7b0O85jb8RInYbSu3d4pZZBYP24wYA0e3KLxNl56Nwbe9i
\connect ytorsweb
\restrict btHtLfaKMNqNjehGM7b0O85jb8RInYbSu3d4pZZBYP24wYA0e3KLxNl56Nwbe9i

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

--
-- TOC entry 6 (class 2615 OID 16747)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 5124 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- TOC entry 2 (class 3079 OID 16748)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- TOC entry 5126 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 16760)
-- Name: admins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admins (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    password_hash text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.admins OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16759)
-- Name: admins_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admins_id_seq OWNER TO postgres;

--
-- TOC entry 5127 (class 0 OID 0)
-- Dependencies: 218
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admins_id_seq OWNED BY public.admins.id;


--
-- TOC entry 242 (class 1259 OID 16936)
-- Name: advertising_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.advertising_events (
    id integer NOT NULL,
    platform character varying(100) NOT NULL,
    event_type character varying(100) NOT NULL,
    event_data text,
    user_agent text,
    ip_address inet,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.advertising_events OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16935)
-- Name: advertising_events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.advertising_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.advertising_events_id_seq OWNER TO postgres;

--
-- TOC entry 5128 (class 0 OID 0)
-- Dependencies: 241
-- Name: advertising_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.advertising_events_id_seq OWNED BY public.advertising_events.id;


--
-- TOC entry 240 (class 1259 OID 16921)
-- Name: advertising_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.advertising_settings (
    id integer NOT NULL,
    platform character varying(100) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    settings_json text DEFAULT '{}'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.advertising_settings OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16920)
-- Name: advertising_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.advertising_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.advertising_settings_id_seq OWNER TO postgres;

--
-- TOC entry 5129 (class 0 OID 0)
-- Dependencies: 239
-- Name: advertising_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.advertising_settings_id_seq OWNED BY public.advertising_settings.id;


--
-- TOC entry 260 (class 1259 OID 17062)
-- Name: bot_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bot_settings (
    id integer NOT NULL,
    setting_key character varying(255) NOT NULL,
    setting_value text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.bot_settings OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 17061)
-- Name: bot_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bot_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bot_settings_id_seq OWNER TO postgres;

--
-- TOC entry 5130 (class 0 OID 0)
-- Dependencies: 259
-- Name: bot_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bot_settings_id_seq OWNED BY public.bot_settings.id;


--
-- TOC entry 225 (class 1259 OID 16795)
-- Name: brands; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.brands (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.brands OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16794)
-- Name: brands_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.brands_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.brands_id_seq OWNER TO postgres;

--
-- TOC entry 5131 (class 0 OID 0)
-- Dependencies: 224
-- Name: brands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.brands_id_seq OWNED BY public.brands.id;


--
-- TOC entry 221 (class 1259 OID 16772)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16771)
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
-- TOC entry 5132 (class 0 OID 0)
-- Dependencies: 220
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 233 (class 1259 OID 16863)
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    phone character varying(50) NOT NULL,
    email character varying(255),
    address text
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16862)
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customers_id_seq OWNER TO postgres;

--
-- TOC entry 5133 (class 0 OID 0)
-- Dependencies: 232
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- TOC entry 262 (class 1259 OID 17075)
-- Name: email_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_settings (
    id integer NOT NULL,
    setting_key character varying(255) NOT NULL,
    setting_value text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.email_settings OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 17074)
-- Name: email_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.email_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.email_settings_id_seq OWNER TO postgres;

--
-- TOC entry 5134 (class 0 OID 0)
-- Dependencies: 261
-- Name: email_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.email_settings_id_seq OWNED BY public.email_settings.id;


--
-- TOC entry 254 (class 1259 OID 17018)
-- Name: filter_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.filter_settings (
    id integer NOT NULL,
    setting_key character varying(255) NOT NULL,
    setting_value integer DEFAULT 1 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.filter_settings OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 17017)
-- Name: filter_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.filter_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.filter_settings_id_seq OWNER TO postgres;

--
-- TOC entry 5135 (class 0 OID 0)
-- Dependencies: 253
-- Name: filter_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.filter_settings_id_seq OWNED BY public.filter_settings.id;


--
-- TOC entry 236 (class 1259 OID 16887)
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id character varying(255) NOT NULL,
    product_id integer,
    title text NOT NULL,
    price integer NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16886)
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO postgres;

--
-- TOC entry 5136 (class 0 OID 0)
-- Dependencies: 235
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- TOC entry 238 (class 1259 OID 16906)
-- Name: order_notes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_notes (
    id integer NOT NULL,
    order_id character varying(255) NOT NULL,
    text text NOT NULL,
    type character varying(50) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.order_notes OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16905)
-- Name: order_notes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_notes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_notes_id_seq OWNER TO postgres;

--
-- TOC entry 5137 (class 0 OID 0)
-- Dependencies: 237
-- Name: order_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_notes_id_seq OWNED BY public.order_notes.id;


--
-- TOC entry 234 (class 1259 OID 16871)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id character varying(255) NOT NULL,
    order_number character varying(255) NOT NULL,
    customer_id integer,
    status character varying(50) DEFAULT 'new'::character varying NOT NULL,
    pricing_json text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 17002)
-- Name: popular_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.popular_products (
    id integer NOT NULL,
    product_id integer NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.popular_products OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 17001)
-- Name: popular_products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.popular_products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.popular_products_id_seq OWNER TO postgres;

--
-- TOC entry 5138 (class 0 OID 0)
-- Dependencies: 251
-- Name: popular_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.popular_products_id_seq OWNED BY public.popular_products.id;


--
-- TOC entry 229 (class 1259 OID 16832)
-- Name: product_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_images (
    id integer NOT NULL,
    product_id integer NOT NULL,
    image_data text NOT NULL,
    is_main boolean DEFAULT false NOT NULL
);


ALTER TABLE public.product_images OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16831)
-- Name: product_images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_images_id_seq OWNER TO postgres;

--
-- TOC entry 5139 (class 0 OID 0)
-- Dependencies: 228
-- Name: product_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_images_id_seq OWNED BY public.product_images.id;


--
-- TOC entry 227 (class 1259 OID 16804)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    title text NOT NULL,
    price integer NOT NULL,
    category_id integer,
    subcategory_id integer,
    brand_id integer,
    available boolean DEFAULT true NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    description text,
    specifications_json text,
    features_json text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16803)
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- TOC entry 5140 (class 0 OID 0)
-- Dependencies: 226
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- TOC entry 256 (class 1259 OID 17030)
-- Name: promocodes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promocodes (
    id integer NOT NULL,
    code character varying(255) NOT NULL,
    description text,
    discount_type character varying(50) DEFAULT 'percentage'::character varying NOT NULL,
    discount_value integer NOT NULL,
    min_purchase integer DEFAULT 0,
    max_uses integer,
    used_count integer DEFAULT 0 NOT NULL,
    valid_from timestamp with time zone,
    valid_until timestamp with time zone,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.promocodes OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 17029)
-- Name: promocodes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.promocodes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.promocodes_id_seq OWNER TO postgres;

--
-- TOC entry 5141 (class 0 OID 0)
-- Dependencies: 255
-- Name: promocodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.promocodes_id_seq OWNED BY public.promocodes.id;


--
-- TOC entry 231 (class 1259 OID 16847)
-- Name: promotions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promotions (
    id integer NOT NULL,
    title text NOT NULL,
    description text,
    discount integer NOT NULL,
    category_id integer,
    valid_until timestamp with time zone,
    active boolean DEFAULT true NOT NULL,
    featured boolean DEFAULT false NOT NULL,
    min_purchase integer
);


ALTER TABLE public.promotions OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16846)
-- Name: promotions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.promotions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.promotions_id_seq OWNER TO postgres;

--
-- TOC entry 5142 (class 0 OID 0)
-- Dependencies: 230
-- Name: promotions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.promotions_id_seq OWNED BY public.promotions.id;


--
-- TOC entry 250 (class 1259 OID 16989)
-- Name: site_content; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.site_content (
    id integer NOT NULL,
    content_key character varying(255) NOT NULL,
    content_data text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.site_content OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 16988)
-- Name: site_content_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.site_content_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.site_content_id_seq OWNER TO postgres;

--
-- TOC entry 5143 (class 0 OID 0)
-- Dependencies: 249
-- Name: site_content_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.site_content_id_seq OWNED BY public.site_content.id;


--
-- TOC entry 223 (class 1259 OID 16781)
-- Name: subcategories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subcategories (
    id integer NOT NULL,
    category_id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.subcategories OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16780)
-- Name: subcategories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subcategories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subcategories_id_seq OWNER TO postgres;

--
-- TOC entry 5144 (class 0 OID 0)
-- Dependencies: 222
-- Name: subcategories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subcategories_id_seq OWNED BY public.subcategories.id;


--
-- TOC entry 244 (class 1259 OID 16946)
-- Name: terrain_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.terrain_types (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.terrain_types OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16945)
-- Name: terrain_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.terrain_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.terrain_types_id_seq OWNER TO postgres;

--
-- TOC entry 5145 (class 0 OID 0)
-- Dependencies: 243
-- Name: terrain_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.terrain_types_id_seq OWNED BY public.terrain_types.id;


--
-- TOC entry 258 (class 1259 OID 17047)
-- Name: vehicle_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicle_images (
    id integer NOT NULL,
    vehicle_id integer NOT NULL,
    image_data text NOT NULL,
    is_main boolean DEFAULT false NOT NULL
);


ALTER TABLE public.vehicle_images OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 17046)
-- Name: vehicle_images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vehicle_images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vehicle_images_id_seq OWNER TO postgres;

--
-- TOC entry 5146 (class 0 OID 0)
-- Dependencies: 257
-- Name: vehicle_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vehicle_images_id_seq OWNED BY public.vehicle_images.id;


--
-- TOC entry 246 (class 1259 OID 16956)
-- Name: vehicle_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicle_types (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.vehicle_types OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 16955)
-- Name: vehicle_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vehicle_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vehicle_types_id_seq OWNER TO postgres;

--
-- TOC entry 5147 (class 0 OID 0)
-- Dependencies: 245
-- Name: vehicle_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vehicle_types_id_seq OWNED BY public.vehicle_types.id;


--
-- TOC entry 248 (class 1259 OID 16966)
-- Name: vehicles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicles (
    id integer NOT NULL,
    name text NOT NULL,
    type character varying(255) NOT NULL,
    terrain character varying(255) NOT NULL,
    price integer NOT NULL,
    image text,
    description text,
    specs_json text,
    available boolean DEFAULT true NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.vehicles OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 16965)
-- Name: vehicles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vehicles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vehicles_id_seq OWNER TO postgres;

--
-- TOC entry 5148 (class 0 OID 0)
-- Dependencies: 247
-- Name: vehicles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vehicles_id_seq OWNED BY public.vehicles.id;


--
-- TOC entry 4761 (class 2604 OID 16763)
-- Name: admins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins ALTER COLUMN id SET DEFAULT nextval('public.admins_id_seq'::regclass);


--
-- TOC entry 4788 (class 2604 OID 16939)
-- Name: advertising_events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.advertising_events ALTER COLUMN id SET DEFAULT nextval('public.advertising_events_id_seq'::regclass);


--
-- TOC entry 4783 (class 2604 OID 16924)
-- Name: advertising_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.advertising_settings ALTER COLUMN id SET DEFAULT nextval('public.advertising_settings_id_seq'::regclass);


--
-- TOC entry 4818 (class 2604 OID 17065)
-- Name: bot_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bot_settings ALTER COLUMN id SET DEFAULT nextval('public.bot_settings_id_seq'::regclass);


--
-- TOC entry 4765 (class 2604 OID 16798)
-- Name: brands id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands ALTER COLUMN id SET DEFAULT nextval('public.brands_id_seq'::regclass);


--
-- TOC entry 4763 (class 2604 OID 16775)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 4776 (class 2604 OID 16866)
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- TOC entry 4821 (class 2604 OID 17078)
-- Name: email_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_settings ALTER COLUMN id SET DEFAULT nextval('public.email_settings_id_seq'::regclass);


--
-- TOC entry 4805 (class 2604 OID 17021)
-- Name: filter_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filter_settings ALTER COLUMN id SET DEFAULT nextval('public.filter_settings_id_seq'::regclass);


--
-- TOC entry 4780 (class 2604 OID 16890)
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- TOC entry 4781 (class 2604 OID 16909)
-- Name: order_notes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_notes ALTER COLUMN id SET DEFAULT nextval('public.order_notes_id_seq'::regclass);


--
-- TOC entry 4802 (class 2604 OID 17005)
-- Name: popular_products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.popular_products ALTER COLUMN id SET DEFAULT nextval('public.popular_products_id_seq'::regclass);


--
-- TOC entry 4771 (class 2604 OID 16835)
-- Name: product_images id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_images ALTER COLUMN id SET DEFAULT nextval('public.product_images_id_seq'::regclass);


--
-- TOC entry 4766 (class 2604 OID 16807)
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- TOC entry 4809 (class 2604 OID 17033)
-- Name: promocodes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promocodes ALTER COLUMN id SET DEFAULT nextval('public.promocodes_id_seq'::regclass);


--
-- TOC entry 4773 (class 2604 OID 16850)
-- Name: promotions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotions ALTER COLUMN id SET DEFAULT nextval('public.promotions_id_seq'::regclass);


--
-- TOC entry 4799 (class 2604 OID 16992)
-- Name: site_content id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_content ALTER COLUMN id SET DEFAULT nextval('public.site_content_id_seq'::regclass);


--
-- TOC entry 4764 (class 2604 OID 16784)
-- Name: subcategories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcategories ALTER COLUMN id SET DEFAULT nextval('public.subcategories_id_seq'::regclass);


--
-- TOC entry 4790 (class 2604 OID 16949)
-- Name: terrain_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.terrain_types ALTER COLUMN id SET DEFAULT nextval('public.terrain_types_id_seq'::regclass);


--
-- TOC entry 4816 (class 2604 OID 17050)
-- Name: vehicle_images id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_images ALTER COLUMN id SET DEFAULT nextval('public.vehicle_images_id_seq'::regclass);


--
-- TOC entry 4792 (class 2604 OID 16959)
-- Name: vehicle_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_types ALTER COLUMN id SET DEFAULT nextval('public.vehicle_types_id_seq'::regclass);


--
-- TOC entry 4794 (class 2604 OID 16969)
-- Name: vehicles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicles ALTER COLUMN id SET DEFAULT nextval('public.vehicles_id_seq'::regclass);


--
-- TOC entry 5074 (class 0 OID 16760)
-- Dependencies: 219
-- Data for Name: admins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admins (id, username, password_hash, created_at) FROM stdin;
1	admin	$2a$12$sAgNVV/sa5aODs/ZmN7kP.mDfeJp3o.NGsCdNe0PJeUv/U323ukme	2025-08-11 11:37:32+02
\.


--
-- TOC entry 5097 (class 0 OID 16936)
-- Dependencies: 242
-- Data for Name: advertising_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.advertising_events (id, platform, event_type, event_data, user_agent, ip_address, created_at) FROM stdin;
\.


--
-- TOC entry 5095 (class 0 OID 16921)
-- Dependencies: 240
-- Data for Name: advertising_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.advertising_settings (id, platform, enabled, settings_json, created_at, updated_at) FROM stdin;
1	yandexDirect	f	{"counterId":"","remarketingCode":"","conversionCode":"","pixelCode":""}	2025-08-23 18:31:53+02	2025-08-23 18:48:17+02
2	googleAds	f	{"conversionId":"","conversionLabel":"","remarketingCode":"","gtagCode":""}	2025-08-23 18:31:53+02	2025-08-23 18:48:17+02
3	facebookPixel	f	{"pixelId":"","conversionCode":""}	2025-08-23 18:31:53+02	2025-08-23 18:48:17+02
4	vkPixel	f	{"pixelId":"","conversionCode":""}	2025-08-23 18:31:53+02	2025-08-23 18:48:17+02
5	telegramPixel	f	{"botToken":"","chatId":""}	2025-08-23 18:31:53+02	2025-08-23 18:48:17+02
6	customScripts	f	{"headScripts":"","bodyScripts":""}	2025-08-23 18:31:53+02	2025-08-23 18:48:17+02
\.


--
-- TOC entry 5115 (class 0 OID 17062)
-- Dependencies: 260
-- Data for Name: bot_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bot_settings (id, setting_key, setting_value, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5080 (class 0 OID 16795)
-- Dependencies: 225
-- Data for Name: brands; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.brands (id, name) FROM stdin;
1	Вездеход-Мастер
2	ТехноМотор
3	СуперТрек
4	DrivePro
5	FilterPro
6	LubeMax
7	CoolMax
8	ClutchMax
9	WheelTech
10	LightMax
11	PowerMax
12	WirePro
13	ComfortSeat
14	InstrumentPro
\.


--
-- TOC entry 5076 (class 0 OID 16772)
-- Dependencies: 221
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name) FROM stdin;
3	Ходовая часть
13	Электрооборудование
16	Трансмиссия и привод
19	Инструмент и оборудование
20	Двигатель и топливная система
26	Двигатель
27	Трансмиссия
28	Электрика
29	Кабина
\.


--
-- TOC entry 5088 (class 0 OID 16863)
-- Dependencies: 233
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, name, phone, email, address) FROM stdin;
1	QIWI CARD	89224762214		
2	Тестовый клиент	+7 (999) 123-45-67	test@example.com	\N
3	QIWI CARD	89224762214	i.am31827@gmail.com	Nonono\nNonono
4	QIWI CARD	89224762214		
5	QIWI CARD	89224762214		
6	QIWI CARD	89224762214		Nonono\nNonono
7	QIWI CARD	89224762214		
8	Тестовый клиент	+7 (999) 123-45-67	test@example.com	\N
9	Тестовый клиент	+7 (999) 123-45-67	test@example.com	\N
10	QIWI CARD	89224762214		
11	QIWI CARD	89224762214		
12	QIWI CARD	89224762214		
13	QIWI CARD	89224762214		
14	QIWI CARD	89224762214		
15	Тестовый клиент	+7 (999) 123-45-67	test@example.com	\N
16	Тестовый клиент	+7 (999) 123-45-67	test@example.com	\N
17	QIWI CARD	89224762214		
18	QIWI CARD	89224762214		
19	QIWI CARD	89224762214		
20	QIWI CARD	89224762214		
21	QIWI CARD	89224762214		
22	sGzdsrg	546345345345		
23	QIWI CARD	89224762214		
24	QIWI CARD	89224762214		
25	[weq	sxc	wsx@ya.ru	fgdf
26	Кирилл	89506715774	m.e.g.a.t.r.o.n.753951@gmail.com	
27	Кирилл Шубин	89506715774	m.e.g.a.t.r.o.n.753951@gmail.com	
28	Кирилл	89506715774	m.e.g.a.t.r.o.n.753951@gmail.com	
29	Кирилл	89506715774	m.e.g.a.t.r.o.n.753951@gmail.com	
30	QIWI CARD	89224762214		
31	QIWI CARD	89224762214		
32	QIWI CARD	89224762214		
33	QIWI CARD	89224762214		
34	QIWI CARD	89224762214		
35	QIWI CARD	89224762214		
36	QIWI CARD	89224762214		
37	QIWI CARD	89224762214		
38	QIWI CARD	89224762214		
39	QIWI CARD	89224762214		
\.


--
-- TOC entry 5117 (class 0 OID 17075)
-- Dependencies: 262
-- Data for Name: email_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_settings (id, setting_key, setting_value, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5109 (class 0 OID 17018)
-- Dependencies: 254
-- Data for Name: filter_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.filter_settings (id, setting_key, setting_value, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5091 (class 0 OID 16887)
-- Dependencies: 236
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, product_id, title, price, quantity) FROM stdin;
44	26528261	21	Блок двигателя 51-01-109	194390	1
\.


--
-- TOC entry 5093 (class 0 OID 16906)
-- Dependencies: 238
-- Data for Name: order_notes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_notes (id, order_id, text, type, "timestamp") FROM stdin;
\.


--
-- TOC entry 5089 (class 0 OID 16871)
-- Dependencies: 234
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, order_number, customer_id, status, pricing_json, created_at, updated_at) FROM stdin;
26528261	26528261	39	new	{"subtotal":194390,"discountAmount":29159,"promocodeDiscount":0,"total":165231,"appliedPromotion":{"id":19,"title":"Скидка на двигатель","description":"Скидка на двигатель при покупке от 15 000р","discount":15,"category":null,"validUntil":"2025-12-12","active":true,"featured":true,"minPurchase":15000},"appliedPromocode":null}	2025-08-30 10:28:46+02	2025-08-30 10:28:46+02
\.


--
-- TOC entry 5107 (class 0 OID 17002)
-- Dependencies: 252
-- Data for Name: popular_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.popular_products (id, product_id, sort_order, created_at) FROM stdin;
\.


--
-- TOC entry 5084 (class 0 OID 16832)
-- Dependencies: 229
-- Data for Name: product_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_images (id, product_id, image_data, is_main) FROM stdin;
1539	24	🔩	t
1540	25	🔩	t
1541	38	🔩	t
1542	42	🔩	t
1543	50	🔩	t
1544	52	🔩	t
1545	54	🔩	t
1546	57	🔩	t
1547	61	🔩	t
1548	62	🔩	t
1549	65	🔩	t
1550	78	⚙️	t
1551	86	⚙️	t
1552	88	⚙️	t
1553	90	⚙️	t
1554	92	⚙️	t
1555	93	⚙️	t
1556	94	⚙️	t
1557	95	⚙️	t
1558	96	🔩	t
1559	97	⚡	t
1560	98	🔩	t
1561	100	🔧	t
1562	101	/uploads/1755993576200-333904918.jpg	t
1563	1	https://ytors.ru/wp-content/uploads/2023/07/zl646hlrrcu76bqhlfwgos375vs6exst-transformed.jpeg	t
1564	2	https://ytors.ru/wp-content/uploads/2023/07/item_6503-transformed.jpeg	t
1565	3	https://ytors.ru/wp-content/uploads/2023/07/m37ig1i7i9vi3vu1pnqlkanvamwb7uzh-transformed.jpeg	t
1566	4	https://ytors.ru/wp-content/uploads/2023/07/8ajhq3jg0vt1ebajx14t5fd9xgt0l523-transformed.jpeg	t
1567	5	https://ytors.ru/wp-content/uploads/2023/07/l1x7nert3fwg0i9na7aiwq49h4e0gbmg-transformed.jpeg	t
1568	6	https://ytors.ru/wp-content/uploads/2023/07/owy8xucosi1bfdiceh84sgtt582u65mf-transformed.jpeg	t
1569	7	https://ytors.ru/wp-content/uploads/2023/07/6nvbw0b13pu09r7w3t9n1smlm0l7vspz-transformed.jpeg	t
1570	8	https://ytors.ru/wp-content/uploads/2023/07/z0m1uk2qgc88zuxzaietjau88p2y835s-transformed.jpeg	t
1571	9	https://ytors.ru/wp-content/uploads/2023/07/p70hs05liqko63lo6groh6yb3m5hzke6-xreei7lf8-transformed.jpeg	t
1572	10	https://ytors.ru/wp-content/uploads/2023/07/ja2kp4fbb5lc0xqoaazqswpkryafrh2f_1-transformed.jpeg	t
1573	11	https://ytors.ru/wp-content/uploads/2023/07/r3uaqgb2hd5ade1hh871j3p38kjaiwk9-transformed.jpeg	t
1574	12	https://ytors.ru/wp-content/uploads/2023/07/msgcrcptfuujgo7xxf8fxnlvfxzcqjpk-nawrn_0lu-transformed.jpeg	t
1575	13	https://ytors.ru/wp-content/uploads/2023/07/6k4tl5h7ryruppyrytuvv2j3w0u9llm3-transformed.jpeg	t
1576	14	https://ytors.ru/wp-content/uploads/2023/07/qhnc1scm446b7pass8sbqdqdxgz7l2t0-transformed.jpeg	t
1577	15	https://ytors.ru/wp-content/uploads/2023/07/dewatermark.ai_1726483236334.jpg	t
1578	16	https://ytors.ru/wp-content/uploads/2023/07/c4kaxiwaz2ji0rnhx7lkzfx8hbbgyitc-transformed.jpeg	t
1579	17	https://ytors.ru/wp-content/uploads/2023/07/yzpep438ih1penk4v1l74yk9sc5awv6p-transformed.jpeg	t
1580	18	https://ytors.ru/wp-content/uploads/2023/07/bn037zj7aoyo269ymhwy2s18shzxxn74-transformed.jpeg	t
1581	19	https://ytors.ru/wp-content/uploads/2023/07/svmtvr1edms2hui82kljfxbvcpv3sa21-transformed.jpeg	t
1582	20	https://ytors.ru/wp-content/uploads/2023/07/5697sytuuantev8kcl4hreokxnk43z9n-transformed.jpeg	t
1583	21	https://ytors.ru/wp-content/uploads/2023/07/9kxt33j3im2znegb1m35yl3qhts0hhkk-transformed.jpeg	t
1584	39	https://ytors.ru/wp-content/uploads/2023/07/bolt12304.jpg	t
1585	48	https://ytors.ru/wp-content/uploads/2023/07/bolt700-28-2546.jpg	t
1586	63	https://ytors.ru/wp-content/uploads/2023/07/boltkreplenijakatka700-28-2527.jpg	t
1587	64	https://ytors.ru/wp-content/uploads/2023/07/boltm12-min-scaled.jpg	t
1588	67	https://ytors.ru/wp-content/uploads/2023/07/boltm12-min-scaled.jpg	t
1589	71	https://ytors.ru/wp-content/uploads/2023/07/boltm16m6g85.58.019-min-scaled.jpg	t
1590	84	https://ytors.ru/wp-content/uploads/2023/07/valkardannyj18-14-77-min.jpg	t
1591	87	https://ytors.ru/wp-content/uploads/2023/07/valkolenchtyj16-03-112-scaled.jpeg	t
1592	99	https://ytors.ru/wp-content/uploads/2023/07/gajka700-30-2327.jpg	t
1593	22	🔧	t
1594	102	/img/vehicles/1757657975220-561708050.png	t
1595	103	/img/vehicles/1757699189101-187791637.png	t
\.


--
-- TOC entry 5082 (class 0 OID 16804)
-- Dependencies: 227
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, title, price, category_id, subcategory_id, brand_id, available, quantity, description, specifications_json, features_json, created_at, updated_at) FROM stdin;
1	Кольцо 46764	20	3	69	\N	t	10	Кольцо для форкамеры, применяется для комплектации и ремонта двигателей тракторов Т-130, Т-170.	\N	\N	2025-08-23 23:12:41+02	2025-08-23 23:23:50+02
2	Вал карданный 18-14-77-1	2490	16	66	\N	t	10	Карданный вал служит для передачи крутящего момента от коробки передач на муфту сцепления трактора. \r\nПрименяется для серийных модификаций тракторов Т-130, Т-170	\N	\N	2025-08-23 23:12:41+02	2025-08-23 23:32:45+02
3	Кольцо 700-58-2251	490	3	69	\N	t	10	Кольцо 700-58-2251 применяется в муфте сцепления трактора	\N	\N	2025-08-23 23:12:41+02	2025-08-23 23:23:50+02
4	Кольцо 21363	30	3	69	\N	t	10	Кольцо применяется в муфте сцепления трактора.	\N	\N	2025-08-23 23:12:41+02	2025-08-23 23:23:50+02
5	Кольцо 50-19-152	360	3	69	\N	t	10	Кольцо — запасная часть для ремонта и обслуживания техники ЧТЗ.	\N	\N	2025-08-23 23:12:41+02	2025-08-23 23:32:45+02
6	Ремкомплект малого сервомеханизма к 50-15-118	250	3	69	\N	t	10	Ремкомплект малого сервомеханизма трактора Т-130, Т-170 \r\n— Манжета — 1 шт. — 3-48Х28-6 \r\n— Кольцо — 2 шт. — 40911 \r\n— Кольцо — 4 шт. — 40912 \r\n— Кольцо — 1 шт. — 40920 \r\n— Кольцо — 1 шт. — 46588 \r\n— Кольцо — 2 шт. — 46764 \r\n— Воротник — 1 шт. — 700-40-4032-1 \r\n— Кольцо — 1 шт. — 700-40-7374 \r\n— Кольцо — 1 шт. — 700-40-7375	\N	\N	2025-08-23 23:12:41+02	2025-08-23 23:23:50+02
7	Планка 50-21-42	240	3	69	\N	t	10	Планка применяется для крепления концевых подшипников, бортовых редукторов тракторов Т-130. \r\nДополнительно возможна комплектация планок другими запчастями Т-130.	\N	\N	2025-08-23 23:12:41+02	2025-08-23 23:23:50+02
8	Тарелка пружины клапана 0489	90	20	99	\N	t	10	Деталь является составным механизмом клапанов, предназначенная для герметизации цилиндра.	\N	\N	2025-08-23 23:12:41+02	2025-08-23 23:28:42+02
9	Шайба 700-31-2550	20	19	50	\N	t	10	Шайба применяется для ремонта и обслуживания техники ЧТЗ.	\N	\N	2025-08-23 23:12:41+02	2025-08-23 23:32:45+02
10	Амортизатор 700-40-7216	649	3	71	\N	t	10	Амортизаторы – небольшие виброгасительные детали-прокладки весом 189 г, в конструкции опор кабины их предусмотрено 4 шт. \r\nАмортизаторы предназначены для такой техники, как Т-170 и Б-10.	\N	\N	2025-08-23 23:12:41+02	2025-08-23 23:23:50+02
11	Амортизатор под радиатор 700-40-4915-1	190	20	106	\N	t	10	Предназначен для поглощения энергии, которая возникает в ходе эксплуатации трактора и бульдозеры Т-130, Т-170, Б10.	\N	\N	2025-08-23 23:12:41+02	2025-08-23 23:32:45+02
12	Амортизатор 700-40-7217	260	3	71	\N	t	10	Амортизаторы – небольшие виброгасительные детали-прокладки весом не более 189 г, в конструкции опор кабины их предусмотрено 4 шт. \r\nПредназначены для такой техники, как Т-170 и Б-10.	\N	\N	2025-08-23 23:12:41+02	2025-08-23 23:23:50+02
13	Бак радиатора верхний 130У.13.030	15490	20	106	\N	t	10	Устанавливается на радиатор сверху. Имеет плотно закрытую крышку. В верхний бак радиатора через горловину система охлаждения заливается водой. \r\nБак радиатора верхний применяется в системе охлаждения двигателей Д-160, Д-180.	\N	\N	2025-08-23 23:12:41+02	2025-08-23 23:32:45+02
14	Амортизатор под радиатор 700-40-4923	250	20	106	\N	t	10	Амортизатор предназначен для установки радиатора.	\N	\N	2025-08-23 23:12:41+02	2025-08-23 23:32:45+02
15	Бак топливный 50-25-182	22490	20	107	\N	t	10	Предназначен для хранения и снабжения трактора дизелем. \r\nПрименяется для комплектации и ремонта тракторов и бульдозеров Т-130, Т-170, Б10.	\N	\N	2025-08-23 23:12:41+02	2025-08-23 23:32:46+02
16	Бак радиатора нижний 130У.13.090 (050)	10290	20	106	\N	t	10	Бак радиатора нижний применяется для установки на водяной радиатор тракторов Т-130,Т-170. \r\nНа 1 водяной радиатор Т-130,Т-170 ставится 1 бак.	\N	\N	2025-08-23 23:12:41+02	2025-08-23 23:32:46+02
17	Барабан зубчатый 18-14-104	10490	3	70	\N	t	10	Барабан зубчатый входит в состав муфты сцепления Т-170. \r\nСлужит для сцепления дисков.	\N	\N	2025-08-23 23:12:41+02	2025-08-23 23:23:50+02
18	Барабан внутренний 24-16-5	16490	16	66	\N	t	10	В составе конструкции бортового фрикциона главной передачи бульдозера Б10М внутренний барабан является важной деталью, его функция заключается в передаче крутящего момента ведущим фрикционным дискам 16121 от вала 24-16-1 главной передачи.	\N	\N	2025-08-23 23:12:41+02	2025-08-23 23:32:46+02
19	Барабан наружный 28-16-15	19490	3	70	\N	t	10	Наружный барабан представляет собой «полый цилиндр» с гладкой внешней поверхностью и зубчатой внутренней, для сопряжения с зубцами по внешнему контуру дисков.	\N	\N	2025-08-23 23:12:41+02	2025-08-23 23:23:50+02
20	Башмак серийный 66-22-1	4590	16	66	\N	t	10	Башмак гусеничный на трактор выполнен из проката башмачной полосы и является сборочной единицей ходовой части гусеницы трактора. \r\nПодлежит последующей сборочной операции по установке на цепь гусеничную при помощи крепежных соединений болтов и гаек.	\N	\N	2025-08-23 23:12:41+02	2025-08-23 23:23:50+02
78	Вал (1 промежут.) 60-12-10	2220	16	66	\N	t	10	Вес \r\n 9,92	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:32:46+02
79	Вал 71-44-280	10560	16	66	\N	t	10		\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:32:46+02
80	Вал 50-26-814	3480	16	66	\N	t	10	Вес \r\n 6,8	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:32:46+02
81	Вал 24-16-1	2640	16	66	\N	t	10	Вес \r\n 21,7	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:32:46+02
82	Вал верхний 18-12-132	8400	16	66	\N	t	10	Вес \r\n 16,5	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:32:46+02
83	Вал 71-44-326	52	16	66	\N	t	10		\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:32:46+02
21	Блок двигателя 51-01-109	194390	20	108	\N	t	10	Блок двигателя — это основная деталь двигателей Д-160, Д-180. Является цельнолитой деталью, объединяющей собой цилиндры двигателя. В блоке цилиндров установлен коленчатый вал, к верхней части блока, как правило, крепится головка блока цилиндров, нижняя часть является частью картера. Таким образом, блок цилиндров является основой деталью двигателя Д-180, Д-160, к которой, так или иначе крепятся остальные его агрегаты и узлы.	\N	\N	2025-08-23 23:12:41+02	2025-08-23 23:32:46+02
22	Башмак трубоукладчика (L=690 мм) 66-22-1-02	3310	16	66	\N	t	10	Вес \r\n 20,6	\N	\N	2025-08-23 23:12:41+02	2025-08-23 23:32:46+02
23	Блок картера 17-01-164СП	22740	20	108	\N	t	10	Вес \r\n 51,8	\N	\N	2025-08-23 23:12:41+02	2025-08-23 23:32:46+02
24	Блок передач 64-12-200СП	12000	16	109	\N	t	10	Вес \r\n 10	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:32:46+02
25	Болт 700-28-2312	100	19	50	\N	t	10	Вес \r\n 0,56	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
26	Боковина 50-55-324	2520	19	50	\N	t	10	Вес \r\n 11,4	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
27	Болт 700-28-2378	85	19	50	\N	t	10	Вес \r\n 0,32	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
28	Болт 700-28-2480	90	19	50	\N	t	10	Вес \r\n 0,275	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
29	Болт (28579) 28556	10	19	50	\N	t	10	Вес \r\n 0,053	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
30	Болт (700-28-2587) шаг 2 М24*2*160	95	19	50	\N	t	10	Вес \r\n 0,67	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
31	Болт (М10*25.58.019) М10*25	11	19	50	\N	t	10	Вес \r\n 0,026	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
32	Болт (крепл. 19216) 700-28-2098	67	19	50	\N	t	10	Вес \r\n 0,193	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
33	Болт (М12*1,25*35) 700-28-2173	18	19	50	\N	t	10	Вес \r\n 0,043	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
34	Болт (М10*40.58.019) М10*40	6	19	50	\N	t	10	Вес \r\n 0,035	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
35	Болт (М12*45.58.019) М12*45	11	19	50	\N	t	10	Вес \r\n 0,054	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
36	Болт (М12*25.58.019) муфты сцепл. М12*25	11	19	50	\N	t	10	Вес \r\n 0,037	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
37	Болт + г,гровер 28565	150	19	50	\N	t	10	Вес \r\n 0,368	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
38	Болт 18-14-131	200	19	50	\N	t	10	Вес \r\n 0,46	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
39	Болт 12304	3	19	50	\N	t	10	Вес \r\n 0,025	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
40	Болт 28452	42	19	50	\N	t	10	Вес \r\n 0,032	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
41	Болт 16103	95	19	50	\N	t	10	Вес \r\n 0,104	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
42	Болт 28428	10	19	50	\N	t	10	Вес \r\n 0,013	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
43	Болт 28504	100	19	50	\N	t	10	Вес \r\n 0,197	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
44	Болт 28582	38	19	50	\N	t	10	Вес \r\n 0,219	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
45	Болт 700-28-2379	38	19	50	\N	t	10	Вес \r\n 0,496	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
46	Болт 700-28-2509 (16137)	38	19	50	\N	t	10	Вес \r\n 0,092	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
47	Болт 700-28-2622 (28554)	30	19	50	\N	t	10	Вес \r\n 0,106	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
48	Болт 700-28-2546	85	19	50	\N	t	10	Вес \r\n 0,103	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
49	Болт 700-41-3306	70	19	50	\N	t	10	Вес \r\n 0,124	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
50	Болт 700-28-2625	42	19	50	\N	t	10	Вес \r\n 0,278	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
51	Болт башмачный М16*1,5*60	28	19	50	\N	t	10	Вес \r\n 0,14	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
52	Болт башмачный (ММК) М20*1,5*62	45	19	50	\N	t	10	Вес \r\n 0,244	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
53	Болт БЕЗ гайки(средний нож) 700-28-2492	27	19	50	\N	t	10	Вес \r\n 0,081	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
54	Болт БЕЗ гайки(боковой нож) 700-28-2517	38	19	50	\N	t	10	Вес \r\n 0,16	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
55	Болт бугеля 700-28-2296	160	19	50	\N	t	10	Вес \r\n 0,673	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
56	Болт бендикса М8*12 СМД 8-1994, 700-28-2584	16	19	50	\N	t	10	Вес \r\n 0,01	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
57	Болт Завод 700-28-2546	180	19	50	\N	t	10	Вес \r\n 0,103	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
58	Болт и гайка 18-14-130/131	240	19	50	\N	t	10	Вес \r\n 0,64	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
59	Болт и гайка 700-28-2518	220	19	50	\N	t	10	Вес \r\n 1,05	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
60	Болт и гайка(средний нож) и гровером 700-28-2492	30	19	50	\N	t	10	Вес \r\n 0,128	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
61	Болт и гайка(боковой нож) и гровером 700-28-2517	50	19	50	\N	t	10	Вес \r\n 0,254	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
62	Болт М10*35	8	19	50	\N	t	10	Вес \r\n 0,032	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
63	Болт крепления катка 700-28-2527(2316)	45	19	50	\N	t	10	Вес \r\n 0,278	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
64	Болт М12*30 2816 (М12*30)	20	19	50	\N	t	10	Вес \r\n 0,042	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
65	Болт М10*45	7	19	50	\N	t	10	Вес \r\n 0,038	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
66	Болт М12*50 2856	18	19	50	\N	t	10	Вес \r\n 0,059	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
67	Болт М12*35 28558	12	19	50	\N	t	10	Вес \r\n 0,046	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
68	Болт М16*35 28431(700-28-2621)	20	19	50	\N	t	10	Вес \r\n 0,086	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
69	Болт М12*55.58.019	12	19	50	\N	t	10	Вес \r\n 0,063	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
70	Болт М20*60 28234 (М20*60)	30	19	50	\N	t	10	Вес \r\n 0,212	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
71	Болт М16*50 2837 (700-28-2618)	25	19	50	\N	t	10	Вес \r\n 0,109	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
72	Болт М8*35	5	19	50	\N	t	10	Вес \r\n 0,019	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
73	Болт М8*16	2	19	50	\N	t	10	Вес \r\n 0,012	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
74	Болт усиленный (40Х 8.8) 700-28-2379	95	19	50	\N	t	10	Вес \r\n 0,49	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
75	Болт полый 700-41-2716	14	19	50	\N	t	10	Вес \r\n 0,044	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
76	Бонка (шаг 2) 700-51-2080	40	19	50	\N	t	10	Вес \r\n 0,153	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
77	Болт(700-28-2620) 28417 (М-16*1,5*70.58.019	33	19	50	\N	t	10	Вес \r\n 0,14	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
84	Вал карданный 18-14-77 (50-14-23)	1560	16	66	\N	t	10	Вес \r\n 3,95	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:32:46+02
85	Вал кардан. болотн.(20-14-24) 20-14-8	5820	16	66	\N	t	10	Вес \r\n 9,09	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:32:46+02
86	Вал коленчатый ПД-23 (ЧТЗ) 17-03-26 СП	7920	16	66	\N	t	10	Вес \r\n 16	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:32:46+02
87	Вал коленчатый 16-03-112СП	195000	16	66	\N	t	10	Вес \r\n 139,11	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:32:46+02
88	Вал кулачковый (ТНВД) 51-67-23	4020	16	66	\N	t	10	Вес \r\n 1,5	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:32:46+02
89	Вал коленчатый ПД-23 Н1 17-03-26 СП	5580	16	66	\N	t	10	Вес \r\n 16	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:32:46+02
90	Вал нижний с шестерней 24-12-105СП	34080	16	66	\N	t	10	Вес \r\n 35,4	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:32:46+02
91	Вал нижний 18-12-156	31200	16	66	\N	t	10	Вес \r\n 6,7	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:32:46+02
92	Вал сцепления 41-2103	1590	16	110	\N	t	10	Вес \r\n 7,53	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:32:46+02
93	Вал распределительный 4230	40895	16	66	\N	t	10	Вес \r\n 2,533	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:32:46+02
94	Валик 20-12-79	900	16	66	\N	t	10	Вес \r\n 2	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:32:46+02
95	Вал-комплект (ТТ) 50-14-113	3600	16	66	\N	t	10	Вес \r\n 10,38	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:32:46+02
96	Гайка М30*2 (завод, шаг 2) 30230	84	19	50	\N	t	10	Вес \r\n 0,225	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
97	Генератор 14В 461.3701 1000В	3840	13	51	\N	t	10	Вес \r\n 5	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:23:50+02
98	Гайка к болту 700-28-2517 3015	11	19	50	\N	t	10	Вес \r\n 0,072	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
99	Гайка700-30-2238 700-30-2327	44	19	50	\N	t	10	Вес \r\n 0,06	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
100	Гидрозамок гидроцилиндра 50-50-195	6000	19	50	\N	t	10	Вес \r\n 3	\N	\N	2025-08-23 23:12:42+02	2025-08-23 23:28:42+02
102	салфетка 5	10000	26	131	\N	t	5	геалормлгеамлори	[]	[]	2025-09-12 06:19:40+02	2025-09-12 06:19:40+02
103	салфетка	50000	29	143	\N	t	5	еалоримдгни	[{"name":"аорлпмидгори","value":"765"}]	[]	2025-09-12 17:46:39+02	2025-09-12 17:46:39+02
\.


--
-- TOC entry 5111 (class 0 OID 17030)
-- Dependencies: 256
-- Data for Name: promocodes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promocodes (id, code, description, discount_type, discount_value, min_purchase, max_uses, used_count, valid_from, valid_until, active, created_at, updated_at) FROM stdin;
4	WELCOME10	Скидка 10% для новых клиентов	percentage	10	0	-1	0	\N	2026-09-12 08:06:40.176+02	t	2025-09-12 06:06:40+02	2025-09-12 06:06:40+02
5	SAVE500	Скидка 500 рублей при покупке от 10000	fixed	500	10000	-1	0	\N	2026-03-11 08:06:40.177+02	t	2025-09-12 06:06:40+02	2025-09-12 06:06:40+02
6	SUMMER20	Летняя скидка 20%	percentage	20	5000	-1	0	\N	2025-10-12 08:06:40.177+02	t	2025-09-12 06:06:40+02	2025-09-12 06:06:40+02
\.


--
-- TOC entry 5086 (class 0 OID 16847)
-- Dependencies: 231
-- Data for Name: promotions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promotions (id, title, description, discount, category_id, valid_until, active, featured, min_purchase) FROM stdin;
19	Скидка на двигатель	Скидка на двигатель при покупке от 15 000р	15	\N	2025-12-12 00:00:00+02	t	t	15000
24	Скидка на подвеску	Скидка при покупке от 15 000р	20	3	2025-12-12 00:00:00+02	t	t	15000
\.


--
-- TOC entry 5105 (class 0 OID 16989)
-- Dependencies: 250
-- Data for Name: site_content; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.site_content (id, content_key, content_data, created_at, updated_at) FROM stdin;
4	aboutContent	{"homeHero":{"title":"Запчасти\\nдля вездеходов","description":"Качественные запчасти для всех типов вездеходов.\\nБыстрая доставка по всей России. Гарантия качества на все товары.","ctaText":"Перейти в каталог","ctaLink":"/catalog","heroEffect":"particles","visualButtons":[],"secondaryCtaText":"Связаться с менеджером","secondaryCtaLink":"/about#contacts"},"title":"О компании ЮТОРС","description":"Мы специализируемся на поставке качественных запчастей для вездеходов всех типов и марок. Наша цель — обеспечить вас надежными комплектующими для безопасной и комфортной эксплуатации вашей техники.","advantages":{"title":"Наши преимущества","description":"Мы предлагаем комплексный подход к обслуживанию вашего вездехода","items":[{"title":"Быстрая доставка","description":"Доставка по всей России в кратчайшие сроки. Экспресс-доставка по Челябинску в день заказа.","icon":"🚚","details":["Доставка по Челябинску в день заказа","Доставка по России за 3-14 дней","Бесплатная доставка от 10,000 руб.","Отслеживание посылки в реальном времени"]},{"title":"Выгодные цены","description":"Конкурентные цены на все товары. Скидки для постоянных клиентов и оптовых покупателей.","icon":"💰","details":["Цены ниже рыночных на 10-15%","Скидки до 20% для постоянных клиентов","Специальные условия для оптовиков","Акции и распродажи каждый месяц"]},{"title":"Широкий ассортимент","description":"Более 25,000 наименований запчастей для всех типов и марок вездеходов в наличии на складе.","icon":"🔧","details":["25,000+ наименований в наличии","Запчасти для всех популярных марок","Редкие и снятые с производства детали","Постоянное пополнение ассортимента"]},{"title":"Гарантия качества","description":"Полная гарантия на все товары и профессиональная поддержка. Обменяем или вернем деньги в случае брака.","icon":"✅","details":["Гарантия от 6 месяцев до 2 лет","Официальные документы на все товары","Быстрый обмен при обнаружении брака","Техническая поддержка в течение гарантийного срока"]},{"title":"Профессиональная консультация","description":"Наши эксперты помогут подобрать именно те запчасти, которые подходят вашему вездеходу.","icon":"⭐","details":["Бесплатная консультация по телефону","Подбор по VIN-коду или фотографии","Проверка совместимости деталей","Рекомендации по установке и обслуживанию"]},{"title":"Надежность и опыт","description":"Более 10 лет опыта работы в сфере вездеходной техники. 50,000+ довольных клиентов.","icon":"🏆","details":["10+ лет опыта работы","50,000+ довольных клиентов","Лидер рынка запчастей для вездеходов","Сертифицированные специалисты"]}]},"whyChooseUs":{"title":"Почему выбирают нас","description":"Мы предлагаем не просто запчасти, а комплексное решение для вашего вездехода","items":[{"title":"Профессиональная консультация","description":"Наши эксперты помогут подобрать именно те запчасти, которые подходят вашему вездеходу. Консультация бесплатна!","icon":"⭐","details":["Бесплатная консультация по телефону и в чате","Подбор по VIN-коду, фотографии или описанию","Проверка совместимости деталей","Рекомендации по установке и обслуживанию"]},{"title":"Официальная гарантия","description":"На все товары предоставляется официальная гарантия производителя от 6 месяцев до 2 лет.","icon":"🛡️","details":["Гарантия от 6 месяцев до 2 лет","Официальные документы на все товары","Быстрый обмен при обнаружении брака","Техническая поддержка в течение гарантийного срока"]},{"title":"Точность подбора","description":"Благодаря нашему опыту, мы точно определим нужную деталь по VIN-коду или фотографии.","icon":"🎯","details":["Определение детали по VIN-коду","Подбор по фотографии неисправной детали","Проверка совместимости с вашей моделью","Предложение аналогов при отсутствии оригинала"]},{"title":"Быстрая доставка","description":"Доставляем запчасти по всей России в кратчайшие сроки. Экспресс-доставка по Челябинску в день заказа.","icon":"🚚","details":["Доставка по Челябинску в день заказа","Доставка по России за 3-14 дней","Отслеживание посылки в реальном времени","Бесплатная доставка при заказе от 10,000 руб."]},{"title":"Широкий ассортимент","description":"Более 15,000 наименований запчастей для всех типов и марок вездеходов в наличии на складе.","icon":"🔧","details":["15,000+ наименований в наличии","Запчасти для всех популярных марок","Постоянное пополнение ассортимента","Редкие и снятые с производства детали"]},{"title":"Выгодные цены","description":"Конкурентные цены на все товары. Скидки для постоянных клиентов и оптовых покупателей.","icon":"💰","details":["Цены ниже рыночных на 10-15%","Скидки для постоянных клиентов","Специальные условия для оптовиков","Акции и распродажи каждый месяц"]}]},"team":{"title":"Наша команда","description":"Профессиональная команда экспертов, которая поможет вам найти нужные запчасти и решить любые вопросы","members":[{"name":"Алексей Петров","position":"Генеральный директор","experience":"15 лет в автомобильной индустрии","photo":"👨‍💼","description":"Основатель компании, эксперт по вездеходной технике. Более 15 лет опыта работы с вездеходами различных марок.","achievements":["Основал компанию в 2013 году","Эксперт по техническим вопросам","Лично консультирует сложные случаи"]},{"name":"Мария Сидорова","position":"Технический директор","experience":"12 лет работы с вездеходами","photo":"👩‍🔧","description":"Отвечает за техническую экспертизу и качество продукции. Специализируется на двигателях и трансмиссиях.","achievements":["Инженер-механик по образованию","Сертифицированный эксперт","Обучает новых сотрудников"]},{"name":"Дмитрий Иванов","position":"Менеджер по продажам","experience":"8 лет в сфере запчастей","photo":"👨‍💻","description":"Помогает клиентам найти нужные запчасти и решает вопросы. Отлично знает ассортимент и совместимость деталей.","achievements":["Лучший менеджер 2023 года","Более 1000 довольных клиентов","Эксперт по подбору аналогов"]}]},"history":{"title":"История компании","content":"Компания ЮТОРС была основана в 2013 году группой энтузиастов, увлеченных вездеходной техникой. Начав с небольшого магазина в Челябинске, мы постепенно расширили свою деятельность и сегодня являемся одним из ведущих поставщиков запчастей для вездеходов в России. Наш путь от небольшой мастерской до крупнейшего поставщика запчастей — это история постоянного развития, инноваций и стремления к совершенству.","milestones":{"title":"Основные этапы развития","items":[{"year":"2013","title":"Основание компании","description":"Открытие первого магазина в Челябинске. Начали с небольшого ассортимента запчастей для популярных моделей вездеходов.","achievements":["Первый магазин 50 кв.м","Ассортимент 500 наименований","Команда из 3 человек"]},{"year":"2015","title":"Расширение ассортимента","description":"Добавление более 5000 наименований товаров. Начали работать с крупными поставщиками и дистрибьюторами.","achievements":["Ассортимент 5,000 наименований","Склад 200 кв.м","Команда 8 человек","Первые корпоративные клиенты"]},{"year":"2017","title":"Техническое развитие","description":"Внедрение современных систем учета и логистики. Открытие собственного сервисного центра.","achievements":["Собственный сервисный центр","Система электронного учета","Склад 500 кв.м","Команда 15 человек"]},{"year":"2018","title":"Запуск интернет-магазина","description":"Начало онлайн-продаж по всей России. Развитие логистической сети для доставки в регионы.","achievements":["Интернет-магазин","Доставка по всей России","10,000+ наименований","Команда 25 человек"]},{"year":"2020","title":"Цифровизация процессов","description":"Внедрение CRM-системы, автоматизация процессов. Запуск мобильного приложения.","achievements":["CRM-система","Мобильное приложение","15,000+ наименований","Команда 40 человек"]},{"year":"2022","title":"Региональное расширение","description":"Открытие филиалов в Екатеринбурге и Новосибирске. Развитие партнерской сети.","achievements":["Филиалы в 3 городах","Партнерская сеть 50+ точек","20,000+ наименований","Команда 60 человек"]},{"year":"2023","title":"Лидер рынка","description":"Стали крупнейшим поставщиком запчастей для вездеходов в России. Более 50,000 довольных клиентов.","achievements":["50,000+ клиентов","Лидер рынка","25,000+ наименований","Команда 80 человек"]},{"year":"2024","title":"Инновации и будущее","description":"Внедрение ИИ для подбора запчастей, развитие экологически чистых технологий. Планы выхода на международный рынок.","achievements":["ИИ-консультант","Экологические инициативы","Планы экспансии","Команда 100+ человек"]}]}},"contacts":{"title":"Контакты","phone":"+7 (800) 123-45-67","email":"info@vezdehod-zapchasti.ru","address":"40-летия Победы, 16а, Курчатовский район, Челябинск, 454100","workingHours":"Пн-Пт: 9:00-18:00, Сб: 10:00-16:00","additionalPhones":["+7 (351) 123-45-67","+7 (351) 987-65-43"],"socialMedia":{"vk":"https://vk.com/yutors","instagram":"https://instagram.com/yutors","youtube":"https://youtube.com/@yutors","telegram":"https://t.me/yutors_support"},"managers":[{"name":"Анна Петрова","position":"Менеджер по продажам","phone":"+7 (351) 123-45-68","email":"anna@vezdehod-zapchasti.ru"},{"name":"Михаил Сидоров","position":"Технический консультант","phone":"+7 (351) 123-45-69","email":"mikhail@vezdehod-zapchasti.ru"}],"description":"Мы всегда готовы помочь вам с выбором запчастей и ответить на любые вопросы. Свяжитесь с нами удобным способом!"},"statistics":{"title":"Статистика компании","items":[{"icon":"🏢","number":"10+","title":"Лет опыта","description":"работы в сфере вездеходной техники"},{"icon":"👥","number":"50,000+","title":"Клиентов","description":"доверили нам свою технику"},{"icon":"📦","number":"15,000+","title":"Товаров","description":"в наличии на складе"},{"icon":"🚛","number":"100%","title":"Гарантия","description":"на всю продукцию"}]},"values":{"title":"Наши ценности","items":[{"icon":"🎯","title":"Качество превыше всего","description":"Мы работаем только с проверенными поставщиками и гарантируем высочайшее качество каждой детали."},{"icon":"⚡","title":"Скорость обслуживания","description":"Быстрая обработка заказов и оперативная доставка по всей России в кратчайшие сроки."},{"icon":"🤝","title":"Честность и прозрачность","description":"Никаких скрытых платежей и переплат. Вы всегда знаете за что платите."},{"icon":"💡","title":"Экспертные консультации","description":"Наши специалисты помогут подобрать именно те запчасти, которые нужны вашему вездеходу."}]},"certificates":{"title":"Сертификаты и награды","items":[{"icon":"🏆","title":"ISO 9001:2015","description":"Сертификат системы менеджмента качества","year":"2023"},{"icon":"🥇","title":"Лучший дилер года","description":"Награда от ассоциации производителей вездеходов","year":"2023"},{"icon":"✅","title":"Официальный дистрибьютор","description":"Более 20 ведущих производителей запчастей","year":"2024"},{"icon":"🛡️","title":"Лицензия на торговлю","description":"Полный пакет документов и лицензий","year":"2024"}]},"testimonials":{"title":"Отзывы клиентов","items":[{"name":"Андрей К.","company":"ООО \\"Северная техника\\"","rating":5,"text":"Сотрудничаем уже 3 года. Всегда качественные запчасти и быстрая доставка. Рекомендую!","photo":""},{"name":"Михаил П.","company":"Частный клиент","rating":5,"text":"Нашел редкую деталь для старого вездехода. Ребята помогли, подобрали аналог. Отличный сервис!","photo":""},{"name":"Елена С.","company":"Турбаза \\"Дикий север\\"","rating":5,"text":"Обслуживаем парк из 15 снегоходов. ВездеходЗапчасти - наш надежный партнер уже много лет.","photo":""}]},"guarantees":{"title":"Наши гарантии","items":[{"icon":"🔒","title":"100% оригинальные запчасти","description":"Работаем напрямую с производителями. Никаких подделок и некачественных аналогов."},{"icon":"📋","title":"Гарантия до 2 лет","description":"На все товары предоставляется официальная гарантия производителя от 6 месяцев до 2 лет."},{"icon":"🔄","title":"Возврат в течение 14 дней","description":"Если товар не подошел, мы примем его обратно и вернем деньги без лишних вопросов."},{"icon":"💳","title":"Безопасная оплата","description":"Принимаем наличные, карты, безналичный расчет. Все платежи защищены."}]},"achievements":{"title":"Наши достижения","items":[{"icon":"📈","title":"Рост на 150% за год","description":"Количество довольных клиентов выросло в 2.5 раза","date":"2023"},{"icon":"🌟","title":"Рейтинг 4.9/5","description":"Средняя оценка от наших клиентов в отзывах","date":"2024"},{"icon":"🚀","title":"Запуск экспресс-доставки","description":"Доставка в день заказа по Москве и МО","date":"2024"}]},"deliveryAndPayment":{"title":"Доставка и оплата","steps":[{"title":"Оставляете заявку удобным способом","description":"Заполните форму на сайте или свяжитесь с нашим менеджером — ответим в течение 10 минут."},{"title":"Обработка заявки и счет-договор","description":"Подтвердим наличие, согласуем условия и подготовим счет-договор сразу после согласования."},{"title":"Подготовка товара и отгрузка","description":"Оперативно комплектуем заказ и передаем в доставку выбранным вами способом."},{"title":"Получение и проверка товара","description":"Проверьте товар при получении. При любых несоответствиях сразу свяжитесь с нами."}],"deliveryMethods":[{"title":"Самовывоз","description":"Можно забрать заказ самостоятельно со склада/пункта выдачи в Челябинске.","items":["Готовим заказ заранее и уведомляем, когда можно забрать","Режим работы пункта: Пн–Пт 9:00–18:00, Сб 10:00–16:00","Адрес: 40-летия Победы, 16а, Курчатовский район, Челябинск","На месте можно осмотреть товар и проверить комплектацию","Для самовывоза назовите номер заказа или ФИО получателя"]},{"title":"Бесплатная доставка по г. Челябинск","description":"Доставим заказ по Челябинску бесплатно — быстро и аккуратно.","items":["Курьер предварительно звонит за 30–60 минут до приезда","Доставка в тот же день при наличии товара на складе","Временные интервалы на выбор: 10:00–14:00 или 14:00–20:00","Подъём до двери/лифта — по возможности, крупногабарит по согласованию","Осмотр товара при получении; при несоответствии составим акт замены"]},{"title":"Доставка по России и СНГ","description":"Доставляем по всей России и странам СНГ различными способами.","items":["Транспортной компанией (СДЭК, ПЭК, Деловые линии)","Ж/д и авиа доставка для крупногабаритных грузов","Доставка попутным грузом для экономии","Сроки доставки: 3-14 дней в зависимости от региона","Стоимость рассчитывается индивидуально"]}],"deliveryNote":"Мы подберём оптимальный маршрут доставки по срокам и стоимости под ваш запрос. Всегда стараемся найти наиболее выгодный вариант для клиента.","payment":{"whyPrepay":"Почему мы работаем по предоплате? Чтобы исключить риски возврата груза и простоев товара вне оборота на 1.5–2 месяца.","whyPrepayExtra":"Иногда получатель может изменить решение или финансовые планы, пока груз в пути — это создаёт затраты на пересылку туда-обратно и блокирует товар.","trust":"Как быть уверенным, что это не обман? Мы — действующая компания и по запросу предоставляем учредительные и бухгалтерские документы.","trustExtra":"Перед оплатой заключаем договор поставки с прописанными гарантиями и обязательствами. Работаем с ООО, ИП и физическими лицами.","requisites":"Оплата на расчётный счёт ООО «ЮТОРС», ИНН 7447296417, КПП 745101001.","paymentMethods":["Банковский перевод на расчетный счет","Оплата картой через терминал","Наличные при самовывозе","Безналичный расчет для юридических лиц"]}},"footer":{"aboutSection":{"title":"О компании","description":"Мы специализируемся на поставке качественных запчастей для вездеходов всех типов и марок."},"contactsSection":{"title":"Контакты","phone":"+7 (800) 123-45-67","email":"info@vezdehod-zapchasti.ru","address":"40-летия Победы, 16а, Курчатовский район, Челябинск, 454100"},"informationSection":{"title":"Информация","links":[{"text":"Доставка и оплата","url":"/about#delivery"},{"text":"Гарантия","url":"/about"},{"text":"Возврат товара","url":"/about"},{"text":"Политика конфиденциальности","url":"/about"}]},"socialSection":{"title":"Мы в социальных сетях","links":[{"platform":"vk","url":"https://vk.com/yutors","icon":"FaVk"},{"platform":"instagram","url":"https://instagram.com/yutors","icon":"FaInstagram"},{"platform":"youtube","url":"https://youtube.com/@yutors","icon":"FaYoutube"}]},"copyright":"© 2025 ЮТОРС. Все права защищены."}}	2025-09-11 21:08:05+02	2025-09-12 06:19:06+02
\.


--
-- TOC entry 5078 (class 0 OID 16781)
-- Dependencies: 223
-- Data for Name: subcategories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subcategories (id, category_id, name) FROM stdin;
49	13	Блоки управления
50	19	Крепежные элементы
51	13	Генераторы
66	16	Приводные ремни и цепи
69	3	Гусеницы и траки
70	3	Колеса и диски
71	3	Подвеска и амортизаторы
99	20	Блоки и головки цилиндров
100	21	Воздушные фильтры
101	21	Топливные фильтры
102	21	Масляные фильтры
103	21	Масла и жидкости
104	21	Антифризы
105	21	Свечи и запалы
106	20	Система охлаждения
107	20	Топливная система
108	20	Двигатели
109	16	Коробки передач
110	16	Сцепление
111	22	Основные узлы
112	22	Фильтры
113	22	Масла и жидкости
114	22	Система охлаждения
115	23	Коробка передач
116	23	Приводы
117	23	Сцепление
118	23	Дифференциал
119	3	Гусеницы
120	3	Подвеска
121	3	Колеса
122	3	Тормозная система
123	24	Освещение
124	24	Проводка
125	24	Аккумуляторы
126	24	Стартеры и генераторы
127	25	Сиденья
128	25	Приборы
129	25	Отопление
130	25	Стекла
131	26	Основные узлы
132	26	Фильтры
133	26	Масла и жидкости
134	26	Система охлаждения
135	27	Коробка передач
136	27	Приводы
137	27	Сцепление
138	27	Дифференциал
139	28	Освещение
140	28	Проводка
141	28	Аккумуляторы
142	28	Стартеры и генераторы
143	29	Сиденья
144	29	Приборы
145	29	Отопление
146	29	Стекла
\.


--
-- TOC entry 5099 (class 0 OID 16946)
-- Dependencies: 244
-- Data for Name: terrain_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.terrain_types (id, name, created_at) FROM stdin;
1	Снег	2025-08-30 09:16:54+02
2	Болото	2025-08-30 09:16:54+02
3	Вода	2025-08-30 09:16:54+02
4	Горы	2025-08-30 09:16:54+02
5	Лес	2025-08-30 09:16:54+02
6	Пустыня	2025-08-30 09:16:54+02
7	Лучший	2025-08-30 09:20:23+02
\.


--
-- TOC entry 5113 (class 0 OID 17047)
-- Dependencies: 258
-- Data for Name: vehicle_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vehicle_images (id, vehicle_id, image_data, is_main) FROM stdin;
\.


--
-- TOC entry 5101 (class 0 OID 16956)
-- Dependencies: 246
-- Data for Name: vehicle_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vehicle_types (id, name, created_at) FROM stdin;
1	Гусеничный	2025-08-30 09:16:54+02
2	Колесный	2025-08-30 09:16:54+02
3	Плавающий	2025-08-30 09:16:54+02
4	Лучший	2025-08-30 09:20:09+02
\.


--
-- TOC entry 5103 (class 0 OID 16966)
-- Dependencies: 248
-- Data for Name: vehicles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vehicles (id, name, type, terrain, price, image, description, specs_json, available, quantity, created_at, updated_at) FROM stdin;
8	Пустынный	Колесный	Пустыня	2800000	\N	Вездеход для пустынных и засушливых регионов	{"engine":"Дизельный 160 л.с.","weight":"2.8 тонны","capacity":"6 человек","maxSpeed":"55 км/ч"}	t	1	2025-09-12 06:07:17+02	2025-09-12 06:24:32+02
9	Горный	Колесный	Горы	2200000	\N	Вездеход для горной местности и пересеченной местности	{"engine":"Дизельный 130 л.с.","weight":"2.0 тонны","capacity":"5 человек","maxSpeed":"40 км/ч"}	t	1	2025-09-12 06:07:17+02	2025-09-12 06:24:28+02
13	Mishanya	Лучший	Лучший	5000000	/img/vehicles/1757658286691-822575460.jpg	поваолрпмлгена	{"engine":"Бензин 120 л.с.","weight":"5 тонн","capacity":"6 человек","maxSpeed":"45 км/ч"}	t	1	2025-09-12 06:24:54+02	2025-09-12 06:24:54+02
\.


--
-- TOC entry 5149 (class 0 OID 0)
-- Dependencies: 218
-- Name: admins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admins_id_seq', 1, false);


--
-- TOC entry 5150 (class 0 OID 0)
-- Dependencies: 241
-- Name: advertising_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.advertising_events_id_seq', 1, false);


--
-- TOC entry 5151 (class 0 OID 0)
-- Dependencies: 239
-- Name: advertising_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.advertising_settings_id_seq', 1, false);


--
-- TOC entry 5152 (class 0 OID 0)
-- Dependencies: 259
-- Name: bot_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bot_settings_id_seq', 1, false);


--
-- TOC entry 5153 (class 0 OID 0)
-- Dependencies: 224
-- Name: brands_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.brands_id_seq', 1, false);


--
-- TOC entry 5154 (class 0 OID 0)
-- Dependencies: 220
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, false);


--
-- TOC entry 5155 (class 0 OID 0)
-- Dependencies: 232
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_id_seq', 1, false);


--
-- TOC entry 5156 (class 0 OID 0)
-- Dependencies: 261
-- Name: email_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.email_settings_id_seq', 1, false);


--
-- TOC entry 5157 (class 0 OID 0)
-- Dependencies: 253
-- Name: filter_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.filter_settings_id_seq', 1, false);


--
-- TOC entry 5158 (class 0 OID 0)
-- Dependencies: 235
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 1, false);


--
-- TOC entry 5159 (class 0 OID 0)
-- Dependencies: 237
-- Name: order_notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_notes_id_seq', 1, false);


--
-- TOC entry 5160 (class 0 OID 0)
-- Dependencies: 251
-- Name: popular_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.popular_products_id_seq', 1, false);


--
-- TOC entry 5161 (class 0 OID 0)
-- Dependencies: 228
-- Name: product_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_images_id_seq', 1, false);


--
-- TOC entry 5162 (class 0 OID 0)
-- Dependencies: 226
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 1, false);


--
-- TOC entry 5163 (class 0 OID 0)
-- Dependencies: 255
-- Name: promocodes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.promocodes_id_seq', 1, false);


--
-- TOC entry 5164 (class 0 OID 0)
-- Dependencies: 230
-- Name: promotions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.promotions_id_seq', 1, false);


--
-- TOC entry 5165 (class 0 OID 0)
-- Dependencies: 249
-- Name: site_content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.site_content_id_seq', 1, false);


--
-- TOC entry 5166 (class 0 OID 0)
-- Dependencies: 222
-- Name: subcategories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subcategories_id_seq', 1, false);


--
-- TOC entry 5167 (class 0 OID 0)
-- Dependencies: 243
-- Name: terrain_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.terrain_types_id_seq', 1, false);


--
-- TOC entry 5168 (class 0 OID 0)
-- Dependencies: 257
-- Name: vehicle_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vehicle_images_id_seq', 1, false);


--
-- TOC entry 5169 (class 0 OID 0)
-- Dependencies: 245
-- Name: vehicle_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vehicle_types_id_seq', 1, false);


--
-- TOC entry 5170 (class 0 OID 0)
-- Dependencies: 247
-- Name: vehicles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vehicles_id_seq', 1, false);


--
-- TOC entry 4825 (class 2606 OID 16768)
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- TOC entry 4827 (class 2606 OID 16770)
-- Name: admins admins_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_username_key UNIQUE (username);


--
-- TOC entry 4866 (class 2606 OID 16944)
-- Name: advertising_events advertising_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.advertising_events
    ADD CONSTRAINT advertising_events_pkey PRIMARY KEY (id);


--
-- TOC entry 4861 (class 2606 OID 16932)
-- Name: advertising_settings advertising_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.advertising_settings
    ADD CONSTRAINT advertising_settings_pkey PRIMARY KEY (id);


--
-- TOC entry 4863 (class 2606 OID 16934)
-- Name: advertising_settings advertising_settings_platform_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.advertising_settings
    ADD CONSTRAINT advertising_settings_platform_key UNIQUE (platform);


--
-- TOC entry 4907 (class 2606 OID 17071)
-- Name: bot_settings bot_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bot_settings
    ADD CONSTRAINT bot_settings_pkey PRIMARY KEY (id);


--
-- TOC entry 4909 (class 2606 OID 17073)
-- Name: bot_settings bot_settings_setting_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bot_settings
    ADD CONSTRAINT bot_settings_setting_key_key UNIQUE (setting_key);


--
-- TOC entry 4837 (class 2606 OID 16802)
-- Name: brands brands_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_name_key UNIQUE (name);


--
-- TOC entry 4839 (class 2606 OID 16800)
-- Name: brands brands_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (id);


--
-- TOC entry 4829 (class 2606 OID 16779)
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- TOC entry 4831 (class 2606 OID 16777)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4850 (class 2606 OID 16870)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- TOC entry 4911 (class 2606 OID 17084)
-- Name: email_settings email_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_settings
    ADD CONSTRAINT email_settings_pkey PRIMARY KEY (id);


--
-- TOC entry 4913 (class 2606 OID 17086)
-- Name: email_settings email_settings_setting_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_settings
    ADD CONSTRAINT email_settings_setting_key_key UNIQUE (setting_key);


--
-- TOC entry 4894 (class 2606 OID 17026)
-- Name: filter_settings filter_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filter_settings
    ADD CONSTRAINT filter_settings_pkey PRIMARY KEY (id);


--
-- TOC entry 4896 (class 2606 OID 17028)
-- Name: filter_settings filter_settings_setting_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filter_settings
    ADD CONSTRAINT filter_settings_setting_key_key UNIQUE (setting_key);


--
-- TOC entry 4857 (class 2606 OID 16894)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4859 (class 2606 OID 16914)
-- Name: order_notes order_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_notes
    ADD CONSTRAINT order_notes_pkey PRIMARY KEY (id);


--
-- TOC entry 4855 (class 2606 OID 16880)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 4890 (class 2606 OID 17009)
-- Name: popular_products popular_products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.popular_products
    ADD CONSTRAINT popular_products_pkey PRIMARY KEY (id);


--
-- TOC entry 4892 (class 2606 OID 17011)
-- Name: popular_products popular_products_product_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.popular_products
    ADD CONSTRAINT popular_products_product_id_key UNIQUE (product_id);


--
-- TOC entry 4846 (class 2606 OID 16840)
-- Name: product_images product_images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_images
    ADD CONSTRAINT product_images_pkey PRIMARY KEY (id);


--
-- TOC entry 4844 (class 2606 OID 16815)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 4901 (class 2606 OID 17045)
-- Name: promocodes promocodes_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promocodes
    ADD CONSTRAINT promocodes_code_key UNIQUE (code);


--
-- TOC entry 4903 (class 2606 OID 17043)
-- Name: promocodes promocodes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promocodes
    ADD CONSTRAINT promocodes_pkey PRIMARY KEY (id);


--
-- TOC entry 4848 (class 2606 OID 16856)
-- Name: promotions promotions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotions
    ADD CONSTRAINT promotions_pkey PRIMARY KEY (id);


--
-- TOC entry 4885 (class 2606 OID 17000)
-- Name: site_content site_content_content_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_content
    ADD CONSTRAINT site_content_content_key_key UNIQUE (content_key);


--
-- TOC entry 4887 (class 2606 OID 16998)
-- Name: site_content site_content_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_content
    ADD CONSTRAINT site_content_pkey PRIMARY KEY (id);


--
-- TOC entry 4833 (class 2606 OID 16788)
-- Name: subcategories subcategories_category_id_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcategories
    ADD CONSTRAINT subcategories_category_id_name_key UNIQUE (category_id, name);


--
-- TOC entry 4835 (class 2606 OID 16786)
-- Name: subcategories subcategories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcategories
    ADD CONSTRAINT subcategories_pkey PRIMARY KEY (id);


--
-- TOC entry 4871 (class 2606 OID 16954)
-- Name: terrain_types terrain_types_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.terrain_types
    ADD CONSTRAINT terrain_types_name_key UNIQUE (name);


--
-- TOC entry 4873 (class 2606 OID 16952)
-- Name: terrain_types terrain_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.terrain_types
    ADD CONSTRAINT terrain_types_pkey PRIMARY KEY (id);


--
-- TOC entry 4905 (class 2606 OID 17055)
-- Name: vehicle_images vehicle_images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_images
    ADD CONSTRAINT vehicle_images_pkey PRIMARY KEY (id);


--
-- TOC entry 4875 (class 2606 OID 16964)
-- Name: vehicle_types vehicle_types_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_types
    ADD CONSTRAINT vehicle_types_name_key UNIQUE (name);


--
-- TOC entry 4877 (class 2606 OID 16962)
-- Name: vehicle_types vehicle_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_types
    ADD CONSTRAINT vehicle_types_pkey PRIMARY KEY (id);


--
-- TOC entry 4882 (class 2606 OID 16977)
-- Name: vehicles vehicles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicles
    ADD CONSTRAINT vehicles_pkey PRIMARY KEY (id);


--
-- TOC entry 4867 (class 1259 OID 17090)
-- Name: idx_advertising_events_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_advertising_events_created ON public.advertising_events USING btree (created_at);


--
-- TOC entry 4868 (class 1259 OID 17088)
-- Name: idx_advertising_events_platform; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_advertising_events_platform ON public.advertising_events USING btree (platform);


--
-- TOC entry 4869 (class 1259 OID 17089)
-- Name: idx_advertising_events_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_advertising_events_type ON public.advertising_events USING btree (event_type);


--
-- TOC entry 4864 (class 1259 OID 17087)
-- Name: idx_advertising_platform; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_advertising_platform ON public.advertising_settings USING btree (platform);


--
-- TOC entry 4897 (class 1259 OID 17096)
-- Name: idx_filter_settings_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_filter_settings_key ON public.filter_settings USING btree (setting_key);


--
-- TOC entry 4851 (class 1259 OID 17104)
-- Name: idx_orders_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_created ON public.orders USING btree (created_at);


--
-- TOC entry 4852 (class 1259 OID 17102)
-- Name: idx_orders_customer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_customer ON public.orders USING btree (customer_id);


--
-- TOC entry 4853 (class 1259 OID 17103)
-- Name: idx_orders_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_status ON public.orders USING btree (status);


--
-- TOC entry 4888 (class 1259 OID 17095)
-- Name: idx_popular_products_sort_order; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_popular_products_sort_order ON public.popular_products USING btree (sort_order);


--
-- TOC entry 4840 (class 1259 OID 17101)
-- Name: idx_products_available; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_products_available ON public.products USING btree (available);


--
-- TOC entry 4841 (class 1259 OID 17100)
-- Name: idx_products_brand; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_products_brand ON public.products USING btree (brand_id);


--
-- TOC entry 4842 (class 1259 OID 17099)
-- Name: idx_products_category; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_products_category ON public.products USING btree (category_id);


--
-- TOC entry 4898 (class 1259 OID 17098)
-- Name: idx_promocodes_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_promocodes_active ON public.promocodes USING btree (active);


--
-- TOC entry 4899 (class 1259 OID 17097)
-- Name: idx_promocodes_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_promocodes_code ON public.promocodes USING btree (code);


--
-- TOC entry 4883 (class 1259 OID 17094)
-- Name: idx_site_content_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_site_content_key ON public.site_content USING btree (content_key);


--
-- TOC entry 4878 (class 1259 OID 17093)
-- Name: idx_vehicles_available; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_vehicles_available ON public.vehicles USING btree (available);


--
-- TOC entry 4879 (class 1259 OID 17092)
-- Name: idx_vehicles_terrain; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_vehicles_terrain ON public.vehicles USING btree (terrain);


--
-- TOC entry 4880 (class 1259 OID 17091)
-- Name: idx_vehicles_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_vehicles_type ON public.vehicles USING btree (type);


--
-- TOC entry 4921 (class 2606 OID 16895)
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- TOC entry 4922 (class 2606 OID 16900)
-- Name: order_items order_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE SET NULL;


--
-- TOC entry 4923 (class 2606 OID 16915)
-- Name: order_notes order_notes_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_notes
    ADD CONSTRAINT order_notes_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- TOC entry 4920 (class 2606 OID 16881)
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE SET NULL;


--
-- TOC entry 4926 (class 2606 OID 17012)
-- Name: popular_products popular_products_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.popular_products
    ADD CONSTRAINT popular_products_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- TOC entry 4918 (class 2606 OID 16841)
-- Name: product_images product_images_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_images
    ADD CONSTRAINT product_images_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- TOC entry 4915 (class 2606 OID 16826)
-- Name: products products_brand_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_brand_id_fkey FOREIGN KEY (brand_id) REFERENCES public.brands(id) ON DELETE SET NULL;


--
-- TOC entry 4916 (class 2606 OID 16816)
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE SET NULL;


--
-- TOC entry 4917 (class 2606 OID 16821)
-- Name: products products_subcategory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_subcategory_id_fkey FOREIGN KEY (subcategory_id) REFERENCES public.subcategories(id) ON DELETE SET NULL;


--
-- TOC entry 4919 (class 2606 OID 16857)
-- Name: promotions promotions_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotions
    ADD CONSTRAINT promotions_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE SET NULL;


--
-- TOC entry 4914 (class 2606 OID 16789)
-- Name: subcategories subcategories_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcategories
    ADD CONSTRAINT subcategories_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- TOC entry 4927 (class 2606 OID 17056)
-- Name: vehicle_images vehicle_images_vehicle_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_images
    ADD CONSTRAINT vehicle_images_vehicle_id_fkey FOREIGN KEY (vehicle_id) REFERENCES public.vehicles(id) ON DELETE CASCADE;


--
-- TOC entry 4924 (class 2606 OID 16983)
-- Name: vehicles vehicles_terrain_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicles
    ADD CONSTRAINT vehicles_terrain_fkey FOREIGN KEY (terrain) REFERENCES public.terrain_types(name) ON DELETE SET NULL;


--
-- TOC entry 4925 (class 2606 OID 16978)
-- Name: vehicles vehicles_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicles
    ADD CONSTRAINT vehicles_type_fkey FOREIGN KEY (type) REFERENCES public.vehicle_types(name) ON DELETE SET NULL;


--
-- TOC entry 5125 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2025-09-14 03:47:06

--
-- PostgreSQL database dump complete
--

\unrestrict btHtLfaKMNqNjehGM7b0O85jb8RInYbSu3d4pZZBYP24wYA0e3KLxNl56Nwbe9i

-- Completed on 2025-09-14 03:47:06

--
-- PostgreSQL database cluster dump complete
--

