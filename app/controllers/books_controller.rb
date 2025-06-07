class BooksController < ApplicationController
  include Pagy::Backend

  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all

    @pagy, @books = pagy(@books, items: 12)
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to edit_book_path(@book.slug), notice: 'book was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to edit_book_path(@book.slug), notice: 'book was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: 'book was successfully destroyed.'
  end

  def remove_image
    @book.image.purge
    redirect_to edit_book_path(book_slug: @book.slug), notice: 'Image removed successfully.'
  end

  private

  def set_book
    @book = Book.find_by!(slug: params[:slug])
  end

  def book_params
    permitted_params = [:title, :subtitle, :author]
    permitted_params << :slug unless action_name == 'create'
    params.require(:book).permit(permitted_params)
  end
end
