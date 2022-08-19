# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

  first_user = User.create!(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  second_user = User.create!(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')

  first_post = Post.create!(author: first_user, title: 'Hello', text: 'This is my first post')
  second_post = Post.create!(author: second_user, title: 'Hello', text: 'This is my second post')
  third_post = Post.create!(author: second_user, title: 'Hello', text: 'This is my third post')

  Comment.create!(author: first_user, post: first_post, text: 'This is my first comment')
  Comment.create!(author: second_user, post: first_post, text: 'This is my second comment')
  Comment.create!(author: second_user, post: second_post, text: 'This is my third comment')
  Comment.create!(author: first_user, post: second_post, text: 'This is my fourth comment')
  Comment.create!(author: second_user, post: third_post, text: 'This is my fifth comment')