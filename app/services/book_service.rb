class BookService

#  response = Faraday.get("https://www.googleapis.com/books/v1/volumes?q=isbn:#{params[:isbn]}")
#  json = JSON.parse(response.body, symbolize_names: true)


  def conn(isbn)
    Faraday.get("https://www.googleapis.com/books/v1/volumes?q=isbn:#{isbn}")
  end

  def create_book(isbn)
    json = JSON.parse(conn(isbn).body, symbolize_names: true)
    Book.create(isbn: isbn,
                title: json[:items][0][:volumeInfo][:title],
                cover_image: json[:items][0][:volumeInfo][:imageLinks][:thumbnail],
                description: json[:items][0][:volumeInfo][:description],
                publication_date: json[:items][0][:volumeInfo][:publishedDate],
                category: json[:items][0][:volumeInfo][:categories][0],
                maturity: json[:items][0][:volumeInfo][:maturityRating],
                info_link: json[:items][0][:volumeInfo][:infoLink])
  end

  def create_author(isbn, book)
    json = JSON.parse(conn(isbn).body, symbolize_names: true)
    json_authors = json[:items][0][:volumeInfo][:authors]
    json_authors.each do |author|
      author_object = Author.find_or_create_by(name: author)
      AuthorBook.create(author_id: author_object.id, book_id: book.id)
    end
  end

end
