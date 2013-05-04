class Admin::BorrowersController < ApplicationController
  before_filter :require_admin_login
  
  # GET /admin/borrowers
  # GET /admin/borrowers.json
  def index
    @admin_borrowers = Borrower.all
    @admin_borrower = Borrower.new
  end

  # # GET /admin/borrowers/1
  # # GET /admin/borrowers/1.json
  # def show
  #   @admin_borrower = Borrower.find(params[:id])
  # end

  # GET /admin/borrowers/new
  # GET /admin/borrowers/new.json
  # def new
  #   @admin_borrower = Borrower.new

  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @admin_borrower }
  #   end
  # end

  # # GET /admin/borrowers/1/edit
  # def edit
  #   @admin_borrower = Borrower.find(params[:id])
  # end

  # POST /admin/borrowers
  # POST /admin/borrowers.json
  def create
    @admin_borrower = Borrower.new(params[:borrower])
    @admin_borrower.creator = current_admin
      if @admin_borrower.save
        redirect_to admin_borrowers_url, notice: 'Borrower was successfully created.'
      else
        render action: "index"
      end
  end

  # # PUT /admin/borrowers/1
  # # PUT /admin/borrowers/1.json
  # def update
  #   @admin_borrower = Borrower.find(params[:id])

  #   if @admin_borrower.update_attributes(params[:borrower])
  #     redirect_to @admin_borrower, notice: 'Borrower was successfully updated.'
  #   else
  #     render action: "edit"
  #   end
  # end

  # DELETE /admin/borrowers/1
  # DELETE /admin/borrowers/1.json
  def destroy
    @admin_borrower = Borrower.find(params[:id])
    @admin_borrower.suspend = true
    @admin_borrower.save
    redirect_to admin_borrowers_url
  end
end
