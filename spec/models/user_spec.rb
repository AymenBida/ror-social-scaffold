require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    user = User.new(name: 'Yukihiro Matsumoto', email: 'yukihiro@mastsumoto.com', password: 'matsumoto')
    user.save
    expect(user).to be_valid
  end
  it 'is invalid without a name' do
    user = User.new(name: '', email: 'yukihiro@matsumoto.com', password: 'matsumoto')
    expect(user).to_not be_valid
  end
  it 'is invalid without an email' do
    user = User.new(name: 'Yukihiro Matsumoto', email: '', password: 'matsumoto')
    expect(user).to_not be_valid
  end
  it 'is invalid without a password' do
    user = User.new(name: 'Yukihiro Matsumoto', email: 'yukihiro@matsumoto.com', password: '')
    expect(user).to_not be_valid
  end
  it 'is invalid if password is less than 6 characters ' do
    user = User.new(name: 'Yukihiro Matsumoto', email: 'yukihiro@matsumoto.com', password: 'matsu')
    expect(user).to_not be_valid
  end
  it 'is invalid if name exceeds 20 characters ' do
    user = User.new(name: 'Yukihiro Matsumotomiyazaki', email: 'yukihiro@matsumoto.com', password: 'matsumoto')
    expect(user).to_not be_valid
  end
  describe 'assosiations' do
    it 'can have many posts' do
      user = User.reflect_on_association(:posts)
      expect(user.macro).to eql(:has_many)
    end
    it 'can have many comments' do
      user = User.reflect_on_association(:comments)
      expect(user.macro).to eql(:has_many)
    end
    it 'can have many likes' do
      user = User.reflect_on_association(:likes)
      expect(user.macro).to eql(:has_many)
    end
    it 'can have many frienships' do
      user = User.reflect_on_association(:friendships)
      expect(user.macro).to eql(:has_many)
    end
    it 'can have many inverse frienships' do
      user = User.reflect_on_association(:inverse_friendships)
      expect(user.macro).to eql(:has_many)
    end
  end
end

RSpec.feature 'Users' do
  before(:each) do
    User.create(name: 'Yukihiro Matsumoto', email: 'yukihiro@mastsumoto.com', password: 'matsumoto')
  end
  scenario 'User sign in successfully' do
    visit root_path
    fill_in 'user_email', with: 'yukihiro@mastsumoto.com'
    fill_in 'user_password', with: 'matsumoto'
    click_on 'Log in'
    expect(page).to have_content('Signed in successfully.')
  end
  scenario 'User sign in ends with failure' do
    visit root_path
    fill_in 'user_email', with: 'yukihiro@mastsumoto.com'
    fill_in 'user_password', with: 'matsum'
    click_on 'Log in'
    expect(page).to have_content('Invalid Email or password.')
  end
end
