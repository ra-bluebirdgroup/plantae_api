class Api::V1::UserPlantsController < ApplicationController

  def create
  puts params
  @user = User.find_by(username: params['username'])

  if @user.plants.map{|s| s.scientific_name}.include?(params['plantid'])
    response = {}
    response["user"] =@user
    response["userplants"] =@user.plants

    token = encode_token(user_id:@user.id)
    response["token"] = token
   render json: response, status: :created

  else
    Plant.find_by(scientific_name: params['plantid']) ? @plant = Plant.find_by(scientific_name: params['plantid']) : @plant = Plant.create(scientific_name: params['plantid'])

    @user.plants.push(@plant)
    response = {}
    response["user"] =@user
    response["userplants"] =@user.plants

    token = encode_token(user_id:@user.id)
    response["token"] = token
   render json: response, status: :created
  end

end

def show

@user = User.find_by(user_name: params[:id])
render json: @user.plants

end


  def destroy
    puts params
    @user = User.find_by(username: params['username'])

    if @user.plants.map{|s| s.scientific_name}.include?(params['plantid'])

      @plant = Plant.find_by(scientific_name: params['plantid'])

      @user.plants.delete(@plant)

      response = {}
      response["user"] = @user
      response["userplants"] = @user.plants

      token = encode_token(user_id: @user.id)
      response["token"] = token
      render json: response
    else
      response = {}
      response["user"] = @user
      response["userplants"] = @user.plants

      token = encode_token(user_id:@user.id)
      response["token"] = token
     render json: response
    end

  end

private

def user_plants_params
 params.require(:user_plant).permit!
end

end
