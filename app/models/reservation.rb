class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_date, :end_date, :person_num, presence: true
  validate :check_out_after_check_in

  before_validation :calculate_total_price

  private

  # チェックアウト日がチェックイン日より後であることを確認
  def check_out_after_check_in
    if start_date.present? && end_date.present? && start_date >= end_date
      errors.add(:end_date, "はチェックイン日より後の日付を選択してください")
    end
  end

  # 合計料金（宿泊代×宿泊日数×人数）
  def calculate_total_price
    if room && start_date && end_date && person_num
      nights = (end_date - start_date).to_i
      self.total_price = room.price * nights * person_num
    end
  end

end

