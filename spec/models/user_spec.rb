require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  user = User.create!(
    name: 'Test Name',
    email: 'test@emaill.com',
    gravatar_url: 'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?f=y',
    password: '123456'
  )

  describe 'Validates' do
    it 'the presence of content' do
      expect(user.valid?).to be true
    end

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(20) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end

  describe 'associations' do
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:friendships) }
    it { should have_many(:posts) }
    it { should have_many(:inverted_friendships) }
    it { should have_many(:friend_requests) }
    it { should have_many(:pending_friendships) }
    it { should have_many(:pending_requests) }
  end

  describe '#friends' do
    it 'should return array of friends' do
      expect(user.friends).to be_an_instance_of(Array)
    end
  end
end
