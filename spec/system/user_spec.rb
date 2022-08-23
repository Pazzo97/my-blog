require 'rails_helper'

RSpec.describe 'Users pages test', type: :feature do
  describe 'index page' do
    before :each do
      @first_user = User.create(name: 'Pazzo', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                                bio: 'Teacher from Mexico')
      @second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                                 bio: 'A beautiful lady')
    end

    it 'check users#index path' do
      visit '/'
      expect(current_path).to eq(root_path)
      expect(page).to have_text('My Blog')
    end

    it 'Should display all user names' do
      visit '/'
      expect(page).to have_content('Pazzo')
      expect(page).to have_content('Lilly')
    end

    it 'Should set the link of the picture to the img src' do
      visit '/'
      all('img').each do |i|
        expect(i[:src]).to eq('/assets/profile-53a15a9e715fa47d98dea599224ead356cb0a39779bbc537868e46898f5ae746.jpg')
      end
    end

    it 'shows the username the user' do
      visit '/'
      expect(page).to have_content(@first_user.name)
    end

    it "Should navigate to user's show page" do
      visit user_path(@first_user.id)
      expect(current_path).to eq(user_path(@first_user.id))
    end
  end

  describe 'show page' do
    before :each do
      @first_user = User.create(name: 'Pazzo', photo: 'pic.png', bio: 'Teacher from Mexico')

      @first_post = @first_user.posts.new(title: 'Love must lead', text: 'This is my first post')
      @first_post.likes_count = 0
      @first_post.comments_count = 0
      @first_post.update_post_counter
      @first_post.save

      @second_post = @first_user.posts.new(title: 'Being a good child', text: 'This is my second post')
      @second_post.likes_count = 0
      @second_post.comments_count = 0
      @second_post.update_post_counter
      @second_post.save
    end

    it 'check users#show path' do
      visit user_path(@first_user.id)
      expect(current_path).to eq(user_path(@first_user.id))
      expect(page).to have_text('My Blog')
    end

    it 'Should set the link of the picture to the img src' do
      visit user_path(@first_user.id)
      all('img').each do |i|
        expect(i[:src]).to eq('/assets/profile-53a15a9e715fa47d98dea599224ead356cb0a39779bbc537868e46898f5ae746.jpg')
      end
    end

    it 'Should display the user name' do
      visit user_path(@first_user.id)
      expect(page).to have_content('Pazzo')
    end

    it 'shows number of posts for the user' do
      visit '/'
      expect(page).to have_content("Number of posts: #{@first_user.updated_at_change}")
    end

    it 'Should display user bio' do
      visit user_path(@first_user.id)
      expect(page).to have_content('Teacher from Mexico')
    end

    it 'Should display the user first 3 posts' do
      visit user_path(@first_user.id)
      expect(page).to have_content('This is my first post')
      expect(page).to have_content('This is my second post')
    end

    it 'Should display a button with "See all posts" text' do
      visit user_path(@first_user.id)
      expect(page).to have_link('See all posts')
    end

    it 'Should redirect to post page after clicking on "See all posts"' do
      visit user_path(@first_user.id)
      click_link 'See all posts'
      expect(current_path).to eq(user_posts_path(@first_user.id))
    end
  end
end
