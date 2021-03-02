class BookService

#  response = Faraday.get("https://www.googleapis.com/books/v1/volumes?q=isbn:#{params[:isbn]}")
#  json = JSON.parse(response.body, symbolize_names: true)


  def request(isbn)
    Faraday.get("https://www.googleapis.com/books/v1/volumes?q=isbn:#{isbn}")
  end

  def create_book(isbn)
    json = JSON.parse(request(isbn).body, symbolize_names: true)
    json_authors = json[:items][0][:volumeInfo][:authors]
    book = Book.create(isbn: isbn,
                title: json[:items][0][:volumeInfo][:title],
                cover_image: json[:items][0][:volumeInfo][:imageLinks][:thumbnail],
                description: json[:items][0][:volumeInfo][:description],
                publication_date: json[:items][0][:volumeInfo][:publishedDate],
                category: json[:items][0][:volumeInfo][:categories][0],
                maturity: json[:items][0][:volumeInfo][:maturityRating],
                info_link: json[:items][0][:volumeInfo][:infoLink])
    create_authors(book, json_authors)
    return book
  end

  def create_authors(book, json_authors)
    json_authors.each do |author|
      author_object = Author.find_or_create_by(name: author)
      AuthorBook.create(author_id: author_object.id, book_id: book.id)
    end
  end

end
