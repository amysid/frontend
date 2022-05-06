class Web::OperationsController < Web::WebApplicationController
  before_action :set_operation
  # layout false

  def media_files
    @book = @operation.book
    @book.update(last_listening_at: Time.now)
  end

  def update_listen_count
    current_listen_time = params[:current_time].to_f
    total_time = params[:file_duration].to_f
    listen_time = current_listen_time.to_f
    @operation.update(listening_time: Time.now, listening_status: listen_time)
    render json: {message: "successfully save count"}
  end

  private

  def set_operation
    @operation = Operation.find_by(number: params[:id])
  end
end
