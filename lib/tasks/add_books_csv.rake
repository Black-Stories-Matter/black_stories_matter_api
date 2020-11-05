require "#{Rails.root}/app/helpers/isbn_helper"
require 'csv'

include IsbnHelper

desc "Add books from .csv containing ISBN-10"
task :add_books_from_csv, [:filename] => :environment do |t, args|
	if args.filename.nil? || !File.exists?(args.filename)
		puts "File not specified or Does not Exist"
	else
		CSV.foreach(args.filename, :headers => false) do |row|
			begin
				if is_isbn10?(row.first)
					book = BookService.new.create_book(row.first)
					authors = BookService.new.create_author(row.first, book)
					
					if !book.nil? && !authors.nil?
						if book.save
							puts "#{row.first} has been added"
						else
							puts "Unable to add: #{row.first}"
						end
					end
				else
					puts "#{row.first} is not an ISBN 10, skipping"
				end
			
			rescue => e
				puts "Error creating book for ISBN: #{row.first}"
				next
			end
		end
	end
end
