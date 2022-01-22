class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :check_self_permission, except: %i[index new create]
  skip_before_action :authenticate, only: %i[new create]

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html do
          flash[:notice] = t('auth.messages.sign_up_success')
          redirect_to_index
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def redirect_to_index
    if session[:current_user_id]
      redirect_to users_path
    else
      sign_in @user
    end
  end

  def check_self_permission
    method_not_allowed unless current_user.id == params[:id].to_i
  end
end
