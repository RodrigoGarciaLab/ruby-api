class Order < ApplicationRecord
  
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
  

  validates_presence_of :created_by
  validates_presence_of :total
  validates :total, numericality: { greater_than_or_equal_to: 0 }
  

  before_validation :set_total!

  def build_order_with_product_ids_and_quantities(product_ids_and_quantities)
    product_ids_and_quantities.each do |product_id_and_quantity|
      id, quantity = product_id_and_quantity
      self.order_products.build(product_id: id, quantity: quantity)
    end
    set_total!
  end

  private
  
    def set_total!
      self.total = 0
      order_products.each do |order_product|
        self.total += order_product.product.price * order_product.quantity
      end
    end
end
