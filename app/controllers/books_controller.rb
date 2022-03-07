class BooksController < ApplicationController
  before_action :logged_in?
  # before_action :ensure_category_present?, only: [:create, :update]
  def index
    @book = Book.new
    @book.book_files.build
    per_page = params[:per_page] || 10
    @books = Book.all.order('created_at desc').paginate(page: params[:page], per_page: per_page)
  end
  
  def create
    @book = Book.new(book_params)
    if @book.save
      # @book.categories << @category
      redirect_to books_path, notice: t("book_created_successfully")
    else
      redirect_to books_path, alert: @book.errors.full_messages
    end
  end

  def update
    @book = Book.find_by(id: params[:id])
    if @book.update(book_params)
      # @book.categories << @category
      redirect_to books_path, notice: t("book_created_successfully")
    else
      redirect_to books_path, alert: @book.errors.full_messages
    end
  end

  def show
    @book = Book.includes(:book_files).find_by(id: params[:id])
  end

  def edit
    @book = Book.includes(:book_files).find_by(id: params[:id])
  end

  def setting
    @book = Book.includes(:book_files).find_by(id: params[:id])
  end


  private

  def book_params
    params.require(:book).permit(:title, :author_name, :book_duration, :body,
      :user_id, :category_id, book_files_attributes: [:book_cover_file, :audio, :short_audio_file]
    )
  end

  def ensure_category_present?
    @category = Category.find_by(id: params[:book][:category_id])
    if @category.blank?
      redirect_to books_path, alert: t('category_not_valid')
    end
  end
end
