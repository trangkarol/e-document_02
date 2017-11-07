class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :coin

  validates :payment_date_estimate, presence: true
  validates :number, presence: true
  validate :payment_date_estimate_cannot_be_in_the_past

  def payment_date_estimate_cannot_be_in_the_past
    if payment_date_estimate.present? && payment_date_estimate < Date.today
      errors.add(:payment_date_estimate, I18n.t("payment.less_then_today"))
    end
  end
end
