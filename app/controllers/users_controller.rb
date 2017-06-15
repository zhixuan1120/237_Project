class UsersController < ApplicationController
  before_filter :signed_in_user,  only: [:index, :edit, :update]
  before_filter :correct_user,    only: [:eidt, :update, :show]
  before_filter :admin_user,      only: :destroy

  def create
      @user = User.new(user_params)
      if @user.save
        @user.update_attribute(:inform, false)  
      end
  end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if params[:mode] == false
      if @user.update_attributes(params[:user])
        flash[:success] = "Profile Updated"
        sign_in @user
        redirect_to @user
      else
        render 'edit'
      end
    else
      @user.update_attribute(:inform, true)
    end
  end

  def help
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
      redirect_to(root_path) unless current_user.admin?
  end

  private
  # Action Controller parameters are forbidden to be used in Active Model mass assignments 
  # until they have been whitelisted.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
