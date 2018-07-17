class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = t "active_success_smg"
      redirect_to user
    else
      flash[:danger] = t "active_failed_smg"
      redirect_to root_url
    end
  end
end
