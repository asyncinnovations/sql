PGDMP  !    ;        	        }            taskmaster_db    17.2    17.1 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    16388    taskmaster_db    DATABASE     �   CREATE DATABASE taskmaster_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Pakistan.1252';
    DROP DATABASE taskmaster_db;
                     postgres    false            �           0    0    DATABASE taskmaster_db    ACL     _   GRANT ALL ON DATABASE taskmaster_db TO root;
GRANT ALL ON DATABASE taskmaster_db TO test_user;
                        postgres    false    5053                        3079    33087    pgcrypto 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
    DROP EXTENSION pgcrypto;
                        false            �           0    0    EXTENSION pgcrypto    COMMENT     <   COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
                             false    2            �           1247    32881    task_status    TYPE     k   CREATE TYPE public.task_status AS ENUM (
    'open',
    'in_progress',
    'completed',
    'canceled'
);
    DROP TYPE public.task_status;
       public               root    false            �            1259    16703    batches    TABLE     �  CREATE TABLE public.batches (
    batch_id integer NOT NULL,
    user_id integer,
    batch_name character varying(100),
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    total_earnings numeric(10,2) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.batches;
       public         heap r       root    false            �           0    0    TABLE batches    ACL     s   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.batches TO admin;
GRANT SELECT ON TABLE public.batches TO users;
          public               root    false    235            �            1259    16702    batches_batch_id_seq    SEQUENCE     �   CREATE SEQUENCE public.batches_batch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.batches_batch_id_seq;
       public               root    false    235            �           0    0    batches_batch_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.batches_batch_id_seq OWNED BY public.batches.batch_id;
          public               root    false    234            �            1259    16469    bids    TABLE     �  CREATE TABLE public.bids (
    bid_id integer NOT NULL,
    task_id integer,
    tasker_id integer,
    bid_amount numeric(10,2) NOT NULL,
    bid_message text,
    status character varying(20) DEFAULT 'pending'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT bids_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'accepted'::character varying, 'rejected'::character varying])::text[])))
);
    DROP TABLE public.bids;
       public         heap r       root    false            �           0    0 
   TABLE bids    ACL     m   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bids TO admin;
GRANT SELECT ON TABLE public.bids TO users;
          public               root    false    223            �            1259    16468    bids_bid_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bids_bid_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.bids_bid_id_seq;
       public               root    false    223            �           0    0    bids_bid_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.bids_bid_id_seq OWNED BY public.bids.bid_id;
          public               root    false    222            �            1259    32831    blogs    TABLE     <  CREATE TABLE public.blogs (
    blog_id uuid DEFAULT gen_random_uuid() NOT NULL,
    title character varying(255) NOT NULL,
    content text NOT NULL,
    author_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.blogs;
       public         heap r       root    false            �           0    0    TABLE blogs    ACL     o   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.blogs TO admin;
GRANT SELECT ON TABLE public.blogs TO users;
          public               root    false    244            �            1259    16542 
   categories    TABLE     �   CREATE TABLE public.categories (
    category_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    task_count integer DEFAULT 0
);
    DROP TABLE public.categories;
       public         heap r       root    false            �           0    0    TABLE categories    ACL     y   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.categories TO admin;
GRANT SELECT ON TABLE public.categories TO users;
          public               root    false    229            �            1259    16541    categories_category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.categories_category_id_seq;
       public               root    false    229            �           0    0    categories_category_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;
          public               root    false    228            �            1259    32860    comments    TABLE     �   CREATE TABLE public.comments (
    comment_id uuid DEFAULT gen_random_uuid() NOT NULL,
    blog_id uuid,
    user_id integer,
    comment_text text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.comments;
       public         heap r       root    false            �           0    0    TABLE comments    ACL     u   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.comments TO admin;
GRANT SELECT ON TABLE public.comments TO users;
          public               root    false    245            �            1259    16717    faqs    TABLE     �   CREATE TABLE public.faqs (
    faq_id integer NOT NULL,
    question text NOT NULL,
    answer text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.faqs;
       public         heap r       root    false            �           0    0 
   TABLE faqs    ACL     m   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.faqs TO admin;
GRANT SELECT ON TABLE public.faqs TO users;
          public               root    false    237            �            1259    16716    faqs_faq_id_seq    SEQUENCE     �   CREATE SEQUENCE public.faqs_faq_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.faqs_faq_id_seq;
       public               root    false    237            �           0    0    faqs_faq_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.faqs_faq_id_seq OWNED BY public.faqs.faq_id;
          public               root    false    236            �            1259    24648    favorite_tasks    TABLE     �   CREATE TABLE public.favorite_tasks (
    favorite_id integer NOT NULL,
    user_id integer,
    task_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 "   DROP TABLE public.favorite_tasks;
       public         heap r       root    false            �           0    0    TABLE favorite_tasks    ACL     �   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.favorite_tasks TO admin;
GRANT SELECT ON TABLE public.favorite_tasks TO users;
          public               root    false    243            �            1259    24647    favorite_tasks_favorite_id_seq    SEQUENCE     �   CREATE SEQUENCE public.favorite_tasks_favorite_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.favorite_tasks_favorite_id_seq;
       public               root    false    243            �           0    0    favorite_tasks_favorite_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.favorite_tasks_favorite_id_seq OWNED BY public.favorite_tasks.favorite_id;
          public               root    false    242            �            1259    16743    featured_tasks    TABLE     �   CREATE TABLE public.featured_tasks (
    task_id integer NOT NULL,
    feature_start_date timestamp without time zone,
    feature_end_date timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 "   DROP TABLE public.featured_tasks;
       public         heap r       root    false            �           0    0    TABLE featured_tasks    ACL     �   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.featured_tasks TO admin;
GRANT SELECT ON TABLE public.featured_tasks TO users;
          public               root    false    238            �            1259    16754    my_tasks    TABLE     i  CREATE TABLE public.my_tasks (
    user_id integer NOT NULL,
    task_id integer NOT NULL,
    role character varying(20),
    status character varying(20) DEFAULT 'open'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT my_tasks_role_check CHECK (((role)::text = ANY ((ARRAY['customer'::character varying, 'tasker'::character varying])::text[]))),
    CONSTRAINT my_tasks_status_check CHECK (((status)::text = ANY ((ARRAY['open'::character varying, 'in_progress'::character varying, 'completed'::character varying, 'canceled'::character varying])::text[])))
);
    DROP TABLE public.my_tasks;
       public         heap r       root    false            �           0    0    TABLE my_tasks    ACL     u   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.my_tasks TO admin;
GRANT SELECT ON TABLE public.my_tasks TO users;
          public               root    false    239            �            1259    16566    notifications    TABLE     �   CREATE TABLE public.notifications (
    notification_id integer NOT NULL,
    user_id integer,
    message text NOT NULL,
    is_read boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 !   DROP TABLE public.notifications;
       public         heap r       root    false            �           0    0    TABLE notifications    ACL        GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.notifications TO admin;
GRANT SELECT ON TABLE public.notifications TO users;
          public               root    false    233            �            1259    16565 !   notifications_notification_id_seq    SEQUENCE     �   CREATE SEQUENCE public.notifications_notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.notifications_notification_id_seq;
       public               root    false    233            �           0    0 !   notifications_notification_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.notifications_notification_id_seq OWNED BY public.notifications.notification_id;
          public               root    false    232            �            1259    16491    payments    TABLE       CREATE TABLE public.payments (
    payment_id integer NOT NULL,
    task_id integer,
    customer_id integer,
    tasker_id integer,
    amount numeric(10,2) NOT NULL,
    payment_status character varying(20) DEFAULT 'pending'::character varying,
    payment_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT payments_payment_status_check CHECK (((payment_status)::text = ANY ((ARRAY['pending'::character varying, 'completed'::character varying, 'failed'::character varying])::text[])))
);
    DROP TABLE public.payments;
       public         heap r       root    false            �           0    0    TABLE payments    ACL     u   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.payments TO admin;
GRANT SELECT ON TABLE public.payments TO users;
          public               root    false    225            �            1259    16490    payments_payment_id_seq    SEQUENCE     �   CREATE SEQUENCE public.payments_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.payments_payment_id_seq;
       public               root    false    225            �           0    0    payments_payment_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.payments_payment_id_seq OWNED BY public.payments.payment_id;
          public               root    false    224            �            1259    16516    reviews    TABLE     L  CREATE TABLE public.reviews (
    review_id integer NOT NULL,
    task_id integer,
    reviewer_id integer,
    reviewee_id integer,
    rating integer NOT NULL,
    comments text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);
    DROP TABLE public.reviews;
       public         heap r       root    false            �           0    0    TABLE reviews    ACL     s   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.reviews TO admin;
GRANT SELECT ON TABLE public.reviews TO users;
          public               root    false    227            �            1259    16515    reviews_review_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reviews_review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.reviews_review_id_seq;
       public               root    false    227            �           0    0    reviews_review_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.reviews_review_id_seq OWNED BY public.reviews.review_id;
          public               root    false    226            �            1259    24626    subcategories    TABLE     0  CREATE TABLE public.subcategories (
    subcategory_id integer NOT NULL,
    category_id integer,
    name character varying(100) NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 !   DROP TABLE public.subcategories;
       public         heap r       root    false            �           0    0    TABLE subcategories    ACL        GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.subcategories TO admin;
GRANT SELECT ON TABLE public.subcategories TO users;
          public               root    false    241            �            1259    24625     subcategories_subcategory_id_seq    SEQUENCE     �   CREATE SEQUENCE public.subcategories_subcategory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.subcategories_subcategory_id_seq;
       public               root    false    241            �           0    0     subcategories_subcategory_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.subcategories_subcategory_id_seq OWNED BY public.subcategories.subcategory_id;
          public               root    false    240            �            1259    16553 	   task_logs    TABLE     �   CREATE TABLE public.task_logs (
    log_id integer NOT NULL,
    task_id integer,
    old_status character varying(20),
    new_status character varying(20),
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.task_logs;
       public         heap r       root    false            �           0    0    TABLE task_logs    ACL     w   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.task_logs TO admin;
GRANT SELECT ON TABLE public.task_logs TO users;
          public               root    false    231            �            1259    16552    task_logs_log_id_seq    SEQUENCE     �   CREATE SEQUENCE public.task_logs_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.task_logs_log_id_seq;
       public               root    false    231            �           0    0    task_logs_log_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.task_logs_log_id_seq OWNED BY public.task_logs.log_id;
          public               root    false    230            �            1259    16434    tasks    TABLE     �  CREATE TABLE public.tasks (
    task_id integer NOT NULL,
    title character varying(100) NOT NULL,
    description text NOT NULL,
    category_id integer,
    location text,
    budget numeric(10,2) NOT NULL,
    status character varying(50) DEFAULT 'open'::character varying,
    due_date date,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    user_id uuid,
    sub_category character varying(255),
    image text,
    task_date timestamp without time zone,
    location_type character varying(50),
    CONSTRAINT check_budget_positive CHECK ((budget > (0)::numeric)),
    CONSTRAINT status_check CHECK (((status)::text = ANY ((ARRAY['open'::character varying, 'assigned'::character varying, 'pending'::character varying, 'completed'::character varying])::text[]))),
    CONSTRAINT tasks_location_type_check CHECK (((location_type)::text = ANY ((ARRAY['physical'::character varying, 'online'::character varying])::text[]))),
    CONSTRAINT tasks_status_check CHECK (((status)::text = ANY (ARRAY[('open'::character varying)::text, ('in_progress'::character varying)::text, ('completed'::character varying)::text, ('canceled'::character varying)::text])))
);
    DROP TABLE public.tasks;
       public         heap r       root    false            �           0    0    TABLE tasks    ACL     o   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tasks TO admin;
GRANT SELECT ON TABLE public.tasks TO users;
          public               root    false    221            �            1259    16433    tasks_task_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tasks_task_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.tasks_task_id_seq;
       public               root    false    221            �           0    0    tasks_task_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.tasks_task_id_seq OWNED BY public.tasks.task_id;
          public               root    false    220            �            1259    16390    users    TABLE     b  CREATE TABLE public.users (
    uuid uuid NOT NULL,
    user_id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    phone_number character varying(15),
    password_hash character varying(255) NOT NULL,
    user_role character varying(20) NOT NULL,
    profile_picture_url text,
    bio text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(100),
    batch character varying(100),
    basic_info jsonb,
    address text,
    education jsonb,
    experience jsonb,
    skills text[],
    languages text[],
    encrypted_email text,
    CONSTRAINT user_user_role_check CHECK (((user_role)::text = ANY ((ARRAY['customer'::character varying, 'tasker'::character varying])::text[])))
);
    DROP TABLE public.users;
       public         heap r       root    false            �           0    0    TABLE users    ACL     o   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.users TO admin;
GRANT SELECT ON TABLE public.users TO users;
          public               root    false    219            �            1259    16389    user_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.user_user_id_seq;
       public               root    false    219            �           0    0    user_user_id_seq    SEQUENCE OWNED BY     F   ALTER SEQUENCE public.user_user_id_seq OWNED BY public.users.user_id;
          public               root    false    218            �           2604    16706    batches batch_id    DEFAULT     t   ALTER TABLE ONLY public.batches ALTER COLUMN batch_id SET DEFAULT nextval('public.batches_batch_id_seq'::regclass);
 ?   ALTER TABLE public.batches ALTER COLUMN batch_id DROP DEFAULT;
       public               root    false    235    234    235            �           2604    16472    bids bid_id    DEFAULT     j   ALTER TABLE ONLY public.bids ALTER COLUMN bid_id SET DEFAULT nextval('public.bids_bid_id_seq'::regclass);
 :   ALTER TABLE public.bids ALTER COLUMN bid_id DROP DEFAULT;
       public               root    false    222    223    223            �           2604    16545    categories category_id    DEFAULT     �   ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);
 E   ALTER TABLE public.categories ALTER COLUMN category_id DROP DEFAULT;
       public               root    false    229    228    229            �           2604    16720    faqs faq_id    DEFAULT     j   ALTER TABLE ONLY public.faqs ALTER COLUMN faq_id SET DEFAULT nextval('public.faqs_faq_id_seq'::regclass);
 :   ALTER TABLE public.faqs ALTER COLUMN faq_id DROP DEFAULT;
       public               root    false    237    236    237            �           2604    24651    favorite_tasks favorite_id    DEFAULT     �   ALTER TABLE ONLY public.favorite_tasks ALTER COLUMN favorite_id SET DEFAULT nextval('public.favorite_tasks_favorite_id_seq'::regclass);
 I   ALTER TABLE public.favorite_tasks ALTER COLUMN favorite_id DROP DEFAULT;
       public               root    false    242    243    243            �           2604    16569    notifications notification_id    DEFAULT     �   ALTER TABLE ONLY public.notifications ALTER COLUMN notification_id SET DEFAULT nextval('public.notifications_notification_id_seq'::regclass);
 L   ALTER TABLE public.notifications ALTER COLUMN notification_id DROP DEFAULT;
       public               root    false    233    232    233            �           2604    16494    payments payment_id    DEFAULT     z   ALTER TABLE ONLY public.payments ALTER COLUMN payment_id SET DEFAULT nextval('public.payments_payment_id_seq'::regclass);
 B   ALTER TABLE public.payments ALTER COLUMN payment_id DROP DEFAULT;
       public               root    false    225    224    225            �           2604    16519    reviews review_id    DEFAULT     v   ALTER TABLE ONLY public.reviews ALTER COLUMN review_id SET DEFAULT nextval('public.reviews_review_id_seq'::regclass);
 @   ALTER TABLE public.reviews ALTER COLUMN review_id DROP DEFAULT;
       public               root    false    226    227    227            �           2604    24629    subcategories subcategory_id    DEFAULT     �   ALTER TABLE ONLY public.subcategories ALTER COLUMN subcategory_id SET DEFAULT nextval('public.subcategories_subcategory_id_seq'::regclass);
 K   ALTER TABLE public.subcategories ALTER COLUMN subcategory_id DROP DEFAULT;
       public               root    false    241    240    241            �           2604    16556    task_logs log_id    DEFAULT     t   ALTER TABLE ONLY public.task_logs ALTER COLUMN log_id SET DEFAULT nextval('public.task_logs_log_id_seq'::regclass);
 ?   ALTER TABLE public.task_logs ALTER COLUMN log_id DROP DEFAULT;
       public               root    false    231    230    231            �           2604    16437    tasks task_id    DEFAULT     n   ALTER TABLE ONLY public.tasks ALTER COLUMN task_id SET DEFAULT nextval('public.tasks_task_id_seq'::regclass);
 <   ALTER TABLE public.tasks ALTER COLUMN task_id DROP DEFAULT;
       public               root    false    220    221    221            �           2604    16393    users user_id    DEFAULT     m   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.user_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public               root    false    219    218    219            �          0    16703    batches 
   TABLE DATA           ~   COPY public.batches (batch_id, user_id, batch_name, start_date, end_date, total_earnings, created_at, updated_at) FROM stdin;
    public               root    false    235   ��       �          0    16469    bids 
   TABLE DATA           g   COPY public.bids (bid_id, task_id, tasker_id, bid_amount, bid_message, status, created_at) FROM stdin;
    public               root    false    223   ��       �          0    32831    blogs 
   TABLE DATA           [   COPY public.blogs (blog_id, title, content, author_id, created_at, updated_at) FROM stdin;
    public               root    false    244   ��       �          0    16542 
   categories 
   TABLE DATA           P   COPY public.categories (category_id, name, description, task_count) FROM stdin;
    public               root    false    229   �       �          0    32860    comments 
   TABLE DATA           Z   COPY public.comments (comment_id, blog_id, user_id, comment_text, created_at) FROM stdin;
    public               root    false    245   8�       �          0    16717    faqs 
   TABLE DATA           P   COPY public.faqs (faq_id, question, answer, created_at, updated_at) FROM stdin;
    public               root    false    237   U�       �          0    24648    favorite_tasks 
   TABLE DATA           S   COPY public.favorite_tasks (favorite_id, user_id, task_id, created_at) FROM stdin;
    public               root    false    243   r�       �          0    16743    featured_tasks 
   TABLE DATA           c   COPY public.featured_tasks (task_id, feature_start_date, feature_end_date, created_at) FROM stdin;
    public               root    false    238   ��       �          0    16754    my_tasks 
   TABLE DATA           N   COPY public.my_tasks (user_id, task_id, role, status, created_at) FROM stdin;
    public               root    false    239   ��       �          0    16566    notifications 
   TABLE DATA           _   COPY public.notifications (notification_id, user_id, message, is_read, created_at) FROM stdin;
    public               root    false    233   ��       �          0    16491    payments 
   TABLE DATA           u   COPY public.payments (payment_id, task_id, customer_id, tasker_id, amount, payment_status, payment_date) FROM stdin;
    public               root    false    225   ��       �          0    16516    reviews 
   TABLE DATA           m   COPY public.reviews (review_id, task_id, reviewer_id, reviewee_id, rating, comments, created_at) FROM stdin;
    public               root    false    227   �       �          0    24626    subcategories 
   TABLE DATA           o   COPY public.subcategories (subcategory_id, category_id, name, description, created_at, updated_at) FROM stdin;
    public               root    false    241    �       �          0    16553 	   task_logs 
   TABLE DATA           X   COPY public.task_logs (log_id, task_id, old_status, new_status, updated_at) FROM stdin;
    public               root    false    231   =�       �          0    16434    tasks 
   TABLE DATA           �   COPY public.tasks (task_id, title, description, category_id, location, budget, status, due_date, created_at, updated_at, user_id, sub_category, image, task_date, location_type) FROM stdin;
    public               root    false    221   Z�       �          0    16390    users 
   TABLE DATA           �   COPY public.users (uuid, user_id, first_name, last_name, phone_number, password_hash, user_role, profile_picture_url, bio, created_at, updated_at, status, batch, basic_info, address, education, experience, skills, languages, encrypted_email) FROM stdin;
    public               root    false    219   w�       �           0    0    batches_batch_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.batches_batch_id_seq', 1, false);
          public               root    false    234            �           0    0    bids_bid_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.bids_bid_id_seq', 1, false);
          public               root    false    222            �           0    0    categories_category_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.categories_category_id_seq', 1, false);
          public               root    false    228            �           0    0    faqs_faq_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.faqs_faq_id_seq', 1, false);
          public               root    false    236            �           0    0    favorite_tasks_favorite_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.favorite_tasks_favorite_id_seq', 1, false);
          public               root    false    242            �           0    0 !   notifications_notification_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.notifications_notification_id_seq', 1, false);
          public               root    false    232            �           0    0    payments_payment_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.payments_payment_id_seq', 1, false);
          public               root    false    224            �           0    0    reviews_review_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.reviews_review_id_seq', 1, false);
          public               root    false    226            �           0    0     subcategories_subcategory_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.subcategories_subcategory_id_seq', 1, false);
          public               root    false    240            �           0    0    task_logs_log_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.task_logs_log_id_seq', 1, false);
          public               root    false    230            �           0    0    tasks_task_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.tasks_task_id_seq', 1, false);
          public               root    false    220            �           0    0    user_user_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.user_user_id_seq', 1, false);
          public               root    false    218            �           2606    16710    batches batches_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.batches
    ADD CONSTRAINT batches_pkey PRIMARY KEY (batch_id);
 >   ALTER TABLE ONLY public.batches DROP CONSTRAINT batches_pkey;
       public                 root    false    235            �           2606    16479    bids bids_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_pkey PRIMARY KEY (bid_id);
 8   ALTER TABLE ONLY public.bids DROP CONSTRAINT bids_pkey;
       public                 root    false    223            �           2606    32840    blogs blogs_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.blogs
    ADD CONSTRAINT blogs_pkey PRIMARY KEY (blog_id);
 :   ALTER TABLE ONLY public.blogs DROP CONSTRAINT blogs_pkey;
       public                 root    false    244            �           2606    16551    categories categories_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);
 H   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_name_key;
       public                 root    false    229            �           2606    16549    categories categories_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public                 root    false    229            �           2606    32868    comments comments_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (comment_id);
 @   ALTER TABLE ONLY public.comments DROP CONSTRAINT comments_pkey;
       public                 root    false    245            �           2606    16726    faqs faqs_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.faqs
    ADD CONSTRAINT faqs_pkey PRIMARY KEY (faq_id);
 8   ALTER TABLE ONLY public.faqs DROP CONSTRAINT faqs_pkey;
       public                 root    false    237            �           2606    24654 "   favorite_tasks favorite_tasks_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.favorite_tasks
    ADD CONSTRAINT favorite_tasks_pkey PRIMARY KEY (favorite_id);
 L   ALTER TABLE ONLY public.favorite_tasks DROP CONSTRAINT favorite_tasks_pkey;
       public                 root    false    243            �           2606    24656 1   favorite_tasks favorite_tasks_user_id_task_id_key 
   CONSTRAINT     x   ALTER TABLE ONLY public.favorite_tasks
    ADD CONSTRAINT favorite_tasks_user_id_task_id_key UNIQUE (user_id, task_id);
 [   ALTER TABLE ONLY public.favorite_tasks DROP CONSTRAINT favorite_tasks_user_id_task_id_key;
       public                 root    false    243    243            �           2606    16748 "   featured_tasks featured_tasks_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.featured_tasks
    ADD CONSTRAINT featured_tasks_pkey PRIMARY KEY (task_id);
 L   ALTER TABLE ONLY public.featured_tasks DROP CONSTRAINT featured_tasks_pkey;
       public                 root    false    238            �           2606    16762    my_tasks my_tasks_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.my_tasks
    ADD CONSTRAINT my_tasks_pkey PRIMARY KEY (user_id, task_id);
 @   ALTER TABLE ONLY public.my_tasks DROP CONSTRAINT my_tasks_pkey;
       public                 root    false    239    239            �           2606    16575     notifications notifications_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notification_id);
 J   ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_pkey;
       public                 root    false    233            �           2606    16499    payments payments_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);
 @   ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_pkey;
       public                 root    false    225            �           2606    16525    reviews reviews_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (review_id);
 >   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_pkey;
       public                 root    false    227            �           2606    24635     subcategories subcategories_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.subcategories
    ADD CONSTRAINT subcategories_pkey PRIMARY KEY (subcategory_id);
 J   ALTER TABLE ONLY public.subcategories DROP CONSTRAINT subcategories_pkey;
       public                 root    false    241            �           2606    16559    task_logs task_logs_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.task_logs
    ADD CONSTRAINT task_logs_pkey PRIMARY KEY (log_id);
 B   ALTER TABLE ONLY public.task_logs DROP CONSTRAINT task_logs_pkey;
       public                 root    false    231            �           2606    16445    tasks tasks_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (task_id);
 :   ALTER TABLE ONLY public.tasks DROP CONSTRAINT tasks_pkey;
       public                 root    false    221            �           2606    16432    users user_id_unique 
   CONSTRAINT     R   ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_id_unique UNIQUE (user_id);
 >   ALTER TABLE ONLY public.users DROP CONSTRAINT user_id_unique;
       public                 root    false    219            �           2606    16404    users user_phone_number_key 
   CONSTRAINT     ^   ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_phone_number_key UNIQUE (phone_number);
 E   ALTER TABLE ONLY public.users DROP CONSTRAINT user_phone_number_key;
       public                 root    false    219            �           2606    33080    users user_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_pkey PRIMARY KEY (uuid);
 9   ALTER TABLE ONLY public.users DROP CONSTRAINT user_pkey;
       public                 root    false    219            �           1259    24642    idx_category_name    INDEX     H   CREATE INDEX idx_category_name ON public.categories USING btree (name);
 %   DROP INDEX public.idx_category_name;
       public                 root    false    229            �           1259    24668    idx_favorite_task    INDEX     O   CREATE INDEX idx_favorite_task ON public.favorite_tasks USING btree (task_id);
 %   DROP INDEX public.idx_favorite_task;
       public                 root    false    243            �           1259    24667    idx_favorite_user    INDEX     O   CREATE INDEX idx_favorite_user ON public.favorite_tasks USING btree (user_id);
 %   DROP INDEX public.idx_favorite_user;
       public                 root    false    243            �           1259    24644    idx_featured_task_id    INDEX     R   CREATE INDEX idx_featured_task_id ON public.featured_tasks USING btree (task_id);
 (   DROP INDEX public.idx_featured_task_id;
       public                 root    false    238            �           1259    24643    idx_subcategory_name    INDEX     N   CREATE INDEX idx_subcategory_name ON public.subcategories USING btree (name);
 (   DROP INDEX public.idx_subcategory_name;
       public                 root    false    241            �           1259    24646    idx_task_count    INDEX     P   CREATE INDEX idx_task_count ON public.categories USING btree (task_count DESC);
 "   DROP INDEX public.idx_task_count;
       public                 root    false    229            �           2606    16711    batches batches_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.batches
    ADD CONSTRAINT batches_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.batches DROP CONSTRAINT batches_user_id_fkey;
       public               root    false    235    4804    219            �           2606    16480    bids bids_task_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(task_id) ON DELETE CASCADE;
 @   ALTER TABLE ONLY public.bids DROP CONSTRAINT bids_task_id_fkey;
       public               root    false    223    4810    221            �           2606    16485    bids bids_tasker_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_tasker_id_fkey FOREIGN KEY (tasker_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.bids DROP CONSTRAINT bids_tasker_id_fkey;
       public               root    false    4804    219    223                       2606    32841    blogs blogs_author_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.blogs
    ADD CONSTRAINT blogs_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 D   ALTER TABLE ONLY public.blogs DROP CONSTRAINT blogs_author_id_fkey;
       public               root    false    244    4804    219                       2606    32869    comments comments_blog_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_blog_id_fkey FOREIGN KEY (blog_id) REFERENCES public.blogs(blog_id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.comments DROP CONSTRAINT comments_blog_id_fkey;
       public               root    false    245    244    4846                       2606    32874    comments comments_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.comments DROP CONSTRAINT comments_user_id_fkey;
       public               root    false    245    4804    219                       2606    24662 *   favorite_tasks favorite_tasks_task_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.favorite_tasks
    ADD CONSTRAINT favorite_tasks_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(task_id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.favorite_tasks DROP CONSTRAINT favorite_tasks_task_id_fkey;
       public               root    false    4810    221    243                       2606    24657 *   favorite_tasks favorite_tasks_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.favorite_tasks
    ADD CONSTRAINT favorite_tasks_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.favorite_tasks DROP CONSTRAINT favorite_tasks_user_id_fkey;
       public               root    false    243    4804    219            �           2606    16749 *   featured_tasks featured_tasks_task_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.featured_tasks
    ADD CONSTRAINT featured_tasks_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(task_id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.featured_tasks DROP CONSTRAINT featured_tasks_task_id_fkey;
       public               root    false    221    4810    238            �           2606    32889    batches fk_batches_user    FK CONSTRAINT     �   ALTER TABLE ONLY public.batches
    ADD CONSTRAINT fk_batches_user FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.batches DROP CONSTRAINT fk_batches_user;
       public               root    false    4804    219    235            �           2606    16768    my_tasks my_tasks_task_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.my_tasks
    ADD CONSTRAINT my_tasks_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(task_id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.my_tasks DROP CONSTRAINT my_tasks_task_id_fkey;
       public               root    false    4810    239    221                        2606    16763    my_tasks my_tasks_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.my_tasks
    ADD CONSTRAINT my_tasks_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.my_tasks DROP CONSTRAINT my_tasks_user_id_fkey;
       public               root    false    219    239    4804            �           2606    16576 (   notifications notifications_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_user_id_fkey;
       public               root    false    219    4804    233            �           2606    16505 "   payments payments_customer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_customer_id_fkey;
       public               root    false    4804    225    219            �           2606    16500    payments payments_task_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(task_id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_task_id_fkey;
       public               root    false    225    4810    221            �           2606    16510     payments payments_tasker_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_tasker_id_fkey FOREIGN KEY (tasker_id) REFERENCES public.users(user_id);
 J   ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_tasker_id_fkey;
       public               root    false    4804    219    225            �           2606    16536     reviews reviews_reviewee_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_reviewee_id_fkey FOREIGN KEY (reviewee_id) REFERENCES public.users(user_id);
 J   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_reviewee_id_fkey;
       public               root    false    4804    219    227            �           2606    16531     reviews reviews_reviewer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_reviewer_id_fkey FOREIGN KEY (reviewer_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_reviewer_id_fkey;
       public               root    false    219    227    4804            �           2606    16526    reviews reviews_task_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(task_id) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_task_id_fkey;
       public               root    false    4810    227    221                       2606    24636 ,   subcategories subcategories_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.subcategories
    ADD CONSTRAINT subcategories_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(category_id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.subcategories DROP CONSTRAINT subcategories_category_id_fkey;
       public               root    false    4820    241    229            �           2606    16560     task_logs task_logs_task_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.task_logs
    ADD CONSTRAINT task_logs_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(task_id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.task_logs DROP CONSTRAINT task_logs_task_id_fkey;
       public               root    false    4810    221    231            �           2606    16446    tasks tasks_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.tasks DROP CONSTRAINT tasks_category_id_fkey;
       public               root    false    219    4804    221            �           0    16434    tasks    ROW SECURITY     3   ALTER TABLE public.tasks ENABLE ROW LEVEL SECURITY;          public               root    false    221            �           3256    33081    tasks user_can_view_own_tasks    POLICY     }   CREATE POLICY user_can_view_own_tasks ON public.tasks USING ((user_id = (current_setting('app.current_user'::text))::uuid));
 5   DROP POLICY user_can_view_own_tasks ON public.tasks;
       public               root    false    221    221            �           3256    33086    users user_policy    POLICY     n   CREATE POLICY user_policy ON public.users USING ((uuid = (current_setting('app.current_user'::text))::uuid));
 )   DROP POLICY user_policy ON public.users;
       public               root    false    219    219            �           0    16390    users    ROW SECURITY     3   ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;          public               root    false    219            �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �     