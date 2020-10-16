require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Validate' do
    it 'the presence of content' do
      @user = User.create!(
        name: 'Test Name',
        email: 'test@email.com',
        gravatar_url: 'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?f=y',
        password: '123456'
      )

      @post = Post.create!(user_id: @user.id, content: 'this is a post! hi!')

      like = Like.create!(user_id: @user.id, post_id: @post.id)
      expect(like.valid?).to be true
    end

    it { should validate_uniqueness_of(:user_id).scoped_to(:post_id) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
