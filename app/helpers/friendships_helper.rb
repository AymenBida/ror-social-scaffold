module FriendshipsHelper
  def show_invite_button(user)
    if current_user.request_sent?(user)
      link_to 'Invitation sent', '#', class: 'btn btn-secondary disabled', disabled: true
    elsif current_user.request_recieved?(user)
      link_to 'Accept friendship', user_accept_path(user), method: :post, class: 'btn btn-secondary'
    elsif !current_user.friend?(user) and current_user != user
      link_to 'Invite to friendship', user_friendships_path(user), method: :post, class: 'btn btn-secondary'
    end
  end
end
