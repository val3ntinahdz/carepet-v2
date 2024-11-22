class VeterinariesController < ApplicationController
  def index
    @veterinaries = Veterinary.all
  end

  def show
    @veterinary = Veterinary.find(params[:id])
  end

  def new
    @veterinary = Veterinary.new
  end

  def create
    @veterinary = Veterinary.new(veterinary_params)
    if @veterinary.save
      redirect_to veterinaries_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def veterinary_params
    params.require(:veterinary).permit(:specialization, :dni, :user_id)
  end
end
