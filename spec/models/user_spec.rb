require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

  before { subject.save }

  it 'validates the name is present' do
    subject.name = ''
    expect(subject).to_not be_valid
  end

  it 'validates posts_count is an integer value' do
    subject.posts_count = 'three'
    expect(subject).to_not be_valid
  end

  it 'validates posts_count is not less than 0' do
    subject.posts_count = -1
    expect(subject).to_not be_valid
  end

  it 'most_recent_posts method is defined' do
    expect(defined? subject.most_recent_posts).to_not be_nil
  end
end
