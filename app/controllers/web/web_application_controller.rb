class Web::WebApplicationController < ActionController::Base
  layout 'web_layout'
  before_action :set_locale

  def set_locale
    I18n.locale = :en
    I18n.locale = params[:locale]
  end
end
