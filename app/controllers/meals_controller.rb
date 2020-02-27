class MealsController < ApplicationController
  def new
    @meal = Meal.new
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.user = User.find(params[:id])

    if @meal.save
      flash[:notice] = "Meal was added"
      redirect_to meals_path
    else
      flash[:danger] = "Check you attributes again"
      render :new
    end
  end

  def index
    @meals = current_user.get_todays_meals
    @meals = @meals.to_a.sort_by {|meal| meal.ate_meal_at}.reverse
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
    params.require(:meal).permit(:name,:calories,:ate_meal_at)
  end
end
