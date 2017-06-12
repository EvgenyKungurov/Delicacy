require 'rails_helper'

RSpec.describe Cart, type: :model do
  let!(:category) { FactoryGirl.create :item }
  subject { FactoryGirl.build(:cart, item_id: item.id) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:item_id) }
  it { should have_many(:items) }
end
