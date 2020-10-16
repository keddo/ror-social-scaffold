require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validate' do
    it 'the presence of content' do
      @user = User.create!(
        name: 'Test Name',
        email: 'test@email.com',
        gravatar_url: 'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?f=y',
        password: '123456'
      )

      @post = Post.create!(user_id: @user.id, content: 'this is a post! hi!')

      comment = Comment.create!(user_id: @user.id, post_id: @post.id, content: 'This is a comment! Hey!')

      expect(comment.valid?).to be true
    end

    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).is_at_most(200).with_long_message('200 characters in comment is the maximum allowed.') }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
