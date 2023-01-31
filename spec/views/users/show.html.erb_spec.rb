require 'rails_helper'

RSpec.describe 'User show', type: :feature do
  before(:each) do
    @user1 = User.create(name: 'Peter Parker', bio: 'Official spiderman hotographer', photo: 'https://www.example.com',
                         posts_counter: 0)

    @user2 = User.create(name: 'Bruce Wayne', bio: 'Millionaire', photo: 'https://www.example.com', posts_counter: 3)

    @post1 = Post.create(author_id: @user1.id, title: 'First post', text: 'This is my first post', comments_counter: 0,
                         likes_counter: 0)
    @post2 = Post.create(author_id: @user1.id, title: 'Second post', text: 'This is my second post',
                         comments_counter: 0,
                         likes_counter: 0)
    @post3 = Post.create(author_id: @user1.id, title: 'Third post', text: 'This is my third post', comments_counter: 0,
                         likes_counter: 0)
    @post4 = Post.create(author_id: @user1.id, title: 'Fourth post', text: 'This is my fourth post',
                         comments_counter: 0,
                         likes_counter: 0)
                         
    @post6 = Post.create(author_id: @user1.id, title: 'Fifth post', text: 'This is my fifth post',
                         comments_counter: 0,
                         likes_counter: 0)

    # Second user single post
    @post5 = Post.create(author_id: @user2.id, title: 'Hello World', text: 'My first post too!', comments_counter: 0,
                         likes_counter: 0)

    # First post interactions
    Comment.create(post_id: @post1.id, author_id: @user1.id, text: 'First comment! Wow')
    Comment.create(post_id: @post1.id, author_id: @user2.id, text: 'Nice post BTW')
    Comment.create(post_id: @post1.id, author_id: @user2.id, text: 'Yeah I agree')

    Like.create(post_id: @post1.id, author_id: @user2.id)

    # Second post interactions
    Comment.create(post_id: @post2.id, author_id: @user1.id, text: 'First comment! Wow')

    Like.create(post_id: @post2.id, author_id: @user1.id)
  end

  describe 'user show page' do
    # user profile photo test
    it 'displays the users profile photo' do
      visit user_path(@user1)
      expect(page).to have_css("img[src*='https://www.example.com']")
    end
    # username test
    it 'displays the right username' do
      visit user_path(@user1)
      expect(page).to have_content('Peter Parker')
      expect(page).to_not have_content('Bruce Wayne')
    end

    # number of posts test
    it 'displays the number of posts the first user has written' do
      visit user_path(@user1)
      expect(page).to have_content('Number of posts: 5')
    end

    # correct bio test
    it 'displays the right biography of first user' do
      visit user_path(@user1)
      expect(page).to have_content('Official spiderman hotographer')
      expect(page).to_not have_content('Millionaire')
    end
    # last three posts test
    it 'displays the last 3 posts' do
      visit user_path(@user1)
      expect(page).to have_content('This is my third post')
      expect(page).to have_content('This is my fourth post')
      expect(page).to have_content('This is my fifth post')
    end

    # Button to see all posts exist test
    it 'displays a button to view all posts' do
      visit user_path(@user2)
      expect(page).to_not have_content('See all posts')
    end

    # Button to see all posts exist test
    it 'displays a button to view all posts' do
      visit user_path(@user1)
      expect(page).to have_content("See all posts")
    end

    # Redirects correctly to show post
    it 'redirects to show post properly' do
      visit user_path(@user1)
      click_link 'Post #1'
      expect(page).to have_content('This is my fifth post')
      expect(page).to_not have_content('Please approve <3')
    end

    # Redirects correctly to show all posts
    it 'redirects to show all posts properly' do
      visit user_path(@user1)
      click_link 'See all posts'
      expect(page).to have_content('This is my first post')
      expect(page).to have_content('This is my second post')
      expect(page).to have_content('This is my third post')
      expect(page).to have_content('This is my fourth post')
    end
  end
end
