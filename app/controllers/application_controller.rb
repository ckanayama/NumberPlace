class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production? 
  before_action :set_theme

  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |name, password|
      name == ENV["BASIC_AUTH_NAME"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def set_theme
    @theme = Setting.first.theme
  end
end
