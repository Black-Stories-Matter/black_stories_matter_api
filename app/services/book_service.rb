class BookService

#  response = Faraday.get("https://www.googleapis.com/books/v1/volumes?q=isbn:#{params[:isbn]}")
#  json = JSON.parse(response.body, symbolize_names: true)


  def conn(isbn)
    Faraday.get("https://www.googleapis.com/books/v1/volumes?q=isbn:#{isbn}")
  end

  def create_book(isbn)
    json = JSON.parse(conn(isbn).body, symbolize_names: true)
    volume_info = json[:items][0][:volumeInfo]

    Book.create(isbn: isbn,
                title: volume_info[:title],
                cover_image: volume_info[:imageLinks].nil? ? nil : volume_info[:imageLinks][:thumbnail],
                description: volume_info[:description],
                publication_date: volume_info[:publishedDate],
                category: volume_info[:categories].nil? ? nil : volume_info[:categories][0],
                maturity: volume_info[:maturityRating],
                info_link: volume_info[:infoLink])
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
