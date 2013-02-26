class LoansController < ApplicationController
  def index
    @loans = Loan.paginate(page: params[:page])
    @title = "All Loans"
  end
  

  def show
    @loan = Loan.find(params[:id])
    @am = Array.new

    # Declare Variables
    term = (0..(@loan.term.to_i * 12)).to_a
    @payment = -((@loan.amount * (1 - @loan.down)) * ((@loan.rate / 12) / (1 - (
               1 + (@loan.rate / 12) * ( 12 * @loan.term))))*100).round / 100.0
    variables = Hash.new
    variables = { value: @loan.amount, principal: ( @loan.amount * (1 - @loan.down)),
                  total_fees: 0, interest: 0, total_int: 0, total_expense: 0 }

    term.each do |i|
      variables[:month] = i
      @am << variables.dup
      variables[:value] = variables[:value] * ( @loan.appriciation / 12 + 1 )
      variables[:total_fees] = variables[:total_fees] + @loan.fees
      variables[:interest] = variables[:principal] * ( @loan.rate / 12 )
      variables[:total_int] = variables[:interest] + variables[:total_int]
      variables[:total_expense] = variables[:total_fees] + variables[:total_int] - (
                                  variables[:value] - @loan.amount)
      variables[:principal] = variables[:principal] - @payment
    end
  end

  def new
    @loan = Loan.new
    @title = "New Loan"
  end

  def create
    @loan = Loan.new(params[:loan])
    if @loan.save
      redirect_to loan_path(@loan), notice: "Successfully created loan."
    else
      render :action => :new
    end
  end

  def edit
    @loan = Loan.find(params[:id])
  end

  def update
    @loan = Loan.find(params[:id])
    if @loan.update_attributes(params[:loan])
      redirect_to loan_assessment_path(@loan, @assessment), notice: "Successfully updated loan."
    else
      render :edit
    end
  end

  def destroy
    @loan = Loan.find(params[:id])
    @loan.destroy
    redirect_to loan_path(@loan), notice: "Successfully destroyed loan"
  end
end
