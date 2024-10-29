class ConditionsController < ApplicationController
  before_action :set_condition, only: %i[show edit update destroy]
  before_action :set_pet, only: %i[new create]

  def index
    @condition = Condition.all
  end

  def show; end

  def new
    @condition = Condition.new
  end

  def create
    @condition = Condition.new(condition_params)
    @condition.pet = @pet # Associate the condition with the pet
    if @condition.save
      redirect_to pet_path(@pet)
    else
      render :new, status: :unprocessable_entity
    end
  end


  def edit; end

  def update
    if @condition.update(condition_params)
      redirect_to pet_path(@pet) # Redirect to the pet show page
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @condition.destroy
    redirect_to pet_path(@pet)
  end

  private

  def condition_params
    params.require(:condition).permit(:diagnosis_date, :comments, :disease_id, :pet_id)
  end

  def set_condition
    @condition = Condition.find(params[:id])
    @pet = @condition.pet
  end

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end
end
