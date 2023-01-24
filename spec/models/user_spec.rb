require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.new(
      name: 'Tom',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Teacher from Mexico.',
      posts_counter: 3
    )
  end

  before { subject.save }

  it 'The name should be present' do
    user.name = nil

    expect(user).to_not be_valid
  end

  it 'PostsCounter must be an integer greater than or equal to zero.' do
    user.posts_counter = nil
    expect(user).to_not be_valid
  end

  it 'PostsCounter must not be a string' do
    user.posts_counter = 'Hello World'
    expect(user).to_not be_valid
  end

  it 'PostsCounter must not be positive' do
    user.posts_counter = -1
    expect(user).to_not be_valid
  end

  it 'The photo should be present' do
    user.photo = nil

    expect(user).to_not be_valid
  end

  it 'The bio should be present' do
    user.bio = nil
    expect(user).to_not be_valid
  end
end
