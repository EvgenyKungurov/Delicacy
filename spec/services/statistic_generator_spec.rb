require 'rails_helper'

RSpec.describe StatisticGenerator do
  let!(:start_date) { Time.zone.now - 1.day }
  let!(:end_date) { Time.zone.now }
  let!(:beginning_of_month) { Time.zone.now.beginning_of_month }
  let!(:end_of_month) { Time.zone.now.end_of_month }
  let!(:params) { { start_date: start_date, end_date: end_date } }
  let!(:category) { FactoryGirl.create :category }
  let!(:item) { FactoryGirl.create(:item, category_id: category.id, price: 25) }
  let!(:only_order) { FactoryGirl.create :order }
  let!(:order) { FactoryGirl.create :order }
  let!(:order_item) do
    FactoryGirl.create(
      :order_item, item_id: item.id, quantity: 1, order_id: order.id, total_price: item.id
    )
  end

  describe 'call' do
    context 'valid params' do
      it 'should return orders all orders between dates' do
        result = StatisticGenerator.new(params).call
        expect(result).to match_array Order.all
      end

      it 'should return orders includes item' do
        result = StatisticGenerator.new(params.merge(item_id: item.id)).call
        expect(result.first).to eq order
      end
    end

    context 'no params' do
      it 'should return current month orders' do
        result = StatisticGenerator.new.call
        expect(result).to eq Order.where(created_at: beginning_of_month..end_of_month)
      end
    end
  end
end
