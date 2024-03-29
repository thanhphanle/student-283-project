-- Table: datas_fields_product

-- DROP TABLE datas_fields_product;

CREATE TABLE datas_fields_product
(
  id serial NOT NULL,
  serial_data character(1000),
  create_date timestamp without time zone,
  write_date timestamp without time zone,
  active boolean,
  CONSTRAINT datas_fields_product_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE datas_fields_product
  OWNER TO postgres;

-- Table: fields_product

-- DROP TABLE fields_product;

CREATE TABLE fields_product
(
  id serial NOT NULL,
  create_date timestamp without time zone,
  write_date timestamp without time zone,
  active boolean,
  serial_fields character(1000),
  CONSTRAINT fields_product_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fields_product
  OWNER TO postgres;

-- Table: cart

-- DROP TABLE cart;

CREATE TABLE cart
(
  id serial NOT NULL,
  create_date timestamp without time zone,
  write_date timestamp without time zone,
  active boolean,
  CONSTRAINT cart_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE cart
  OWNER TO postgres;

-- Table: user_group

-- DROP TABLE user_group;

CREATE TABLE user_group
(
  id serial NOT NULL,
  name character varying(32),
  create_date timestamp without time zone,
  write_date timestamp without time zone,
  active boolean,
  CONSTRAINT user_group_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE user_group
  OWNER TO postgres;
  
-- Table: os_user

-- DROP TABLE os_user;

CREATE TABLE os_user
(
  id serial NOT NULL,
  group_id integer,
  cart_id integer,
  username character varying(16),
  password character varying(16),
  full_name character varying(32),
  address character varying(256),
  phone character varying(16),
  email character varying(64),
  create_date timestamp without time zone,
  write_date timestamp without time zone,
  active boolean,
  CONSTRAINT os_user_pkey PRIMARY KEY (id),
  CONSTRAINT os_user_cart_id_fkey FOREIGN KEY (cart_id)
      REFERENCES cart (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT os_user_group_id_fkey FOREIGN KEY (group_id)
      REFERENCES user_group (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT os_user_username_key UNIQUE (username)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE os_user
  OWNER TO postgres;
  
-- Table: status

-- DROP TABLE status;

CREATE TABLE status
(
  id serial NOT NULL,
  status_type character varying(32),
  name character varying(32),
  create_date timestamp without time zone,
  write_date timestamp without time zone,
  active boolean,
  CONSTRAINT status_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE status
  OWNER TO postgres;

-- Table: producer

-- DROP TABLE producer;

CREATE TABLE producer
(
  id serial NOT NULL,
  name character varying(32),
  description character varying(256),
  create_date timestamp without time zone,
  write_date timestamp without time zone,
  active boolean,
  CONSTRAINT producer_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE producer
  OWNER TO postgres;

-- Table: category

-- DROP TABLE category;

CREATE TABLE category
(
  id serial NOT NULL,
  parent_id integer,
  fields_id integer,
  name character varying(32),
  priority integer,
  create_date timestamp without time zone,
  write_date timestamp without time zone,
  active boolean,
  CONSTRAINT category_pkey PRIMARY KEY (id),
  CONSTRAINT category_fields_id_fkey FOREIGN KEY (fields_id)
      REFERENCES fields_product (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE category
  OWNER TO postgres;

-- Table: price

-- DROP TABLE price;

CREATE TABLE price
(
  id serial NOT NULL,
  price double precision,
  create_date timestamp without time zone,
  write_date timestamp without time zone,
  active boolean,
  CONSTRAINT price_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE price
  OWNER TO postgres;

-- Table: promotion

-- DROP TABLE promotion;

CREATE TABLE promotion
(
  id serial NOT NULL,
  name character varying(32),
  start_date date,
  end_date date,
  type_promotion character varying(32),
  description character varying(256),
  create_date timestamp without time zone,
  write_date timestamp without time zone,
  active boolean,
  CONSTRAINT promotion_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE promotion
  OWNER TO postgres;
  
-- Table: gallery

-- DROP TABLE gallery;

CREATE TABLE gallery
(
  id serial NOT NULL,
  name character varying(32),
  create_date timestamp without time zone,
  write_date timestamp without time zone,
  active boolean,
  CONSTRAINT gallery_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE gallery
  OWNER TO postgres;

-- Table: image

-- DROP TABLE image;

CREATE TABLE image
(
  id serial NOT NULL,
  gallery_id integer,
  name character varying(256),
  description character varying(512),
  create_date timestamp without time zone,
  write_date timestamp without time zone,
  active boolean,
  CONSTRAINT image_pkey PRIMARY KEY (id),
  CONSTRAINT image_gallery_id_fkey FOREIGN KEY (gallery_id)
      REFERENCES gallery (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT
)
WITH (
  OIDS=FALSE
);
ALTER TABLE image
  OWNER TO postgres;
  
-- Table: product

-- DROP TABLE product;

CREATE TABLE product
(
  id serial NOT NULL,
  producer_id integer,
  status_id integer,
  promotion_id integer,
  price_id integer,
  gallery_id integer,
  datas_fields_id integer,
  name character varying(32),
  icon character varying(256),
  stock_quantity integer,
  error_quantity integer,
  description character varying(256),
  create_date timestamp without time zone,
  write_date timestamp without time zone,
  active boolean,
  CONSTRAINT product_pkey PRIMARY KEY (id),
  CONSTRAINT product_datas_fields_id_fkey FOREIGN KEY (datas_fields_id)
      REFERENCES datas_fields_product (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT product_gallery_id_fkey FOREIGN KEY (gallery_id)
      REFERENCES gallery (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT product_price_id_fkey FOREIGN KEY (price_id)
      REFERENCES price (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT product_producer_id_fkey FOREIGN KEY (producer_id)
      REFERENCES producer (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT product_promotion_id_fkey FOREIGN KEY (promotion_id)
      REFERENCES promotion (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT product_status_id_fkey FOREIGN KEY (status_id)
      REFERENCES status (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT
)
WITH (
  OIDS=FALSE
);
ALTER TABLE product
  OWNER TO postgres;
  
-- Table: category_product

-- DROP TABLE category_product;

CREATE TABLE category_product
(
  id serial NOT NULL,
  category_id integer,
  product_id integer,
  CONSTRAINT category_product_pkey PRIMARY KEY (id),
  CONSTRAINT category_product_category_id_fkey FOREIGN KEY (category_id)
      REFERENCES category (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT category_product_product_id_fkey FOREIGN KEY (product_id)
      REFERENCES product (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT
)
WITH (
  OIDS=FALSE
);
ALTER TABLE category_product
  OWNER TO postgres;

-- Table: cart_product

-- DROP TABLE cart_product;

CREATE TABLE cart_product
(
  id serial NOT NULL,
  cart_id integer,
  product_id integer,
  quantity integer,
  create_date timestamp without time zone,
  write_date timestamp without time zone,
  active boolean,
  CONSTRAINT cart_product_pkey PRIMARY KEY (id),
  CONSTRAINT cart_product_cart_id_fkey FOREIGN KEY (cart_id)
      REFERENCES cart (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT cart_product_product_id_fkey FOREIGN KEY (product_id)
      REFERENCES product (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT
)
WITH (
  OIDS=FALSE
);
ALTER TABLE cart_product
  OWNER TO postgres;  

-- Table: transport_fee

-- DROP TABLE transport_fee;

CREATE TABLE transport_fee
(
  id serial NOT NULL,
  name character varying(32),
  price double precision,
  create_date timestamp without time zone,
  write_date timestamp without time zone,
  active boolean,
  CONSTRAINT transport_fee_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE transport_fee
  OWNER TO postgres;

-- Table: tax

-- DROP TABLE tax;

CREATE TABLE tax
(
  id serial NOT NULL,
  name character varying(32),
  value double precision,
  create_date timestamp without time zone,
  write_date timestamp without time zone,
  active boolean,
  CONSTRAINT tax_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE tax
  OWNER TO postgres;
  
-- Table: os_order

-- DROP TABLE os_order;

CREATE TABLE os_order
(
  id serial NOT NULL,
  user_id integer,
  status_id integer,
  transport_fee_id integer,
  tax_id integer,
  total_price double precision,
  address character varying(256),
  phone character varying(16),
  create_date timestamp without time zone,
  write_date timestamp without time zone,
  active boolean,
  CONSTRAINT os_order_pkey PRIMARY KEY (id),
  CONSTRAINT os_order_status_id_fkey FOREIGN KEY (status_id)
      REFERENCES status (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT os_order_tax_id_fkey FOREIGN KEY (tax_id)
      REFERENCES tax (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT os_order_transport_fee_id_fkey FOREIGN KEY (transport_fee_id)
      REFERENCES transport_fee (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT os_order_user_id_fkey FOREIGN KEY (user_id)
      REFERENCES os_user (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT
)
WITH (
  OIDS=FALSE
);
ALTER TABLE os_order
  OWNER TO postgres;
  
-- Table: os_order_detail

-- DROP TABLE os_order_detail;

CREATE TABLE os_order_detail
(
  id serial NOT NULL,
  product_id integer,
  order_id integer,
  quantity integer,
  price double precision,
  create_date timestamp without time zone,
  write_date timestamp without time zone,
  active boolean,
  CONSTRAINT os_order_detail_pkey PRIMARY KEY (id),
  CONSTRAINT os_order_detail_order_id_fkey FOREIGN KEY (order_id)
      REFERENCES os_order (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT os_order_detail_product_id_fkey FOREIGN KEY (product_id)
      REFERENCES product (id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT
)
WITH (
  OIDS=FALSE
);
ALTER TABLE os_order_detail
  OWNER TO postgres;

-- Table: os_config

-- DROP TABLE os_config;

CREATE TABLE config
(
  id serial NOT NULL,
  name character varying(32),
  data_type character varying(32),
  value character varying(32),
  create_date timestamp without time zone,
  write_date timestamp without time zone,
  active boolean,
  CONSTRAINT config_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE config
  OWNER TO postgres;


