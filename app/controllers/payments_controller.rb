class PaymentsController < ApplicationController
  before_action :load_user_url, only: [:index, :new]
  before_action :logged_in_user, only: [:index, :new, :destroy]
  before_action :list_friend_request, only: [:index, :new, :create]
  before_action :list_friends_accept, only: [:index, :new, :create]
  before_action :list_document_history, only: [:index, :new, :create]
  before_action :load_payment, only: [:destroy]

  def index
    list_payments
    respond_to do |format|
      format.html{head :no_content}
      format.js
    end
  end

  def new
    @payment = Payment.new
  end

  def create
    @payment = current_user.payments.build payment_params
    if @payment.save
      current_user.update_buy_coin total_coins
      flash[:success] = t "payment.buycoin_success"
      redirect_to user_payments_index_path(current_user)
    else
      render :new
    end
  end

  def destroy
    if @payment.destroy
      flash[:success] = t "payment.delete_suceess"
    else
      flash[:danger] = t "payment.delete_fail"
    end
    redirect_to user_payments_index_path(current_user)
  end

  private

  def list_payments
    @payments = current_user.payments.includes(:coin).paginate(page: params[:page], per_page: Settings.paginate_number)
  end

  def payment_params
    params.require(:payment).permit :coin_id, :number, :payment_date_estimate
  end

  def total_coins
    coin = @payment.coin
    coin.number_coins * @payment.number
  end

  def load_payment
    @payment =  Payment.find_by_id params[:format]
    return if @payment
    flash[:danger] = t "payment.payment_not_found"
    redirect_to user_payments_index_path(current_user)
  end
end
