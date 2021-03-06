PGDMP     4    8                z         
   school_app    14.2    14.2                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16394 
   school_app    DATABASE     j   CREATE DATABASE school_app WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE school_app;
                postgres    false            ?            1259    16509    aluno    TABLE     d   CREATE TABLE public.aluno (
    codigo integer NOT NULL,
    nome character varying(50) NOT NULL
);
    DROP TABLE public.aluno;
       public         heap    postgres    false            ?            1259    16508    aluno_codigo_seq    SEQUENCE     ?   CREATE SEQUENCE public.aluno_codigo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.aluno_codigo_seq;
       public          postgres    false    210                       0    0    aluno_codigo_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.aluno_codigo_seq OWNED BY public.aluno.codigo;
          public          postgres    false    209            ?            1259    16516    curso    TABLE     ?   CREATE TABLE public.curso (
    codigo integer NOT NULL,
    descricao character varying(50) NOT NULL,
    ementa text NOT NULL
);
    DROP TABLE public.curso;
       public         heap    postgres    false            ?            1259    16526    curso_aluno    TABLE     ?   CREATE TABLE public.curso_aluno (
    codigo integer NOT NULL,
    codigo_aluno integer NOT NULL,
    codigo_curso integer NOT NULL
);
    DROP TABLE public.curso_aluno;
       public         heap    postgres    false            ?            1259    16525    curso_aluno_codigo_seq    SEQUENCE     ?   CREATE SEQUENCE public.curso_aluno_codigo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.curso_aluno_codigo_seq;
       public          postgres    false    214            	           0    0    curso_aluno_codigo_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.curso_aluno_codigo_seq OWNED BY public.curso_aluno.codigo;
          public          postgres    false    213            ?            1259    16515    curso_codigo_seq    SEQUENCE     ?   CREATE SEQUENCE public.curso_codigo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.curso_codigo_seq;
       public          postgres    false    212            
           0    0    curso_codigo_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.curso_codigo_seq OWNED BY public.curso.codigo;
          public          postgres    false    211            f           2604    16512    aluno codigo    DEFAULT     l   ALTER TABLE ONLY public.aluno ALTER COLUMN codigo SET DEFAULT nextval('public.aluno_codigo_seq'::regclass);
 ;   ALTER TABLE public.aluno ALTER COLUMN codigo DROP DEFAULT;
       public          postgres    false    210    209    210            g           2604    16519    curso codigo    DEFAULT     l   ALTER TABLE ONLY public.curso ALTER COLUMN codigo SET DEFAULT nextval('public.curso_codigo_seq'::regclass);
 ;   ALTER TABLE public.curso ALTER COLUMN codigo DROP DEFAULT;
       public          postgres    false    212    211    212            h           2604    16529    curso_aluno codigo    DEFAULT     x   ALTER TABLE ONLY public.curso_aluno ALTER COLUMN codigo SET DEFAULT nextval('public.curso_aluno_codigo_seq'::regclass);
 A   ALTER TABLE public.curso_aluno ALTER COLUMN codigo DROP DEFAULT;
       public          postgres    false    214    213    214            ?          0    16509    aluno 
   TABLE DATA           -   COPY public.aluno (codigo, nome) FROM stdin;
    public          postgres    false    210   0       ?          0    16516    curso 
   TABLE DATA           :   COPY public.curso (codigo, descricao, ementa) FROM stdin;
    public          postgres    false    212   r                 0    16526    curso_aluno 
   TABLE DATA           I   COPY public.curso_aluno (codigo, codigo_aluno, codigo_curso) FROM stdin;
    public          postgres    false    214   ?                  0    0    aluno_codigo_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.aluno_codigo_seq', 32, true);
          public          postgres    false    209                       0    0    curso_aluno_codigo_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.curso_aluno_codigo_seq', 41, true);
          public          postgres    false    213                       0    0    curso_codigo_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.curso_codigo_seq', 25, true);
          public          postgres    false    211            j           2606    16514    aluno aluno_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.aluno
    ADD CONSTRAINT aluno_pkey PRIMARY KEY (codigo);
 :   ALTER TABLE ONLY public.aluno DROP CONSTRAINT aluno_pkey;
       public            postgres    false    210            n           2606    16531    curso_aluno curso_aluno_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.curso_aluno
    ADD CONSTRAINT curso_aluno_pkey PRIMARY KEY (codigo);
 F   ALTER TABLE ONLY public.curso_aluno DROP CONSTRAINT curso_aluno_pkey;
       public            postgres    false    214            l           2606    16523    curso curso_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.curso
    ADD CONSTRAINT curso_pkey PRIMARY KEY (codigo);
 :   ALTER TABLE ONLY public.curso DROP CONSTRAINT curso_pkey;
       public            postgres    false    212            o           2606    16532    curso_aluno FK__aluno    FK CONSTRAINT        ALTER TABLE ONLY public.curso_aluno
    ADD CONSTRAINT "FK__aluno" FOREIGN KEY (codigo_aluno) REFERENCES public.aluno(codigo);
 A   ALTER TABLE ONLY public.curso_aluno DROP CONSTRAINT "FK__aluno";
       public          postgres    false    210    3178    214            p           2606    16537    curso_aluno FK__curso    FK CONSTRAINT        ALTER TABLE ONLY public.curso_aluno
    ADD CONSTRAINT "FK__curso" FOREIGN KEY (codigo_curso) REFERENCES public.curso(codigo);
 A   ALTER TABLE ONLY public.curso_aluno DROP CONSTRAINT "FK__curso";
       public          postgres    false    214    212    3180            ?   2   x?32?ʯ?22?t?+9?%/3??Ȅ?7?(3??Ȃ3 5?(?+F??? ??      ?   A   x?3???M,I?=??$39???В?)3?'?=3??73?(?	??22?tO?O/JLJY?=... *?         $   x?3??42?4??21?42 39?L8-?b???? O??     