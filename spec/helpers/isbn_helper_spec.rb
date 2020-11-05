require 'rails_helper'

describe IsbnHelper, type: :helper do
	describe "is_isbn10?" do
		it "rejects dashes" do
			expect(is_isbn10?("1-234-56789-X")).to be false
		end

		it "rejects spaces" do
			expect(is_isbn10?("1 234 56789 X")).to be false
		end

		it "rejects non-isbn-10" do
			expect(is_isbn10?("111232789X")).to be false
		end

		it "rejects incorrect length" do
			expect(is_isbn10?("12345678X")).to be false
			expect(is_isbn10?("1123456789X")).to be false
		end

		it "accepts isbn-10 with no spaces" do
			expect(is_isbn10?("123456789X")).to be true
		end
	end
end
