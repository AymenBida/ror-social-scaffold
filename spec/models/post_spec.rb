require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'assosiations' do
    it 'can have many likes' do
      post = Post.reflect_on_association(:likes)
      expect(post.macro).to eql(:has_many)
    end
    it 'can have many comments' do
      post = Post.reflect_on_association(:comments)
      expect(post.macro).to eql(:has_many)
    end
    it 'belongs to one user' do
      post = Post.reflect_on_association(:user)
      expect(post.macro).to eql(:belongs_to)
    end
  end
end

RSpec.feature 'Posts' do
  before(:each) do
    User.create(name: 'Yukihiro Matsumoto', email: 'yukihiro@mastsumoto.com', password: 'matsumoto')
  end

  scenario 'when a user tries to send a post with an empty field' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'yukihiro@mastsumoto.com'
    fill_in 'Password', with: 'matsumoto'
    click_on 'Log in'
    visit root_path
    fill_in 'post_content', with: nil
    click_on 'Save'
    expect(page).to have_content("Post could not be saved. Content can't be blank")
  end
  scenario 'when a user makes a valid post' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'yukihiro@mastsumoto.com'
    fill_in 'Password', with: 'matsumoto'
    click_on 'Log in'
    visit root_path
    fill_in 'post_content', with: 'post sent'
    click_on 'Save'
    expect(page).to have_content('Post was successfully created.')
  end
end
