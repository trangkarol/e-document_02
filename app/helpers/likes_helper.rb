module LikesHelper
  def list_user document
    list_liked = ""
    case document.number_of_like
      when 1
        list_liked += check_user_like(document.likes.first)
      when 2
        document.likes.each_with_index do |like, index| 
          list_liked +=  check_user_like(like)
          if index == 0
            list_liked += I18n.t("like.and")
          end
        end
      else
        document.likes.each_with_index do |like, index|
          if index == 0
            list_liked += check_user_like(like) + ", "
          elsif index == 1
            list_liked += check_user_like(like) + "<a data-toggle='modal' href='#squarespaceModal' id='list-liked'>" + I18n.t("like.and_more") + "</a>" 
          end  
        end
    end
    list_liked.html_safe
  end

  def check_user_like like
    if like.user.id == current_user.id
      I18n.t("like.you_like")
    else
      like.user.name
    end
  end
end
