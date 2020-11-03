
require 'pp'

desc "Add books from .csv"
task :add_books_from_csv => :environment do
	puts "add_books_from_csv - testing 3,2,1"

	isbn = "0241346843"
	book = BookService.new.create_book(isbn)
	authors = BookService.new.create_author(isbn, book)
	#book.save
	
end
