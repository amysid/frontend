class Web::BoothsController < ApplicationController
  before_action :set_booth, only: [:show]
  def index
    @booths = Booth.all.order("created_at desc")
  end

  def show
  end
  private

  def set_booth
    @booth = Booth.find_by(number: params[:id])
    redirect_to root_path, notice: "Invali Booth" if @booth.blank?
  end
end
