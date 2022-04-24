class BooksController < ApplicationController
  before_action :logged_in?
  before_action :ensure_category_present?, only: [:create, :update]
  before_action :set_book, except: [:new, :create, :index]
  before_action :ensure_book_present?, except: [:new, :create, :index]
  before_action :update_category_record, only: [:update]

  def index
    @book = Book.new
    @book.book_files.build
    per_page = params[:per_page] || 10
    @books = Book.all.includes(:operations).order('created_at desc').paginate(page: params[:page], per_page: per_page)
  end
  
  def create
    @book = Book.new(book_params)
    if @book.save
      @book.categories << @categories
      redirect_to books_path, notice: t("book_created_successfully")
    else
      redirect_to books_path, alert: @book.errors.full_messages
    end
  end

  def update 
    if @book.update(book_params)
      @book.categories << @new_categories
      redirect_to books_path, notice: t("book_created_successfully")
    else
      redirect_to books_path, alert: @book.errors.full_messages
    end
  end

  def show
  end

  def edit
  end

  def setting
  end

  def change_status
    status = @book.status == "Published" ? "UnPublished" : "Published"
    @book.update(status: status)
    redirect_to books_path, notice: t("book_updated_successfully")
  end

  private

  def book_params
    params.require(:book).permit(:title, :author_name, :book_duration, :body,
      :user_id, book_files_attributes: [:id, :book_cover_file, :audio, :short_audio_file, :_destroy]
    )
  end

  def set_book
    @book = Book.find_by(id: params[:id])
  end

  def ensure_book_present?
    if @book.blank?
      redirect_to books_path, alert: t("booth_not_found")
    end
  end

  def ensure_category_present?
    @categories = Category.where(id: params[:book][:category_ids])
    if @categories.blank?
      redirect_to books_path, alert: t('category_not_valid')
    end
  end

  def update_category_record
    existing_category_id = @book.category_ids
    category_ids_for_remove = existing_category_id - @categories.pluck(:id)
    @book.category_ids -= category_ids_for_remove
    @new_categories = @categories.where.not(id: existing_category_id)
  end
end
