require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { FactoryGirl.build :order }

  it { should have_many(:order_items).dependent(:destroy) }

  describe '#current_number' do
    it 'should be return number of order as all order size today' do
      expect(Order.order_number_today).to eq 0
    end

    it 'should be call #set_current_order_number and return 1' do
      subject.save!
      expect(subject.current_number).to eq 1
    end

    it '#set_current_order_number should save current_number once times ' do
      subject.save!
      FactoryGirl.create :order
      current_number = subject.current_number
      expect(subject).to receive(:set_current_order_number).and_return(current_number)
      subject.save!
    end
  end
end
