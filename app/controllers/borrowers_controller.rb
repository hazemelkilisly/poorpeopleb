class BorrowersController < ApplicationController

  def show
    @borrower = Borrower.find(params[:id])
  end

end
