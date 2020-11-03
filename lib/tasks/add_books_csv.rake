require "#{Rails.root}/app/helpers/isbn_helper"
require 'csv'

include IsbnHelper

desc "Add books from .csv"
task :add_books_from_csv, [:filename] => :environment do |t, args|
	if args.filename.nil? || !File.exists?(args.filename)
		p "File not specified or Does not Exist"
	else
		CSV.foreach(args.filename, :headers => false) do |row|
			puts "ISBN: #{row.first}"
			if is_isbn10?(row.first)
				book = BookService.new.create_book(row.first)
				authors = BookService.new.create_author(row.first, book)
				if book.save
					p "#{row.first} has been added"
				else
					p "Unable to add: #{row.first}"
				end
			else
				puts "#{row.first} is not an ISBN 10, skipping"
			end
		end
	end
end
