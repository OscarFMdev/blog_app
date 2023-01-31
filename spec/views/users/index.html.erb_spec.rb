require 'rails_helper'

RSpec.describe 'User index', type: :feature do
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
      posts_counter: 2
    )

    @user3 = User.create(
      name: 'Tony stark',
      bio: 'Stark industries CEO',
      photo: 'https://www.example.com',
      posts_counter: 3
    )
  end

  describe 'users index page' do
    # Display all the usernames test
    it 'displays the created users' do
      visit users_path
      expect(page).to have_content('Peter Parker')
      expect(page).to have_content('Bruce Wayne')
      expect(page).to have_content('Tony stark')
    end

    # Profile picture test
    it 'shows the right photo' do
      visit users_path
      expect(page).to have_css("img[src*='https://www.example.com']")
    end

    # Number of posts test
    it 'displays the right Number of posts' do
      visit users_path
      expect(page).to have_content('Number of posts: 0')
      expect(page).to have_content('Number of posts: 2')
      expect(page).to have_content('Number of posts: 3')
    end

    # Redirect to a specific user test
    it 'redirects to show user properly' do
      visit users_path
      click_link 'Peter Parker'
      expect(page).to have_content('Official spiderman hotographer')
      expect(page).to_not have_content('Millionaire')
    end
  end
end
