require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryGirl.build :user }

  describe 'rolify' do
    it 'should respond to #has_role? method' do
      subject.save!
      expect(subject).to respond_to(:has_role?)
    end
  end
end
