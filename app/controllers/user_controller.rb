class UserController < ApplicationController
  def show
    @id = params[:id]
    @user = User.find(@id)
    @city = @user.city
  end

  def new
    @city = City.all
  end

  def create

    @user = User.new(email: params[:email], password: params[:pass], first_name: params[:first_name], last_name: params[:last_name], city_id: params[:city])

    respond_to do |format|
      if @user.save
        log_in(@user)
        format.html { redirect_to gossips_path, notice: 'Ton profil a bien été créé' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end



end
