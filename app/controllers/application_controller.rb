class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session

  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def check_login
    unless authorized?
      redirect_to "/auth/identity"
    end
  end

  def logged_in?
    if session[:user_id]
      return true
    else
      return false
    end
  end

  protected
  def authorized?
    logged_in? && (request.get? || current_user.admin?)
  end
end
