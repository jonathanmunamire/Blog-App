require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 1) }

  it 'has name attribute' do
    expect(user.name).to eq 'Tom'
  end

  it 'has photo attribute' do
    expect(user.photo).to eq 'https://unsplash.com/photos/F_-0BxGuVvo'
  end

  it 'has bio attribute' do
    expect(user.bio).to eq 'Teacher from Mexico.'
  end

  context 'validations' do
    it 'is valid with a name and a non-negative posts counter' do
      user = User.new(name: 'Tom', posts_counter: 0)
      user2 = User.new(name: 'Tom', posts_counter: 1)

      expect(user).to be_valid
      expect(user2).to be_valid
    end

    it 'is invalid without a name' do
      user = User.new(posts_counter: 0)
      expect(user).to_not be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'is invalid with a negative posts counter' do
      user = User.new(name: 'Tom', posts_counter: -1)
      expect(user).to_not be_valid
      expect(user.errors[:posts_counter]).to include('must be greater than or equal to 0')
    end
  end
end
