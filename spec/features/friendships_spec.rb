require 'rails_helper'

feature 'create a friendship' do
  before(:each) do
    @user1 = User.create!(name: 'Test',
                          email: 'test@example.com',
                          password: 'cake,biscuitsandtea')
    @user2 = User.create!(name: 'Test2',
                          email: 'test2@example.com',
                          password: 'cake,biscuitsandtea')
    sign_in @user1
    visit users_path
  end

  scenario 'create friendship between two users' do
    expect(page).to have_content 'Action'
  end

  feature 'send a request' do
    before(:each) do
      first(:link, 'Add Friend').click
    end

    scenario 'renders user page' do
      expect(page).to have_content 'Request sent'
    end
  end

  feature 'accept a request' do
    before(:each) do
      visit users_path

      first(:link, 'Add Friend').click
      sign_out @user1
      sign_in @user2
      visit users_path
    end

    scenario 'renders friend requests page' do
      expect(page).to have_content @user1.name.to_s
    end

    scenario 'renders Accept friend Request page' do
      visit users_path
      first(:link, 'Accept').click
      expect(page).to have_content "Congrats! You added #{@user1.name} to your friend list!"
    end

    scenario ' Rejecting a friend Request' do
      visit users_path
      first(:link, 'Reject').click
      expect(page).to have_content "You canceled #{@user1.name} friend request!"
    end
  end
end
