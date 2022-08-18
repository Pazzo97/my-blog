require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { Comment.new(text: 'Text', author_id: 1, post_id: 1) }

  before { subject.save }

  it 'validates the text is present' do
    subject.text = ''
    expect(subject).to_not be_valid
  end

  it 'validates the author_id is present' do
    subject.author_id = nil
    expect(subject).to_not be_valid
  end

  it 'validates the post_id is present' do
    subject.post_id = nil
    expect(subject).to_not be_valid
  end

  it 'updates_comments_count method is defined' do
    expect(defined? subject.updates_comments_count).to_not be_nil
  end
end
