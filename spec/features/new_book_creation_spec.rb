require 'rails_helper'

RSpec.describe "As a visitor,", type: :feature do
  describe "when I visit /books/new" do
    it "then I can complete a form to add a new book to the database" do

      visit '/books/new'

      fill_in :isbn, with: "0439023440"

      click_on "Submit"

      book = Book.last
      expect(page).to have_content("You succesfully added a book to the database")
      expect(current_path).to eq("/books/#{book.id}")
    end

    it "doesn't allow you to enter the same book twice" do
      visit '/books/new'

      fill_in :isbn, with: "0439023440"

      click_on "Submit"

      visit '/books/new'

      fill_in :isbn, with: "0439023440"

      click_on "Submit"

      expect(page).to have_content("Book not created, please try again")
    end

    it "doesn't allow you to enter an ISBN that is longer than 10 digits" do

      visit '/books/new'

      fill_in :isbn, with: "043902344045"

      click_on "Submit"

      expect(page).to have_content("We could not complete your request. Please make sure you entered an ISBN-10 with no dashes.")

      fill_in :isbn, with: "04-3902-3440"

      click_on "Submit"

      expect(page).to have_content("We could not complete your request. Please make sure you entered an ISBN-10 with no dashes.")
    end

    it "allows me to add new book, with no category assignments, to the database" do
      visit '/books/new'

      fill_in :isbn, with: "0241346843"

      click_on "Submit"

      book = Book.last
      expect(page).to have_content("You succesfully added a book to the database")
      expect(current_path).to eq("/books/#{book.id}")
    end
  end
end
