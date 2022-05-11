class Web::OperationsController < Web::WebApplicationController
  before_action :set_operation
  layout false

  def media_files
    @book = @operation.book
    language = params[:locale] == "en" ? "English" : "Arabic"
    @book.update(last_listening_at: Time.now, language: language)
  end

  def update_listen_count
    current_listen_time = params[:current_time].to_f
    total_time = params[:file_duration].to_f
    listen_time = current_listen_time.to_f
    @operation.update(listening_time: Time.now, listening_status: listen_time)
    render json: {message: "successfully save count"}
  end

  def save_feedback
    @operation.update(rating: params[:feedback][:rating], note: params[:feedback][:note])
    redirect_to media_files_web_operation_path(id: @operation.number), notice: t("feedback save successfully")
  end

  private

  def set_operation
    @operation = Operation.find_by(number: params[:id])
  end
end
