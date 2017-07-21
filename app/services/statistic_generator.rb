class StatisticGenerator
  attr_reader :start_date, :end_date, :item_id, :relation

  def initialize(options = {})
    @start_date = beginning_of_day(options.fetch(:start_date, beginning_of_month))
    @end_date   = end_of_day(options.fetch(:end_date, end_of_month))
    @item_id    = options[:item_id]
    @relation = Order.includes(:order_items).extending(Scopes)
  end

  def call
    relation.with_dates(start_date: start_date, end_date: end_date)
            .with_item(item_id)
  end

  module Scopes
    def with_dates(start_date:, end_date:)
      return self unless start_date && end_date
      where(created_at: start_date..end_date)
    end

    def with_item(item_id)
      return self unless item_id
      where(order_items: { item_id: item_id })
    end
  end

  private

  def beginning_of_day(start_date)
    start_date.to_date.beginning_of_day
  end

  def end_of_day(end_date)
    end_date.to_date.end_of_day
  end

  def end_of_month
    Time.zone.now.end_of_month
  end

  def beginning_of_month
    Time.zone.now.beginning_of_month
  end
end
