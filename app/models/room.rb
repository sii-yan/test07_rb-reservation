class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy

  validates :name, :description, :price, :address, presence: true
  validates :price, numericality: { greater_than: 0 } # 料金が1円以上に設定

  has_one_attached :image # 画像添付の設定
end
