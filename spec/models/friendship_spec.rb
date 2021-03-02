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

  let(:third_user) { User.create(id: 3, name: 'luigi Mahrez', email: 'luigi@mahrez.com', password: 'mahrez') }
  let(:fourth_user) { User.create(id: 4, name: 'Jorge Martin', email: 'jorge@martin.com', password: 'martin') }

  let(:invitation) { Friendship.create(user_id: 3, friend_id: 4, status: 'pending')}

  before(:each) do
    current_user
    another_user
    third_user
    fourth_user
    invitation
  end


  scenario 'when a user gets invited to a friendship' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'yukihiro@mastsumoto.com'
    fill_in 'Password', with: 'matsumoto'
    click_on 'Log in'
    visit '/users'
    click_link 'users/2/friendships'
    # click_on 'Invite to friendship'
    expect(page).to have_content("Your friend request to #{another_user.name} is sent!")
  end

  scenario 'when a user accepts an invitation to a friendship' do

    visit '/users/sign_in'
    fill_in 'Email', with: 'jorge@martin.com'
    fill_in 'Password', with: 'martin'
    click_on 'Log in'
    visit '/users/4/friendships'
    expect(page).to have_content('Pending requests')
    # click_on 'Accept friendship'
    # expect(page).to have_content("You're now friends with to #{current_user.name}!")
  end
end
