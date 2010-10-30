class ApplicationController < ActionController::Base
  protect_from_forgery

  def check_login
    # TODO: This should actually redirect to welcome.
    redirect_to new_user_session_path unless user_signed_in?
  end
end
