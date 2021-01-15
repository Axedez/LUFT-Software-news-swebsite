class Account::Admin::UsersController < Account::Admin::AdminController
  before_action :set_user, only: %i[edit update destroy]

  def index
    @users = User.all.order(:id).page params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to account_admin_users_path
      flash[:success] = "New user with name: \"#{@user.username}\" and id:#{@user.id} has been succesfully created!"
    else
      flash.now[:danger] = 'Something was wrong'
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'Profile updated'
      redirect_to account_admin_users_path
    else
      flash.now[:warning] = 'Invalid parameters for editing!'
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:danger] = "User profile with email: \"#{@user.email}\" and id:#{@user.id} has been deleted"
    redirect_to account_admin_users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :role, :password, :password_confirmation)
  end
end
