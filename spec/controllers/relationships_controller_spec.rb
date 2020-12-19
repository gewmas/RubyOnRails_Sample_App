require 'spec_helper'
require 'rails_helper'

describe RelationshipsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  before { sign_in user, no_capybara: true }

  describe 'creating a relationship with Ajax' do
    it 'should increment the Relationship count' do
      expect do
        post :create, params: { relationship: { followed_id: other_user.id } }, xhr: true
      end.to change(Relationship, :count).by(1)
    end

    it 'should respond with success' do
      post :create, params: { relationship: { followed_id: other_user.id } }, xhr: true
      expect(response).to be_successful
    end
  end

  describe 'destroying a relationship with Ajax' do
    before { user.follow!(other_user) }
    let(:relationship) { user.relationships.find_by(followed_id: other_user) }

    it 'should decrement the Relationship count' do
      expect do
        post :destroy, params: { id: relationship.id }, xhr: true
      end.to change(Relationship, :count).by(-1)
    end

    it 'should respond with success' do
      post :destroy, params: { id: relationship.id }, xhr: true
      expect(response).to be_successful
    end
  end
end
