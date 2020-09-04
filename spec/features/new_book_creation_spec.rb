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
  end
end
