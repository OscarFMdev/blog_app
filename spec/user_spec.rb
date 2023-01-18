require 'rails_helper'

RSpec.describe User, type: :model do
  subject{ User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 3) }

  before{ subject.save }

  it 'The name should be present' do
    subject.name = nil

    expect(subject).to_not be_valid
  end

  it 'PostsCounter must be an integer greater than or equal to zero.' do
    subject.posts_counter = nil
    expect(subject).to_not be_valid
  end

  it 'PostsCounter must not be a string' do
    subject.posts_counter = 'Hello World'
    expect(subject).to_not be_valid
  end

  it 'PostsCounter must not be positive' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'The photo should be present' do
    subject.photo = nil

    expect(subject).to_not be_valid
  end

  it 'The bio should be present' do
    subject.bio = nil

    expect(subject).to_not be_valid
  end

  it 'last_five_posts must be between 0 and 3' do

    tester = subject.last_three_posts.length

    expect(tester).to be_between(0,3)

  end

end