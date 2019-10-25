drop database if exists music_shop;
create database music_shop;
use music_shop;

CREATE TABLE Author 
( 
author_id INTEGER NOT NULL, 
author_name CHAR(18) NULL, 
author_surname CHAR(50) NOT NULL, 
author_birthdate DATE NULL, 
author_deathdate DATE NULL 
); 

ALTER TABLE Author 
ADD CONSTRAINT XPKAuthor PRIMARY KEY (author_id); 

CREATE TABLE Collection 
( 
collection_id INTEGER NOT NULL, 
collection_name CHAR(50) NOT NULL, 
page_quantity INTEGER NULL
); 

ALTER TABLE Collection 
ADD CONSTRAINT XPKCollection PRIMARY KEY (collection_id); 

CREATE TABLE Composition 
( 
composition_id INTEGER NOT NULL AUTO_INCREMENT, 
composition_name CHAR(50) NULL, 
genre_id INTEGER NOT NULL, 
author_id INTEGER NOT NULL,
PRIMARY KEY (composition_id)
);

CREATE TABLE Genre 
( 
genre_id INTEGER NOT NULL, 
genre_name CHAR(50) NOT NULL 
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
ADD CONSTRAINT contain FOREIGN KEY (collection_id) REFERENCES Collection (collection_id); 

ALTER TABLE Genre_description 
ADD CONSTRAINT is_included_in FOREIGN KEY (genre_id) REFERENCES Genre (genre_id); 

ALTER TABLE Note_of_presence 
ADD CONSTRAINT associates_with FOREIGN KEY (collection_id) REFERENCES Collection (collection_id); 

ALTER TABLE Note_of_presence 
ADD CONSTRAINT has FOREIGN KEY (shop_id) REFERENCES Shop (shop_id); 

ALTER TABLE Record_of_contents 
ADD CONSTRAINT is_included FOREIGN KEY (composition_id) REFERENCES Composition (composition_id); 

ALTER TABLE Record_of_contents 
ADD CONSTRAINT containing FOREIGN KEY (collection_id) REFERENCES Collection (collection_id);



INSERT INTO Shop (shop_id, shop_name, address) VALUES (1, "Вдохновение", "ул. Воронцовская, д. 17");
INSERT INTO Shop (shop_id, shop_name, address) VALUES (2, "Сокровища Эвтерпы", "пер. Успенский, д. 7");
INSERT INTO Shop (shop_id, shop_name, address) VALUES (3, "Нотный магазин", "ул. Савельева, д. 5");

INSERT INTO Genre (genre_id, genre_name) VALUES (1, "Концерты");
INSERT INTO Genre (genre_id, genre_name) VALUES (2, "Симфонии");
INSERT INTO Genre (genre_id, genre_name) VALUES (3, "Сонаты");
INSERT INTO Genre (genre_id, genre_name) VALUES (4, "Оперы");
INSERT INTO Genre (genre_id, genre_name) VALUES (5, "Вальсы");
INSERT INTO Genre (genre_id, genre_name) VALUES (6, "Классическая музыка");
INSERT INTO Genre (genre_id, genre_name) VALUES (7, "Полонезы");
INSERT INTO Genre (genre_id, genre_name) VALUES (8, "Танго");
INSERT INTO Genre (genre_id, genre_name) VALUES (9, "Этюды");
INSERT INTO Genre (genre_id, genre_name) VALUES (10, "Рок");
INSERT INTO Genre (genre_id, genre_name) VALUES (11, "Романсы");
INSERT INTO Genre (genre_id, genre_name) VALUES (12, "Блюз");
INSERT INTO Genre (genre_id, genre_name) VALUES (13, "Джаз");
INSERT INTO Genre (genre_id, genre_name) VALUES (14, "Поп-музыка");
INSERT INTO Genre (genre_id, genre_name) VALUES (15, "Саундтреки");
INSERT INTO Genre (genre_id, genre_name) VALUES (16, "Народная музыка");
INSERT INTO Genre (genre_id, genre_name) VALUES (17, "Прелюдии");
INSERT INTO Genre (genre_id, genre_name) VALUES (18, "Балет");


INSERT INTO Author (author_id, author_name, author_surname, author_birthdate, author_deathdate) VALUES (1, "Пётр", "Чайковский", "1840-04-25", "1893-10-16");
INSERT INTO Author (author_id, author_name, author_surname, author_birthdate, author_deathdate) VALUES (2, "Модест", "Мусоргский", "1839-03-09", "1881-03-16");
INSERT INTO Author (author_id, author_name, author_surname, author_birthdate, author_deathdate) VALUES (3, "Джордж", "Гершвин", "1898-09-26", "1937-07-11");
INSERT INTO Author (author_id, author_surname, author_birthdate) VALUES (4, "Юрима", "1978-02-15");
INSERT INTO Author (author_id, author_name, author_surname, author_birthdate, author_deathdate) VALUES (5, "Доменико", "Скарлатти", "1685-10-26", "1757-07-23");
INSERT INTO Author (author_id, author_name, author_surname, author_birthdate, author_deathdate) VALUES (6, "Джон", "Леннон", "1940-10-09", "1980-12-08");
INSERT INTO Author (author_id, author_name, author_surname, author_birthdate, author_deathdate) VALUES (7, "Жорж", "Бизе", "1838-10-25", "1875-08-03");
INSERT INTO Author (author_id, author_name, author_surname, author_birthdate, author_deathdate) VALUES (8, "Сергей", "Рахманинов", "1873-03-20", "1943-03-28");
INSERT INTO Author (author_id, author_name, author_surname, author_birthdate) VALUES (9, "Александра", "Пахмутова", "1929-11-09");
INSERT INTO Author (author_id, author_name, author_surname, author_birthdate, author_deathdate) VALUES (10, "Дюк", "Эллингтон", "1899-04-29", "1974-05-24");
INSERT INTO Author (author_id, author_name, author_surname, author_birthdate, author_deathdate) VALUES (11, "Сергей", "Прокофьев", "1891-04-11", "1953-03-05");
INSERT INTO Author (author_id, author_name, author_surname, author_birthdate, author_deathdate) VALUES (12, "Георгий", "Свиридов", "1915-12-03", "1998-01-06");
INSERT INTO Author (author_id, author_name, author_surname, author_birthdate, author_deathdate) VALUES (13, "Астор", "Пьяццолла", "1921-03-11", "1992-07-04");
INSERT INTO Author (author_id, author_name, author_surname, author_birthdate, author_deathdate) VALUES (14, "Чарли", "Чаплин", "1889-04-16", "1977-12-25");


INSERT INTO Composition (composition_id, composition_name, genre_id, author_id) VALUES (1, "Хабанера из оперы \"Кармен\"", 4, 7);
INSERT INTO Composition (composition_id, composition_name, genre_id, author_id) VALUES (2, "Увертюра из оперы \"Кармен\"", 4, 7);
INSERT INTO Composition (composition_id, composition_name, genre_id, author_id) VALUES (3, "Summertime", 4, 3);
INSERT INTO Composition (composition_id, composition_name, genre_id, author_id) VALUES (4, "Рапсодия в стиле блюз", 12, 3);
INSERT INTO Composition (composition_id, composition_name, genre_id, author_id) VALUES (5, "Yesterday", 14, 6);
INSERT INTO Composition (composition_id, composition_name, genre_id, author_id) VALUES (6, "Let it be", 14, 6);
INSERT INTO Composition (composition_id, composition_name, genre_id, author_id) VALUES (7, "Hey, Jude", 14, 6);
INSERT INTO Composition (composition_id, composition_name, genre_id, author_id) VALUES (8, "Girl", 14, 6);
INSERT INTO Composition (composition_id, composition_name, genre_id, author_id) VALUES (9, "Imagine", 14, 6);
INSERT INTO Composition (composition_id, composition_name, genre_id, author_id) VALUES (10, "Can't buy me love", 14, 6);
INSERT INTO Composition (composition_id, composition_name, genre_id, author_id) VALUES (11, "River flows in you", 15, 4);
INSERT INTO Composition (composition_id, composition_name, genre_id, author_id) VALUES (12, "It don't mean a thing", 13, 10);
INSERT INTO Composition (composition_id, composition_name, genre_id, author_id) VALUES (13, "Концерт №2 для фортепиано с оркестром", 1, 8);
INSERT INTO Composition (composition_id, composition_name, genre_id, author_id) VALUES (14, "Прелюдия G-moll", 17, 8);
INSERT INTO Composition (composition_id, composition_name, genre_id, author_id) VALUES (15, "Прелюдия Cis-moll", 17, 8);
INSERT INTO Composition (composition_id, composition_name, genre_id, author_id) VALUES (16, "Монтекки и Капулетти", 18, 11 );
INSERT INTO Composition (composition_id, composition_name, genre_id, author_id) VALUES (17, "Вальс из оперы \"Война и Мир\"", 5, 11);
INSERT INTO Composition (composition_id, composition_name, genre_id, author_id) VALUES (18, "Вальс из сюиты \"Метель\"", 5, 12);
INSERT INTO Composition (composition_id, composition_name, genre_id, author_id) VALUES (19, "Libertango", 8, 13);
INSERT INTO Composition (composition_id, composition_name, genre_id, author_id) VALUES (20, "Oblivion", 8, 13);
INSERT INTO Composition (composition_id, composition_name, genre_id, author_id) VALUES (21, "Вальс цветов из балета \"Щелкунчик\"", 5, 1);
INSERT INTO Composition (composition_id, composition_name, genre_id, author_id) VALUES (22, "Большой вальс из оперы \"Евгений Онегин\"", 5, 1);
INSERT INTO Composition (composition_id, composition_name, genre_id, author_id) VALUES (23, "Ария Ленского из оперы \"Евгений Онегин\"", 4, 1);


INSERT INTO Collection (collection_id, collection_name, page_quantity) VALUES (1, "The Beatles. Любимые хиты", 12);
INSERT INTO Collection (collection_id, collection_name, page_quantity) VALUES (2, "Любимые вальсы", 87);
INSERT INTO Collection (collection_id, collection_name, page_quantity) VALUES (3, "Фрагменты из опер", 92);
INSERT INTO Collection (collection_id, collection_name, page_quantity) VALUES (4, "Концерты для фортепиано", 100);
INSERT INTO Collection (collection_id, collection_name, page_quantity) VALUES (5, "С.А.Рахманинов", 100);
INSERT INTO Collection (collection_id, collection_name, page_quantity) VALUES (6, "Лучшая музыка из кино", 60);
INSERT INTO Collection (collection_id, collection_name, page_quantity) VALUES (7, "О, Танго!", 50);
INSERT INTO Collection (collection_id, collection_name, page_quantity) VALUES (8, "Американская классика. Джордж Гершвин.", 1000);


INSERT INTO Record_of_contents (page_num, composition_id, collection_id) VALUES (1, 5, 1);
INSERT INTO Record_of_contents (page_num, composition_id, collection_id) VALUES (3, 6, 1);
INSERT INTO Record_of_contents (page_num, composition_id, collection_id) VALUES (5, 7, 1);
INSERT INTO Record_of_contents (page_num, composition_id, collection_id) VALUES (7, 8, 1);
INSERT INTO Record_of_contents (page_num, composition_id, collection_id) VALUES (9, 9, 1);
INSERT INTO Record_of_contents (page_num, composition_id, collection_id) VALUES (10, 10, 1);

INSERT INTO Record_of_contents (page_num, composition_id, collection_id) VALUES (1, 17, 2);
INSERT INTO Record_of_contents (page_num, composition_id, collection_id) VALUES (4, 18, 2);
INSERT INTO Record_of_contents (page_num, composition_id, collection_id) VALUES (7, 21, 2);
INSERT INTO Record_of_contents (page_num, composition_id, collection_id) VALUES (15, 22, 2);

INSERT INTO Record_of_contents (page_num, composition_id, collection_id) VALUES (1, 1, 3);
INSERT INTO Record_of_contents (page_num, composition_id, collection_id) VALUES (5, 2, 3);
INSERT INTO Record_of_contents (page_num, composition_id, collection_id) VALUES (10, 23, 3);

INSERT INTO Record_of_contents (page_num, composition_id, collection_id) VALUES (1, 13, 4);

INSERT INTO Record_of_contents (page_num, composition_id, collection_id) VALUES (1, 14, 5);
INSERT INTO Record_of_contents (page_num, composition_id, collection_id) VALUES (3, 15, 5);

INSERT INTO Record_of_contents (page_num, composition_id, collection_id) VALUES (1, 11, 6);

INSERT INTO Record_of_contents (page_num, composition_id, collection_id) VALUES (1, 20, 7);
INSERT INTO Record_of_contents (page_num, composition_id, collection_id) VALUES (3, 19, 7);

INSERT INTO Record_of_contents (page_num, composition_id, collection_id) VALUES (1, 4, 8);
INSERT INTO Record_of_contents (page_num, composition_id, collection_id) VALUES (3, 3, 8);


INSERT INTO Genre_description (collection_id, genre_id) VALUES (1, 14);
INSERT INTO Genre_description (collection_id, genre_id) VALUES (2, 5);
INSERT INTO Genre_description (collection_id, genre_id) VALUES (2, 6);
INSERT INTO Genre_description (collection_id, genre_id) VALUES (2, 18);
INSERT INTO Genre_description (collection_id, genre_id) VALUES (3, 4);
INSERT INTO Genre_description (collection_id, genre_id) VALUES (3, 6);
INSERT INTO Genre_description (collection_id, genre_id) VALUES (4, 1);
INSERT INTO Genre_description (collection_id, genre_id) VALUES (4, 6);
INSERT INTO Genre_description (collection_id, genre_id) VALUES (5, 17);
INSERT INTO Genre_description (collection_id, genre_id) VALUES (5, 6);
INSERT INTO Genre_description (collection_id, genre_id) VALUES (6, 15);
INSERT INTO Genre_description (collection_id, genre_id) VALUES (7, 8);
INSERT INTO Genre_description (collection_id, genre_id) VALUES (8, 12);
INSERT INTO Genre_description (collection_id, genre_id) VALUES (8, 13);
INSERT INTO Genre_description (collection_id, genre_id) VALUES (8, 4);


INSERT INTO Note_of_presence (collection_id, quantity, price, shop_id) VALUES (1, 5, 550, 1);
INSERT INTO Note_of_presence (collection_id, quantity, price, shop_id) VALUES (1, 1, 400, 3);
INSERT INTO Note_of_presence (collection_id, quantity, price, shop_id) VALUES (2, 7, 180, 3);
INSERT INTO Note_of_presence (collection_id, quantity, price, shop_id) VALUES (2, 3, 420.50, 1);
INSERT INTO Note_of_presence (collection_id, quantity, price, shop_id) VALUES (2, 1, 250, 2);
INSERT INTO Note_of_presence (collection_id, quantity, price, shop_id) VALUES (3, 2, 700, 2);
INSERT INTO Note_of_presence (collection_id, quantity, price, shop_id) VALUES (4, 10, 610, 1);
INSERT INTO Note_of_presence (collection_id, quantity, price, shop_id) VALUES (4, 3, 570, 2);
INSERT INTO Note_of_presence (collection_id, quantity, price, shop_id) VALUES (4, 1, 649.99, 3);
INSERT INTO Note_of_presence (collection_id, quantity, price, shop_id) VALUES (5, 8, 920, 1);
INSERT INTO Note_of_presence (collection_id, quantity, price, shop_id) VALUES (5, 5, 735, 2);
INSERT INTO Note_of_presence (collection_id, quantity, price, shop_id) VALUES (5, 2, 469, 3);
INSERT INTO Note_of_presence (collection_id, quantity, price, shop_id) VALUES (6, 1, 660, 3);
INSERT INTO Note_of_presence (collection_id, quantity, price, shop_id) VALUES (6, 3, 890, 1);
INSERT INTO Note_of_presence (collection_id, quantity, price, shop_id) VALUES (6, 4, 600, 2);
INSERT INTO Note_of_presence (collection_id, quantity, price, shop_id) VALUES (7, 2, 780, 2);
INSERT INTO Note_of_presence (collection_id, quantity, price, shop_id) VALUES (7, 5, 850, 1);
INSERT INTO Note_of_presence (collection_id, quantity, price, shop_id) VALUES (7, 6, 995, 3);
INSERT INTO Note_of_presence (collection_id, quantity, price, shop_id) VALUES (8, 7, 625, 1);
INSERT INTO Note_of_presence (collection_id, quantity, price, shop_id) VALUES (8, 3, 750, 2);
INSERT INTO Note_of_presence (collection_id, quantity, price, shop_id) VALUES (8, 1, 720.50, 3);