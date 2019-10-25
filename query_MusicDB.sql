use music_shop;

#1 Вывести все названия сборников, которые есть в наличии в магазине Вдохновение
select collection_name 
from ((Note_of_presence inner join Collection on Note_of_presence.collection_id = Collection.collection_id) 
inner join Shop on Note_of_presence.shop_id = Shop.shop_id)
where shop_name = "Вдохновение"

#2 Вывести все названия сборников дешевле 500 рублей и название магазина
select Collection.collection_name, Note_of_presence.price, Shop.shop_name
from ((Note_of_presence inner join Collection on Note_of_presence.collection_id = Collection.collection_id) 
inner join Shop on Note_of_presence.shop_id = Shop.shop_id)
where Note_of_presence.price <=500

#3 Вывести все названия сборников, где есть Чайковский
select Collection.collection_name
from ((Record_of_contents inner join Composition on Record_of_contents.composition_id = Composition.composition_id)
inner join Collection on Collection.collection_id = Record_of_contents.collection_id) 
inner join Author on Composition.author_id = Author.author_id
where Author.author_surname = "Чайковский"
group by collection_name

#4 Вывести все названия джазовых или блюзовых сборников, которые продаются в магазине Сокровища Эвтерпы
select Collection.collection_name
from (((Note_of_presence inner join Shop on Note_of_presence.shop_id = Shop.shop_id) 
inner join Collection on Note_of_presence.collection_id = Collection.collection_id)
inner join Genre_description on Collection.collection_id = Genre_description.collection_id)
inner join Genre on Genre_description.genre_id = Genre.genre_id
where genre_name = "Джаз" or genre_name = "Блюз"
group by collection_name

#5 Вывести среднюю стоимость сборника "Любимые вальсы"
select avg(price)
from Note_of_presence inner join Collection on Note_of_presence.collection_id = Collection.collection_id
where Collection.collection_name = "Любимые вальсы"

#6 Вывести сборники жанра Танго, их цену и имя и адрес магазина
select Collection.collection_name, Note_of_presence.price, Shop.shop_name, Shop.address
from Genre
inner join Genre_description on Genre.genre_id = Genre_description.genre_id
inner join Collection on Genre_description.collection_id = Collection.collection_id
inner join Note_of_presence on Collection.collection_id = Note_of_presence.collection_id
inner join Shop on Note_of_presence.shop_id = Shop.shop_id
where Genre.genre_name = "Танго"

#7 Вывести все сборники, содержащие произведения Свиридова, их цену, имя и адрес магазина
select Collection.collection_name, Note_of_presence.price, Shop.shop_name, Shop.address
from Author
inner join Composition on Author.author_id = Composition.author_id
inner join Record_of_contents on Composition.composition_id = Record_of_contents.composition_id
inner join Collection on Record_of_contents.collection_id = Collection.collection_id
inner join Note_of_presence on Collection.collection_id = Note_of_presence.collection_id
inner join Shop on Note_of_presence.shop_id = Shop.shop_id
where Author.author_surname = "Свиридов"
group by Shop.shop_id

#8 Вывести все сборники, в магазине Вдохновение их цену и жанры
select Collection.collection_name, Note_of_presence.price, group_concat(Genre.genre_name separator ', '), Shop.address
from Shop
inner join Note_of_presence on Shop.shop_id = Note_of_presence.shop_id
inner join Collection on Note_of_presence.collection_id = Collection.collection_id
inner join Genre_description on Collection.collection_id = Genre_description.collection_id
inner join Genre on Genre_description.genre_id = Genre.genre_id
where Shop.shop_name = "Вдохновение"
group by Collection.collection_id

#9 Вывести содержание сборника "Любимые вальсы"
select Composition.composition_name, Record_of_contents.page_num
from Collection
inner join Record_of_contents on Record_of_contents.collection_id = Collection.collection_id
inner join Composition on Composition.composition_id = Record_of_contents.composition_id
where Collection.collection_name = "Любимые вальсы"

#10 Вывести полную информацию о сборнике в магазине "Нотный магазин"
select Collection.collection_name, Note_of_presence.price, group_concat(Genre.genre_name separator ', ')
from Shop
inner join Note_of_presence on Shop.shop_id = Note_of_presence.shop_id
inner join Collection on Note_of_presence.collection_id = Collection.collection_id
inner join Genre_description on Collection.collection_id = Genre_description.collection_id
inner join Genre on Genre_description.genre_id = Genre.genre_id
where Shop.shop_name = "Нотный магазин"
group by Collection.collection_id

#11 Вывести самый дешевый сборник в каждом магазине
select Collection.collection_name, Note_of_presence.price, Shop.shop_name
from (Note_of_presence inner join Shop on Note_of_presence.shop_id = Shop.shop_id)
inner join Collection on Note_of_presence.collection_id = Collection.collection_id
where Note_of_presence.price in 
(select min(Note_of_presence.price)
from Note_of_presence
group by Note_of_presence.shop_id)

#12 Вывести всех композиторов сборника "Фрагменты из опер"
select Author.author_name, Author.author_surname
from ((Record_of_contents inner join Collection on Record_of_contents.collection_id = Collection.collection_id)
inner join Composition on Record_of_contents.composition_id = Composition.composition_id)
inner join Author on Composition.author_id = Author.author_id
where Collection.collection_name = "Фрагменты из опер"
group by Author.author_name, Author.author_surname

#13 Изменить цену "Американская классика. Джордж Гершвин." в магазине Сокровища Эвтерпы на 699.90
update Note_of_presence
set Note_of_presence.price = 699.90
where Note_of_presence.collection_id in (select Collection.collection_id
from Collection where Collection.collection_name = "Американская классика. Джордж Гершвин.")
and Note_of_presence.shop_id in (select Shop.shop_id 
from Shop where Shop.shop_name = "Сокровища Эвтерпы")

#14 Изменить количество сборника "С.А.Рахманинов" в Нотном магазине
update Note_of_presence
set Note_of_presence.quantity = 1
where Note_of_presence.collection_id in (select Collection.collection_id
from Collection where Collection.collection_name = "С.А.Рахманинов")
and Note_of_presence.shop_id in (select Shop.shop_id 
from Shop where Shop.shop_name = "Нотный магазин")

#15 Изменить автора "Прелюдии Cis-moll" на Сергея Прокофьева
update Composition
set Composition.author_id = (select author_id from Author
where Author.author_name = "Сергей" and Author.author_surname = "Прокофьев")
where Composition.composition_name = "Прелюдия Cis-moll"

#16 Удалить из базы авторов Чарли Чаплина 
delete from Author
where author_name = "Чарли"
and author_surname = "Чаплин"

#17 Удалить из Нотного магазина сборник "Американская классика. Джордж Гершвин."
delete from Note_of_presence
where Note_of_presence.collection_id = (select collection_id from Collection
where collection_name = "Американская классика. Джордж Гершвин.")
and Note_of_presence.shop_id = (select shop_id from Shop
where shop_name = "Нотный магазин")