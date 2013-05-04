class Admin::UsersController < ApplicationController
  before_filter :require_admin_login
  
  # GET /admin/users
  # GET /admin/users.json
  def index
    @admin_users = User.active
  end
  def suspended
    @admin_users = User.suspends
  end

  # # GET /admin/users/1
  # # GET /admin/users/1.json
  # def show
  #   @admin_user = User.find(params[:id])
  # end

  # # GET /admin/users/new
  # # GET /admin/users/new.json
  # def new
  #   @admin_user = User.new
  # end

  # # GET /admin/users/1/edit
  # def edit
  #   @admin_user = Admin::User.find(params[:id])
  # end

  # # POST /admin/users
  # # POST /admin/users.json
  # def create
  #   @admin_user = Admin::User.new(params[:admin_user])

  #   if @admin_user.save
  #     format.html { redirect_to @admin_user, notice: 'User was successfully created.' }
  #   else
  #     format.html { render action: "new" }
  #   end
  # end

  # # PUT /admin/users/1
  # # PUT /admin/users/1.json
  # def update
  #   @admin_user = Admin::User.find(params[:id])

  #   respond_to do |format|
  #     if @admin_user.update_attributes(params[:admin_user])
  #       format.html { redirect_to @admin_user, notice: 'User was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @admin_user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  def desuspend
    @admin_user = User.find(params[:id])
    @admin_user.suspended = false
    @admin_user.save
    redirect_to admin_users_url
  end
  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @admin_user = User.find(params[:id])
    @admin_user.suspended = true
    @admin_user.save
    redirect_to admin_users_url
  end
end
