class Admin::CasesController < ApplicationController
  before_filter :require_admin_login
  
  # GET /admin/cases
  # GET /admin/cases.json
  def index
    @admin_cases = Case.active
    @admin_case = Case.new
  end

  def suspended
    @admin_cases = Case.suspends
  end

  def show
    @case = Case.find(params[:id])
    @installment = Installment.new
  end

  # POST /admin/cases
  # POST /admin/cases.json
  def create
    params[:case][:owner_ids].shift
    @admin_case = Case.new(params[:case])
    @admin_case.creator = current_admin
      if @admin_case.save
        redirect_to admin_cases_url, notice: 'Case was successfully created.'
      else
        render action: "index"
      end
  end

  #POST
  def desuspend
    @case = Case.find(params[:id])
    @case.suspended = false
    @case.save
    redirect_to admin_cases_url 
  end

  # DELETE /admin/cases/1
  # DELETE /admin/cases/1.json
  def destroy
    @case = Case.find(params[:id])
    @case.suspended = true
    @case.save
    redirect_to admin_cases_url 
  end

  #POST
  def add_installment

    unless ((params[:payment_date] == "" && params[:default_date] == 'false' ) || (params[:quantity] == "" && params[:default_inst] == 'false'))
      @case = Case.find(params[:id])
      @installment = Installment.new
      if (params[:default_inst] == 'true')
        @installment.quantity = @case.inst_value
      else
        @installment.quantity = params[:quantity]
        if (params[:extra_inst] == 'true')
          @case.postponed_insts += 1
          @case.save
        end
      end

      # pay_date = params[:payment_date]
      if params[:default_date] == 'true'
        @installment.payment_date = @case.inst_timing(@case.current_inst)
      else
        @installment.payment_date = params[:payment_date]
      end

      late_test = @case.inst_late_by(@installment.payment_date.year,@installment.payment_date.month,@installment.payment_date.day)
      @installment.days_diff = late_test

      @installment.number = @case.current_inst
      @installment.case = @case 
      @installment.creator = current_admin
      @installment.save

      @case.loans.active_payable.each do |loan|
        @payback = PayBack.new
        @payback.quantity = ((loan.percentage / 100.0) * @installment.quantity).round(2)
        @payback.paid_to = loan.user
        @payback.from_installment = @installment
        @payback.from_loan = loan
        @payback.save
      end
      redirect_to admin_case_path(@case), :notice => "Successfully created installment."
    else
      redirect_to admin_cases_path, :alert => "Unsuccessful creation of installment, please try again! \n You must enter Quantity and choose Payment Date."
    end
    
  end

end
