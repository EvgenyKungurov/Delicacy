require 'rails_helper'

RSpec.describe OrderSearcher do
  let!(:start_date) { Time.zone.now - 1.day }
  let!(:end_date) { Time.zone.now }
  let!(:beginning_of_month) { Time.zone.now.beginning_of_month }
  let!(:end_of_month) { Time.zone.now.end_of_month }
  let!(:params) { { start_date: start_date, end_date: end_date } }
  include_examples 'order_with_dependencies'

  describe 'call' do
    context 'valid params' do
      it 'should return orders all orders between dates' do
        result = OrderSearcher.new(params).call
        expect(result).to match_array Order.where('order_items_count > 0')
      end

      it 'should return orders includes item' do
        result = OrderSearcher.new(params.merge(item_id: item.id)).call
        expect(result.first).to eq order
      end

      it 'should return orders includes status in kitchen' do
        result = OrderSearcher.new(params.merge(status: 1)).call
        expect(result.first).to eq order_in_kitchen
      end
    end

    context 'no params' do
      it 'should return current month orders' do
        result = OrderSearcher.new.call
        expect(result).to eq Order
          .where(created_at: beginning_of_month..end_of_month)
          .where('order_items_count > 0')
      end
    end
  end
end
