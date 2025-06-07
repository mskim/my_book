class AccountsController < ApplicationController
  include Pagy::Backend

  before_action :set_account, only: [:edit, :update, :switch, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @accounts = current_user.accounts.all
    @account = current_user.accounts.last
    @pagy, @accounts = pagy(@accounts, items: 12)
  end

  def new
    @account = current_user.accounts.new
  end

  def create
    @account = current_user.accounts.new(account_params)
    if @account.save
      cookies[:current_account] = @account.slug
      @account.account_users.find_or_create_by(user: current_user)
      redirect_to account_settings_path(@account.slug), notice: 'Account was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @account.update(account_params)
      redirect_to account_settings_path(@account.slug), notice: 'Account was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def switch
    if @account
      cookies[:current_account] = @account.slug
      redirect_to root_path, notice: "Switched to #{@account.name}."
    else
      redirect_to accounts_path, alert: "You don't have access to this account."
    end
  end

  def destroy
    @account.destroy
    redirect_to accounts_path, notice: 'Account was successfully destroyed.'
  end

  private

  def set_account
    @account = Account.find_by!(slug: params[:account_slug])
  end

  def account_params
    params.require(:account).permit(:name, :slug, :owner_id)
  end

  def authorize_user
    unless current_user.account_admin?(@account)
      redirect_to root_path, alert: "You don't have permission to do that."
    end
  end
end
