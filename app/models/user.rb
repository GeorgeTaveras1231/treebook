class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, presence: true
  #has_secure_password


  has_many :statuses
  has_many :likes
  has_many :comments

  def like a_likeable
    #helps determine whether to delete an existing like or create a new like
    persisted_like = a_likeable.likes.find_by(user_id: self.id)
    new_like = a_likeable.likes.build(user_id: self.id)
    persisted_like or new_like
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end


end
