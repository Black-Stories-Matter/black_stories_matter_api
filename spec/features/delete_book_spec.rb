require 'rails_helper'

RSpec.describe "As a visitor,", type: :feature do
  describe "when I visit /books" do
    it "Next to each book, I see an option to delete that book and can click the link to delete the book" do
      book1 = Book.create(isbn: "0439023440", title: "Elijah of Buxton")
      book2 = Book.create(isbn: "1481463330", title: "All American Boys")

      author_1 = Author.create(name: "Author Name1")
      author_2 = Author.create(name: "Author Name2")

      AuthorBook.create(book_id: book1.id, author_id: author_1.id)
      AuthorBook.create(book_id: book1.id, author_id: author_2.id)
      AuthorBook.create(book_id: book2.id, author_id: author_1.id)

      visit '/books'

      expect(page).to have_link 'Delete Book', href: "/books/#{book1.id}"
      expect(page).to have_link 'Delete Book', href: "/books/#{book2.id}"

      within "#book-#{book1.id}" do
        click_link "Delete Book"
      end

      expect(current_path).to eq("/books")
      expect(page).to_not have_content("Elijah of Buxton")
    end
  end

  describe "when I visit /books/:id" do
    it "I see an option to delete that book and can click the link to delete the book" do
      book1 = Book.create(isbn: "0439023440", title: "Elijah of Buxton")
      book2 = Book.create(isbn: "1481463330", title: "All American Boys")

      author_1 = Author.create(name: "Author Name1")
      author_2 = Author.create(name: "Author Name2")

      AuthorBook.create(book_id: book1.id, author_id: author_1.id)
      AuthorBook.create(book_id: book1.id, author_id: author_2.id)
      AuthorBook.create(book_id: book2.id, author_id: author_1.id)

      visit "/books/#{book1.id}"

      click_link("Delete Book")

      expect(current_path).to eq("/books")
      expect(page).to_not have_content("Elijah of Buxton")
    end
  end
end
