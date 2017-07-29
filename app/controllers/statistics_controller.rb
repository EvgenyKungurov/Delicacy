class StatisticsController < ApplicationController
  def index
    @statistic = OrderSearcher.new(statistics_params).call
  end

  private

  def statistics_params
    params.permit(:item_id, :start_date, :end_date)
  end
end
