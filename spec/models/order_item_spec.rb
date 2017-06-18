require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:category) { FactoryGirl.create :category }
  let!(:item) { FactoryGirl.create :item, category_id: category.id }
  let!(:order) { FactoryGirl.create :order }
  subject do
    FactoryGirl.build(
      :order_item, item_id: item.id, quantity: 2,
                   order_id: order.id, total_price: item.price
    )
  end

  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:item_id) }
  it { should validate_presence_of(:total_price) }
  it { validate_numericality_of(:quantity).is_greater_than_or_equal_to(1) }
  it { validate_numericality_of(:total_price).is_greater_than_or_equal_to(1) }

  it { should validate_presence_of(:order_id) }

  it { should belong_to(:order) }

  describe 'before create' do
    it 'should invoke #sum_price' do
      expect(subject).to receive(:sum_price)
      subject.save!
    end
  end

  describe 'sum_price' do
    it 'should assign total_price * quantity' do
      subject.save!
      expect(subject.total_price).to eq subject.item.price * 2
    end
  end
end
