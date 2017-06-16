require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { FactoryGirl.build(:order) }

  it { should have_many(:order_items) }
end
