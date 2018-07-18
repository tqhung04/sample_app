class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :getUserById, only: [:show, :edit, :update, :destroy, :correct_user]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.where(activated: true).page(params[:page]).per_page Settings.page.per_page
  end

  def show
    redirect_to root_url and return unless @user.activated
    @microposts = @user.microposts.paginate(page: params[:page]).per_page Settings.page.per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t(:check_account_active)
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    redirect_to root_url unless @user.present?
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "profile_updated_success_msg"
      redirect_to @user
    else
      flash[:success] = t "profile_updated_failed_msg"
      render :edit
    end
  end

  def destroy
    if @user.destroy.destroyed?
      flash[:success] = t "profile_delete_success_msg"
    else
      flash[:danger] = t "profile_delete_failed_msg"
    end

    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit :name, :email, :password, :password_confirmation
    end

    def correct_user
      redirect_to root_url unless current_user? @user
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end

    def getUserById
      @user = User.find_by id: params[:id]
    end
end
