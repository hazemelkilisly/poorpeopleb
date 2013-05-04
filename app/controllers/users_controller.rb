class UsersController < ApplicationController
  before_filter :require_user_login, :except=> [:show]

  def show
    @user = User.find(params[:id])
  end

  def settings
    @user = current_user
    p current_admin
  end

  def update_settings
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to settings_users_path, notice: 'Settings Succesfully updated.'
    else
      render action: "settings"
    end
  end

  def update_password
    @user = current_user
    if @user.update_attributes(params[:user])
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to settings_users_path, notice: 'Password Succesfully Changed!'
    else
      render action: "settings"
    end
  end

  def credit
    @user = current_user
  end

  def withdraw
    payback = PayBack.find(params[:id])
    payback.update_attribute(:withdrawn,true)
    redirect_to credit_users_path,:notice=>"You've Succesfully withdrown you PayBack"
  end
end
