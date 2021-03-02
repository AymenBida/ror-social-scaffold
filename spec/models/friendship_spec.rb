# rubocop:disable Metrics/BlockLength
# rubocop:disable Layout/LineLength

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'associations' do
    it 'belongs to one user' do
      friend = Friendship.reflect_on_association(:user)
      expect(friend.macro).to eql(:belongs_to)
    end
    it 'belongs to one user' do
      friend = Friendship.reflect_on_association(:friend)
      expect(friend.macro).to eql(:belongs_to)
    end
  end
end

RSpec.feature 'Friendships' do
  let(:current_user) { User.create(id: 1, name: 'Yukihiro Matsumo', email: 'yukihiro@mastsumoto.com', password: 'matsumoto') }
  let(:another_user) { User.create(id: 2, name: 'Yubei Miyazaki', email: 'yubei@miyazaki.com', password: 'miyazaki') }

  before(:each) do
    current_user
    another_user
  end

  scenario 'when a user gets invited to a friendship' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'yukihiro@mastsumoto.com'
    fill_in 'Password', with: 'matsumoto'
    click_on 'Log in'
    visit '/users'
    click_on 'Invite to friendship'
    expect(page).to have_content("Your friend request to #{another_user.name} is sent!")
  end

  scenario 'when a user accepts an invitation to a friendship' do
    Friendship.create(user_id: 2, friend_id: 1, status: 'pending')
    visit '/users/sign_in'
    fill_in 'Email', with: 'yukihiro@mastsumoto.com'
    fill_in 'Password', with: 'matsumoto'
    click_on 'Log in'
    visit '/users/1/friendships'
    click_on 'Accept friendship'
    expect(page).to have_content("You are now friends with #{another_user.name}!")
  end

  scenario 'when a user denies an invitation to a friendship' do
    Friendship.create(user_id: 2, friend_id: 1, status: 'pending')
    visit '/users/sign_in'
    fill_in 'Email', with: 'yukihiro@mastsumoto.com'
    fill_in 'Password', with: 'matsumoto'
    click_on 'Log in'
    visit '/users/1/friendships'
    click_on 'Deny'
    expect(page).to have_content("You just denied the invitation from #{another_user.name}!")
  end
end

# rubocop:enable Metrics/BlockLength
# rubocop:enable Layout/LineLength
