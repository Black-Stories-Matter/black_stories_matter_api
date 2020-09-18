# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

book1 = Book.create(isbn: "0439023440", title: "Elijah of Buxton")
book2 = Book.create(isbn: "1481463330", title: "All American Boys")

author_1 = Author.create(name: "Author Name1")
author_2 = Author.create(name: "Author Name2")

AuthorBook.create(book_id: book1.id, author_id: author_1.id)
AuthorBook.create(book_id: book1.id, author_id: author_2.id)
AuthorBook.create(book_id: book2.id, author_id: author_1.id)
