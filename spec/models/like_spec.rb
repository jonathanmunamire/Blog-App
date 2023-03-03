require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'Tom') }
  let(:post) { Post.create(author: user, text: 'This is my first post', likes_counter: 1) }

  it 'increments the post likes counter' do
    post.increment!(:likes_counter)
    expect(post.likes_counter).to eq(2)
  end
end
