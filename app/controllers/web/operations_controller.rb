class Web::OperationsController < Web::WebApplicationController
  layout false

  def media_files
    url = "#{ENV["API_BASE_URL"]}/web_api/operations/#{params[:id]}/media_files"
    headers = {"Content-Type": "application/json"}
    response = HTTParty.get(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("book").present? && response_body.dig("operation").present?
      @book = response_body["book"]["data"]["attributes"]
      @operation = response_body["operation"]["data"]["attributes"]
    end
  end

  def save_feedback
    url = "#{ENV["API_BASE_URL"]}/web_api/operations/#{params[:id]}/save_feedback"
    headers = {"Content-Type": "application/json", body: params.as_json}
    response = HTTParty.put(url, headers: headers)
    response_body = JSON.parse(response.body) if response.body.present?
    if response_body.present? &&  response_body.dig("message").present?
      render json: {message: "data save successfully"}
    end
  end

end
