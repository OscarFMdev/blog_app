require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) do
    User.new(
      name: 'Tom',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Teacher from Mexico.',
      posts_counter: 3
    )
  end

  let(:post) do
    Post.new(
      author: user,
      title: 'My first post',
      text: 'This is my first post',
      comments_counter: 1,
      likes_counter: 1
    )
  end

  let(:like) do
    Like.new(
      author: user,
      post:
    )
  end

  it 'is only valid with a user' do
    like.author = user
    expect(like).to be_valid
  end

  it 'is valid with a post' do
    like.post = post
    expect(like).to be_valid
  end

  it 'updates likes counter after save' do
    like.save
    expect(post.likes_counter).to eq(2)
  end
end
