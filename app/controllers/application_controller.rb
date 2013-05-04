class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_language

  def set_language
    if session[:locale]
      I18n.locale = session[:locale]
    else
      if current_admin
        I18n.locale = current_admin.locale
      elsif current_user
        I18n.locale = current_user.locale
      else
        I18n.locale = 'en'
      end
    end
  end

  def require_admin_login
    unless current_admin
      redirect_to new_admin_session_path, alert: 'You must be logged as Admin in to access this Section.'
    end
  end

  def require_user_login
    unless current_user
      redirect_to new_user_session_path, alert: 'You must be logged in to do that Action. Please Sign-in or Sign-up..'
    end
  end
  
 end
