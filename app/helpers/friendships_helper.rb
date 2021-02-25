module FriendshipsHelper
  def show_invite_button(user)
    if !current_user.friend?(user) and current_user != user
      link_to 'Invite to friendship', user_friendships_path(user), method: :post, class: 'btn btn-secondary'
    end
  end
end
