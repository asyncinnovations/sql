PGDMP               	        }            taskmaster_db    17.2    17.2 �    A           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            B           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            C           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            D           1262    16388    taskmaster_db    DATABASE     �   CREATE DATABASE taskmaster_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Pakistan.1252';
    DROP DATABASE taskmaster_db;
                     postgres    false            E           0    0    DATABASE taskmaster_db    ACL     _   GRANT ALL ON DATABASE taskmaster_db TO root;
GRANT ALL ON DATABASE taskmaster_db TO test_user;
                        postgres    false    5188                        3079    33134    pg_stat_statements 	   EXTENSION     F   CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;
 #   DROP EXTENSION pg_stat_statements;
                        false            F           0    0    EXTENSION pg_stat_statements    COMMENT     u   COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';
                             false    3                        3079    33087    pgcrypto 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
    DROP EXTENSION pgcrypto;
                        false            G           0    0    EXTENSION pgcrypto    COMMENT     <   COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
                             false    2            �           1247    32881    task_status    TYPE     k   CREATE TYPE public.task_status AS ENUM (
    'open',
    'in_progress',
    'completed',
    'canceled'
);
    DROP TYPE public.task_status;
       public               root    false                       1259    33561 
   audit_logs    TABLE     �   CREATE TABLE public.audit_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id integer,
    action text NOT NULL,
    table_name text NOT NULL,
    record_id uuid,
    created_at timestamp without time zone DEFAULT now()
);
    DROP TABLE public.audit_logs;
       public         heap r       root    false            �            1259    16703    batches    TABLE     �  CREATE TABLE public.batches (
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
       public         heap r       root    false            H           0    0    TABLE batches    ACL     s   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.batches TO admin;
GRANT SELECT ON TABLE public.batches TO users;
          public               root    false    234            �            1259    16702    batches_batch_id_seq    SEQUENCE     �   CREATE SEQUENCE public.batches_batch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.batches_batch_id_seq;
       public               root    false    234            I           0    0    batches_batch_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.batches_batch_id_seq OWNED BY public.batches.batch_id;
          public               root    false    233            �            1259    33516    bid_history    TABLE     �  CREATE TABLE public.bid_history (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bid_id uuid,
    status character varying(20),
    changed_at timestamp without time zone DEFAULT now(),
    changed_by integer,
    CONSTRAINT bid_history_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'accepted'::character varying, 'rejected'::character varying])::text[])))
);
    DROP TABLE public.bid_history;
       public         heap r       root    false            �            1259    16469    bids    TABLE     �  CREATE TABLE public.bids (
    task_id integer,
    tasker_id integer,
    bid_amount numeric(10,2) NOT NULL,
    bid_message text,
    status character varying(20) DEFAULT 'pending'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    bid_id uuid DEFAULT gen_random_uuid() NOT NULL,
    CONSTRAINT bids_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'accepted'::character varying, 'rejected'::character varying])::text[])))
);
    DROP TABLE public.bids;
       public         heap r       root    false            J           0    0 
   TABLE bids    ACL     m   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bids TO admin;
GRANT SELECT ON TABLE public.bids TO users;
          public               root    false    223            �            1259    32831    blogs    TABLE     <  CREATE TABLE public.blogs (
    blog_id uuid DEFAULT gen_random_uuid() NOT NULL,
    title character varying(255) NOT NULL,
    content text NOT NULL,
    author_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.blogs;
       public         heap r       root    false            K           0    0    TABLE blogs    ACL     o   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.blogs TO admin;
GRANT SELECT ON TABLE public.blogs TO users;
          public               root    false    243            �            1259    16542 
   categories    TABLE     �   CREATE TABLE public.categories (
    category_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    task_count integer DEFAULT 0
);
    DROP TABLE public.categories;
       public         heap r       root    false            L           0    0    TABLE categories    ACL     y   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.categories TO admin;
GRANT SELECT ON TABLE public.categories TO users;
          public               root    false    228            �            1259    16541    categories_category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.categories_category_id_seq;
       public               root    false    228            M           0    0    categories_category_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;
          public               root    false    227            �            1259    32860    comments    TABLE     �   CREATE TABLE public.comments (
    comment_id uuid DEFAULT gen_random_uuid() NOT NULL,
    blog_id uuid,
    user_id integer,
    comment_text text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.comments;
       public         heap r       root    false            N           0    0    TABLE comments    ACL     u   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.comments TO admin;
GRANT SELECT ON TABLE public.comments TO users;
          public               root    false    244            �            1259    16717    faqs    TABLE     �   CREATE TABLE public.faqs (
    faq_id integer NOT NULL,
    question text NOT NULL,
    answer text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.faqs;
       public         heap r       root    false            O           0    0 
   TABLE faqs    ACL     m   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.faqs TO admin;
GRANT SELECT ON TABLE public.faqs TO users;
          public               root    false    236            �            1259    16716    faqs_faq_id_seq    SEQUENCE     �   CREATE SEQUENCE public.faqs_faq_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.faqs_faq_id_seq;
       public               root    false    236            P           0    0    faqs_faq_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.faqs_faq_id_seq OWNED BY public.faqs.faq_id;
          public               root    false    235            �            1259    24648    favorite_tasks    TABLE     �   CREATE TABLE public.favorite_tasks (
    favorite_id integer NOT NULL,
    user_id integer,
    task_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 "   DROP TABLE public.favorite_tasks;
       public         heap r       root    false            Q           0    0    TABLE favorite_tasks    ACL     �   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.favorite_tasks TO admin;
GRANT SELECT ON TABLE public.favorite_tasks TO users;
          public               root    false    242            �            1259    24647    favorite_tasks_favorite_id_seq    SEQUENCE     �   CREATE SEQUENCE public.favorite_tasks_favorite_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.favorite_tasks_favorite_id_seq;
       public               root    false    242            R           0    0    favorite_tasks_favorite_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.favorite_tasks_favorite_id_seq OWNED BY public.favorite_tasks.favorite_id;
          public               root    false    241            �            1259    16743    featured_tasks    TABLE     �   CREATE TABLE public.featured_tasks (
    task_id integer NOT NULL,
    feature_start_date timestamp without time zone,
    feature_end_date timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 "   DROP TABLE public.featured_tasks;
       public         heap r       root    false            S           0    0    TABLE featured_tasks    ACL     �   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.featured_tasks TO admin;
GRANT SELECT ON TABLE public.featured_tasks TO users;
          public               root    false    237            �            1259    16754    my_tasks    TABLE     i  CREATE TABLE public.my_tasks (
    user_id integer NOT NULL,
    task_id integer NOT NULL,
    role character varying(20),
    status character varying(20) DEFAULT 'open'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT my_tasks_role_check CHECK (((role)::text = ANY ((ARRAY['customer'::character varying, 'tasker'::character varying])::text[]))),
    CONSTRAINT my_tasks_status_check CHECK (((status)::text = ANY ((ARRAY['open'::character varying, 'in_progress'::character varying, 'completed'::character varying, 'canceled'::character varying])::text[])))
);
    DROP TABLE public.my_tasks;
       public         heap r       root    false            T           0    0    TABLE my_tasks    ACL     u   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.my_tasks TO admin;
GRANT SELECT ON TABLE public.my_tasks TO users;
          public               root    false    238            �            1259    16566    notifications    TABLE     �   CREATE TABLE public.notifications (
    notification_id integer NOT NULL,
    user_id integer,
    message text NOT NULL,
    is_read boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 !   DROP TABLE public.notifications;
       public         heap r       root    false            U           0    0    TABLE notifications    ACL        GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.notifications TO admin;
GRANT SELECT ON TABLE public.notifications TO users;
          public               root    false    232            �            1259    16565 !   notifications_notification_id_seq    SEQUENCE     �   CREATE SEQUENCE public.notifications_notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.notifications_notification_id_seq;
       public               root    false    232            V           0    0 !   notifications_notification_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.notifications_notification_id_seq OWNED BY public.notifications.notification_id;
          public               root    false    231            �            1259    33412    payment_logs    TABLE     t  CREATE TABLE public.payment_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    payment_id uuid,
    transaction_type character varying(20),
    gateway character varying(50),
    amount numeric(10,2) NOT NULL,
    status character varying(20),
    created_at timestamp without time zone DEFAULT now(),
    CONSTRAINT payment_logs_gateway_check CHECK (((gateway)::text = ANY ((ARRAY['Stripe'::character varying, 'PayPal'::character varying, 'BankTransfer'::character varying])::text[]))),
    CONSTRAINT payment_logs_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'successful'::character varying, 'failed'::character varying])::text[]))),
    CONSTRAINT payment_logs_transaction_type_check CHECK (((transaction_type)::text = ANY ((ARRAY['deposit'::character varying, 'withdrawal'::character varying, 'refund'::character varying])::text[])))
);
     DROP TABLE public.payment_logs;
       public         heap r       root    false            �            1259    16491    payments    TABLE       CREATE TABLE public.payments (
    task_id integer,
    customer_id integer,
    tasker_id integer,
    amount numeric(10,2) NOT NULL,
    payment_status character varying(20) DEFAULT 'pending'::character varying,
    payment_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    payment_id uuid DEFAULT gen_random_uuid() NOT NULL,
    CONSTRAINT payments_payment_status_check CHECK (((payment_status)::text = ANY ((ARRAY['pending'::character varying, 'completed'::character varying, 'failed'::character varying])::text[])))
);
    DROP TABLE public.payments;
       public         heap r       root    false            W           0    0    TABLE payments    ACL     u   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.payments TO admin;
GRANT SELECT ON TABLE public.payments TO users;
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
       public         heap r       root    false            X           0    0    TABLE reviews    ACL     s   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.reviews TO admin;
GRANT SELECT ON TABLE public.reviews TO users;
          public               root    false    226            �            1259    16515    reviews_review_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reviews_review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.reviews_review_id_seq;
       public               root    false    226            Y           0    0    reviews_review_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.reviews_review_id_seq OWNED BY public.reviews.review_id;
          public               root    false    225            �            1259    33535    roles    TABLE     e   CREATE TABLE public.roles (
    id integer NOT NULL,
    role_name character varying(50) NOT NULL
);
    DROP TABLE public.roles;
       public         heap r       root    false            �            1259    33534    roles_id_seq    SEQUENCE     �   CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.roles_id_seq;
       public               root    false    255            Z           0    0    roles_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;
          public               root    false    254            �            1259    24626    subcategories    TABLE     0  CREATE TABLE public.subcategories (
    subcategory_id integer NOT NULL,
    category_id integer,
    name character varying(100) NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 !   DROP TABLE public.subcategories;
       public         heap r       root    false            [           0    0    TABLE subcategories    ACL        GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.subcategories TO admin;
GRANT SELECT ON TABLE public.subcategories TO users;
          public               root    false    240            �            1259    24625     subcategories_subcategory_id_seq    SEQUENCE     �   CREATE SEQUENCE public.subcategories_subcategory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.subcategories_subcategory_id_seq;
       public               root    false    240            \           0    0     subcategories_subcategory_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.subcategories_subcategory_id_seq OWNED BY public.subcategories.subcategory_id;
          public               root    false    239            �            1259    33500    support_tickets    TABLE       CREATE TABLE public.support_tickets (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id integer,
    subject text NOT NULL,
    message text NOT NULL,
    status character varying(20),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    CONSTRAINT support_tickets_status_check CHECK (((status)::text = ANY ((ARRAY['open'::character varying, 'in_progress'::character varying, 'resolved'::character varying, 'closed'::character varying])::text[])))
);
 #   DROP TABLE public.support_tickets;
       public         heap r       root    false            �            1259    16553 	   task_logs    TABLE     �   CREATE TABLE public.task_logs (
    log_id integer NOT NULL,
    task_id integer,
    old_status character varying(20),
    new_status character varying(20),
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.task_logs;
       public         heap r       root    false            ]           0    0    TABLE task_logs    ACL     w   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.task_logs TO admin;
GRANT SELECT ON TABLE public.task_logs TO users;
          public               root    false    230            �            1259    16552    task_logs_log_id_seq    SEQUENCE     �   CREATE SEQUENCE public.task_logs_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.task_logs_log_id_seq;
       public               root    false    230            ^           0    0    task_logs_log_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.task_logs_log_id_seq OWNED BY public.task_logs.log_id;
          public               root    false    229            �            1259    33219    tasks    TABLE     �   CREATE TABLE public.tasks (
    id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL
)
PARTITION BY RANGE (created_at);
    DROP TABLE public.tasks;
       public         p       root    false            �            1259    33224 
   tasks_2024    TABLE     n   CREATE TABLE public.tasks_2024 (
    id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL
);
    DROP TABLE public.tasks_2024;
       public         heap r       root    false    247            �            1259    33229 
   tasks_2025    TABLE     n   CREATE TABLE public.tasks_2025 (
    id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL
);
    DROP TABLE public.tasks_2025;
       public         heap r       root    false    247            �            1259    16434 	   tasks_old    TABLE     �  CREATE TABLE public.tasks_old (
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
    DROP TABLE public.tasks_old;
       public         heap r       root    false            _           0    0    TABLE tasks_old    ACL     w   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tasks_old TO admin;
GRANT SELECT ON TABLE public.tasks_old TO users;
          public               root    false    222            �            1259    16433    tasks_task_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tasks_task_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.tasks_task_id_seq;
       public               root    false    222            `           0    0    tasks_task_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.tasks_task_id_seq OWNED BY public.tasks_old.task_id;
          public               root    false    221                       1259    33544 
   user_roles    TABLE     �   CREATE TABLE public.user_roles (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    assigned_at timestamp without time zone DEFAULT now()
);
    DROP TABLE public.user_roles;
       public         heap r       root    false                        1259    33543    user_roles_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.user_roles_id_seq;
       public               root    false    257            a           0    0    user_roles_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.user_roles_id_seq OWNED BY public.user_roles.id;
          public               root    false    256            �            1259    33484    user_sessions    TABLE     %  CREATE TABLE public.user_sessions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id integer,
    session_token text NOT NULL,
    ip_address inet,
    user_agent text,
    created_at timestamp without time zone DEFAULT now(),
    expires_at timestamp without time zone NOT NULL
);
 !   DROP TABLE public.user_sessions;
       public         heap r       root    false            �            1259    16390    users    TABLE     b  CREATE TABLE public.users (
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
       public         heap r       root    false            b           0    0    TABLE users    ACL     o   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.users TO admin;
GRANT SELECT ON TABLE public.users TO users;
          public               root    false    220            �            1259    16389    user_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.user_user_id_seq;
       public               root    false    220            c           0    0    user_user_id_seq    SEQUENCE OWNED BY     F   ALTER SEQUENCE public.user_user_id_seq OWNED BY public.users.user_id;
          public               root    false    219            �           0    0 
   tasks_2024    TABLE ATTACH     �   ALTER TABLE ONLY public.tasks ATTACH PARTITION public.tasks_2024 FOR VALUES FROM ('2024-01-01 00:00:00') TO ('2024-12-31 00:00:00');
          public               root    false    248    247            �           0    0 
   tasks_2025    TABLE ATTACH     �   ALTER TABLE ONLY public.tasks ATTACH PARTITION public.tasks_2025 FOR VALUES FROM ('2025-01-01 00:00:00') TO ('2025-12-31 00:00:00');
          public               root    false    249    247            �           2604    16706    batches batch_id    DEFAULT     t   ALTER TABLE ONLY public.batches ALTER COLUMN batch_id SET DEFAULT nextval('public.batches_batch_id_seq'::regclass);
 ?   ALTER TABLE public.batches ALTER COLUMN batch_id DROP DEFAULT;
       public               root    false    234    233    234            �           2604    16545    categories category_id    DEFAULT     �   ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);
 E   ALTER TABLE public.categories ALTER COLUMN category_id DROP DEFAULT;
       public               root    false    227    228    228            �           2604    16720    faqs faq_id    DEFAULT     j   ALTER TABLE ONLY public.faqs ALTER COLUMN faq_id SET DEFAULT nextval('public.faqs_faq_id_seq'::regclass);
 :   ALTER TABLE public.faqs ALTER COLUMN faq_id DROP DEFAULT;
       public               root    false    236    235    236            �           2604    24651    favorite_tasks favorite_id    DEFAULT     �   ALTER TABLE ONLY public.favorite_tasks ALTER COLUMN favorite_id SET DEFAULT nextval('public.favorite_tasks_favorite_id_seq'::regclass);
 I   ALTER TABLE public.favorite_tasks ALTER COLUMN favorite_id DROP DEFAULT;
       public               root    false    242    241    242            �           2604    16569    notifications notification_id    DEFAULT     �   ALTER TABLE ONLY public.notifications ALTER COLUMN notification_id SET DEFAULT nextval('public.notifications_notification_id_seq'::regclass);
 L   ALTER TABLE public.notifications ALTER COLUMN notification_id DROP DEFAULT;
       public               root    false    232    231    232            �           2604    16519    reviews review_id    DEFAULT     v   ALTER TABLE ONLY public.reviews ALTER COLUMN review_id SET DEFAULT nextval('public.reviews_review_id_seq'::regclass);
 @   ALTER TABLE public.reviews ALTER COLUMN review_id DROP DEFAULT;
       public               root    false    226    225    226            �           2604    33538    roles id    DEFAULT     d   ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);
 7   ALTER TABLE public.roles ALTER COLUMN id DROP DEFAULT;
       public               root    false    254    255    255            �           2604    24629    subcategories subcategory_id    DEFAULT     �   ALTER TABLE ONLY public.subcategories ALTER COLUMN subcategory_id SET DEFAULT nextval('public.subcategories_subcategory_id_seq'::regclass);
 K   ALTER TABLE public.subcategories ALTER COLUMN subcategory_id DROP DEFAULT;
       public               root    false    239    240    240            �           2604    16556    task_logs log_id    DEFAULT     t   ALTER TABLE ONLY public.task_logs ALTER COLUMN log_id SET DEFAULT nextval('public.task_logs_log_id_seq'::regclass);
 ?   ALTER TABLE public.task_logs ALTER COLUMN log_id DROP DEFAULT;
       public               root    false    229    230    230            �           2604    16437    tasks_old task_id    DEFAULT     r   ALTER TABLE ONLY public.tasks_old ALTER COLUMN task_id SET DEFAULT nextval('public.tasks_task_id_seq'::regclass);
 @   ALTER TABLE public.tasks_old ALTER COLUMN task_id DROP DEFAULT;
       public               root    false    221    222    222            �           2604    33547    user_roles id    DEFAULT     n   ALTER TABLE ONLY public.user_roles ALTER COLUMN id SET DEFAULT nextval('public.user_roles_id_seq'::regclass);
 <   ALTER TABLE public.user_roles ALTER COLUMN id DROP DEFAULT;
       public               root    false    257    256    257            �           2604    16393    users user_id    DEFAULT     m   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.user_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public               root    false    220    219    220            >          0    33561 
   audit_logs 
   TABLE DATA           \   COPY public.audit_logs (id, user_id, action, table_name, record_id, created_at) FROM stdin;
    public               root    false    258   /      )          0    16703    batches 
   TABLE DATA           ~   COPY public.batches (batch_id, user_id, batch_name, start_date, end_date, total_earnings, created_at, updated_at) FROM stdin;
    public               root    false    234   L      9          0    33516    bid_history 
   TABLE DATA           Q   COPY public.bid_history (id, bid_id, status, changed_at, changed_by) FROM stdin;
    public               root    false    253   i                0    16469    bids 
   TABLE DATA           g   COPY public.bids (task_id, tasker_id, bid_amount, bid_message, status, created_at, bid_id) FROM stdin;
    public               root    false    223   �      2          0    32831    blogs 
   TABLE DATA           [   COPY public.blogs (blog_id, title, content, author_id, created_at, updated_at) FROM stdin;
    public               root    false    243   �      #          0    16542 
   categories 
   TABLE DATA           P   COPY public.categories (category_id, name, description, task_count) FROM stdin;
    public               root    false    228   �      3          0    32860    comments 
   TABLE DATA           Z   COPY public.comments (comment_id, blog_id, user_id, comment_text, created_at) FROM stdin;
    public               root    false    244   �      +          0    16717    faqs 
   TABLE DATA           P   COPY public.faqs (faq_id, question, answer, created_at, updated_at) FROM stdin;
    public               root    false    236   �      1          0    24648    favorite_tasks 
   TABLE DATA           S   COPY public.favorite_tasks (favorite_id, user_id, task_id, created_at) FROM stdin;
    public               root    false    242         ,          0    16743    featured_tasks 
   TABLE DATA           c   COPY public.featured_tasks (task_id, feature_start_date, feature_end_date, created_at) FROM stdin;
    public               root    false    237   4      -          0    16754    my_tasks 
   TABLE DATA           N   COPY public.my_tasks (user_id, task_id, role, status, created_at) FROM stdin;
    public               root    false    238   Q      '          0    16566    notifications 
   TABLE DATA           _   COPY public.notifications (notification_id, user_id, message, is_read, created_at) FROM stdin;
    public               root    false    232   n      6          0    33412    payment_logs 
   TABLE DATA           m   COPY public.payment_logs (id, payment_id, transaction_type, gateway, amount, status, created_at) FROM stdin;
    public               root    false    250   �                0    16491    payments 
   TABLE DATA           u   COPY public.payments (task_id, customer_id, tasker_id, amount, payment_status, payment_date, payment_id) FROM stdin;
    public               root    false    224   �      !          0    16516    reviews 
   TABLE DATA           m   COPY public.reviews (review_id, task_id, reviewer_id, reviewee_id, rating, comments, created_at) FROM stdin;
    public               root    false    226   �      ;          0    33535    roles 
   TABLE DATA           .   COPY public.roles (id, role_name) FROM stdin;
    public               root    false    255   �      /          0    24626    subcategories 
   TABLE DATA           o   COPY public.subcategories (subcategory_id, category_id, name, description, created_at, updated_at) FROM stdin;
    public               root    false    240   �      8          0    33500    support_tickets 
   TABLE DATA           h   COPY public.support_tickets (id, user_id, subject, message, status, created_at, updated_at) FROM stdin;
    public               root    false    252         %          0    16553 	   task_logs 
   TABLE DATA           X   COPY public.task_logs (log_id, task_id, old_status, new_status, updated_at) FROM stdin;
    public               root    false    230   9      4          0    33224 
   tasks_2024 
   TABLE DATA           4   COPY public.tasks_2024 (id, created_at) FROM stdin;
    public               root    false    248   V      5          0    33229 
   tasks_2025 
   TABLE DATA           4   COPY public.tasks_2025 (id, created_at) FROM stdin;
    public               root    false    249   s                0    16434 	   tasks_old 
   TABLE DATA           �   COPY public.tasks_old (task_id, title, description, category_id, location, budget, status, due_date, created_at, updated_at, user_id, sub_category, image, task_date, location_type) FROM stdin;
    public               root    false    222   �      =          0    33544 
   user_roles 
   TABLE DATA           G   COPY public.user_roles (id, user_id, role_id, assigned_at) FROM stdin;
    public               root    false    257   �      7          0    33484    user_sessions 
   TABLE DATA           s   COPY public.user_sessions (id, user_id, session_token, ip_address, user_agent, created_at, expires_at) FROM stdin;
    public               root    false    251   �                0    16390    users 
   TABLE DATA           �   COPY public.users (uuid, user_id, first_name, last_name, phone_number, password_hash, user_role, profile_picture_url, bio, created_at, updated_at, status, batch, basic_info, address, education, experience, skills, languages, encrypted_email) FROM stdin;
    public               root    false    220   �      d           0    0    batches_batch_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.batches_batch_id_seq', 1, false);
          public               root    false    233            e           0    0    categories_category_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.categories_category_id_seq', 1, false);
          public               root    false    227            f           0    0    faqs_faq_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.faqs_faq_id_seq', 1, false);
          public               root    false    235            g           0    0    favorite_tasks_favorite_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.favorite_tasks_favorite_id_seq', 1, false);
          public               root    false    241            h           0    0 !   notifications_notification_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.notifications_notification_id_seq', 1, false);
          public               root    false    231            i           0    0    reviews_review_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.reviews_review_id_seq', 1, false);
          public               root    false    225            j           0    0    roles_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.roles_id_seq', 1, false);
          public               root    false    254            k           0    0     subcategories_subcategory_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.subcategories_subcategory_id_seq', 1, false);
          public               root    false    239            l           0    0    task_logs_log_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.task_logs_log_id_seq', 1, false);
          public               root    false    229            m           0    0    tasks_task_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.tasks_task_id_seq', 1, false);
          public               root    false    221            n           0    0    user_roles_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.user_roles_id_seq', 1, false);
          public               root    false    256            o           0    0    user_user_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.user_user_id_seq', 1, false);
          public               root    false    219            _           2606    33569    audit_logs audit_logs_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.audit_logs DROP CONSTRAINT audit_logs_pkey;
       public                 root    false    258            )           2606    16710    batches batches_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.batches
    ADD CONSTRAINT batches_pkey PRIMARY KEY (batch_id);
 >   ALTER TABLE ONLY public.batches DROP CONSTRAINT batches_pkey;
       public                 root    false    234            U           2606    33523    bid_history bid_history_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.bid_history
    ADD CONSTRAINT bid_history_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.bid_history DROP CONSTRAINT bid_history_pkey;
       public                 root    false    253                       2606    33346    bids bids_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_pkey PRIMARY KEY (bid_id);
 8   ALTER TABLE ONLY public.bids DROP CONSTRAINT bids_pkey;
       public                 root    false    223            ;           2606    32840    blogs blogs_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.blogs
    ADD CONSTRAINT blogs_pkey PRIMARY KEY (blog_id);
 :   ALTER TABLE ONLY public.blogs DROP CONSTRAINT blogs_pkey;
       public                 root    false    243                       2606    16551    categories categories_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);
 H   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_name_key;
       public                 root    false    228            !           2606    16549    categories categories_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public                 root    false    228            >           2606    32868    comments comments_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (comment_id);
 @   ALTER TABLE ONLY public.comments DROP CONSTRAINT comments_pkey;
       public                 root    false    244            +           2606    16726    faqs faqs_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.faqs
    ADD CONSTRAINT faqs_pkey PRIMARY KEY (faq_id);
 8   ALTER TABLE ONLY public.faqs DROP CONSTRAINT faqs_pkey;
       public                 root    false    236            5           2606    24654 "   favorite_tasks favorite_tasks_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.favorite_tasks
    ADD CONSTRAINT favorite_tasks_pkey PRIMARY KEY (favorite_id);
 L   ALTER TABLE ONLY public.favorite_tasks DROP CONSTRAINT favorite_tasks_pkey;
       public                 root    false    242            7           2606    24656 1   favorite_tasks favorite_tasks_user_id_task_id_key 
   CONSTRAINT     x   ALTER TABLE ONLY public.favorite_tasks
    ADD CONSTRAINT favorite_tasks_user_id_task_id_key UNIQUE (user_id, task_id);
 [   ALTER TABLE ONLY public.favorite_tasks DROP CONSTRAINT favorite_tasks_user_id_task_id_key;
       public                 root    false    242    242            -           2606    16748 "   featured_tasks featured_tasks_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.featured_tasks
    ADD CONSTRAINT featured_tasks_pkey PRIMARY KEY (task_id);
 L   ALTER TABLE ONLY public.featured_tasks DROP CONSTRAINT featured_tasks_pkey;
       public                 root    false    237            0           2606    16762    my_tasks my_tasks_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.my_tasks
    ADD CONSTRAINT my_tasks_pkey PRIMARY KEY (user_id, task_id);
 @   ALTER TABLE ONLY public.my_tasks DROP CONSTRAINT my_tasks_pkey;
       public                 root    false    238    238            '           2606    16575     notifications notifications_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notification_id);
 J   ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_pkey;
       public                 root    false    232            I           2606    33421    payment_logs payment_logs_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.payment_logs
    ADD CONSTRAINT payment_logs_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.payment_logs DROP CONSTRAINT payment_logs_pkey;
       public                 root    false    250                       2606    33353    payments payments_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);
 @   ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_pkey;
       public                 root    false    224                       2606    16525    reviews reviews_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (review_id);
 >   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_pkey;
       public                 root    false    226            Y           2606    33540    roles roles_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public                 root    false    255            [           2606    33542    roles roles_role_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_role_name_key UNIQUE (role_name);
 C   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_role_name_key;
       public                 root    false    255            3           2606    24635     subcategories subcategories_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.subcategories
    ADD CONSTRAINT subcategories_pkey PRIMARY KEY (subcategory_id);
 J   ALTER TABLE ONLY public.subcategories DROP CONSTRAINT subcategories_pkey;
       public                 root    false    240            S           2606    33510 $   support_tickets support_tickets_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.support_tickets
    ADD CONSTRAINT support_tickets_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.support_tickets DROP CONSTRAINT support_tickets_pkey;
       public                 root    false    252            %           2606    16559    task_logs task_logs_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.task_logs
    ADD CONSTRAINT task_logs_pkey PRIMARY KEY (log_id);
 B   ALTER TABLE ONLY public.task_logs DROP CONSTRAINT task_logs_pkey;
       public                 root    false    230            A           2606    33223    tasks tasks_pkey1 
   CONSTRAINT     [   ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey1 PRIMARY KEY (id, created_at);
 ;   ALTER TABLE ONLY public.tasks DROP CONSTRAINT tasks_pkey1;
       public                 root    false    247    247            D           2606    33228    tasks_2024 tasks_2024_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.tasks_2024
    ADD CONSTRAINT tasks_2024_pkey PRIMARY KEY (id, created_at);
 D   ALTER TABLE ONLY public.tasks_2024 DROP CONSTRAINT tasks_2024_pkey;
       public                 root    false    248    248    4929    248            G           2606    33233    tasks_2025 tasks_2025_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.tasks_2025
    ADD CONSTRAINT tasks_2025_pkey PRIMARY KEY (id, created_at);
 D   ALTER TABLE ONLY public.tasks_2025 DROP CONSTRAINT tasks_2025_pkey;
       public                 root    false    4929    249    249    249                       2606    16445    tasks_old tasks_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.tasks_old
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (task_id);
 >   ALTER TABLE ONLY public.tasks_old DROP CONSTRAINT tasks_pkey;
       public                 root    false    222                       2606    16432    users user_id_unique 
   CONSTRAINT     R   ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_id_unique UNIQUE (user_id);
 >   ALTER TABLE ONLY public.users DROP CONSTRAINT user_id_unique;
       public                 root    false    220                       2606    16404    users user_phone_number_key 
   CONSTRAINT     ^   ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_phone_number_key UNIQUE (phone_number);
 E   ALTER TABLE ONLY public.users DROP CONSTRAINT user_phone_number_key;
       public                 root    false    220                       2606    33080    users user_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_pkey PRIMARY KEY (uuid);
 9   ALTER TABLE ONLY public.users DROP CONSTRAINT user_pkey;
       public                 root    false    220            ]           2606    33550    user_roles user_roles_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.user_roles DROP CONSTRAINT user_roles_pkey;
       public                 root    false    257            L           2606    33492     user_sessions user_sessions_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.user_sessions DROP CONSTRAINT user_sessions_pkey;
       public                 root    false    251            N           2606    33494 -   user_sessions user_sessions_session_token_key 
   CONSTRAINT     q   ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_session_token_key UNIQUE (session_token);
 W   ALTER TABLE ONLY public.user_sessions DROP CONSTRAINT user_sessions_session_token_key;
       public                 root    false    251            `           1259    33584    idx_audit_logs_created_at    INDEX     V   CREATE INDEX idx_audit_logs_created_at ON public.audit_logs USING btree (created_at);
 -   DROP INDEX public.idx_audit_logs_created_at;
       public                 root    false    258            V           1259    33577    idx_bid_history_bid_id    INDEX     P   CREATE INDEX idx_bid_history_bid_id ON public.bid_history USING btree (bid_id);
 *   DROP INDEX public.idx_bid_history_bid_id;
       public                 root    false    253            W           1259    33578    idx_bid_history_changed_by    INDEX     X   CREATE INDEX idx_bid_history_changed_by ON public.bid_history USING btree (changed_by);
 .   DROP INDEX public.idx_bid_history_changed_by;
       public                 root    false    253                       1259    33579    idx_bids_status    INDEX     B   CREATE INDEX idx_bids_status ON public.bids USING btree (status);
 #   DROP INDEX public.idx_bids_status;
       public                 root    false    223                       1259    33130    idx_bids_task_id    INDEX     D   CREATE INDEX idx_bids_task_id ON public.bids USING btree (task_id);
 $   DROP INDEX public.idx_bids_task_id;
       public                 root    false    223            <           1259    33585    idx_blogs_content    INDEX     g   CREATE INDEX idx_blogs_content ON public.blogs USING gin (to_tsvector('english'::regconfig, content));
 %   DROP INDEX public.idx_blogs_content;
       public                 root    false    243    243            "           1259    24642    idx_category_name    INDEX     H   CREATE INDEX idx_category_name ON public.categories USING btree (name);
 %   DROP INDEX public.idx_category_name;
       public                 root    false    228            8           1259    24668    idx_favorite_task    INDEX     O   CREATE INDEX idx_favorite_task ON public.favorite_tasks USING btree (task_id);
 %   DROP INDEX public.idx_favorite_task;
       public                 root    false    242            9           1259    24667    idx_favorite_user    INDEX     O   CREATE INDEX idx_favorite_user ON public.favorite_tasks USING btree (user_id);
 %   DROP INDEX public.idx_favorite_user;
       public                 root    false    242            .           1259    24644    idx_featured_task_id    INDEX     R   CREATE INDEX idx_featured_task_id ON public.featured_tasks USING btree (task_id);
 (   DROP INDEX public.idx_featured_task_id;
       public                 root    false    237                       1259    33133    idx_reviews_reviewee_id    INDEX     R   CREATE INDEX idx_reviews_reviewee_id ON public.reviews USING btree (reviewee_id);
 +   DROP INDEX public.idx_reviews_reviewee_id;
       public                 root    false    226                       1259    33132    idx_reviews_reviewer_id    INDEX     R   CREATE INDEX idx_reviews_reviewer_id ON public.reviews USING btree (reviewer_id);
 +   DROP INDEX public.idx_reviews_reviewer_id;
       public                 root    false    226                       1259    33131    idx_reviews_task_id    INDEX     J   CREATE INDEX idx_reviews_task_id ON public.reviews USING btree (task_id);
 '   DROP INDEX public.idx_reviews_task_id;
       public                 root    false    226            1           1259    24643    idx_subcategory_name    INDEX     N   CREATE INDEX idx_subcategory_name ON public.subcategories USING btree (name);
 (   DROP INDEX public.idx_subcategory_name;
       public                 root    false    240            O           1259    33583    idx_support_tickets_created_at    INDEX     `   CREATE INDEX idx_support_tickets_created_at ON public.support_tickets USING btree (created_at);
 2   DROP INDEX public.idx_support_tickets_created_at;
       public                 root    false    252            P           1259    33586    idx_support_tickets_message    INDEX     {   CREATE INDEX idx_support_tickets_message ON public.support_tickets USING gin (to_tsvector('english'::regconfig, message));
 /   DROP INDEX public.idx_support_tickets_message;
       public                 root    false    252    252            Q           1259    33576    idx_support_tickets_user_id    INDEX     Z   CREATE INDEX idx_support_tickets_user_id ON public.support_tickets USING btree (user_id);
 /   DROP INDEX public.idx_support_tickets_user_id;
       public                 root    false    252            #           1259    24646    idx_task_count    INDEX     P   CREATE INDEX idx_task_count ON public.categories USING btree (task_count DESC);
 "   DROP INDEX public.idx_task_count;
       public                 root    false    228            ?           1259    33580    idx_tasks_created_at    INDEX     Q   CREATE INDEX idx_tasks_created_at ON ONLY public.tasks USING btree (created_at);
 (   DROP INDEX public.idx_tasks_created_at;
       public                 root    false    247                       1259    33129    idx_tasks_user_id    INDEX     J   CREATE INDEX idx_tasks_user_id ON public.tasks_old USING btree (user_id);
 %   DROP INDEX public.idx_tasks_user_id;
       public                 root    false    222            J           1259    33575    idx_user_sessions_user_id    INDEX     V   CREATE INDEX idx_user_sessions_user_id ON public.user_sessions USING btree (user_id);
 -   DROP INDEX public.idx_user_sessions_user_id;
       public                 root    false    251            B           1259    33581    tasks_2024_created_at_idx    INDEX     V   CREATE INDEX tasks_2024_created_at_idx ON public.tasks_2024 USING btree (created_at);
 -   DROP INDEX public.tasks_2024_created_at_idx;
       public                 root    false    4927    248    248            E           1259    33582    tasks_2025_created_at_idx    INDEX     V   CREATE INDEX tasks_2025_created_at_idx ON public.tasks_2025 USING btree (created_at);
 -   DROP INDEX public.tasks_2025_created_at_idx;
       public                 root    false    4927    249    249            a           0    0    tasks_2024_created_at_idx    INDEX ATTACH     [   ALTER INDEX public.idx_tasks_created_at ATTACH PARTITION public.tasks_2024_created_at_idx;
          public               root    false    4930    4927    248    247            b           0    0    tasks_2024_pkey    INDEX ATTACH     H   ALTER INDEX public.tasks_pkey1 ATTACH PARTITION public.tasks_2024_pkey;
          public               root    false    4932    4929    248    4929    248    247            c           0    0    tasks_2025_created_at_idx    INDEX ATTACH     [   ALTER INDEX public.idx_tasks_created_at ATTACH PARTITION public.tasks_2025_created_at_idx;
          public               root    false    4933    4927    249    247            d           0    0    tasks_2025_pkey    INDEX ATTACH     H   ALTER INDEX public.tasks_pkey1 ATTACH PARTITION public.tasks_2025_pkey;
          public               root    false    4935    4929    249    4929    249    247            �           2606    33570 "   audit_logs audit_logs_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.audit_logs DROP CONSTRAINT audit_logs_user_id_fkey;
       public               root    false    4875    220    258            p           2606    16711    batches batches_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.batches
    ADD CONSTRAINT batches_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.batches DROP CONSTRAINT batches_user_id_fkey;
       public               root    false    234    4875    220            ~           2606    33524 #   bid_history bid_history_bid_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid_history
    ADD CONSTRAINT bid_history_bid_id_fkey FOREIGN KEY (bid_id) REFERENCES public.bids(bid_id) ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.bid_history DROP CONSTRAINT bid_history_bid_id_fkey;
       public               root    false    253    4884    223                       2606    33529 '   bid_history bid_history_changed_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid_history
    ADD CONSTRAINT bid_history_changed_by_fkey FOREIGN KEY (changed_by) REFERENCES public.users(user_id) ON DELETE SET NULL;
 Q   ALTER TABLE ONLY public.bid_history DROP CONSTRAINT bid_history_changed_by_fkey;
       public               root    false    253    220    4875            f           2606    16480    bids bids_task_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks_old(task_id) ON DELETE CASCADE;
 @   ALTER TABLE ONLY public.bids DROP CONSTRAINT bids_task_id_fkey;
       public               root    false    4882    223    222            g           2606    16485    bids bids_tasker_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_tasker_id_fkey FOREIGN KEY (tasker_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.bids DROP CONSTRAINT bids_tasker_id_fkey;
       public               root    false    4875    223    220            x           2606    32841    blogs blogs_author_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.blogs
    ADD CONSTRAINT blogs_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 D   ALTER TABLE ONLY public.blogs DROP CONSTRAINT blogs_author_id_fkey;
       public               root    false    4875    220    243            y           2606    32869    comments comments_blog_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_blog_id_fkey FOREIGN KEY (blog_id) REFERENCES public.blogs(blog_id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.comments DROP CONSTRAINT comments_blog_id_fkey;
       public               root    false    4923    243    244            z           2606    32874    comments comments_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.comments DROP CONSTRAINT comments_user_id_fkey;
       public               root    false    4875    244    220            v           2606    24662 *   favorite_tasks favorite_tasks_task_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.favorite_tasks
    ADD CONSTRAINT favorite_tasks_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks_old(task_id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.favorite_tasks DROP CONSTRAINT favorite_tasks_task_id_fkey;
       public               root    false    222    242    4882            w           2606    24657 *   favorite_tasks favorite_tasks_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.favorite_tasks
    ADD CONSTRAINT favorite_tasks_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.favorite_tasks DROP CONSTRAINT favorite_tasks_user_id_fkey;
       public               root    false    4875    220    242            r           2606    16749 *   featured_tasks featured_tasks_task_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.featured_tasks
    ADD CONSTRAINT featured_tasks_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks_old(task_id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.featured_tasks DROP CONSTRAINT featured_tasks_task_id_fkey;
       public               root    false    237    222    4882            q           2606    32889    batches fk_batches_user    FK CONSTRAINT     �   ALTER TABLE ONLY public.batches
    ADD CONSTRAINT fk_batches_user FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.batches DROP CONSTRAINT fk_batches_user;
       public               root    false    234    220    4875            s           2606    16768    my_tasks my_tasks_task_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.my_tasks
    ADD CONSTRAINT my_tasks_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks_old(task_id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.my_tasks DROP CONSTRAINT my_tasks_task_id_fkey;
       public               root    false    222    238    4882            t           2606    16763    my_tasks my_tasks_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.my_tasks
    ADD CONSTRAINT my_tasks_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.my_tasks DROP CONSTRAINT my_tasks_user_id_fkey;
       public               root    false    4875    238    220            o           2606    16576 (   notifications notifications_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_user_id_fkey;
       public               root    false    232    4875    220            {           2606    33422 )   payment_logs payment_logs_payment_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.payment_logs
    ADD CONSTRAINT payment_logs_payment_id_fkey FOREIGN KEY (payment_id) REFERENCES public.payments(payment_id) ON DELETE CASCADE;
 S   ALTER TABLE ONLY public.payment_logs DROP CONSTRAINT payment_logs_payment_id_fkey;
       public               root    false    4888    250    224            h           2606    16505 "   payments payments_customer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_customer_id_fkey;
       public               root    false    220    224    4875            i           2606    16500    payments payments_task_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks_old(task_id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_task_id_fkey;
       public               root    false    222    224    4882            j           2606    16510     payments payments_tasker_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_tasker_id_fkey FOREIGN KEY (tasker_id) REFERENCES public.users(user_id);
 J   ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_tasker_id_fkey;
       public               root    false    220    4875    224            k           2606    16536     reviews reviews_reviewee_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_reviewee_id_fkey FOREIGN KEY (reviewee_id) REFERENCES public.users(user_id);
 J   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_reviewee_id_fkey;
       public               root    false    226    220    4875            l           2606    16531     reviews reviews_reviewer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_reviewer_id_fkey FOREIGN KEY (reviewer_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_reviewer_id_fkey;
       public               root    false    4875    226    220            m           2606    16526    reviews reviews_task_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks_old(task_id) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_task_id_fkey;
       public               root    false    226    4882    222            u           2606    24636 ,   subcategories subcategories_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.subcategories
    ADD CONSTRAINT subcategories_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(category_id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.subcategories DROP CONSTRAINT subcategories_category_id_fkey;
       public               root    false    228    4897    240            }           2606    33511 ,   support_tickets support_tickets_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.support_tickets
    ADD CONSTRAINT support_tickets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.support_tickets DROP CONSTRAINT support_tickets_user_id_fkey;
       public               root    false    4875    220    252            n           2606    16560     task_logs task_logs_task_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.task_logs
    ADD CONSTRAINT task_logs_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks_old(task_id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.task_logs DROP CONSTRAINT task_logs_task_id_fkey;
       public               root    false    222    4882    230            e           2606    16446     tasks_old tasks_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tasks_old
    ADD CONSTRAINT tasks_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.tasks_old DROP CONSTRAINT tasks_category_id_fkey;
       public               root    false    220    4875    222            �           2606    33556 "   user_roles user_roles_role_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.user_roles DROP CONSTRAINT user_roles_role_id_fkey;
       public               root    false    255    257    4953            �           2606    33551 "   user_roles user_roles_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.user_roles DROP CONSTRAINT user_roles_user_id_fkey;
       public               root    false    4875    220    257            |           2606    33495 (   user_sessions user_sessions_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.user_sessions DROP CONSTRAINT user_sessions_user_id_fkey;
       public               root    false    4875    251    220                       0    16434 	   tasks_old    ROW SECURITY     7   ALTER TABLE public.tasks_old ENABLE ROW LEVEL SECURITY;          public               root    false    222                       3256    33081 !   tasks_old user_can_view_own_tasks    POLICY     �   CREATE POLICY user_can_view_own_tasks ON public.tasks_old USING ((user_id = (current_setting('app.current_user'::text))::uuid));
 9   DROP POLICY user_can_view_own_tasks ON public.tasks_old;
       public               root    false    222    222                       3256    33086    users user_policy    POLICY     n   CREATE POLICY user_policy ON public.users USING ((uuid = (current_setting('app.current_user'::text))::uuid));
 )   DROP POLICY user_policy ON public.users;
       public               root    false    220    220                       0    16390    users    ROW SECURITY     3   ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;          public               root    false    220            >      x������ � �      )      x������ � �      9      x������ � �            x������ � �      2      x������ � �      #      x������ � �      3      x������ � �      +      x������ � �      1      x������ � �      ,      x������ � �      -      x������ � �      '      x������ � �      6      x������ � �            x������ � �      !      x������ � �      ;      x������ � �      /      x������ � �      8      x������ � �      %      x������ � �      4      x������ � �      5      x������ � �            x������ � �      =      x������ � �      7      x������ � �            x������ � �     