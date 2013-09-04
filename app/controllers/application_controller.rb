class ApplicationController < ActionController::Base
  protect_from_forgery
    
  helper_method :current_user 
  helper_method :logged_in 

  helper_method :choosed_playlist
  helper_method :choosed_own_playlist

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in
  	return !current_user.nil?
  end    

  def choosed_playlist
    return (logged_in and !session[:playlist].nil?)
  end

  def choosed_own_playlist
    return (choosed_playlist and session[:playlist].creator == current_user.id)    
  end
end
