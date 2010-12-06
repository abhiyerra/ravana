class ApplicationController < ActionController::Base
  protect_from_forgery

  def check_login
    # TODO: This should actually redirect to welcome.
    return redirect_to new_user_session_path unless user_signed_in?
  end

  def is_admin?
    return redirect_to :back unless current_user.is_admin
  end
end
