module FriendsHelper
  def check_friend_request? member, status
    @check = Friend.check_friend(status, member.id, current_user.id)
    @check.any?
  end

  def determine_friend_user member
    member.user_id == current_user.id ? member.friend : member.user
  end
end
