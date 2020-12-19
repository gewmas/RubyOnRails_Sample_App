require 'spec_helper'

describe Relationship do
  let(:follower) { FactoryBot.create(:user) }
  let(:followed) { FactoryBot.create(:user) }
  # As with microposts in Section 10.1.3, we will create new relationships using the user association, with code such as
  # user.relationships.build(followed_id: ...)
  let(:relationship) { follower.relationships.build(followed_id: followed.id) }

  subject { relationship }

  it { should be_valid }

  describe 'follower methods' do
    it { should respond_to(:follower) }
    it { should respond_to(:followed) }
    its(:follower) { should eq follower }
    its(:followed) { should eq followed }
  end

  describe 'when followed id is not present' do
    before { relationship.followed_id = nil }
    it { should_not be_valid }
  end

  describe 'when follower id is not present' do
    before { relationship.follower_id = nil }
    it { should_not be_valid }
  end
end
