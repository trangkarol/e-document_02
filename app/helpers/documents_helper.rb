module DocumentsHelper
  def check_owner? owner_id
    current_user.id == owner_id
  end

  def check_like document, current_user
    return if document.check_like_document current_user.id
    Settings.active
  end
end
