class UsersController < ApplicationController
  before_action :check_status, except: [:show, :index]
  before_action :check_admin_and_manager, only: [:edit,:update,:destroy, :make_admin]

  def index
    @users = User.all.paginate(page: params[:page], per_page: 5)
    @users.sort_by {|user| user.status}.reverse
  end

  def show
    @user = User.find(params[:id])
    @meals = @user.get_todays_meals
    @meals = @meals.paginate(page: params[:page], per_page: 8)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "You have successfully added new user"
      redirect_to root_path
    else
      flash[:danger] = "Parameters were wrong"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_with_password(user_params_current)
      flash[:notice] = "User's parameters was successfully updated"
      redirect_to user_path(@user)
    else
      flash[:danger] = "Parameters were wrong"
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "User was removed"
    redirect_to users_path
  end

  def make_admin
    @user = User.find(params[:id])
    @user.admin!
    redirect_to users_path, notice: "your chosen user is admin"
  end

  def make_manager
    @user = User.find(params[:id])
    @user.manager!
    redirect_to users_path, notice: "your chosen user is manager"
  end

  def make_default_user
    @user = User.find(params[:id])
    @user.default_user!
    redirect_to users_path, notice: "your chosen user is default user"
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,:daily_calories, :name)
  end

  def user_params_current
    params.require(:user).permit(:email, :password, :password_confirmation,:daily_calories, :name, :current_password)
  end

  def check_status
    unless current_user.admin? || current_user.manager?
        flash[:notice] = "you can't perform such operation"
        redirect_to root_path
    end
  end

  def check_admin_and_manager
    user = User.find(params[:id])
    if current_user.manager? && user.admin?
      flash[:notice] = "you can't perform such operation"
      redirect_to root_path
    end
  end

end
