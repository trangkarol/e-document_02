module ApplicationHelper
  def check_current_url? url
    unless asset_url(url) == request.original_url
      Settings.active
    end
  end
end
