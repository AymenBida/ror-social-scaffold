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
  let(:current_user) { User.create(name: 'Yukihiro Matsumo', email: 'yukihiro@mastsumoto.com', password: 'matsumoto') }

  let(:another_user) { User.create(name: 'Yubei Miyazaki', email: 'yubei@miyazaki.com', password: 'miyazaki') }

  before(:each) do
    current_user
  end
  before(:each) do
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
end
