class Api::V1::AuthorsController < ApplicationController

  def index
    authors = Author.all
    render json: AuthorSerializer.new(authors)
  end

  def show
    author = Author.find(params[:id])
    render json: AuthorSerializer.new(author)
   rescue ActiveRecord::RecordNotFound
   	render json: { code: "404", message: "Author Not Found" }
  end

end
