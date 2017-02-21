class SessionsController < ApplicationController
  def new
    render :new
  end

  def create

    user_search_results = User.find_by_credentials(session_params[:user_name], session_params[:password])

    if user_search_results.is_a?(User)
      @user = user_search_results
      login_user!(@user)
      @current_user = @user
      # fail
      session[:session_token] = @user.session_token
      redirect_to cats_url #:index per controller?
    else
      flash[:errors] = "Invalid login"
      redirect_to new_session_url
    end
  end

  private

  def session_params
    params.require(:user).permit(:user_name, :password)
  end
end
