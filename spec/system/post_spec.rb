require 'rails_helper'

RSpec.describe 'Post pages test', type: :feature do
  describe 'index page' do
    before :each do
      @user = User.create(name: 'Pazzo', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')

      @post = @user.posts.new(title: 'My story', text: 'This is my first post')
      @post.likes_count = 0
      @post.comments_count = 0
      @post.save

      @comment = @user.comments.new(post_id: @post.id, author_id: @user.id, text: 'My first comment')
      @comment.post_id = @post.id
      @comment.save

      @like = Like.new(author_id: @user.id, post_id: @post.id)
      @like.author = @user
      @like.post = @post
      @like.save
    end

    it 'check posts#index path' do
      visit user_posts_path(@user.id)
      expect(current_path).to eq(user_posts_path(@user.id))
      expect(page).to have_text('My Blog')
    end

    it 'Should set the link of the picture to the img src' do
      visit user_posts_path(@user.id)
      all('img').each do |i|
        expect(i[:src]).to eq('/assets/profile-53a15a9e715fa47d98dea599224ead356cb0a39779bbc537868e46898f5ae746.jpg')
      end
    end

    it 'Should display the user name' do
      visit user_posts_path(@user.id)
      expect(page).to have_content('Pazzo')
    end

    it 'shows number of posts for the user' do
      visit user_posts_path(@user)
      expect(page).to have_content('Number of posts: 1')
    end

    it 'Should display the post title' do
      visit user_posts_path(@user.id)
      expect(page).to have_content('My story')
    end

    it 'Should display the post body' do
      visit user_posts_path(@user.id)
      expect(page).to have_content('This is my first post')
    end

    it 'Should display the post comment' do
      visit user_posts_path(@user.id)
      expect(page).to have_content('My first comment')
    end

    it 'Should display the total post comment number of 1' do
      visit user_posts_path(@user.id)
      expect(page).to have_content('Comment 1')
    end

    it 'Should display the total post likes number of 1' do
      visit user_posts_path(@user.id)
      expect(page).to have_content('Likes 1')
    end

    it 'Should display a button with "Pagination" text' do
      visit user_posts_path(@user.id)
      expect(page).to have_link('Click to go back !')
    end

    it 'Should redirect to post show page after clicking on a post' do
      visit user_posts_path(@user.id)
      click_link 'My story'
      expect(current_path).to eq(user_post_path(@user.id, @post.id))
    end
  end

  describe 'show page' do
    before :each do
      @user = User.create(name: 'Pazzo', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico')

      @post = @user.posts.new(title: 'My story', text: 'This is my first post')
      @post.likes_count = 0
      @post.comments_count = 0
      @post.update_post_counter
      @post.save

      @comment = @user.comments.new(post_id: @post.id, author_id: @user.id, text: 'My first comment')
      @comment.post_id = @post.id
      @comment.updates_comments_count
      @comment.save

      @like = Like.new(author_id: @user.id, post_id: @post.id)
      @like.author = @user
      @like.post = @post
      @like.save
      @like.updates_likes_count
    end

    it 'check posts#show path' do
      visit user_post_path(@user.id, @post.id)
      expect(current_path).to eq(user_post_path(@user.id, @post.id))
      expect(page).to have_text('My Blog')
    end

    it 'Should display the post title' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content('My story')
    end

    it 'Should display who wrote the post' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content('Pazzo')
    end

    it 'Should display the total post comment number of 2' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content('Comment 2')
    end

    it 'Should display the total post likes number of 2' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content('Likes 2')
    end

    it 'Should display the post body' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content('This is my first post')
    end

    it 'Should display the name of the user who posted a comment' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content('Pazzo:')
    end

    it 'Should display the post comment text of a user' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content('My first comment')
    end
  end
end
