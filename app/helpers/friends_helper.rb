module FriendsHelper
  def check_friend? member
    current_user.friends.check_friend(member.id).empty?
  end

  def determine_friend_user member
    if member.user_id == current_user.id
      member.friend
    else
      member.user
    end
  end
end
