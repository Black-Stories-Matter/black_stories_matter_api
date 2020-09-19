class BookService

  def conn(isbn)
    Faraday.get("https://www.googleapis.com/books/v1/volumes?q=isbn:#{isbn}")
  end

end
