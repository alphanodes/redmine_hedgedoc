--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.10
-- Dumped by pg_dump version 9.6.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: enum_Notes_permission; Type: TYPE; Schema: public; Owner: hedgedoc
--

CREATE TYPE public."enum_Notes_permission" AS ENUM (
    'freely',
    'editable',
    'limited',
    'locked',
    'protected',
    'private'
);


ALTER TYPE public."enum_Notes_permission" OWNER TO hedgedoc;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Authors; Type: TABLE; Schema: public; Owner: hedgedoc
--

CREATE TABLE public."Authors" (
    id integer NOT NULL,
    color character varying(255),
    "noteId" uuid,
    "userId" uuid,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone
);


ALTER TABLE public."Authors" OWNER TO hedgedoc;

--
-- Name: Authors_id_seq; Type: SEQUENCE; Schema: public; Owner: hedgedoc
--

CREATE SEQUENCE public."Authors_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Authors_id_seq" OWNER TO hedgedoc;

--
-- Name: Authors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hedgedoc
--

ALTER SEQUENCE public."Authors_id_seq" OWNED BY public."Authors".id;


--
-- Name: Notes; Type: TABLE; Schema: public; Owner: hedgedoc
--

CREATE TABLE public."Notes" (
    id uuid NOT NULL,
    "ownerId" uuid,
    content text,
    title text,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    shortid character varying(255) DEFAULT '0000000000'::character varying NOT NULL,
    permission public."enum_Notes_permission",
    viewcount integer DEFAULT 0,
    "lastchangeuserId" uuid,
    "lastchangeAt" timestamp with time zone,
    alias character varying(255),
    "savedAt" timestamp with time zone,
    authorship text,
    "deletedAt" timestamp with time zone
);


ALTER TABLE public."Notes" OWNER TO hedgedoc;

--
-- Name: Revisions; Type: TABLE; Schema: public; Owner: hedgedoc
--

CREATE TABLE public."Revisions" (
    id uuid NOT NULL,
    "noteId" uuid,
    patch text,
    "lastContent" text,
    content text,
    length integer,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    authorship text
);


ALTER TABLE public."Revisions" OWNER TO hedgedoc;

--
-- Name: SequelizeMeta; Type: TABLE; Schema: public; Owner: hedgedoc
--

CREATE TABLE public."SequelizeMeta" (
    name character varying(255) NOT NULL
);


ALTER TABLE public."SequelizeMeta" OWNER TO hedgedoc;

--
-- Name: Sessions; Type: TABLE; Schema: public; Owner: hedgedoc
--

CREATE TABLE public."Sessions" (
    sid character varying(32) NOT NULL,
    expires timestamp with time zone,
    data text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."Sessions" OWNER TO hedgedoc;

--
-- Name: Temp; Type: TABLE; Schema: public; Owner: hedgedoc
--

CREATE TABLE public."Temp" (
    id character varying(255) NOT NULL,
    date text,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone
);


ALTER TABLE public."Temp" OWNER TO hedgedoc;

--
-- Name: Temps; Type: TABLE; Schema: public; Owner: hedgedoc
--

CREATE TABLE public."Temps" (
    id character varying(255) NOT NULL,
    data text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."Temps" OWNER TO hedgedoc;

--
-- Name: Users; Type: TABLE; Schema: public; Owner: hedgedoc
--

CREATE TABLE public."Users" (
    id uuid NOT NULL,
    profileid character varying(255),
    profile text,
    history text,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "accessToken" text,
    "refreshToken" text,
    email text,
    password text,
    "deleteToken" uuid
);


ALTER TABLE public."Users" OWNER TO hedgedoc;

--
-- Name: Authors id; Type: DEFAULT; Schema: public; Owner: hedgedoc
--

ALTER TABLE ONLY public."Authors" ALTER COLUMN id SET DEFAULT nextval('public."Authors_id_seq"'::regclass);


--
-- Name: Authors Authors_pkey; Type: CONSTRAINT; Schema: public; Owner: hedgedoc
--

ALTER TABLE ONLY public."Authors"
    ADD CONSTRAINT "Authors_pkey" PRIMARY KEY (id);


--
-- Name: Notes Notes_pkey; Type: CONSTRAINT; Schema: public; Owner: hedgedoc
--

ALTER TABLE ONLY public."Notes"
    ADD CONSTRAINT "Notes_pkey" PRIMARY KEY (id);


--
-- Name: Revisions Revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: hedgedoc
--

ALTER TABLE ONLY public."Revisions"
    ADD CONSTRAINT "Revisions_pkey" PRIMARY KEY (id);


--
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: hedgedoc
--

ALTER TABLE ONLY public."SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


--
-- Name: Sessions Sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: hedgedoc
--

ALTER TABLE ONLY public."Sessions"
    ADD CONSTRAINT "Sessions_pkey" PRIMARY KEY (sid);


--
-- Name: Temp Temp_pkey; Type: CONSTRAINT; Schema: public; Owner: hedgedoc
--

ALTER TABLE ONLY public."Temp"
    ADD CONSTRAINT "Temp_pkey" PRIMARY KEY (id);


--
-- Name: Temps Temps_pkey; Type: CONSTRAINT; Schema: public; Owner: hedgedoc
--

ALTER TABLE ONLY public."Temps"
    ADD CONSTRAINT "Temps_pkey" PRIMARY KEY (id);


--
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: public; Owner: hedgedoc
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);


--
-- Name: Users Users_profileid_key; Type: CONSTRAINT; Schema: public; Owner: hedgedoc
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_profileid_key" UNIQUE (profileid);


--
-- Name: authors_note_id_user_id; Type: INDEX; Schema: public; Owner: hedgedoc
--

CREATE UNIQUE INDEX authors_note_id_user_id ON public."Authors" USING btree ("noteId", "userId");


--
-- Name: notes_alias; Type: INDEX; Schema: public; Owner: hedgedoc
--

CREATE UNIQUE INDEX notes_alias ON public."Notes" USING btree (alias);


--
-- Name: notes_shortid; Type: INDEX; Schema: public; Owner: hedgedoc
--

CREATE UNIQUE INDEX notes_shortid ON public."Notes" USING btree (shortid);


--
-- PostgreSQL database dump complete
--

