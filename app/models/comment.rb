class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  has_many :comments, as: :commentable
  has_many :likes, as: :likeable

  scope :statuses,lambda { self.where("comments.commentable_id IS null") }

  validates :content, presence: true
  validates :user_id, presence: true

  scope :most_recent, lambda {|l= 5|
    self.order(created_at: :desc).limit(l)
  }

  def belongs_to? user
    self.user_id == (user && user.id)
  end
end
