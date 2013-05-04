class Admin::LoansController < ApplicationController
  before_filter :require_admin_login

  # GET /admin/admins
  # GET /admin/admins.json
  def index
    @admin_loans = Loan.pending
  end
  # # GET /admin/admins/1
  # # GET /admin/admins/1.json
  # def show
  #   @admin_admin = Admin.find(params[:id])
  # end

  # # GET /admin/admins/new
  # # GET /admin/admins/new.json
  # def new
  #   @admin_admin = Admin.new
  # end

  # # GET /admin/admins/1/edit
  # def edit
  #   @admin_admin = Admin.find(params[:id])
  # end

  # # POST /admin/admins
  # # POST /admin/admins.json
  # def create
  #   @admin_admin = Admin.new(params[:admin])
  #   @admin_admin.password = "123456"
  #   @admin_admin.admin_creator = current_admin
  #     if @admin_admin.save
  #       redirect_to admin_admins_url, notice: 'Admin was successfully created, he can now Sign-in.'
  #     else
  #       render action: "new"
  #     end
  # end

  # # PUT /admin/admins/1
  # # PUT /admin/admins/1.json
  # def update
  #   @admin_admin = Admin.find(params[:id])

  #     if @admin_admin.update_attributes(params[:admin])
  #       redirect_to @admin_admin, notice: 'Admin was successfully updated.'
  #     else
  #       render action: "edit"
  #     end
  # end

  # DELETE /admin/admins/1
  # DELETE /admin/admins/1.json
  def destroy
    @admin_loan = Loan.find(params[:id])
    @admin_loan.collected = true
    @admin_loan.save

    redirect_to admin_loans_url
  end
end
