module SessionsHelper
   def current_user
    User.find_by(id: session[:user_id])
  end

   def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !session[:user_id].nil?
  end

  def is_this_the_logged_user?(user_id)
    #On teste si le user est celui à qui appartient la session
    logged_in? && user_id == session[:user_id]
  end

end
