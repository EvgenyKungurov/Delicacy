require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { FactoryGirl.build(:order, id: 5) }

  it { should have_many(:order_items).dependent(:destroy) }

  describe '#current_number' do
    it 'should be return number of order as all order size today' do
      expect(Order.order_number_today).to eq 1
    end
  end
end
