-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA mydb;
USE mydb;

-- -----------------------------------------------------
-- Table mydb.salesman
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.salesman (
  id_salesman INT NOT NULL,
  document_type VARCHAR(3) NOT NULL,
  document_number DECIMAL(10) NOT NULL,
  name VARCHAR(45) NOT NULL,
  lastname VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_salesman),
  UNIQUE INDEX document_number_UNIQUE (document_number ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table mydb.store
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.store (
  id_store INT NOT NULL,
  name VARCHAR(45) NOT NULL,
  address VARCHAR(45) NOT NULL,
  type VARCHAR(5) NULL,
  store_owner INT NOT NULL,
  PRIMARY KEY (id_store),
  UNIQUE INDEX address_UNIQUE (address ASC) VISIBLE,
  UNIQUE INDEX name_UNIQUE (name ASC) VISIBLE,
  INDEX fk_store_salesman1_idx (store_owner ASC) VISIBLE,
  CONSTRAINT fk_store_salesman1
    FOREIGN KEY (store_owner)
    REFERENCES mydb.salesman (id_salesman)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table mydb.product
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.product (
  id_product INT NOT NULL,
  name VARCHAR(45) NOT NULL,
  price FLOAT NOT NULL,
  category VARCHAR(45) NOT NULL,
  arrival DATE NOT NULL,
  batch DECIMAL(10) NOT NULL,
  expiration DATE NOT NULL,
  manufacturer VARCHAR(45) NOT NULL,
  store_id_store INT NOT NULL,
  PRIMARY KEY (id_product),
  INDEX fk_product_store_idx (store_id_store ASC) VISIBLE,
  CONSTRAINT fk_product_store
    FOREIGN KEY (store_id_store)
    REFERENCES mydb.store (id_store)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table mydb.sale
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.sale (
  id_sale INT NOT NULL,
  sale_time DATETIME NOT NULL,
  client_id DECIMAL(10) NOT NULL,
  client_document_type VARCHAR(3) NOT NULL,
  salesman_id_salesman INT NOT NULL,
  is_deleted INT NULL,
  PRIMARY KEY (id_sale, salesman_id_salesman),
  INDEX fk_sale_salesman1_idx (salesman_id_salesman ASC) VISIBLE,
  CONSTRAINT fk_sale_salesman1
    FOREIGN KEY (salesman_id_salesman)
    REFERENCES mydb.salesman (id_salesman)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`provider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.provider (
  id_provider INT NOT NULL,
  name VARCHAR(45) NOT NULL,
  store_id_store INT NOT NULL,
  PRIMARY KEY (id_provider),
  INDEX fk_provider_store1_idx (store_id_store ASC) VISIBLE,
  CONSTRAINT fk_provider_store1
    FOREIGN KEY (store_id_store)
    REFERENCES mydb.store (id_store)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table mydb.provider_has_product
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.provider_has_product (
  provider_id_provider INT NOT NULL,
  product_id_product INT NOT NULL,
  PRIMARY KEY (provider_id_provider, product_id_product),
  INDEX fk_provider_has_product_product1_idx (product_id_product ASC) VISIBLE,
  INDEX fk_provider_has_product_provider1_idx (provider_id_provider ASC) VISIBLE,
  CONSTRAINT fk_provider_has_product_provider1
    FOREIGN KEY (provider_id_provider)
    REFERENCES mydb.provider (id_provider)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_provider_has_product_product1
    FOREIGN KEY (product_id_product)
    REFERENCES mydb.product (id_product)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`sale_has_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.sale_has_product (
  sale_id_sale INT NOT NULL,
  product_id_product INT NOT NULL,
  PRIMARY KEY (sale_id_sale, product_id_product),
  INDEX fk_sale_has_product_product1_idx (product_id_product ASC) VISIBLE,
  INDEX fk_sale_has_product_sale1_idx (sale_id_sale ASC) VISIBLE,
  CONSTRAINT fk_sale_has_product_sale1
    FOREIGN KEY (sale_id_sale)
    REFERENCES mydb.sale (id_sale)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_sale_has_product_product1
    FOREIGN KEY (product_id_product)
    REFERENCES mydb.product (id_product)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Loading the data
-- -----------------------------------------------------
-- salesman
INSERT INTO mydb.salesman
(id_salesman,
document_type,
document_number,
name,
lastname)
VALUES
(1,
"CC",
12222,
"Owen",
"Sore");

-- store

INSERT INTO mydb.store
(id_store,
name,
address,
type,
store_owner)
VALUES
(1,
"My Store",
"CLL88#23A",
"MIMK",
1);

-- provider

insert into mydb.provider (id_provider, name, store_id_store) values (1, 'Flashset', 1);
insert into mydb.provider (id_provider, name, store_id_store) values (2, 'Feednation', 1);
insert into mydb.provider (id_provider, name, store_id_store) values (3, 'Latz', 1);
insert into mydb.provider (id_provider, name, store_id_store) values (4, 'DabZ', 1);
insert into mydb.provider (id_provider, name, store_id_store) values (5, 'Twitterwire', 1);
insert into mydb.provider (id_provider, name, store_id_store) values (6, 'Browsetype', 1);
insert into mydb.provider (id_provider, name, store_id_store) values (7, 'Edgeblab', 1);
insert into mydb.provider (id_provider, name, store_id_store) values (8, 'Yakijo', 1);
insert into mydb.provider (id_provider, name, store_id_store) values (9, 'Kwilith', 1);
insert into mydb.provider (id_provider, name, store_id_store) values (10, 'Voonte', 1);
insert into mydb.provider (id_provider, name, store_id_store) values (11, 'Jabbersphere', 1);
insert into mydb.provider (id_provider, name, store_id_store) values (12, 'Miboo', 1);
insert into mydb.provider (id_provider, name, store_id_store) values (13, 'Blogpad', 1);
insert into mydb.provider (id_provider, name, store_id_store) values (14, 'Yamia', 1);
insert into mydb.provider (id_provider, name, store_id_store) values (15, 'Flashspan', 1);
insert into mydb.provider (id_provider, name, store_id_store) values (16, 'Photolist', 1);
insert into mydb.provider (id_provider, name, store_id_store) values (17, 'Realcube', 1);
insert into mydb.provider (id_provider, name, store_id_store) values (18, 'Skinder', 1);
insert into mydb.provider (id_provider, name, store_id_store) values (19, 'Miboo', 1);
insert into mydb.provider (id_provider, name, store_id_store) values (20, 'Brainsphere', 1);


-- product

insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (1, 'Pork Loin Cutlets', 35792, 'Automotive', '2021-10-24', 1, '2021-12-25', 'Dynabox', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (2, 'Foil - Round Foil', 63003, 'Sports', '2021-09-11', 2, '2021-06-30', 'Eazzy', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (3, 'Napkin White', 87905, 'Computers', '2021-12-28', 3, '2021-03-17', 'Shufflester', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (4, 'Neckerchief Blck', 57783, 'Beauty', '2022-01-02', 4, '2021-07-31', 'Gabtune', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (5, 'Cumin - Whole', 71738, 'Beauty', '2021-04-24', 5, '2021-04-18', 'Fivechat', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (6, 'Longos - Assorted Sandwich', 46230, 'Beauty', '2021-12-17', 6, '2021-06-24', 'Yakijo', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (7, 'Onions - Cooking', 62147, 'Grocery', '2021-08-26', 7, '2022-01-07', 'Realbuzz', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (8, 'Wine - Zinfandel Rosenblum', 60874, 'Industrial', '2021-03-14', 8, '2021-10-24', 'Skimia', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (9, 'Bag - Bread, White, Plain', 56299, 'Toys', '2021-12-22', 9, '2021-04-19', 'Tanoodle', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (10, 'Tart Shells - Sweet, 3', 84121, 'Shoes', '2021-09-05', 10, '2021-12-09', 'Feednation', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (11, 'Cabbage - Red', 25228, 'Kids', '2021-09-07', 11, '2021-05-20', 'Twinte', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (12, 'Milk - Buttermilk', 19766, 'Sports', '2022-01-24', 12, '2021-03-15', 'Feedmix', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (13, 'Chicken - Leg, Fresh', 74998, 'Garden', '2021-10-23', 13, '2021-12-15', 'Mynte', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (14, 'Broom And Brush Rack Black', 6372, 'Computers', '2022-02-13', 14, '2022-01-26', 'Reallinks', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (15, 'Wine - Cahors Ac 2000, Clos', 52843, 'Jewelry', '2022-01-24', 15, '2021-07-14', 'Dynazzy', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (16, 'Vinegar - Raspberry', 26911, 'Music', '2021-11-18', 16, '2021-12-26', 'Zoonder', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (17, 'Tomatoes - Diced, Canned', 27366, 'Clothing', '2021-08-13', 17, '2021-09-11', 'Edgeclub', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (18, 'Cup - Paper 10oz 92959', 74140, 'Beauty', '2021-11-09', 18, '2021-04-16', 'Myworks', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (19, 'Juice - Clam, 46 Oz', 72253, 'Outdoors', '2022-01-07', 19, '2021-12-03', 'Feedbug', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (20, 'Lettuce - Radicchio', 58534, 'Tools', '2022-02-14', 20, '2022-01-03', 'Einti', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (21, 'Dragon Fruit', 95823, 'Games', '2021-12-09', 21, '2021-09-21', 'Youbridge', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (22, 'Wine - Sauvignon Blanc', 58197, 'Shoes', '2021-10-29', 22, '2021-08-28', 'Ozu', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (23, 'Sesame Seed Black', 16968, 'Games', '2021-06-16', 23, '2021-06-15', 'Tanoodle', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (24, 'Dasheen', 36190, 'Automotive', '2021-07-18', 24, '2021-07-26', 'Demivee', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (25, 'Buffalo - Short Rib Fresh', 43491, 'Industrial', '2021-08-28', 25, '2021-10-08', 'Jayo', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (26, 'Sauce - Balsamic Viniagrette', 42589, 'Clothing', '2021-10-15', 26, '2021-05-26', 'Twinte', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (27, 'Cookies Almond Hazelnut', 90095, 'Outdoors', '2021-07-29', 27, '2021-03-26', 'Flashdog', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (28, 'Carbonated Water - Raspberry', 72496, 'Beauty', '2021-10-04', 28, '2021-08-12', 'Dazzlesphere', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (29, 'Squash - Pepper', 67162, 'Garden', '2021-10-31', 29, '2022-01-28', 'Jatri', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (30, 'Bread - Mini Hamburger Bun', 15475, 'Tools', '2021-04-01', 30, '2021-12-05', 'Lajo', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (31, 'Beer - Guiness', 32349, 'Health', '2021-06-13', 31, '2021-07-09', 'Twimbo', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (32, 'Liqueur Banana, Ramazzotti', 59270, 'Electronics', '2022-02-06', 32, '2021-04-18', 'Photobug', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (33, 'Potatoes - Instant, Mashed', 69990, 'Books', '2022-01-22', 33, '2022-01-19', 'Jatri', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (34, 'Island Oasis - Sweet And Sour Mix', 54826, 'Movies', '2022-01-01', 34, '2021-03-14', 'Pixoboo', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (35, 'Rice - Aborio', 50797, 'Electronics', '2021-08-04', 35, '2021-11-20', 'Oodoo', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (36, 'Tomatoes Tear Drop Yellow', 95392, 'Garden', '2022-03-02', 36, '2021-08-06', 'Skiba', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (37, 'Salmon Steak - Cohoe 6 Oz', 86952, 'Tools', '2021-12-24', 37, '2021-07-26', 'Pixonyx', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (38, 'Ostrich - Prime Cut', 39183, 'Clothing', '2021-10-11', 38, '2021-03-26', 'Bubblebox', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (39, 'Mince Meat - Filling', 44019, 'Health', '2021-09-03', 39, '2022-02-11', 'Feedbug', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (40, 'Wine - Montecillo Rioja Crianza', 64762, 'Industrial', '2021-08-13', 40, '2021-03-18', 'Buzzshare', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (41, 'Tea - Camomele', 92318, 'Music', '2021-04-11', 41, '2021-11-19', 'Dynazzy', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (42, 'Otomegusa Dashi Konbu', 8310, 'Games', '2021-06-26', 42, '2021-03-14', 'Midel', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (43, 'Milk - Chocolate 500ml', 19090, 'Automotive', '2021-07-11', 43, '2021-05-11', 'Skiptube', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (44, 'Lamb - Pieces, Diced', 72368, 'Music', '2021-08-14', 44, '2022-02-06', 'Photobug', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (45, 'Pepper - Black, Crushed', 62684, 'Movies', '2022-03-08', 45, '2021-07-02', 'Ailane', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (46, 'Cocoa Powder - Dutched', 78373, 'Clothing', '2021-10-14', 46, '2021-09-28', 'Skyba', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (47, 'Instant Coffee', 73152, 'Jewelry', '2022-02-09', 47, '2021-11-24', 'Realmix', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (48, 'Puree - Passion Fruit', 24289, 'Books', '2021-08-21', 48, '2021-05-12', 'Edgepulse', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (49, 'Yeast - Fresh, Fleischman', 77793, 'Clothing', '2021-07-01', 49, '2021-07-01', 'Twiyo', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (50, 'Tomato Puree', 33821, 'Health', '2021-07-29', 50, '2021-05-25', 'Vidoo', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (51, 'Squid Ink', 20270, 'Shoes', '2022-02-11', 51, '2021-09-21', 'Camimbo', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (52, 'Compound - Mocha', 90778, 'Jewelry', '2021-05-07', 52, '2021-03-26', 'Quire', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (53, 'Bar - Sweet And Salty Chocolate', 59672, 'Sports', '2021-07-27', 53, '2022-01-19', 'Meejo', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (54, 'Shrimp - Baby, Warm Water', 70202, 'Automotive', '2021-12-28', 54, '2021-08-13', 'Wordtune', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (55, 'Icecream - Dibs', 26780, 'Toys', '2022-01-28', 55, '2021-12-06', 'Skyvu', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (56, 'Truffle Cups - White Paper', 69490, 'Outdoors', '2021-12-20', 56, '2021-10-15', 'Katz', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (57, 'Island Oasis - Raspberry', 65041, 'Electronics', '2021-11-05', 57, '2021-07-23', 'Mycat', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (58, 'Monkfish Fresh - Skin Off', 90611, 'Automotive', '2021-08-07', 58, '2021-08-09', 'Mymm', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (59, 'Wine - Tio Pepe Sherry Fino', 38272, 'Books', '2021-12-28', 59, '2021-10-04', 'Rhyzio', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (60, 'Cilantro / Coriander - Fresh', 47102, 'Clothing', '2021-06-14', 60, '2021-05-14', 'Yabox', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (61, 'Chicken - Wieners', 40797, 'Computers', '2021-11-22', 61, '2021-11-15', 'Zava', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (62, 'Vinegar - Rice', 67178, 'Movies', '2022-03-05', 62, '2022-02-27', 'Skipstorm', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (63, 'Juice - Mango', 55154, 'Tools', '2021-07-31', 63, '2021-06-05', 'Innotype', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (64, 'Pork - Kidney', 93527, 'Beauty', '2022-01-18', 64, '2021-08-13', 'Skalith', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (65, 'Wine - Niagara Peninsula Vqa', 91506, 'Automotive', '2022-03-07', 65, '2021-09-30', 'Feedmix', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (66, 'Salmon - Smoked, Sliced', 96910, 'Computers', '2021-04-21', 66, '2022-02-28', 'Twitterbridge', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (67, 'Jameson Irish Whiskey', 63971, 'Shoes', '2021-10-26', 67, '2021-11-26', 'Leexo', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (68, 'Coffee - 10oz Cup 92961', 92190, 'Industrial', '2021-12-22', 68, '2022-02-23', 'Feedspan', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (69, 'Rabbit - Saddles', 8494, 'Toys', '2021-12-13', 69, '2021-09-05', 'Thoughtstorm', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (70, 'Cookie Dough - Oatmeal Rasin', 42589, 'Grocery', '2021-05-30', 70, '2021-05-06', 'Yakijo', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (71, 'Yokaline', 51076, 'Baby', '2021-05-03', 71, '2021-09-13', 'Realcube', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (72, 'Coconut - Shredded, Sweet', 95825, 'Kids', '2022-02-04', 72, '2022-01-09', 'Muxo', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (73, 'Sauce - Alfredo', 46570, 'Electronics', '2021-06-09', 73, '2021-12-21', 'Layo', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (74, 'Gatorade - Orange', 71543, 'Sports', '2022-01-25', 74, '2021-04-13', 'Gigabox', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (75, 'Tea - Orange Pekoe', 18757, 'Health', '2022-03-07', 75, '2021-06-19', 'Dynazzy', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (76, 'Juice - Prune', 54571, 'Industrial', '2021-06-08', 76, '2022-01-22', 'Lazzy', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (77, 'Beef - Montreal Smoked Brisket', 58825, 'Sports', '2021-11-13', 77, '2021-09-13', 'Jabberstorm', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (78, 'Wine - Port Late Bottled Vintage', 89905, 'Automotive', '2022-02-12', 78, '2021-04-25', 'Quire', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (79, 'Gatorade - Cool Blue Raspberry', 49075, 'Health', '2021-04-05', 79, '2021-07-06', 'Ooba', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (80, 'Cheese - Montery Jack', 47279, 'Kids', '2021-09-13', 80, '2021-10-27', 'DabZ', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (81, 'Bread - Kimel Stick Poly', 33169, 'Tools', '2021-05-10', 81, '2021-08-04', 'Yambee', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (82, 'Seabream Whole Farmed', 20525, 'Toys', '2021-08-01', 82, '2021-10-04', 'Vinder', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (83, 'Longos - Chicken Cordon Bleu', 90547, 'Computers', '2021-08-17', 83, '2021-05-15', 'Twimbo', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (84, 'Sauce - Cranberry', 95877, 'Home', '2021-10-27', 84, '2021-09-17', 'Meetz', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (85, 'Coffee - Frthy Coffee Crisp', 12677, 'Toys', '2021-11-30', 85, '2021-09-20', 'Rhyloo', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (86, 'Food Colouring - Orange', 7994, 'Books', '2021-04-12', 86, '2021-07-17', 'Quamba', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (87, 'Wine - Chardonnay Mondavi', 50675, 'Music', '2021-07-08', 87, '2022-01-26', 'Fivespan', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (88, 'Tomatoes - Plum, Canned', 22671, 'Electronics', '2021-08-31', 88, '2021-05-01', 'Twitterworks', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (89, 'Apple - Northern Spy', 78615, 'Beauty', '2022-01-18', 89, '2021-12-28', 'Divanoodle', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (90, 'Garbage Bag - Clear', 34719, 'Toys', '2021-06-10', 90, '2021-07-28', 'Katz', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (91, 'Ice Cream - Life Savers', 66310, 'Outdoors', '2021-06-13', 91, '2021-05-30', 'Abatz', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (92, 'Chef Hat 20cm', 59148, 'Outdoors', '2022-02-16', 92, '2021-03-21', 'Divavu', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (93, 'Soup - Campbells Beef Strogonoff', 74133, 'Movies', '2021-03-27', 93, '2022-01-19', 'Skibox', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (94, 'Mushroom - Trumpet, Dry', 71146, 'Electronics', '2022-01-23', 94, '2021-05-29', 'Flipbug', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (95, 'Garlic - Peeled', 21526, 'Electronics', '2021-10-18', 95, '2021-11-12', 'Zoomzone', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (96, 'Juice - V8 Splash', 91320, 'Automotive', '2021-07-15', 96, '2022-02-09', 'JumpXS', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (97, 'Spice - Onion Powder Granulated', 49835, 'Tools', '2021-08-31', 97, '2021-12-23', 'Npath', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (98, 'Lobster - Canned Premium', 50059, 'Jewelry', '2021-06-24', 98, '2021-07-08', 'Edgeblab', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (99, 'Pesto - Primerba, Paste', 71116, 'Automotive', '2022-03-04', 99, '2021-05-27', 'Tagpad', 1);
insert into mydb.product (id_product, name, price, category, arrival, batch, expiration, manufacturer, store_id_store) values (100, 'Lid - 16 Oz And 32 Oz', 59420, 'Toys', '2021-09-10', 100, '2021-04-17', 'Quaxo', 1);

-- provider_has_product

insert into mydb.provider_has_product (provider_id_provider, product_id_product) values (11, 56);
insert into mydb.provider_has_product (provider_id_provider, product_id_product) values (10, 53);
insert into mydb.provider_has_product (provider_id_provider, product_id_product) values (18, 41);
insert into mydb.provider_has_product (provider_id_provider, product_id_product) values (3, 35);
insert into mydb.provider_has_product (provider_id_provider, product_id_product) values (18, 100);

-- sale

insert into mydb.sale (id_sale, sale_time, client_id, client_document_type, salesman_id_salesman, is_deleted) values (1, '2022-01-09', 10000, 'CC', 1, 0);
insert into mydb.sale (id_sale, sale_time, client_id, client_document_type, salesman_id_salesman, is_deleted) values (2, '2022-01-30', 11111, 'CC', 1, 0);
insert into mydb.sale (id_sale, sale_time, client_id, client_document_type, salesman_id_salesman, is_deleted) values (3, '2022-02-10', 11111, 'CC', 1, 0);
insert into mydb.sale (id_sale, sale_time, client_id, client_document_type, salesman_id_salesman, is_deleted) values (4, '2021-04-25', 12222, 'CC', 1, 0);
insert into mydb.sale (id_sale, sale_time, client_id, client_document_type, salesman_id_salesman, is_deleted) values (5, '2021-08-18', 13333, 'CC', 1, 0);
insert into mydb.sale (id_sale, sale_time, client_id, client_document_type, salesman_id_salesman, is_deleted) values (6, '2021-05-22', 13333, 'CC', 1, 0);
insert into mydb.sale (id_sale, sale_time, client_id, client_document_type, salesman_id_salesman, is_deleted) values (7, '2021-07-30', 13333, 'CC', 1, 0);
insert into mydb.sale (id_sale, sale_time, client_id, client_document_type, salesman_id_salesman, is_deleted) values (8, '2021-07-07', 10000, 'CC', 1, 0);
insert into mydb.sale (id_sale, sale_time, client_id, client_document_type, salesman_id_salesman, is_deleted) values (9, '2022-01-21', 14444, 'CC', 1, 0);
insert into mydb.sale (id_sale, sale_time, client_id, client_document_type, salesman_id_salesman, is_deleted) values (10, '2022-01-21', 12222, 'CC', 1, 0);
insert into mydb.sale (id_sale, sale_time, client_id, client_document_type, salesman_id_salesman, is_deleted) values (11, '2021-11-16', 13333, 'CC', 1, 0);
insert into mydb.sale (id_sale, sale_time, client_id, client_document_type, salesman_id_salesman, is_deleted) values (12, '2021-07-16', 14444, 'CC', 1, 0);
insert into mydb.sale (id_sale, sale_time, client_id, client_document_type, salesman_id_salesman, is_deleted) values (13, '2021-11-20', 10000, 'CC', 1, 0);
insert into mydb.sale (id_sale, sale_time, client_id, client_document_type, salesman_id_salesman, is_deleted) values (14, '2021-08-14', 10000, 'CC', 1, 0);
insert into mydb.sale (id_sale, sale_time, client_id, client_document_type, salesman_id_salesman, is_deleted) values (15, '2022-01-09', 10000, 'CC', 1, 0);
insert into mydb.sale (id_sale, sale_time, client_id, client_document_type, salesman_id_salesman, is_deleted) values (16, '2021-09-15', 10000, 'CC', 1, 0);
insert into mydb.sale (id_sale, sale_time, client_id, client_document_type, salesman_id_salesman, is_deleted) values (17, '2021-05-17', 14444, 'CC', 1, 0);
insert into mydb.sale (id_sale, sale_time, client_id, client_document_type, salesman_id_salesman, is_deleted) values (18, '2021-05-26', 14444, 'CC', 1, 0);
insert into mydb.sale (id_sale, sale_time, client_id, client_document_type, salesman_id_salesman, is_deleted) values (19, '2022-01-06', 14444, 'CC', 1, 0);
insert into mydb.sale (id_sale, sale_time, client_id, client_document_type, salesman_id_salesman, is_deleted) values (20, '2021-11-24', 14444, 'CC', 1, 0);


-- sale_has_product

insert into mydb.sale_has_product (sale_id_sale, product_id_product) values (8, 96);
insert into mydb.sale_has_product (sale_id_sale, product_id_product) values (10, 59);
insert into mydb.sale_has_product (sale_id_sale, product_id_product) values (17, 87);
insert into mydb.sale_has_product (sale_id_sale, product_id_product) values (19, 1);
insert into mydb.sale_has_product (sale_id_sale, product_id_product) values (5, 17);
insert into mydb.sale_has_product (sale_id_sale, product_id_product) values (12, 11);
insert into mydb.sale_has_product (sale_id_sale, product_id_product) values (2, 35);
insert into mydb.sale_has_product (sale_id_sale, product_id_product) values (3, 99);
insert into mydb.sale_has_product (sale_id_sale, product_id_product) values (9, 67);
insert into mydb.sale_has_product (sale_id_sale, product_id_product) values (15, 11);
insert into mydb.sale_has_product (sale_id_sale, product_id_product) values (11, 41);
insert into mydb.sale_has_product (sale_id_sale, product_id_product) values (5, 10);
insert into mydb.sale_has_product (sale_id_sale, product_id_product) values (5, 86);
insert into mydb.sale_has_product (sale_id_sale, product_id_product) values (13, 18);
insert into mydb.sale_has_product (sale_id_sale, product_id_product) values (14, 57);
insert into mydb.sale_has_product (sale_id_sale, product_id_product) values (8, 91);
insert into mydb.sale_has_product (sale_id_sale, product_id_product) values (14, 38);
insert into mydb.sale_has_product (sale_id_sale, product_id_product) values (6, 85);
insert into mydb.sale_has_product (sale_id_sale, product_id_product) values (6, 24);
insert into mydb.sale_has_product (sale_id_sale, product_id_product) values (4, 21);

-- -----------------------------------------------------
-- Querying the data
-- -----------------------------------------------------

-- logical delete

UPDATE mydb.sale
SET
is_deleted = 1
WHERE id_sale < 5;

UPDATE mydb.sale
SET
is_deleted = 1
WHERE id_sale >= 17;


-- physical delete

DELETE FROM mydb.sale
WHERE is_deleted = 1 AND id_sale < 19 AND id_sale > 17;

-- update provider and name
UPDATE mydb.product
SET
name = 'rebranded product'
WHERE id_product < 4;

UPDATE mydb.provider_has_product
SET
provider_id_provider = 1 -- default provider
WHERE provider_id_provider IN (select id_product from mydb.product where id_product < 4);