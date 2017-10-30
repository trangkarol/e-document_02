module PaymentsHelper
  def check_status payment
    if payment.status == 0
      Settings.payment.not_pay
    elsif payment.status == 1
      Settings.payment.pay
    else
      Settings.payment.cancel
    end
  end

  def list_cost
    Coin.all
  end
end
