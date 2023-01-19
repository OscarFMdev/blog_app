require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) do
    User.new(
      name: 'John Doe',
      photo: 'https://unsplash.com/photos',
      bio: 'Foo bar',
      posts_counter: 3
    )
  end

  let(:post) do
    Post.new(
      author: user,
      title: 'My first post',
      text: 'This is my first post',
      comments_counter: 1,
      likes_counter: 2
    )
  end

  let(:comment) do
    Comment.new(
      author: user,
      post:,
      text: 'first comment'
    )
  end

  it 'is valid with a text' do
    comment.text = 'first comment'
    expect(comment).to be_valid
  end

  it 'is only valid with a user' do
    comment.author = user
    expect(comment).to be_valid
  end

  it 'is valid with a post' do
    comment.post = post
    expect(comment).to be_valid
  end

  it 'updates comments counter after save' do
    comment.save
    expect(post.comments_counter).to eq(2)
  end

  it 'Should output 0 to 5 last comment when last_five_comments is called' do
    expect(post.last_five_comments.length).to be_between(0, 5)
  end
end
