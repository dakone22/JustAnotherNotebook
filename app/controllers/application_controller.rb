PER_PAGE = 20

class ApplicationController < ActionController::Base
  # before_action :preserve_params, only: :index
  before_action :authenticate
  before_action :set_current_user
  around_action :select_locale

  def current_user
    User.find(session[:current_user_id])
  rescue StandardError
    nil
  end

  def set_current_user
    @current_user = current_user
  end

  def user_signed_in?
    @current_user != nil
  end

  private

  def authenticate
    redirect_to signin_path unless current_user
  end

  def sign_in(user)
    session[:current_user_id] = user.id
    redirect_to root_path
  end

  def method_not_allowed
    respond_to do |format|
      format.all { render file: "#{Rails.root}/public/405.html", status: :method_not_allowed }
    end
  end

  def retrieve_locales
    request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/[a-z]{2}/)
  end

  def valid_locale
    retrieve_locales&.find { |locale| I18n.locale_available? locale } || I18n.default_locale
  end

  def select_locale(&action)
    I18n.with_locale(valid_locale, &action)
  end

  # def preserve_params
  #   @params = params
  # end
end
