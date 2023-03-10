require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before(:each) do
    @user = User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/johndoe',
                        bio: 'Software Engineer, enjoys hiking and photography', posts_counter: 0)
    @post = Post.create(author: @user, title: 'My first blog post',
                        text: 'This is my first blog post, hope you like it!', comments_counter: 2,
                        likes_counter: 5)
  end

  describe 'request list of all posts' do
    before(:each) { get user_posts_path(@user) }

    it 'Gives the correct response status' do
      expect(response).to have_http_status(:ok)
    end

    it 'Renders the correct template' do
      expect(response).to render_template('index')
    end

    it 'includes correct placeholder text' do
      expect(response.body).to include('This is my first blog post')
    end

    it 'Checks for full list of posts info into the body' do
      expect(response.body).to include('<h3>Post #1</h3>')
      expect(response.body).to include('This is my first blog post')
    end
  end

  describe 'request a specific post' do
    before(:each) { get user_post_path(@user, @post) }

    it 'Gives the correct response status' do
      expect(response).to have_http_status(:ok)
    end

    it 'Renders the correct template' do
      expect(response).to render_template('show')
    end

    it 'includes correct post title' do
      expect(response.body).to include('My first blog post')
    end

    it 'Checks for single post info into the body' do
      expect(response.body).to include('My first blog post')
      expect(response.body).to_not include('This is my second blog post!')
    end
  end
end
