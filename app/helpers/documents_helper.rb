module DocumentsHelper
  def check_owner? owner_id
    current_user.id == owner_id
  end

  def check_like document, current_user
    return if document.check_like_document current_user.id
    Settings.active
  end

  def total_money coin_cost, number
    coin_cost * number
  end

  def total_coins number_coins, number
    number_coins * number
  end
end
