require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:item_id) }
  it { validate_numericality_of(:quantity).is_greater_than_or_equal_to(1) }

  it { should validate_presence_of(:order_id) }

  it { should belong_to(:order) }
end
