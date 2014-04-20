class Like < ActiveRecord::Base
  include PolymorphicHelper

  belongs_to :likeable, polymorphic: true, counter_cache: :likes_count
  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: [:likeable_type,:likeable_id]}
  
end
