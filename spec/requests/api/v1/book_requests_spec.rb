require 'rails_helper'

describe 'Books API' do
  it "retrieves book information" do
    book1 = Book.create(isbn: "0439023440",title: "Elijah of Buxton")
    book2 = Book.create(isbn: "1481463330", title: "All American Boys")
    author_1 = Author.create(name: "Author Name1")
    author_2 = Author.create(name: "Author Name2")

    AuthorBook.create(book_id: book1.id, author_id: author_1.id)
    AuthorBook.create(book_id: book1.id, author_id: author_2.id)
    AuthorBook.create(book_id: book2.id, author_id: author_1.id)

    get "/api/v1/books"
    results = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    require "pry"; binding.pry
  end
end
