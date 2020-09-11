require 'rails_helper'

RSpec.describe "As a visitor,", type: :feature do
  describe "when I visit /books" do
    it "I see a list of all of the books that have been entered in the database" do

      visit '/books/new'

      fill_in :isbn, with: "0439023440"

      click_on "Submit"

      visit '/books/new'

      fill_in :isbn, with: "1481463330"

      click_on "Submit"

      visit '/books'

      expect(page).to have_content("Elijah of Buxton")
      expect(page).to have_content("All American Boys")
    end
  end
end
