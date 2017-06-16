require 'rails_helper'

RSpec.describe Item, type: :model do
  let!(:category) { FactoryGirl.create :category }
  subject { FactoryGirl.build(:item, category_id: category.id) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:category_id) }
  it { should validate_length_of(:name).is_at_least 3 }
  it { should belong_to(:category) }
end
