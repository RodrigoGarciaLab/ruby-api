class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  before_action :correct_user,   only: [:show, :update]
  before_action :authorize_admin_request,   only: [:destroy]
  # POST /signup
  # return authenticated token upon signup
  def index
    @users = User.all
    json_response(@users)
  end

  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  def show
    json_response(current_user)
  end

  def update
    puts params
    user = User.find(params[:id])
    user.update(user_params) 
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    head :no_content
  end

  private

    def user_params
      params.require(:user).permit(
        :name,
        :email,
        :password,
        :password_confirmation
      )
    end

    def correct_user
      @user = User.find(params[:id])
      json_response({ message: Message.unauthorized }, :unauthorized) unless current_user == @user || current_user.admin?
    end
end