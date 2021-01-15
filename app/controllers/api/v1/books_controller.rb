class Api::V1::BooksController < ApplicationController

  def index
    books = Book.all
    render json: BookSerializer.new(books)
  end

  def show
    book = Book.find(params[:id])
    render json: BookSerializer.new(book)
   rescue ActiveRecord::RecordNotFound
   	render json: { code: "404", message: "Book Not Found" }
  end
end
