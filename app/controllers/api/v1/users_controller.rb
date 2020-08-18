class Api::V1::UsersController < ApplicationController
 skip_before_action :authorized, only: [:create, :show]
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def create
     puts params
    new_user_params = {}
    new_user_params["username"] = params["username"]
    new_user_params["password"] = params["password"]

    user = User.new(new_user_params)
    if user.save
      response = {}
      response["user"] = user
      response["userplants"] = user.plants

      token = encode_token(user_id: user.id)
      response["token"] = token
     render json: response, status: :created
    else
     render json: user.errors.full_messages, status: :not_acceptable
    end

  end

  def show
puts params
    if @user
     render json: @user
    else
     render json: "user not found"
    end

  end

  private

  def user_params
   params.require(:user).permit!
  end

  def find_user
   @user = User.find(params[:id])
  end

end
