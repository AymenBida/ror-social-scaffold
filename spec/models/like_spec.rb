require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'assosiations' do
    it 'belongs to one post' do
      like = Like.reflect_on_association(:post)
      expect(like.macro).to eql(:belongs_to)
    end
    it 'belongs to one user' do
      like = Like.reflect_on_association(:user)
      expect(like.macro).to eql(:belongs_to)
    end
  end
end
