class List < ActiveRecord::Base
  belongs_to :user
  has_many :items

  validates_uniqueness_of :title, scope: :user_id
end