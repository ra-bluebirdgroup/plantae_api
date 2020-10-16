class Api::V1::SessionsController < ApplicationController
 skip_before_action :authorized, only: [:create, :auto_login]

  def destroy
    user = User.find_by(user_name: params[:session][:name])
    session.delete(:user_id)

    render json: "You have logged out"
  end

  def create
    user = User.find_by(username: params[:session][:username])

    if user && user.authenticate(params[:session][:password])
      response = {}
      response = {}
      response["user"] = user
      response["userplants"] = user.plants

      token = encode_token(user_id: user.id)
      response["token"] = token

    render json: response, status: :created
    else
    full_message = ["wrong password or username"]
    render json: full_message, status: :not_acceptable
    end

  end

  def auto_login
    user = User.find_by(id: request.headers["Authorization"])

    if(user)
      response = {}
      response["user"] = user
      response["userplants"] = user.plants

      token = encode_token(user_id: user.id)
      response["token"] = token
     render json: response, status: :created
    else
      render json: {errors: "User not found"}
    end

  end

  private

  def user_params
   params.require(:user).permit!
  end
end
