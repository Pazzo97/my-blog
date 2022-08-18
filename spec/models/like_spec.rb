require 'rails_helper'

RSpec.describe Like, type: :model do
  subject { Like.new(author_id: 1, post_id: 1) }

  before { subject.save }

  it 'validates the author_id is present' do
    subject.author_id = nil
    expect(subject).to_not be_valid
  end

  it 'validates the post_id is present' do
    subject.post_id = nil
    expect(subject).to_not be_valid
  end

  it 'updates_likes_count method is defined' do
    expect(defined? subject.updates_likes_count).to_not be_nil
  end
end
