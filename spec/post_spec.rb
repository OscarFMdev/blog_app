require 'rails_helper'

RSpec.describe Post, type: :model do
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
      title: 'Hello',
      text: 'This is my first post',
      comments_counter: 1,
      likes_counter: 1
    )
  end

  it 'The author should be present' do
    post.author = nil
    expect(post).to_not be_valid
  end

  it 'title must not be blank' do
    post.title = nil
    expect(post).to_not be_valid
  end

  it 'title must not exeed 250 characters' do
    part1 = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus at cursus lacus. Maecenas eget'
    part2 = ' nunc eu purus viverra tincidunt et in lorem. Nam euismod urna felis,'
    part3 = 'id efficitur velit interdum nec. Quisque in mi diam. Lorem ipsum dolor sit amet, cons'
    post.title = part1 + part2 + part3
    expect(post).to_not be_valid
  end

  it 'title between 3 and 250 should be valid' do
    post.title = 'Hello world'
    expect(post).to be_valid
  end

  it 'The text should be present' do
    post.text = nil

    expect(post).to_not be_valid
  end

  it 'Comments counter must be an integer' do
    post.comments_counter = 'Hello'
    expect(post).to_not be_valid
  end

  it 'Comments counter must not be less than zero' do
    post.comments_counter = -1
    expect(post).to_not be_valid
  end

  it 'Comments counter must be greater than 0' do
    post.comments_counter = 1
    expect(post).to be_valid
  end

  it 'Likes counter must be an integer' do
    post.likes_counter = 'Hello'
    expect(post).to_not be_valid
  end

  it 'Likes counter must be greater than 0' do
    post.likes_counter = -1
    expect(post).to_not be_valid
  end

  it 'Likes counter must be greater than 0' do
    post.likes_counter = 1
    expect(post).to be_valid
  end

  it 'Should output 0 to 5 last comment when last_five_comments is called' do
    expect(post.last_five_comments.length).to be_between(0, 5)
  end

  it 'should update the user posts counter after saving' do
    post.save

    expect(user.posts_counter).to eq(4)
  end
end

# For the Post model:
# Title must not be blank.
# Title must not exceed 250 characters.
# CommentsCounter must be an integer greater than or equal to zero.
# LikesCounter must be an integer greater than or equal to zero.
