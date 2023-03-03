require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'Tom') }
  let(:post) { Post.new(author: user, text: 'This is some text', comments_counter: 1) }
  let(:comment) { Comment.new(post: post, author: user, text: 'Hi Tom!') }

  it 'increments the post comments counter' do
    post.increment!(:comments_counter)
    expect(post.comments_counter).to eq(2)
  end
end
