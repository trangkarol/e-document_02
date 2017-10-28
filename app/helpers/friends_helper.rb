module FriendsHelper
  def check_friend? member
    current_user.friends.check_friend(member.id).empty?
  end
end
