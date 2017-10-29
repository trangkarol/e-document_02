module FriendsHelper
  def check_friend_request? member, status
    @check = Friend.check_friend(status, member.id, current_user.id)
    !@check.empty? 
  end

  def determine_friend_user member
    if member.user_id == current_user.id
      member.friend
    else
      member.user
    end
  end
end
