class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 },
                    presence: true

  has_many :order_products
  has_many :orders, through: :order_products
end
