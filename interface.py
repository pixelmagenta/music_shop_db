from flask import Flask, render_template, request
from sqlalchemy import create_engine

eng = create_engine('mysql+pymysql://user:1234@localhost/music_shop')
app = Flask(__name__)

COMMANDS = [
    {
        'name': 'Жанр',
        'sql': """select Collection.collection_id, Collection.collection_name, Note_of_presence.price, Note_of_presence.quantity, Shop.shop_name, Shop.address
                    from Genre
                    inner join Genre_description on Genre.genre_id = Genre_description.genre_id
                    inner join Collection on Genre_description.collection_id = Collection.collection_id
                    inner join Note_of_presence on Collection.collection_id = Note_of_presence.collection_id
                    inner join Shop on Note_of_presence.shop_id = Shop.shop_id
                    where Genre.genre_name = %s"""
    },
    {
        'name': 'Композитор',
        'sql': """select Collection.collection_id, Collection.collection_name, Note_of_presence.price, Note_of_presence.quantity, Shop.shop_name, Shop.address
                    from Author
                    inner join Composition on Author.author_id = Composition.author_id
                    inner join Record_of_contents on Composition.composition_id = Record_of_contents.composition_id
                    inner join Collection on Record_of_contents.collection_id = Collection.collection_id
                    inner join Note_of_presence on Collection.collection_id = Note_of_presence.collection_id
                    inner join Shop on Note_of_presence.shop_id = Shop.shop_id
                    where Author.author_surname = %s
                    group by Shop.shop_id"""
    },
    {
        'name': 'Магазин',
        'sql': """select Collection.collection_id, Collection.collection_name, Note_of_presence.price, Note_of_presence.quantity, group_concat(Genre.genre_name separator ', '), Shop.address
                    from Shop
                    inner join Note_of_presence on Shop.shop_id = Note_of_presence.shop_id
                    inner join Collection on Note_of_presence.collection_id = Collection.collection_id
                    inner join Genre_description on Collection.collection_id = Genre_description.collection_id
                    inner join Genre on Genre_description.genre_id = Genre.genre_id
                    where Shop.shop_name = %s
                    group by Collection.collection_id"""
    }
]

@app.route('/')
def index():
    with eng.connect() as con:
        rs = con.execute("""
            select genre_name
            from Genre
            order by genre_name""")
        genres = rs.fetchall()
        rs = con.execute("""
            select Author.author_name, Author.author_surname
            from Author
            order by author_surname""")
        authors = rs.fetchall()
        rs = con.execute("""
            select Shop.shop_name, Shop.address
            from Shop""")
        shops = rs.fetchall()
    return render_template('index.html', genres=genres, authors=authors, shops=shops, cmd_id=0, cmds=COMMANDS)

@app.route('/collection/search/<int:cmd_id>')
def search(cmd_id):
    query = request.args.get('query', '')
    cmd = COMMANDS[cmd_id]

    if not cmd:
        return "no such cmd"

    data = []
    if query != '':
        sql = cmd['sql']
        with eng.connect() as con:
            rs = con.execute(sql, (query,))
            data = rs.fetchall()

    return render_template('collection.html', data=data, query=query, cmd_id=cmd_id, cmds=COMMANDS)

@app.route('/collection/<int:id>')
def collection(id):
    with eng.connect() as con:
        rs = con.execute("""
            select Composition.composition_name, Author.author_name, Author.author_surname, Record_of_contents.page_num
            from Collection
            inner join Record_of_contents on Record_of_contents.collection_id = Collection.collection_id
            inner join Composition on Composition.composition_id = Record_of_contents.composition_id
            inner join Author on Author.author_id = Composition.author_id
            where Collection.collection_id = %s
            order by Record_of_contents.page_num""", (id,))
        data = rs.fetchall()
        rs = con.execute("""
            select Collection.collection_name, group_concat(Genre.genre_name separator ', ')
            from Collection
            inner join Genre_description on Collection.collection_id = Genre_description.collection_id
            inner join Genre on Genre_description.genre_id = Genre.genre_id
            where Collection.collection_id = %s
            group by Collection.collection_id""", (id,))
        collection_name, genres = rs.fetchone()
    return render_template('content.html', data=data, collection_name = collection_name, genres = genres)

@app.route('/genres')
def genres():
    with eng.connect() as con:
        rs = con.execute("""
            select Genre.genre_id, Genre.genre_name
            from Genre""")
        genres = rs.fetchall()
    return render_template('genres.html', genres=genres)

@app.route('/genre/edit/<int:id>', methods=['GET', 'POST'])
def edit_genres(id):
    success = False
    if request.method == 'GET':
        with eng.connect() as con:
            rs = con.execute("""
                select Genre.genre_name
                from Genre
                where Genre.genre_id = %s""", (id,))
            (name,) = rs.fetchone()
    else:
        name = request.form['name']
        with eng.connect() as con:
            rs = con.execute("""
                update Genre
                set Genre.genre_name = %s
                where Genre.genre_id = %s""", (name, id))
        success = True
    return render_template('edit_genre.html', id=id, name=name, success=success)


@app.route('/authors')
def authors():
    with eng.connect() as con:
        rs = con.execute("""
            select Author.author_id, Author.author_name, Author.author_surname
            from Author""")
        authors = rs.fetchall()
    return render_template('authors.html', authors=authors)

@app.route('/author/edit/<int:id>', methods=['GET', 'POST'])
def edit_authors(id):
    success = False
    if request.method == 'GET':
        with eng.connect() as con:
            rs = con.execute("""
                select Author.author_name, Author.author_surname, Author.author_birthdate, Author.author_deathdate
                from Author
                where Author.author_id = %s""", (id,))
            name, surname, birthdate, deathdate = rs.fetchone()
    else:
        name = request.form['name']
        surname = request.form['surname']
        birthdate = request.form['birthdate']
        deathdate = request.form['deathdate']
        with eng.connect() as con:
            rs = con.execute("""
                update Author
                set Author.author_name = %s,
                    Author.author_surname = %s,
                    Author.author_birthdate = %s,
                    Author.author_deathdate = %s
                where Author.author_id = %s""", (name, surname, birthdate, deathdate, id))
        success = True
    return render_template('edit_author.html', id=id, name=name, surname=surname, birthdate=birthdate, deathdate=deathdate, success=success)

@app.route('/compositions')
def compositions():
    with eng.connect() as con:
        rs = con.execute("""
            select Composition.composition_id, Composition.composition_name, Author.author_name, Author.author_surname
            from Composition
            inner join Author on Author.author_id = Composition.author_id""")
        compositions = rs.fetchall()
    return render_template('compositions.html', compositions=compositions)

@app.route('/composition/edit/<int:id>', methods=['GET', 'POST'])
def edit_compositions(id):
    success = False
    if request.method == 'GET':
        with eng.connect() as con:
            rs = con.execute("""
            select Composition.composition_name, Genre.genre_name, Author.author_name, Author.author_surname
            from Composition
            inner join Author on Author.author_id = Composition.author_id
            inner join Genre on Genre.genre_id = Composition.genre_id
            where Composition.composition_id = %s""", (id,))
            name, genre, author_name, author_surname = rs.fetchone()
    else:
        name = request.form['name']
        genre = request.form['genre']
        author_name = request.form['author_name']
        author_surname = request.form['author_surname']
        with eng.connect() as con:
            rs = con.execute("""
                update Composition
                set Composition.composition_name = %s,
                    Composition.genre_id = (select genre_id from Genre
                        where Genre.genre_name = %s),
                    Composition.author_id = (select author_id from Author
                        where Author.author_name = %s and Author.author_surname = %s)
                where Composition.composition_id = %s""", (name, genre, author_name, author_surname, id))
        success = True
    return render_template('edit_composition.html', id=id, name=name, genre=genre, author_name=author_name, author_surname=author_surname, success=success)

@app.route('/collections')
def collections():
    with eng.connect() as con:
        rs = con.execute("""
            select Collection.collection_id, Collection.collection_name, group_concat(Genre.genre_name separator ', ')
            from Collection
            inner join Genre_description on Collection.collection_id = Genre_description.collection_id
            inner join Genre on Genre_description.genre_id = Genre.genre_id
            group by Collection.collection_id""")
        collections = rs.fetchall()
    return render_template('collections.html', collections=collections)

@app.route('/composition/add', methods=['GET', 'POST'])
def add_composition():
    success = False
    if request.method == 'POST':
        name = request.form['name']
        genre = request.form['genre']
        author_name = request.form['author_name']
        author_surname = request.form['author_surname']
        with eng.connect() as con:
            rs = con.execute("""
                insert into Composition (composition_name, genre_id, author_id) values (%s, (select genre_id from Genre
                        where Genre.genre_name = %s), (select author_id from Author
                        where Author.author_name = %s and Author.author_surname = %s))""", (name, genre, author_name, author_surname))
        success = True
    return render_template('add_composition.html', success=success)