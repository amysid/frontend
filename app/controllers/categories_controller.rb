class CategoriesController < ApplicationController
  before_action :logged_in?
  def index
    @category = Category.new
    per_page = params[:per_page] || 10
    @categories = Category.all.includes(:booths).order('created_at desc').paginate(page: params[:page], per_page: per_page)
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      message = t('category_created_successfully')
      redirect_to categories_path, notice: message
    else
      redirect_to categories_path, alert: @booth.errors.full_messages
    end
  end

  def show
    @category = Category.includes(:booths).find_by(id: params[:id])
  end

  def edit
    @category = Category.find_by(id: params[:id])
  end

  def setting
    @category = Category.find_by(id: params[:id])
  end

  def update
    @category = Category.find_by(id: params[:id])
    redirect_to categories_path, alert: t("no_record_present") if @category.blank?
     

    if @category.update(category_params) 
      message = t('category_updated_successfully')
      redirect_to categories_path, notice: message 
    else
      redirect_to categories_path, alert: @category.errors.full_messages
    end
  end

  def destroy
    @category = Category.find_by(id: params[:id])
    if @category.destroy
      message = t("category_destroy_message")
      redirect_to categories_path, notice: message
    else
      redirect_to categories_path, alert: @category.errors.full_messages
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :arabic_name, :icon)
  end
end
