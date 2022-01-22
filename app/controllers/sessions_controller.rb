class SessionsController < ApplicationController
  skip_before_action :authenticate, only: %i[new create]

  # GET /sessions/new
  def new; end

  # POST /sessions
  def create
    user_data = params[:user]
    user = User.find_by(username: user_data[:username])
    if user&.authenticate(user_data[:password])
      sign_in user
    else
      flash[:error] = t('auth.messages.sign_in_error')
      redirect_to action: :new
    end
  end

  # DELETE /sessions/1
  def destroy
    session.delete(:current_user_id)
    redirect_to root_path
  end
end
