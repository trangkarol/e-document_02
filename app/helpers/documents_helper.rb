module DocumentsHelper
  def check_owner? owner_id
    current_user.id == owner_id
  end
end
