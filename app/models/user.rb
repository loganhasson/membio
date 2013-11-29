class User < ActiveRecord::Base

  has_many :lists, dependent: :destroy
  validates :phone_number, uniqueness: true,
                           length: { minimum: 10, maximum: 10 }

  before_validation :sanitize_phone_number
  before_create :generate_confirmation_code

  def text_number
    "+1#{self.phone_number}"
  end

  def confirmed?
    self.confirmed
  end

  private

    def generate_confirmation_code
      self.confirmation_code = (SecureRandom.random_number*1000000).to_i
    end

    def sanitize_phone_number
      self.phone_number = phone_number.gsub(/^(\+1)|[^0-9]+/,'') if phone_number
    end

end