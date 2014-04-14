class Status < ActiveRecord::Base
  has_many :likes, as: :likeable
  validates :content, presence: true
	belongs_to :user

  def belongs_to? user
    self.user_id == (user && user.id)
  end
end
