class AllergiesController < ApplicationController
  before_action :set_allergy, only: %i[show edit update destroy]
  before_action :set_pet, only: %i[new create]

  def index
    @allergies = Allergy.all
  end

  def show; end

  def new
    @allergy = Allergy.new
  end

  def create
    @allergy = Allergy.new(allergy_params)
    @allergy.pet = @pet # Associate the allergy with the pet
    if @allergy.save
      redirect_to pet_path(@pet)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @allergy.update(allergy_params)
      redirect_to pet_path(@allergy.pet)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @allergy.destroy
    redirect_to pet_path(@pet)
  end

  private

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def set_allergy
    @allergy = Allergy.find(params[:id])
    @pet = @allergy.pet # Associate the allergy with the pet
  end

  def allergy_params
    params.require(:allergy).permit(:detected_on, :severity, :reactions, :comments, :pet_id, :allergen_id)
  end
end
