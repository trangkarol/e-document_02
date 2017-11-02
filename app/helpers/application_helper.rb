module ApplicationHelper
  def check_current_url? url
    check = asset_url(url) == request.original_url
    check ? Settings.active : ""
  end
end
