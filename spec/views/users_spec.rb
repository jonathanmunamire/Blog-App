require 'rails_helper'

RSpec.describe User, type: :view do
  before :each do
    @user1 = User.create(name: 'Tim', photo: 'https://images.unsplash.com/photo-1511384452836-6',
                         bio: 'Teacher from Mexico.')
    @user2 = User.create(name: 'Will', photo: 'https://unsplash.com/photos/F_-0BxGuVv1', bio: 'Teacher from Mexico.')
    @user1.posts.create(title: 'User1 Title', text: 'Body1')
    @user2.posts.create(title: 'User2 Title', text: 'Body2')
  end

  it 'Should display username' do
    visit root_path
    expect(page).to have_content('Tim')
    expect(page).to have_content('Will')
  end

  it 'should display user photo' do
    visit root_path
    expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1511384452836-6']")
    expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVv1']")
  end

  it 'Should display number of posts for each user' do
    visit root_path
    expect(page).to have_content('Number of posts: 1')
  end

  it 'Redirects to the post show page when you click on a post' do
    visit root_path
    click_link 'Tim'
    expect(current_path).to eq(user_path(@user1.id))
  end

  it 'Should display username' do
    visit user_path(@user1.id)
    expect(page).to have_content('Tim')
  end

  it 'Should display user photo' do
    visit user_path(@user1.id)
    expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1511384452836-6']")
  end

  it 'Should display user bio' do
    visit user_path(@user1.id)
    expect(page).to have_content('Teacher from Mexico.')
  end

  it 'Should display number of posts each user has' do
    visit user_path(@user1.id)
    expect(page).to have_content('Number of posts: 1')
  end

  it 'Should display 3 last posts of user' do
    i = 1
    3.times do
      @user1.posts.create(title: "Post#{i}", text: 'Body')
      i += 1
    end
    visit user_path(@user1.id)
    expect(page).to have_content('Post')
    expect(page).to have_content('Post')
    expect(page).to have_content('Post')
  end

  it 'Should display see all posts button' do
    visit user_path(@user1.id)
    expect(page).to have_content('See all posts')
  end

  it 'Should display all user post' do
    visit user_path(@user1.id)
    click_link 'See all posts'
    expect(current_path).to eq(user_posts_path(@user1.id))
  end

  it 'Should display user photo' do
    visit user_posts_path(@user1.id)
    expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1511384452836-6']")
  end

  it 'Should display user name' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content('Tim')
  end

  it 'Should display user s posts count ' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content('Number of posts: 1')
  end

  it 'Should display post text' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content('Body1')
  end

  it 'Should display first comment' do
    @user1.comments.create(post_id: @user1.posts.first.id, text: 'Comment1')
    visit user_posts_path(@user1.id)
    expect(page).to have_content('Comment1')
  end
end
