require 'rails_helper'

RSpec.describe 'Post index', type: :feature do
  before(:each) do
    @user1 = User.create(name: 'Peter Parker', bio: 'Official spiderman hotographer', photo: 'https://www.example.com',
                         posts_counter: 0)

    @user2 = User.create(name: 'Bruce Wayne', bio: 'Millionaire', photo: 'https://www.example.com', posts_counter: 3)

    @post1 = Post.create(author_id: @user1.id, title: 'First post', text: 'This is my first post', comments_counter: 0,
                         likes_counter: 0)
    @post2 = Post.create(author_id: @user1.id, title: 'First post', text: 'This is my first post', comments_counter: 0,
                         likes_counter: 0)
    @post3 = Post.create(author_id: @user1.id, title: 'First post', text: 'This is my first post', comments_counter: 0,
                         likes_counter: 0)
    @post4 = Post.create(author_id: @user1.id, title: 'First post', text: 'This is my first post', comments_counter: 0,
                         likes_counter: 0)
    @post5 = Post.create(author_id: @user1.id, title: 'First post', text: 'This is my first post', comments_counter: 0,
                         likes_counter: 0)
    @post6 = Post.create(author_id: @user1.id, title: 'First post', text: 'This is my first post', comments_counter: 0,
                         likes_counter: 0)

    @post7 = Post.create(
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

    Like.create(post_id: @post1.id, author_id: @user2.id)

    # Second post interactions
    Comment.create(post_id: @post2.id, author_id: @user1.id, text: 'First comment! Wow')

    Like.create(post_id: @post2.id, author_id: @user1.id)
  end

  describe 'post index page' do
    # user profile picture test
    it 'renders the user photo' do
      visit users_path
      expect(page).to have_css("img[src*='https://www.example.com']")
    end

    # Username test
    it 'displays the user name' do
      visit user_posts_path(@user1)
      expect(page).to have_content('Peter Parker')
    end

    # Number of posts test 
    it 'the post counter renders correctly' do
      visit user_posts_path(@user2)
      expect(page).to have_content('Number of posts: 4')
    end

    # post's title test
    it 'displays the user name' do
      visit user_posts_path(@user1)
      expect(page).to have_content('Peter Parker')
    end
    # post's body test
    it 'should render some of the created post' do
      visit user_posts_path(@user1)
      expect(page).to have_content('This is my first post')
    end

    # first comments on a post test
    it 'should display the first comments ' do
      visit user_posts_path(@user1)
      expect(page).to have_content('Nice post BTW')
      expect(page).to have_content('Yeah I agree')
    end

    # how many comments a post has test
    it 'should count the comments corectly' do
      visit user_posts_path(@user1)

      expect(page).to have_content('Comments (3):')
    end

    # how many likes a post has test
    it 'should count the likes corectly' do
      visit user_posts_path(@user1)

      expect(page).to have_content('Likes: 1')
    end

    # it redirects to that post's show page test
    it 'redirects to show user properly' do
      visit user_posts_path(@user1)
      click_link 'Post #1'
      expect(page).to have_content('This is my first post')
      expect(page).to_not have_content('Please approve <3')
    end
  end
end
