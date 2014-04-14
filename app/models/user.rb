class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :statuses
  has_many :likes


  def like a_likeable
    persisted_like = a_likeable.likes.find_by(user_id: self.id)
    new_like = a_likeable.likes.build(user_id: self.id)
    persisted_like or new_like
  end


end
