class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details
  enum payment_method: { credit_card: 0, transfer: 1 }
  
  def item_amount
    total = 0
    self.order_details.each do |order_detail|
      total += order_detail.quantity
    end
    return total
  end
end