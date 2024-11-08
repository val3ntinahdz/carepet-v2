class PetsController < ApplicationController
  before_action :set_pet, only: %i[show edit update destroy]

  def index
    @pets = Pet.where(user: current_user)
  end

  def show
    @vaccinations = @pet.vaccinations
    @allergies = @pet.allergies
    @conditions = @pet.conditions
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user = current_user
    if @pet.save
      redirect_to pet_path(@pet)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @pet.update(pet_params)
      redirect_to pet_path(@pet)
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @pet.destroy
    redirect_to pets_path, notice: 'Pet was succesfully deleted'
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :age, :pet_type, :breed, :weight, :height, :color, :birthday_date, :gender, :user_id)
  end

  def set_pet
    @pet = Pet.find(params[:id])
  end
end
