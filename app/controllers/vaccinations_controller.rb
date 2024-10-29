class VaccinationsController < ApplicationController
  before_action :set_vaccination, only: %i[show edit update destroy]
  before_action :set_pet, only: %i[new create]

  def index
    @vaccination = Vaccination.all
  end

  def show; end

  def new
    @vaccination = Vaccination.new
  end

  def create
    @vaccination = Vaccination.new(vaccination_params)
    @vaccination.pet = @pet # Associate a vaccination with the pet
    if @vaccination.save
      redirect_to pet_path(@pet)
    else
      render :new, status: :unprocessable
    end
  end

  def edit; end

  def update
    if @vaccination.update(vaccination_params)
      redirect_to pet_path(@oet)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @vaccination.destroy
    redirect_to pet_path(@pet)
  end

  private

  def vaccination_params
    params.require(:vaccination).permit(:date, :comments, :pet_id, :vaccine_id)
  end

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def set_vaccination
    @vaccination = Vaccination.find(params[:id])
    @pet = @vaccination.pet
  end
end
