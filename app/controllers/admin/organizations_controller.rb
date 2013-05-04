class Admin::OrganizationsController < ApplicationController
  before_filter :require_admin_login
  
  # GET /admin/organizations
  # GET /admin/organizations.json
  def index
    @admin_organizations = Organization.active
    @admin_organization = Organization.new
  end
  def suspended
    @admin_organizations = Organization.suspends
  end
  # # GET /admin/organizations/1
  # # GET /admin/organizations/1.json
  # def show
  #   @admin_organization = Organization.find(params[:id])
  # end

  # # GET /admin/organizations/new
  # # GET /admin/organizations/new.json
  # def new
  #   @admin_organization = Organization.new
  # end

  # # GET /admin/organizations/1/edit
  # def edit
  #   @admin_organization = Organization.find(params[:id])
  # end

  # POST /admin/organizations
  # POST /admin/organizations.json
  def create
    @admin_organization = Organization.new(params[:organization])
    # @admin_organization.creator = current_admin
    if @admin_organization.save
      redirect_to admin_organizations_url, notice: 'Organization was successfully created.'
    else
      render action: 'index'
    end
  end

  # # PUT /admin/organizations/1
  # # PUT /admin/organizations/1.json
  # def update
  #   @admin_organization = Organization.find(params[:id])

  #     if @admin_organization.update_attributes(params[:organization])
  #       redirect_to @admin_organization, notice: 'Organization was successfully updated.'
  #     else
  #       render action: "edit"
  #     end
  # end
  def desuspend
    @admin_organization = Organization.find(params[:id])
    @admin_organization.suspended = false
    @admin_organization.save
    @admin_organization.admins.each do |admin|
      admin.suspended = false
      admin.save
    end    
    redirect_to admin_organizations_url
  end
  # DELETE /admin/organizations/1
  # DELETE /admin/organizations/1.json
  def destroy
    @admin_organization = Organization.find(params[:id])
    @admin_organization.suspended = true
    @admin_organization.save
    @admin_organization.admins.each do |admin|
      admin.suspended = true
      admin.save
    end
    redirect_to admin_organizations_url
  end
end
