module PostHelper
  def display_errors(post)
    return unless post.errors.full_messages.any?

    content_tag :p, "Post could not be saved. #{post.errors.full_messages.join('. ')}", class: 'errors'
  end

  def likes_count(post)
    post.likes
  end

  def check_current_user_post(post)
    post.user.id == current_user.id
  end

  def check_friends_post(post)
    current_user.friends.pluck(:id).any?(post.user.id)
  end

  def check_post_owner(post)
    check_current_user_post(post) || check_friends_post(post)
  end

  def show_friends_posts(posts)
    posts.each do |post|
      if check_post_owner(post)
        render 'posts/post', post: post
      end
    end
  end


end
