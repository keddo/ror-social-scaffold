require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before(:each) do
    @user = User.create!(
        name: 'Test Name',
        email: 'test@email.com',
        gravatar_url: 'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?f=y',
        password: '123456'
    )
    sign_in @user
    @post = Post.create!(user_id: @user.id, content: 'this is a post! hi!')
    request.env['HTTP_REFERER'] = '/posts'
  end

  describe 'Post #create of comments' do
    context 'with valid params' do
      it 'creates a new post' do
        post :create, params: { post_id: @post.id, user_id: @user.id, comment: { content: 'abcd' } }
        expect(response).to have_http_status(302)
        expect(flash[:notice]).to match(/Comment was successfully created./)
      end
    end

    context 'with invalid params' do
      it 'renders current template' do
        post :create, params: { post_id: @post.id, user_id: @user.id, comment: { content: '' } }
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to match(/Content can't be blank/)
      end
    end
  end
end