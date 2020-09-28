class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def new
  end

  def show
    @book = Book.find(params[:id])
    @authors = @book.authors
  end

  def create
    if params[:isbn].length == 10
      book = BookService.new.create_book(params[:isbn])
      authors = BookService.new.create_author(params[:isbn], book)
      if book.save
        redirect_to "/books/#{book.id}"
        flash[:success] ="You succesfully added a book to the database"
      else
        flash[:notice] = "Book not created, please try again"
        render :new
      end
    else
      flash[:notice] = "We could not complete your request. Please make sure you entered an ISBN-10 with no dashes."
      render :new
    end
  end

  def destroy
    Book.destroy(params[:id])
    redirect_to '/books'
    flash[:success] ="You succesfully deleted a book from the database"
  end
end
