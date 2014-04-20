class Comment < ActiveRecord::Base
  include PolymorphicHelper

  before_save :trim

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  has_many :comments, as: :commentable
  has_many :likes, as: :likeable

  validates :content, presence: true
  validates :user_id, presence: true

  scope :comments, proc { self.where("comments.commentable_id IS NOT null") }
  scope :statuses, proc { self.where("comments.commentable_id IS null") }
  scope :most_recent, proc { |l = 7|
    self.order(created_at: :desc).limit(l)
  }

  scope :trending_statuses, proc {
    statuses.order(likes_count: :desc).most_recent(7)
  }
  
  def belongs_to? user
    self.user_id == (user && user.id)
  end

  def has_comments?
    !self.comments.to_a.empty?
  end


  def is_status?
    if self.commentable_id
      false
    else
      true
    end
  end

  private

    def trim
      self.content = self.content.strip # avoid saving nil by not using strip!
    end

end
