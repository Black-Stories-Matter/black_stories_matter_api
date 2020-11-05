require 'rails_helper'

describe IsbnHelper, type: :helper do
	describe "isbn10?" do
		it "rejects dashes" do
			expect(isbn10?("1-234-56789-X")).to be false
		end

		it "rejects spaces" do
			expect(isbn10?("1 234 56789 X")).to be false
		end

		it "rejects non-isbn-10" do
			expect(isbn10?("111232789X")).to be false
		end

		it "rejects incorrect length" do
			expect(isbn10?("12345678X")).to be false
			expect(isbn10?("1123456789X")).to be false
		end

		it "accepts isbn-10 with no spaces" do
			expect(isbn10?("123456789X")).to be true
		end
	end

	describe "normalise" do
		it "removes spaces and dashes" do
			expect(normalise(" 1-234-56789-X ")).to eq("123456789X")
		end
	end
end
