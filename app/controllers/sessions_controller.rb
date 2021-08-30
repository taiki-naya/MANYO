class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create, :register]
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id), notice: 'Login seccessed'
    else
      flash.now[:danger] = 'Login FAILED'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path, notice: 'Logged out'
  end
end
