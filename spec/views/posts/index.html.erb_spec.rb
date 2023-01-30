require 'rails_helper'

RSpec.describe 'Post index', type: :feature do
  before(:each) do
    @user1 = User.create(
      name: 'Peter Parker',
      bio: 'Official spiderman hotographer',
      photo: 'https://www.example.com',
      posts_counter: 0
    )

    @user2 = User.create(
      name: 'Bruce Wayne',
      bio: 'Millionaire',
      photo: 'https://www.example.com',
      posts_counter: 0
    )

    @post1 = Post.create(
      author_id: @user1.id,
      title: 'First post',
      text: 'This is my first post',
      comments_counter: 0,
      likes_counter: 0
    )

    @post2 = Post.create(
      author_id: @user2.id,
      title: 'Hello World',
      text: 'My first post too!',
      comments_counter: 0,
      likes_counter: 0
    )

    # First post interactions
    Comment.create(post_id: @post1.id, author_id: @user1.id, text: 'First comment! Wow')
    Comment.create(post_id: @post1.id, author_id: @user2.id, text: 'Nice post BTW')
    Comment.create(post_id: @post1.id, author_id: @user2.id, text: 'Yeah I agree')

    Like.create(post_id: @post1.id,author_id: @user2.id)


    # Second post interactions
    Comment.create(post_id: @post2.id, author_id: @user1.id, text: 'First comment! Wow')

    Like.create(post_id: @post2.id,author_id: @user1.id)
  end

  describe 'post index page' do
    it 'displays the user name' do
      visit user_posts_path(@user1)
      expect(page).to have_content('Peter Parker')
    end
  end

end