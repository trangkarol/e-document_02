class AddPaymentDatePresentToPayments < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :payment_date_present, :date
  end
end
