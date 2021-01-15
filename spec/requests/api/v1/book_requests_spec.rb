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
  end

  it "retrieves individual book information" do
    test_book = Book.create(isbn: "0241346843", title: "Little Leaders: Bold Women in Black History")
    test_author = Author.create(name: "Vashti Harrison")

    AuthorBook.create(book_id: test_book.id, author_id: test_author.id)

    get "/api/v1/books/#{test_book.id}"
    result = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(result.size).to eq(1)
    expect(result[:data][:type]).to eq("book")
  end
end
