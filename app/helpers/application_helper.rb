module ApplicationHelper
  def check_current_url? url
    if asset_url(url) == request.original_url
      Settings.active
    end
  end

  def no_show_member? url
    if check_current_url?(url) == Settings.active
      "no-member"
    end
  end
end
