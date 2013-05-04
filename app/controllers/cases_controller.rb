class CasesController < ApplicationController
  before_filter :require_user_login, :except => [:index, :show]

  # GET /cases
  # GET /cases.json
  def index
    @q=params[:q]
    cas = Case.active.any_of({:title => /#{@q}/i}, {:description => /#{@q}/i})
    if params[:min_time].to_i > 0 && params[:max_time].to_i > 0
      if params[:min_time].to_i >  params[:max_time].to_i
        redirect_to cases_url, :alert => 'Minimum must be smaller than Maximum !'
      else
        cas = cas.where(:inst_months.gte => params[:min_time].to_i, :inst_months.lte =>  params[:min_time].to_i)
      end
    else
      if(params[:min_time].to_i > 0)
        cas = cas.where(:inst_months.gte => params[:min_time].to_i)
      elsif(params[:max_time].to_i > 0)
        cas = cas.where(:inst_months.lte =>  params[:max_time].to_i)
      end
    end
    if(params[:sort])
      case params[:sort]
      when 'newest'
        cas = cas.order_by(:created_at.desc)
      when 'popular'
        cas = cas.sort {|a,b| b.likers.count <=> a.likers.count}
      when 'most_lended'
        cas = cas.sort {|a,b| b.loans.active.count <=> a.loans.active.count}
      when 'almost_collected'
        cas = cas.sort {|a,b| b.collected_perc <=> a.collected_perc}
      end
    end
    @cases = cas.in_columns(3)
  end

  # GET /cases/1
  # GET /cases/1.json
  def show
    @case = Case.find(params[:id])
    if current_admin
      redirect_to admin_case_path(@case)
    end
  end

  def lend
    redirect_to root_url
  end

  def lender
    @case = Case.find(params[:id])
    # loans = Loan.where(:user => current_user, :case => @case, :collected => false)
    loan = Loan.create(params[:loan])
    loan.user = current_user
    loan.case = @case
    loan.save
    if @case.save
      redirect_to @case, notice: 'You\'ve successfully lended '+ @case.title
    else
      redirect_to @case, alert: 'Error prevented you from loaning '+ @case.title
    end
  end

  def like
    @case = Case.find(params[:id])
    @case.liker_ids << current_user.id
    @case.save
    if @case.save
      redirect_to @case, notice: 'You\'ve successfully Liked '+ @case.title
    else
      redirect_to @case, alert: 'Error prevented you from Liking '+ @case.title
    end
  end
  
  def unlike
    @case = Case.find(params[:id])
    @case.likers.delete(current_user)
    redirect_to @case, notice: 'You\'ve unLiked '+ @case.title
  end

end
