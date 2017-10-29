module ApplicationHelper
  def check_current_url? url
    if asset_url(url) == request.original_url 
      "active"
    end
  end
end
