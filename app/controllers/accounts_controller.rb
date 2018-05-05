class AccountsController < ApplicationController
  before_action :set_account, only: %i[show update destroy]

  # GET /accounts
  def index
    @accounts = Account.all

    render json: @accounts
  end

  # GET /accounts/1
  def show
    render json: @account
  end

  # POST /accounts
  def create
    @account = Account.new(account_params)

    if @account.save
      render json: @account, status: :created, location: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accounts/1
  def update
    if @account.update(account_params)
      render json: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy
  end

  # PUT /accounts/debit/1
  def debit
    set_account
    @account.balance -= params[:debit]
    if @account.save
      render json: @account, status: :ok, location: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # PUT /accounts/credit/1
  def credit
    set_account
    @account.balance += params[:credit]
    if @account.save
      render json: @account, status: :ok, location: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def account_params
    params.require(:account).permit(:name, :person_id, :balance)
  end
end
