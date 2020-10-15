require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before(:each) do
    @user = User.create!(
        name: 'Test Name',
        email: 'test@email.com',
        gravatar_url: 'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?f=y',
        password: '123456'
    )
    sign_in @user
  end

  describe '#create post' do
    context 'with valid params' do
      it 'creates a new post' do
        post :create, params: { post: { content: 'Hi I am a post!' } }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(posts_path)
        expect(flash[:notice]).to match(/Post was successfully created./)
      end
    end

    context 'with invalid params' do
      it 'gives an error' do
        post :create, params: { post: { content: 1 } }
        expect(response).to have_http_status(302)
      end
    end
  end
end