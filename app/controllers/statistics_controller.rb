class StatisticsController < ApplicationController
  def index
    @statistics = StatisticGenerator.new(statistics_params).call
  end

  private

  def statistics_params
    params.permit(:item_id, :start_date, :end_date)
  end
end
