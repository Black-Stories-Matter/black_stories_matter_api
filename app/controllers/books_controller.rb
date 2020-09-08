class BooksController < ApplicationController

  def new
  end

  def show
    @book = Book.find(params[:id])
    @authors = @book.authors
  end

  def create
    response = Faraday.get("https://www.googleapis.com/books/v1/volumes?q=isbn:#{params[:isbn]}")
    json = JSON.parse(response.body, symbolize_names: true)

    #need to go back and change relationship to many to many to add authors to books


    book = Book.create(isbn: params[:isbn],
                    title: json[:items][0][:volumeInfo][:title],
                    cover_image: json[:items][0][:volumeInfo][:imageLinks][:thumbnail],
                    description: json[:items][0][:volumeInfo][:description],
                    publication_date: json[:items][0][:volumeInfo][:publishedDate],
                    category: json[:items][0][:volumeInfo][:categories][0],
                    maturity: json[:items][0][:volumeInfo][:maturityRating],
                    info_link: json[:items][0][:volumeInfo][:infoLink])

    json_authors = json[:items][0][:volumeInfo][:authors]
    json_authors.each do |author|
      author_object = Author.find_or_create_by(name: author)
      AuthorBook.create(author_id: author_object.id, book_id: book.id)
    end

    if book.save
      redirect_to "/books/#{book.id}"
      flash[:success] ="You succesfully added a book to the database"
    else
      flash[:notice] = "Book not created, please try again"
      render :new
    end
  end
end
