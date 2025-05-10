class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :person_num, null: false
      t.integer :total_price, null: false, default: 0
      t.references :user, null: false, foreign_key: true  # users テーブルと関連付け
      t.references :room, null: false, foreign_key: true  # rooms テーブルと関連付け

      t.timestamps
    end
  end
end
