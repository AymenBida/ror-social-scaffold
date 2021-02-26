require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'assosiations' do
    it 'belongs to one user' do
      comment = Comment.reflect_on_association(:user)
      expect(comment.macro).to eql(:belongs_to)
    end
    it 'belongs to one post' do
      comment = Comment.reflect_on_association(:post)
      expect(comment.macro).to eql(:belongs_to)
    end
  end
end

RSpec.feature 'Comments' do
  before(:each) do
    User.create(name: 'Yukihiro Matsumoto', email: 'yukihiro@mastsumoto.com', password: 'matsumoto')
  end

  scenario 'when a user tries to make a comment with an empty field' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'yukihiro@mastsumoto.com'
    fill_in 'Password', with: 'matsumoto'
    click_on 'Log in'
    visit root_path
    fill_in 'post_content', with: 'I made Ruby'
    click_on 'Save'
    fill_in 'comment_content', with: nil
    click_on 'Comment'
    expect(page).to have_content("Content can't be blank")
  end
  scenario 'when a user tries to make a valid comment' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'yukihiro@mastsumoto.com'
    fill_in 'Password', with: 'matsumoto'
    click_on 'Log in'
    visit root_path
    fill_in 'post_content', with: 'I made Ruby'
    click_on 'Save'
    fill_in 'comment_content', with: 'Nice!'
    click_on 'Comment'
    expect(page).to have_content('Comment was successfully created.')
  end
end
