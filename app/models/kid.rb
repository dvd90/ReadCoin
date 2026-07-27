class Kid < ApplicationRecord
  AVATARS = %w[🦁 🐯 🦊 🐼 🐸 🦄 🐙 🦖 🐧 🦉 🐳 🚀].freeze

  belongs_to :parent, class_name: "User", inverse_of: :kids
  has_many :readings, dependent: :destroy
  has_many :books, through: :readings
  has_many :redemptions, dependent: :destroy

  has_secure_password :pin, validations: false

  validates :name, presence: true
  validates :avatar, inclusion: { in: AVATARS }
  validates :pin, format: { with: /\A\d{4}\z/, message: "must be 4 digits" }, allow_nil: true

  def finished_readings = readings.finished
  def finished_count = finished_readings.count

  # Called when a kid finishes a book: extends the streak if they also read
  # yesterday, keeps it if they already read today, otherwise restarts at 1.
  def record_reading_day!(date = Date.current)
    self.streak =
      if last_read_on == date then [ streak, 1 ].max
      elsif last_read_on == date - 1 then streak + 1
      else 1
      end
    self.last_read_on = date
    save!
  end

  def current_streak
    return 0 if last_read_on.nil? || last_read_on < Date.current - 1
    streak
  end
end
