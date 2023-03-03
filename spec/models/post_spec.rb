require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'Tom', posts_counter: 1) }
  let(:post) { Post.create(author: user, text: 'This is my first post', likes_counter: 2, comments_counter: 1) }

  it 'increments the user posts counter' do
    user.increment!(:posts_counter)
    expect(user.posts_counter).to eq(2)
  end

  it 'is not valid without a title' do
    post.comments_counter = 0
    post.likes_counter = 0
    expect(post).not_to be_valid
  end

  it 'is not valid with a blank title' do
    post.title = ''
    post.comments_counter = 0
    post.likes_counter = 0
    expect(post).not_to be_valid
  end

  it 'is not valid with a negative comments_counter' do
    post.title = 'This is a title'
    post.comments_counter = -1
    post.likes_counter = 0
    expect(post).not_to be_valid
  end

  it 'is not valid with a negative likes_counter' do
    post.title = 'This is a title'
    post.comments_counter = 0
    post.likes_counter = -1
    expect(post).not_to be_valid
  end

  it 'is valid with a title non-negative counters' do
    post.title = 'This is a title'
    post.comments_counter = 0
    post.likes_counter = 0
    expect(post).to be_valid
  end

  it 'is not valid with a title longer than 250 characters' do
    post.title = 'a' * 251
    post.comments_counter = 0
    post.likes_counter = 0
    expect(post).not_to be_valid
    expect(post.title).to(satisfy { |title| title.length > 250 })
  end

  it 'post has likes' do
    expect(post.likes_counter).to(satisfy { |like| like > 1 })
  end
end
