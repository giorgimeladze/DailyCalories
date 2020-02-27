class MealsController < ApplicationController

  def search
  end

  def result
    start_date = params[:start_date]
    end_date = params[:end_date]
    start_time = params[:start_time]
    end_time = params[:end_time]
    @meals = current_user.meals.to_a
    @meals.select! {|meal| meal.ate_meal_at >= (DateTime.parse("#{start_date} #{start_time}") - (4.0/24.0))}
    @meals.select! {|meal| meal.ate_meal_at <= (DateTime.parse("#{end_date} #{end_time}") - (4.0/24.0))}
    if start_time >= end_time
      @meals.select!{|meal| meal.ate_meal_at_time > start_time || meal.ate_meal_at_time < end_time}
    else
      @meals.select!{|meal| meal.ate_meal_at_time < end_time && meal.ate_meal_at_time > start_time}
    end
    @meals = @meals.sort_by {|meal| meal.ate_meal_at}.reverse
    @meals = @meals.paginate(page: params[:page], per_page: 5)
  end

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
    @meals = @meals.paginate(page: params[:page], per_page: 8)
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
