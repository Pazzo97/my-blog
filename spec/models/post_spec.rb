require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(title: 'Title', text: 'Text') }

  before { subject.save }

  it 'validates the title is present' do
    subject.title = ''
    expect(subject).to_not be_valid
  end

  it 'validates the text is present' do
    subject.text = ''
    expect(subject).to_not be_valid
  end

  it 'validates the comments_count is an integer value' do
    subject.comments_count = 'three'
    expect(subject).to_not be_valid
  end

  it 'validates the comments_count is not less than 0' do
    subject.comments_count = -1
    expect(subject).to_not be_valid
  end

  it 'upddate_post_counter method is defined' do
    expect(defined? subject.update_post_counter).to_not be_nil
  end

  it 'most_recent_comments method is defined' do
    expect(defined? subject.most_recent_comments).to_not be_nil
  end
end
