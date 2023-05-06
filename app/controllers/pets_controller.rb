class PetsController < ApplicationController
  before_action :set_pet, only: %i[show edit update destroy]
  def index
    @pets = Pet.all
  end

  def show
    @days_ago = found_days_ago(@pet)
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(params_pet)
    if @pet.save
      redirect_to pet_path(@pet)
    else
      render :new
    end
  end

  def edit; end


  def update
    if @pet.update(params_pet)
      redirect_to pet_path(@pet)
    else
      render :edit
    end
  end

  def destroy
    @pet.destroy
    redirect_to pets_path
  end

  def found_days_ago(pet)
    DateTime.now - pet.date
  end

  private

  def params_pet
    params.require(:pet).permit(:name, :species, :date)
  end

  def set_pet
    @pet = Pet.find(params[:id])
  end
end
