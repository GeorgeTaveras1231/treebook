class Status < ActiveRecord::Base
  has_many :likes, as: :likeable
  validates :content, presence: true
	belongs_to :user

  has_many :comments, as: :commentable

  scope :most_recent, lambda {|l= 5|
    self.order(created_at: :desc).limit(l)
  }

  def belongs_to? user
    self.user_id == (user && user.id)
  end
end
