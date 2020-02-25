class MealsController < ApplicationController
  def index
    @meals = current_user.meals
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.user = current_user

    if @meal.save
      flash[:notice] = "Meal was added"
      redirect_to meals_path
    else
      flash[:danger] = "Check you attributes again"
      render :new
    end
  end

  def show
    @meal = Meal.find(params[:id])
  end

  def edit
    @meal = Meal.find(params[:id])
  end

  def update
    @meal = Meal.find(params[:id])

    if @meal.update(meal_params)
      flash[:notice] = "Meal's parameters were updated"
      redirect_to meal_path(@meal)
    else
      flash[:danger] = "Check you attributes again"
      render :edit
    end
  end

  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy
    flash[:notice] = "Meal was removed from your daily ration"
    redirect_to meals_path
  end
  
  private
  def meal_params
    params.require(:meal).permit(:name,:calories)
  end
end
