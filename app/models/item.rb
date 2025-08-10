class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_costs
  belongs_to :prefecture
  belongs_to :delivery_time

  validates :name, :description, presence: true

  validates :price, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9_999_999
  }

  validates :category_id, :condition_id, :shipping_costs_id, :prefecture_id, :delivery_time_id,
            numericality: { other_than: 1, message: "can't be blank" }

  validate :attached_image_presence

  private

  def attached_image_presence
    return if image.attached?

    errors.add(:image, "can't be blank")
  end
end
