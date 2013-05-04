class Admin::AdminsController < ApplicationController
  before_filter :require_admin_login

  def index
    @admin_admins = Admin.active
    @admin_admin = Admin.new
  end
  def suspended
    @admin_admins = Admin.suspends
  end

  def settings
    @admin_admin = current_admin
  end

  def update_settings
    @admin = current_admin
    if @admin.update_attributes(params[:admin])
      redirect_to settings_admin_admins_path, notice: 'Settings Succesfully updated.'
    else
      render action: "settings"
    end
  end

  def update_password
    @admin = current_admin
    if @admin.update_attributes(params[:admin])
      # Sign in the admin by passing validation in case his password changed
      sign_in @admin, :bypass => true
      redirect_to settings_admin_admins_path, notice: 'Password Succesfully Changed!'
    else
      render action: "settings"
    end
  end

  def show
    @admin_admin = Admin.find(params[:id])
  end

  def create
    @admin_admin = Admin.new(params[:admin])
    @admin_admin.password = "123456"
    @admin_admin.admin_creator = current_admin
    if @admin_admin.save
      redirect_to admin_admins_url, notice: 'Admin was successfully created, he can now Sign-in.'
    else
      render action: 'index'
    end
  end

  def desuspend
    @admin_admin = Admin.find(params[:id])
    @admin_admin.suspended = false
    @admin_admin.save
    redirect_to admin_admins_url
  end

  def destroy
    @admin_admin = Admin.find(params[:id])
    @admin_admin.suspended = true
    @admin_admin.save
    redirect_to admin_admins_url
  end
end