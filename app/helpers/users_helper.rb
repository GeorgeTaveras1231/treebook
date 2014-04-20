require 'digest/md5'
module UsersHelper
  def gravatar_src_for user
    hash = Digest::MD5.hexdigest(user.email)
    "http://www.gravatar.com/avatar/#{hash}"
  end

  def gravatar_img_for user, size=50
    image_tag "#{gravatar_src_for(user)}?s=#{size}"
  end
end
