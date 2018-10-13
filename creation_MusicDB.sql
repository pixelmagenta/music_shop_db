drop database if exists MusicDB;
create DATABASE MusicDB;
USE MusicDB;

CREATE TABLE Author
(
author_id INTEGER NOT NULL,
author_name CHAR(18) NULL,
author_surname CHAR(18) NOT NULL,
author_birthdate DATE NULL,
author_deathdate DATE NULL
);

ALTER TABLE Author
ADD CONSTRAINT XPKAuthor PRIMARY KEY (author_id);

CREATE TABLE Collection
(
collection_id INTEGER NOT NULL,
collection_name CHAR(18) NOT NULL,
page_quantity INTEGER NULL
);

ALTER TABLE Collection
ADD CONSTRAINT XPKCollection PRIMARY KEY (collection_id);

CREATE TABLE Composition
(
composition_id INTEGER NOT NULL,
composition_name CHAR(50) NULL,
genre_id INTEGER NOT NULL,
author_id INTEGER NOT NULL
);

ALTER TABLE Composition
ADD CONSTRAINT XPKComposition PRIMARY KEY (composition_id);

CREATE TABLE Genre
(
genre_id INTEGER NOT NULL,
genre_name CHAR(18) NOT NULL
);

ALTER TABLE Genre
ADD CONSTRAINT XPKGenre PRIMARY KEY (genre_id);

CREATE TABLE Genre_description
(
collection_id INTEGER NOT NULL,
genre_id INTEGER NOT NULL
);

ALTER TABLE Genre_description
ADD CONSTRAINT XPKGenre_description PRIMARY KEY (genre_id,collection_id);

CREATE TABLE Note_of_presence
(
quantity INTEGER NULL,
price NUMERIC(10,2) NULL,
collection_id INTEGER NOT NULL,
shop_id INTEGER NOT NULL
);

ALTER TABLE Note_of_presence
ADD CONSTRAINT XPKNote_of_presence PRIMARY KEY (shop_id,collection_id);

CREATE TABLE Record_of_contents
(
page_num INTEGER NULL,
composition_id INTEGER NOT NULL,
collection_id INTEGER NOT NULL
);

ALTER TABLE Record_of_contents
ADD CONSTRAINT XPKRecord_of_contents PRIMARY KEY (composition_id,collection_id);

CREATE TABLE Shop
(
shop_id INTEGER NOT NULL,
shop_name CHAR(50) NULL,
address CHAR(100) NULL
);

ALTER TABLE Shop
ADD CONSTRAINT XPKShop PRIMARY KEY (shop_id);

ALTER TABLE Composition
ADD CONSTRAINT belongs_to FOREIGN KEY (genre_id) REFERENCES Genre (genre_id);

ALTER TABLE Composition
ADD CONSTRAINT wrote FOREIGN KEY (author_id) REFERENCES Author (author_id);

ALTER TABLE Genre_description
ADD CONSTRAINT containing FOREIGN KEY (collection_id) REFERENCES Collection (collection_id);

ALTER TABLE Genre_description
ADD CONSTRAINT is_included_in FOREIGN KEY (genre_id) REFERENCES Genre (genre_id);

ALTER TABLE Note_of_presence
ADD CONSTRAINT associates_with FOREIGN KEY (collection_id) REFERENCES Collection (collection_id);

ALTER TABLE Note_of_presence
ADD CONSTRAINT has FOREIGN KEY (shop_id) REFERENCES Shop (shop_id);

ALTER TABLE Record_of_contents
ADD CONSTRAINT is_included FOREIGN KEY (composition_id) REFERENCES Composition (composition_id);

ALTER TABLE Record_of_contents
ADD CONSTRAINT is_containing FOREIGN KEY (collection_id) REFERENCES Collection (collection_id);

